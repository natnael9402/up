'use client';

import { useEffect, useRef, useCallback, useState } from 'react';
import { config } from '../lib/config';
import { storage } from '../lib/storage';
import { useToast } from '../contexts/ToastContext';
import { PwaInstallPrompt } from './PwaInstallPrompt';

const INSTALL_BANNER_KEY = 'uphold_install_prompt_dismissed';

function isStandaloneMode(): boolean {
  if (typeof window === 'undefined') return false;
  if (window.matchMedia('(display-mode: standalone)').matches) return true;
  return (window.navigator as Navigator & { standalone?: boolean }).standalone === true;
}

function isIOS(): boolean {
  if (typeof navigator === 'undefined') return false;
  return /iPad|iPhone|iPod/.test(navigator.userAgent);
}

function getIOSBrowser(): 'safari' | 'other' | 'unknown' {
  if (typeof navigator === 'undefined') return 'unknown';
  if (/Safari/.test(navigator.userAgent) && !/CriOS|FxiOS|EdgiOS|OPiOS/i.test(navigator.userAgent)) {
    return 'safari';
  }
  if (/CriOS|FxiOS|EdgiOS|OPiOS/.test(navigator.userAgent)) return 'other';
  return 'unknown';
}

export function NotificationPermissionPrompt() {
  const toast = useToast();
  const toastShownRef = useRef(false);
  const [showInstall, setShowInstall] = useState(() => {
    if (typeof window === 'undefined') return false;
    if (!('serviceWorker' in navigator)) return false;
    if (!isIOS()) return false;
    if (isStandaloneMode()) return false;
    try {
      if (localStorage.getItem(INSTALL_BANNER_KEY) === '1') return false;
    } catch {
      /* ignore */
    }
    return true;
  });

  const ensureSubscription = useCallback(async (): Promise<boolean> => {
    try {
      const rawToken = storage.getToken();
      if (!rawToken) return false;

      const vapidRes = await fetch(`${config.apiUrl}/push/vapid-public-key`);
      if (!vapidRes.ok) return false;
      const vapidData = await vapidRes.json();
      const publicKey = vapidData?.data?.publicKey || vapidData?.publicKey;
      if (!publicKey) return false;

      const reg = await navigator.serviceWorker.ready;
      if (!reg.pushManager) return false;

      let subscription = await reg.pushManager.getSubscription();
      if (!subscription) {
        subscription = await reg.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: urlBase64ToUint8Array(publicKey) as BufferSource,
        });
      }

      const token = storage.getToken() || '';
      await fetch(`${config.apiUrl}/push/subscribe`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          ...(token ? { Authorization: `Bearer ${token}` } : {}),
        },
        body: JSON.stringify({
          endpoint: subscription.endpoint,
          keys: {
            p256dh: btoa(String.fromCharCode(...new Uint8Array(subscription.getKey('p256dh')!))),
            auth: btoa(String.fromCharCode(...new Uint8Array(subscription.getKey('auth')!))),
          },
          userAgent: navigator.userAgent,
        }),
      });
      return true;
    } catch {
      return false;
    }
  }, []);

  const promptPermission = useCallback(async () => {
    let permission = Notification.permission;
    if (permission === 'default') {
      permission = await Notification.requestPermission();
    }
    if (permission === 'granted') {
      await ensureSubscription();
      toast.success('Notifications enabled');
    } else if (permission === 'denied') {
      toast.info('Notifications are blocked. Enable them in your settings to stay updated.');
    }
  }, [ensureSubscription, toast]);

  const handleInstallDismiss = useCallback(() => {
    localStorage.setItem(INSTALL_BANNER_KEY, '1');
    setShowInstall(false);
  }, []);

  useEffect(() => {
    if (typeof window === 'undefined') return;
    if (!('serviceWorker' in navigator)) return;

    const ios = isIOS();
    const standalone = isStandaloneMode();

    // iOS installed PWA (standalone): offer real push permission.
    if (ios && standalone) {
      if (!('Notification' in window) || !('PushManager' in window)) return;
      if (Notification.permission === 'granted') {
        ensureSubscription();
        return;
      }
      if (toastShownRef.current) return;
      toastShownRef.current = true;
      toast.info('Get real-time alerts from Uphold.', {
        label: 'Allow notifications',
        onClick: promptPermission,
      });
      return;
    }

    // iOS Safari tab (not installed): the install guide is rendered from state.
    if (ios && !standalone) {
      return;
    }

    // Android / desktop: standard push permission flow.
    if (!('Notification' in window) || !('PushManager' in window)) return;
    if (Notification.permission === 'granted') {
      ensureSubscription();
      return;
    }
    if (toastShownRef.current) return;
    toastShownRef.current = true;
    toast.info('Get real-time alerts from Uphold.', {
      label: 'Allow notifications',
      onClick: promptPermission,
    });
  }, [ensureSubscription, promptPermission, toast]);

  const showInstallModal = showInstall && !isStandaloneMode();
  const iosBrowser = showInstallModal ? getIOSBrowser() : 'unknown';

  return (
    <>
      {showInstallModal && (
        <PwaInstallPrompt open browser={iosBrowser} onClose={handleInstallDismiss} />
      )}
    </>
  );
}

function urlBase64ToUint8Array(base64String: string): Uint8Array {
  const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding).replace(/-/g, '+').replace(/_/g, '/');
  const rawData = atob(base64);
  const outputArray = new Uint8Array(rawData.length);
  for (let i = 0; i < rawData.length; i += 1) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}
