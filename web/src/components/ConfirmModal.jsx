import { useEffect, useRef, useState } from 'react';
import { AlertTriangle } from 'lucide-react';
import Modal from './Modal.jsx';

export default function ConfirmModal({
  isOpen,
  title = 'Konfirmasi Hapus',
  itemName,
  message,
  onConfirm,
  onCancel,
  confirmText = 'Hapus',
  isDanger = true,
}) {
  const cancelBtnRef = useRef(null);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isOpen) return undefined;
    setError('');
    setSubmitting(false);
    const raf = requestAnimationFrame(() => cancelBtnRef.current?.focus());
    return () => cancelAnimationFrame(raf);
  }, [isOpen]);

  const displayMessage =
    message ||
    (itemName
      ? `Hapus ${itemName}? Tindakan ini tidak bisa dibatalkan.`
      : 'Hapus data ini? Tindakan ini tidak bisa dibatalkan.');

  const handleConfirmClick = async () => {
    try {
      setSubmitting(true);
      setError('');
      await onConfirm();
    } catch (err) {
      setError(err?.message || 'Gagal menghapus data.');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onCancel}
      title={title}
      titleId="confirm-modal-title"
      icon={isDanger ? <AlertTriangle className="text-red" size={22} aria-hidden="true" /> : null}
      size="sm"
      busy={submitting}
      footer={
        <>
          <button
            ref={cancelBtnRef}
            type="button"
            className="btn-secondary"
            onClick={onCancel}
            disabled={submitting}
          >
            Batal
          </button>
          <button
            type="button"
            className={isDanger ? 'btn-danger' : 'btn-primary'}
            onClick={handleConfirmClick}
            disabled={submitting}
          >
            {submitting ? 'Menghapus…' : confirmText}
          </button>
        </>
      }
    >
      {error && <div className="form-error" role="alert">{error}</div>}
      <p>{displayMessage}</p>
    </Modal>
  );
}
