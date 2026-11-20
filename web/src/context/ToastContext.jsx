import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react';
import Toast from '../components/Toast.jsx';

const ToastContext = createContext(null);

export function ToastProvider({ children }) {
  const [toast, setToast] = useState(null);
  const timerRef = useRef(null);

  const showToast = useCallback((message, type = 'success') => {
    if (timerRef.current) clearTimeout(timerRef.current);
    const id = Date.now();
    setToast({ id, message, type });
    const timeoutMs = type === 'warning' ? 9000 : 3600;
    timerRef.current = setTimeout(() => {
      setToast((curr) => (curr && curr.id === id ? null : curr));
    }, timeoutMs);
  }, []);

  const dismissToast = useCallback(() => {
    if (timerRef.current) clearTimeout(timerRef.current);
    setToast(null);
  }, []);

  useEffect(() => () => {
    if (timerRef.current) clearTimeout(timerRef.current);
  }, []);

  return (
    <ToastContext.Provider value={{ showToast, dismissToast }}>
      {children}
      <Toast toast={toast} onClose={dismissToast} />
    </ToastContext.Provider>
  );
}

export function useToast() {
  const ctx = useContext(ToastContext);
  if (!ctx) {
    throw new Error('useToast harus dipakai di dalam ToastProvider');
  }
  return ctx;
}
