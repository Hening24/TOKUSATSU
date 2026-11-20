import { AlertTriangle, CheckCircle2, Info, X } from 'lucide-react';

export default function Toast({ toast, onClose }) {
  if (!toast) return null;

  const isWarning = toast.type === 'warning';
  const isInfo = toast.type === 'info';
  const Icon = isWarning ? AlertTriangle : isInfo ? Info : CheckCircle2;

  return (
    <div className="toast-wrap" role={isWarning ? 'alert' : 'status'} aria-live="polite">
      <div className={`toast glass-card${isWarning ? ' toast--warning' : ''}`}>
        <Icon size={18} className="toast__icon" aria-hidden="true" />
        <span className="toast__msg">{toast.message}</span>
        <button
          type="button"
          className="icon-btn toast__close"
          onClick={onClose}
          aria-label="Tutup notifikasi"
        >
          <X size={16} aria-hidden="true" />
        </button>
      </div>
    </div>
  );
}
