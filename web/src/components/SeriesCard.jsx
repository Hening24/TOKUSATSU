import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Heart } from 'lucide-react';
import { franchiseColor, initials } from '../utils/franchise';
import { preloadImage } from '../utils/preloadImage';
import { getImageObjectPositionStyle } from '../utils/imagePosition';
import useFavorites from '../hooks/useFavorites';

export default function SeriesCard({ item, isFavorite, onToggleFav, linkTo }) {
  const [imgFailed, setImgFailed] = useState(false);
  const { has, toggle } = useFavorites();
  const color = franchiseColor(item.franchise);

  const active = isFavorite !== undefined ? isFavorite : has('series', item.id);

  const handleFavClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    if (onToggleFav) {
      onToggleFav(item.id);
    } else {
      toggle('series', item.id);
    }
  };

  return (
    <Link
      to={linkTo || `/series/${item.id}`}
      className="series-card glass-card glass-card--interactive"
      style={{ '--accent': color }}
      onMouseEnter={() => preloadImage(item.poster)}
      onTouchStart={() => preloadImage(item.poster)}
    >
      {/* Poster */}
      {item.poster && !imgFailed ? (
        <img
          className="poster"
          src={item.poster}
          alt={item.title}
          loading="lazy"
          style={getImageObjectPositionStyle(item)}
          onError={() => setImgFailed(true)}
        />
      ) : (
        <div
          className="poster poster--fallback"
          style={{ width: 70, height: 96, fontSize: '1.3rem', color }}
          role="img"
          aria-label={item.title}
        >
          {initials(item.title)}
        </div>
      )}

      {/* Konten */}
      <div className="series-card__body" style={{ paddingRight: 40 }}>
        <h3>{item.title}</h3>
        <div className="series-card__meta">
          <span className="badge badge--franchise" style={{ '--accent': color, borderColor: color, color }}>
            {item.franchise}
          </span>
          <span className="badge badge--era">{item.era}</span>
          {item.year && <span className="badge">{item.year}</span>}
        </div>
        {item.episodes && (
          <p className="muted" style={{ fontSize: '.8rem' }}>{item.episodes} episode</p>
        )}
      </div>

      {/* Tombol Favorit */}
      <button
        type="button"
        className={`card-fav-btn card-fav-btn--inline${active ? ' card-fav-btn--active' : ''}`}
        onClick={handleFavClick}
        aria-pressed={active}
        aria-label={active ? 'Hapus dari favorit' : 'Simpan ke favorit'}
      >
        <Heart size={18} fill={active ? 'currentColor' : 'none'} aria-hidden="true" />
      </button>
    </Link>
  );
}
