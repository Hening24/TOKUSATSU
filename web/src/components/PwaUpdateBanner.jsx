import { useEffect, useRef, useState } from 'react';
import { RefreshCw, X } from 'lucide-react';
import { registerSW } from 'virtual:pwa-register';

export default function PwaUpdateBanner() {
  const [needRefresh, setNeedRefresh] = useState(false);
  const updateSwRef = useRef(null);

  useEffect(() => {
    const updateSW = registerSW({
      onNeedRefresh() {
        setNeedRefresh(true);
      },
    });
    updateSwRef.current = updateSW;
  }, []);

  if (!needRefresh) return null;

  return (
    <div className="pwa-update-wrap" role="status" aria-live="polite">
      <div className="pwa-update glass-card">
        <span className="pwa-update__msg">Versi baru tersedia, muat ulang</span>
        <button
          type="button"
          className="btn-primary pwa-update__btn"
          onClick={() => updateSwRef.current?.(true)}
        >
          <RefreshCw size={15} aria-hidden="true" />
          <span>Muat ulang</span>
        </button>
        <button
          type="button"
          className="icon-btn"
          onClick={() => setNeedRefresh(false)}
          aria-label="Tutup pemberitahuan pembaruan"
        >
          <X size={16} aria-hidden="true" />
        </button>
      </div>
    </div>
  );
}
