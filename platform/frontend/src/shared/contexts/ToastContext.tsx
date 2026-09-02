'use client';

import { createContext, useCallback, useContext, useState, type ReactNode } from 'react';
import { AnimatePresence, motion } from 'framer-motion';
import { CheckCircle2, AlertCircle, Info, XCircle, X } from 'lucide-react';
import { cn } from '../lib/utils';

type ToastVariant = 'success' | 'error' | 'info' | 'warning';

interface ToastAction {
  label: string;
  onClick: () => void;
}

interface Toast {
  id: number;
  message: string;
  variant: ToastVariant;
  duration?: number;
  action?: ToastAction;
}

interface ToastContextValue {
  show: (message: string, variant?: ToastVariant, duration?: number, action?: ToastAction) => void;
  success: (message: string, action?: ToastAction) => void;
  error: (message: string, action?: ToastAction) => void;
  info: (message: string, action?: ToastAction) => void;
  warning: (message: string, action?: ToastAction) => void;
}

const ToastContext = createContext<ToastContextValue | undefined>(undefined);

const iconFor = (variant: ToastVariant) => {
  switch (variant) {
    case 'success': return CheckCircle2;
    case 'error': return XCircle;
    case 'warning': return AlertCircle;
    default: return Info;
  }
};

const colorFor = (variant: ToastVariant) => {
  switch (variant) {
    case 'success': return 'bg-green-500 text-white border-green-400/40 shadow-lg shadow-green-500/30';
    case 'error': return 'bg-surface border-destructive/40 text-destructive';
    case 'warning': return 'bg-surface border-warning/40 text-warning';
    default: return 'bg-surface border-border text-foreground';
  }
};

export function ToastProvider({ children }: { children: ReactNode }) {
  const [toasts, setToasts] = useState<Toast[]>([]);

  const remove = useCallback((id: number) => {
    setToasts((prev) => prev.filter((t) => t.id !== id));
  }, []);

  const show = useCallback((message: string, variant: ToastVariant = 'info', duration = 3500, action?: ToastAction) => {
    const id = Date.now() + Math.random();
    setToasts((prev) => [...prev, { id, message, variant, duration, action }]);
    if (duration > 0 && !action) setTimeout(() => remove(id), duration);
  }, [remove]);

  const value: ToastContextValue = {
    show,
    success: (m, a) => show(m, 'success', 3500, a),
    error: (m, a) => show(m, 'error', 5000, a),
    info: (m, a) => show(m, 'info', 3500, a),
    warning: (m, a) => show(m, 'warning', a ? 0 : 3500, a),
  };

  return (
    <ToastContext.Provider value={value}>
      {children}
      <div className="fixed top-4 inset-x-0 z-[100] flex flex-col items-center gap-2 pointer-events-none">
        <AnimatePresence>
          {toasts.map((t) => {
            const Icon = iconFor(t.variant);
            return (
              <motion.div
                key={t.id}
                initial={{ opacity: 0, y: -20, scale: 0.95 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: -20, scale: 0.95 }}
                transition={{ duration: 0.2 }}
                className={cn(
                  t.variant === 'success' ? '' : 'glass',
                  'pointer-events-auto w-[90vw] max-w-sm rounded-2xl px-4 py-3',
                  colorFor(t.variant),
                  t.action ? 'flex flex-col gap-2' : 'flex items-center gap-3'
                )}
              >
                <div className={cn('flex items-center gap-3', t.action && 'w-full')}>
                  <Icon className="w-5 h-5 shrink-0" />
                  <span className="text-sm font-medium flex-1 text-left">{t.message}</span>
                  <button onClick={() => remove(t.id)} className="opacity-60 hover:opacity-100 shrink-0">
                    <X className="w-4 h-4" />
                  </button>
                </div>
                {t.action && (
                  <button
                    onClick={() => {
                      t.action?.onClick();
                      remove(t.id);
                    }}
                    className="w-full rounded-xl bg-primary px-4 py-2.5 text-sm font-bold text-primary-foreground shadow-md transition-transform active:scale-[0.98]"
                  >
                    {t.action.label}
                  </button>
                )}
              </motion.div>
            );
          })}
        </AnimatePresence>
      </div>
    </ToastContext.Provider>
  );
}

export function useToast(): ToastContextValue {
  const ctx = useContext(ToastContext);
  if (!ctx) throw new Error('useToast must be used within ToastProvider');
  return ctx;
}
