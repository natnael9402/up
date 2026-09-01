'use client';

import { useEffect, useRef, useCallback } from 'react';
import { config } from '../lib/config';
import { storage } from '../lib/storage';
import { useToast } from '../contexts/ToastContext';

export function NotificationPermissionPrompt() {
  const toast = useToast();
  const doneRef = useRef(false);
  const toastShownRef = useRef(false);

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
    if (Notification.permission === 'granted') {
      await ensureSubscription();
      toast.success('Notifications enabled');
      return;
    }
    const permission = await Notification.requestPermission();
    if (permission === 'granted') {
      await ensureSubscription();
      toast.success('Notifications enabled');
    }
  }, [ensureSubscription, toast]);

  useEffect(() => {
    if (doneRef.current) return;
    if (typeof window === 'undefined') return;
    if (!('Notification' in window)) return;
    if (!('serviceWorker' in navigator)) return;
    if (!('PushManager' in window)) return;

    doneRef.current = true;

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

  return null;
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