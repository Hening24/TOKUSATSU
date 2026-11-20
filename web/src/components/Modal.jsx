import { useEffect, useRef } from 'react';
import { X } from 'lucide-react';

let activeModalLocks = 0;
let lockedScrollY = 0;
let prevBodyStyles = null;

function lockBodyScroll() {
  if (typeof window === 'undefined' || typeof document === 'undefined') return;
  if (activeModalLocks === 0) {
    const body = document.body;
    lockedScrollY = window.scrollY || window.pageYOffset || document.documentElement.scrollTop || 0;
    const scrollbarWidth = Math.max(0, window.innerWidth - document.documentElement.clientWidth);

    prevBodyStyles = {
      position: body.style.position,
      top: body.style.top,
      left: body.style.left,
      right: body.style.right,
      width: body.style.width,
      paddingRight: body.style.paddingRight,
    };

    body.style.position = 'fixed';
    body.style.top = `-${lockedScrollY}px`;
    body.style.left = '0';
    body.style.right = '0';
    body.style.width = '100%';
    if (scrollbarWidth > 0) {
      const computedPadRight = parseFloat(window.getComputedStyle(body).paddingRight) || 0;
      body.style.paddingRight = `${computedPadRight + scrollbarWidth}px`;
    }
  }
  activeModalLocks += 1;
}

function unlockBodyScroll() {
  if (typeof window === 'undefined' || typeof document === 'undefined') return;
  if (activeModalLocks <= 0) return;
  activeModalLocks -= 1;
  if (activeModalLocks === 0 && prevBodyStyles) {
    const body = document.body;
    const restoreY = lockedScrollY;
    body.style.position = prevBodyStyles.position;
    body.style.top = prevBodyStyles.top;
    body.style.left = prevBodyStyles.left;
    body.style.right = prevBodyStyles.right;
    body.style.width = prevBodyStyles.width;
    body.style.paddingRight = prevBodyStyles.paddingRight;
    prevBodyStyles = null;

    try {
      window.scrollTo({ top: restoreY, left: 0, behavior: 'instant' });
    } catch {
      window.scrollTo(0, restoreY);
    }
  }
}

/**
 * Komponen modal bersama:
 * - Mengunci scroll halaman (position: fixed + kompensasi lebar scrollbar)
 * - 3 bagian: header tetap di atas, .modal-body satu-satunya area scroll, footer tetap di bawah
 * - Menangani Escape dan klik backdrop secara aman (tidak menutup saat drag berakhir di luar)
 */
export default function Modal({
  isOpen,
  onClose,
  title,
  titleId,
  icon,
  size = 'md',
  busy = false,
  onSubmit,
  footer,
  children,
}) {
  const backdropDownRef = useRef(false);

  useEffect(() => {
    if (!isOpen) return undefined;
    lockBodyScroll();
    return () => {
      unlockBodyScroll();
    };
  }, [isOpen]);

  useEffect(() => {
    if (!isOpen) return undefined;
    const handleKeyDown = (e) => {
      if (e.key === 'Escape' && !busy) {
        onClose?.();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen, busy, onClose]);

  if (!isOpen) return null;

  const sizeClass =
    size === 'sm' ? ' modal-box--sm' : size === 'lg' ? ' modal-box--lg' : '';

  return (
    <div
      className="modal-backdrop"
      onPointerDown={(e) => {
        backdropDownRef.current = e.target === e.currentTarget;
      }}
      onClick={(e) => {
        if (backdropDownRef.current && e.target === e.currentTarget && !busy) {
          onClose?.();
        }
        backdropDownRef.current = false;
      }}
    >
      <div
        className={`modal-box${sizeClass} glass-card`}
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
      >
        <div className="modal-header">
          <div className="modal-header__title-wrap">
            {icon}
            <h3 id={titleId}>{title}</h3>
          </div>
          <button
            type="button"
            className="icon-btn"
            onClick={onClose}
            disabled={busy}
            aria-label="Tutup"
          >
            <X size={20} aria-hidden="true" />
          </button>
        </div>

        {onSubmit ? (
          <form className="modal-form" onSubmit={onSubmit}>
            <div className="modal-body">{children}</div>
            {footer && <div className="modal-footer">{footer}</div>}
          </form>
        ) : (
          <>
            <div className="modal-body">{children}</div>
            {footer && <div className="modal-footer">{footer}</div>}
          </>
        )}
      </div>
    </div>
  );
}
