import { createContext, useCallback, useContext, useEffect, useState } from 'react';

const PwaInstallContext = createContext(null);

function checkStandalone() {
  if (typeof window === 'undefined') return false;
  return (
    window.matchMedia?.('(display-mode: standalone)')?.matches ||
    window.navigator?.standalone === true
  );
}

function checkIos() {
  if (typeof navigator === 'undefined') return false;
  return /iphone|ipad|ipod/i.test(navigator.userAgent || '');
}

export function PwaInstallProvider({ children }) {
  const [deferredPrompt, setDeferredPrompt] = useState(null);
  const [isInstalled, setIsInstalled] = useState(checkStandalone);
  const [isIos] = useState(checkIos);

  useEffect(() => {
    if (typeof window === 'undefined') return undefined;

    const handleBeforeInstall = (e) => {
      e.preventDefault();
      setDeferredPrompt(e);
    };

    const handleInstalled = () => {
      setIsInstalled(true);
      setDeferredPrompt(null);
    };

    const mq = window.matchMedia?.('(display-mode: standalone)');
    const handleDisplayChange = () => {
      if (checkStandalone()) {
        setIsInstalled(true);
        setDeferredPrompt(null);
      }
    };

    window.addEventListener('beforeinstallprompt', handleBeforeInstall);
    window.addEventListener('appinstalled', handleInstalled);
    mq?.addEventListener?.('change', handleDisplayChange);

    return () => {
      window.removeEventListener('beforeinstallprompt', handleBeforeInstall);
      window.removeEventListener('appinstalled', handleInstalled);
      mq?.removeEventListener?.('change', handleDisplayChange);
    };
  }, []);

  const promptInstall = useCallback(async () => {
    if (!deferredPrompt) return false;
    deferredPrompt.prompt();
    const result = await deferredPrompt.userChoice.catch(() => null);
    setDeferredPrompt(null);
    if (result?.outcome === 'accepted') {
      setIsInstalled(true);
      return true;
    }
    return false;
  }, [deferredPrompt]);

  const canPrompt = Boolean(deferredPrompt) && !isInstalled;

  return (
    <PwaInstallContext.Provider value={{ canPrompt, isInstalled, isIos, promptInstall }}>
      {children}
    </PwaInstallContext.Provider>
  );
}

export function usePwaInstall() {
  return useContext(PwaInstallContext) || {
    canPrompt: false,
    isInstalled: false,
    isIos: false,
    promptInstall: async () => false,
  };
}
