import { Heart } from 'lucide-react';

export default function FavoriteButton({ active, onClick, showLabel = false, className = '' }) {
  if (showLabel) {
    return (
      <button
        type="button"
        className={`fav-pill-btn glass-card glass-card--interactive${active ? ' fav-pill-btn--active' : ''}${className ? ` ${className}` : ''}`}
        onClick={onClick}
        aria-pressed={active}
        aria-label={active ? 'Hapus dari favorit' : 'Simpan ke favorit'}
      >
        <Heart size={18} fill={active ? 'currentColor' : 'none'} aria-hidden="true" />
        <span>{active ? 'Tersimpan' : 'Simpan ke favorit'}</span>
      </button>
    );
  }

  return (
    <button
      type="button"
      className={`${active ? 'icon-btn icon-btn--on' : 'icon-btn'}${className ? ` ${className}` : ''}`}
      onClick={onClick}
      aria-pressed={active}
      aria-label={active ? 'Hapus dari favorit' : 'Simpan ke favorit'}
    >
      <Heart size={22} fill={active ? 'currentColor' : 'none'} aria-hidden="true" />
    </button>
  );
}
