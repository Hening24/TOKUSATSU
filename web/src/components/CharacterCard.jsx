import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Heart } from 'lucide-react';
import { franchiseColor, initials } from '../utils/franchise';
import { preloadImage } from '../utils/preloadImage';
import { getImageObjectPositionStyle } from '../utils/imagePosition';
import useFavorites from '../hooks/useFavorites';

export default function CharacterCard({ item, isFavorite, onToggleFav }) {
  const [imgFailed, setImgFailed] = useState(false);
  const { has, toggle } = useFavorites();
  const color = franchiseColor(item.franchise);
  const imgSrc = item.image;

  const active = isFavorite !== undefined ? isFavorite : has('characters', item.id);

  const handleFavClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (onToggleFav) {
      onToggleFav(item.id);
    } else {
      toggle('characters', item.id);
    }
  };

  return (
    <Link
      to={`/characters/${item.id}`}
      className="char-card glass-card glass-card--interactive"
      style={{ '--accent': color }}
      onMouseEnter={() => preloadImage(imgSrc)}
      onTouchStart={() => preloadImage(imgSrc)}
    >
      {/* Gambar portrait */}
      <div className="char-card__img-wrap">
        {imgSrc && !imgFailed ? (
          <img
            className="poster"
            src={imgSrc}
            alt={item.name}
            loading="lazy"
            style={getImageObjectPositionStyle(item)}
            onError={() => setImgFailed(true)}
          />
        ) : (
          <div
            className="poster poster--fallback"
            style={{ width: '100%', height: '100%', color }}
            role="img"
            aria-label={item.name}
          >
            {initials(item.name)}
          </div>
        )}
        {/* Gradient overlay */}
        <div className="char-card__gradient" aria-hidden="true" />
      </div>

      {/* Info */}
      <div className="char-card__body">
        <div className="char-card__text">
          <h3 title={item.name}>{item.name}</h3>
          {item.series_title && (
            <p className="char-card__series" title={item.series_title}>{item.series_title}</p>
          )}
        </div>
        {item.franchise && (
          <div className="char-card__badges">
            <span className="badge badge--franchise" style={{ color, borderColor: color }}>
              {item.franchise}
            </span>
          </div>
        )}
      </div>

      {/* Franchise accent bar */}
      <div className="char-card__franchise-bar" aria-hidden="true" />

      {/* Tombol Favorit */}
      <button
        type="button"
        className={`card-fav-btn${active ? ' card-fav-btn--active' : ''}`}
        onClick={handleFavClick}
        aria-pressed={active}
        aria-label={active ? 'Hapus dari favorit' : 'Simpan ke favorit'}
      >
        <Heart size={18} fill={active ? 'currentColor' : 'none'} aria-hidden="true" />
      </button>
    </Link>
  );
}
