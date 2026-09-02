'use client';

import { useCallback, useState } from 'react';
import { Share, Copy, Check, Bell, Smartphone } from 'lucide-react';
import { Modal } from './ui/Modal';
import { Button } from './ui/Button';
import { cn } from '../lib/utils';

interface PwaInstallPromptProps {
  open: boolean;
  onClose: () => void;
  browser: 'safari' | 'other' | 'unknown';
}

function CopyLinkButton() {
  const [copied, setCopied] = useState(false);
  const [failure, setFailure] = useState(false);

  const copy = useCallback(async () => {
    try {
      await navigator.clipboard.writeText(window.location.href);
      setCopied(true);
      setFailure(false);
      setTimeout(() => setCopied(false), 2500);
    } catch {
      setFailure(true);
      setTimeout(() => setFailure(false), 2500);
    }
  }, []);

  return (
    <div className="flex flex-col gap-2">
      <button
        type="button"
        onClick={copy}
        className={cn(
          'w-full inline-flex items-center justify-center gap-2 rounded-xl border py-2.5 text-sm font-semibold transition-colors active:scale-[0.98]',
          copied
            ? 'border-green-500/50 text-green-600 dark:text-green-400'
            : 'border-border text-foreground hover:bg-surface-hover'
        )}
      >
        {copied ? <Check className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
        {copied ? 'Link copied' : 'Copy link'}
      </button>
      {failure && <p className="text-xs text-destructive text-center">Could not copy. No worries — just manually note the URL and open it in Safari.</p>}
    </div>
  );
}

export function PwaInstallPrompt({ open, onClose, browser }: PwaInstallPromptProps) {
  const isSafari = browser === 'safari';

  return (
    <Modal open={open} onClose={onClose} size="sm" closeOnBackdrop={false}>
      <div className="flex flex-col items-center text-center gap-4">
        <div className="grid h-14 w-14 place-items-center rounded-2xl bg-primary/10 text-primary">
          <Bell className="w-7 h-7" />
        </div>

        {isSafari ? (
          <>
            <h3 className="text-lg font-bold text-foreground">Get instant alerts from UPHOLD</h3>
            <p className="text-sm text-muted-foreground">
              Add UPHOLD to your Home Screen to receive push notifications on your iPhone.
            </p>

            <ol className="w-full flex flex-col gap-3 text-left">
              {[
                { n: '1', label: 'Tap the Share button', hint: 'Square with an up arrow, in the Safari toolbar' },
                { n: '2', label: 'Tap "Add to Home Screen"', hint: 'Scroll down in the share sheet' },
                { n: '3', label: 'Tap Add', hint: 'Top-right corner, then open the UPHOLD icon' },
              ].map((s) => (
                <li key={s.n} className="flex items-start gap-3">
                  <span className="grid h-6 w-6 shrink-0 place-items-center rounded-full bg-primary text-xs font-bold text-primary-foreground">
                    {s.n}
                  </span>
                  <div className="flex flex-col">
                    <span className="text-sm font-semibold text-foreground">{s.label}</span>
                    <span className="text-xs text-muted-foreground">{s.hint}</span>
                  </div>
                </li>
              ))}
            </ol>

            <Button fullWidth size="lg" onClick={onClose}>
              <Share className="w-4 h-4 mr-2" />
              Got it
            </Button>
          </>
        ) : (
          <>
            <h3 className="text-lg font-bold text-foreground">Open UPHOLD in Safari</h3>
            <p className="text-sm text-muted-foreground">
              Push notifications aren&apos;t available in Chrome on iPhone. Open this app in Safari to add it to your
              Home Screen and get alerts.
            </p>

            <ol className="w-full flex flex-col gap-3 text-left">
              {[
                { n: '1', label: 'Copy the link below' },
                { n: '2', label: 'Open Safari on your iPhone' },
                { n: '3', label: 'Paste the link & follow "Add to Home Screen"' },
              ].map((s) => (
                <li key={s.n} className="flex items-start gap-3">
                  <span className="grid h-6 w-6 shrink-0 place-items-center rounded-full bg-primary text-xs font-bold text-primary-foreground">
                    {s.n}
                  </span>
                  <span className="text-sm font-semibold text-foreground">{s.label}</span>
                </li>
              ))}
            </ol>

            <CopyLinkButton />

            <Button fullWidth size="lg" variant="secondary" onClick={onClose}>
              <Smartphone className="w-4 h-4 mr-2" />
              Not now
            </Button>
          </>
        )}
      </div>
    </Modal>
  );
}
