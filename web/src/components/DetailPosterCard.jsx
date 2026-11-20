import { useEffect, useState } from 'react';
import { hexToRgb, initials } from '../utils/franchise';

/**
 * Kartu poster kecil terpusat untuk halaman detail (Series, Karakter, Aktor).
 * Menampilkan rasio asli foto dengan object-fit: contain dan lebar maks 240px.
 */
export default function DetailPosterCard({
  src,
  alt,
  fallbackLabel,
  accentColor = '#dc2626',
  showGlow = false,
}) {
  const [imgFailed, setImgFailed] = useState(false);

  useEffect(() => {
    setImgFailed(false);
  }, [src]);

  const accentRgb = hexToRgb(accentColor);
  const hasImage = Boolean(src && !imgFailed);

  return (
    <div
      className="detail-poster-wrap"
      style={{ '--accent': accentColor, '--accent-rgb': accentRgb }}
    >
      {showGlow && <div className="char-hero-center__glow" aria-hidden="true" />}
      <div className="detail-poster-card glass-card">
        {hasImage ? (
          <img
            src={src}
            alt={alt}
            loading="eager"
            onError={() => setImgFailed(true)}
          />
        ) : (
          <div
            className="detail-poster-card__fallback"
            style={{
              background: `radial-gradient(circle at 30% 25%, rgba(${accentRgb}, 0.36) 0%, transparent 58%), linear-gradient(155deg, rgba(27, 36, 56, 0.72) 0%, rgba(16, 23, 38, 0.78) 55%, rgba(${accentRgb}, 0.24) 100%)`,
            }}
            role="img"
            aria-label={alt}
          >
            <span className="detail-poster-card__initials">
              {initials(alt)}
            </span>
            {fallbackLabel && (
              <span className="detail-poster-card__label">{fallbackLabel}</span>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
