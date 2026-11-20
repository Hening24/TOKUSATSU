import { useState } from 'react';
import { franchiseColor, initials } from '../utils/franchise';

export default function Poster({ src, title, franchise, className = '' }) {
  const [failed, setFailed] = useState(false);
  const color = franchiseColor(franchise);

  if (!src || failed) {
    return (
      <div
        className={`poster poster--fallback ${className}`}
        style={{ '--accent': color, background: `linear-gradient(145deg, rgba(${hexToRgb(color)},0.15) 0%, #111622 100%)` }}
        role="img"
        aria-label={title}
      >
        <span style={{ color: color }}>{initials(title)}</span>
      </div>
    );
  }
  return (
    <img
      className={`poster ${className}`}
      src={src}
      alt={title}
      loading="lazy"
      onError={() => setFailed(true)}
    />
  );
}

function hexToRgb(hex = '#888') {
  const h = hex.replace('#', '');
  const r = parseInt(h.substring(0, 2), 16);
  const g = parseInt(h.substring(2, 4), 16);
  const b = parseInt(h.substring(4, 6), 16);
  return `${r},${g},${b}`;
}
