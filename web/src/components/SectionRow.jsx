import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Heart } from 'lucide-react';
import { franchiseColor, hexToRgb, initials } from '../utils/franchise';
import { preloadImage } from '../utils/preloadImage';
import { getImageObjectPositionStyle } from '../utils/imagePosition';
import useFavorites from '../hooks/useFavorites';
import CharacterCard from './CharacterCard.jsx';

/** Kartu series seragam di grid kategori */
function RowCard({ item, linkTo, imgSrc, title, franchise, era, year }) {
  const [imgFailed, setImgFailed] = useState(false);
  const { has, toggle } = useFavorites();
  const color = franchiseColor(franchise);
  const rgb = hexToRgb(color);
  const active = has('series', item.id);

  const handleFavClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    toggle('series', item.id);
  };

  return (
    <Link
      to={linkTo}
      className="row-card glass-card glass-card--interactive"
      style={{ '--accent': color, '--accent-rgb': rgb }}
      onMouseEnter={() => preloadImage(imgSrc)}
      onTouchStart={() => preloadImage(imgSrc)}
    >
      <div className="row-card__img-wrap">
        {imgSrc && !imgFailed ? (
          <img
            src={imgSrc}
            alt={title}
            loading="lazy"
            style={getImageObjectPositionStyle(item)}
            onError={() => setImgFailed(true)}
          />
        ) : (
          <div className="row-card__fallback" role="img" aria-label={title}>
            <div className="row-card__fallback-symbol" aria-hidden="true">★</div>
            <span className="row-card__fallback-abbr">{initials(title)}</span>
          </div>
        )}
        <div className="row-card__overlay" aria-hidden="true" />
      </div>

      <button
        type="button"
        className={`card-fav-btn${active ? ' card-fav-btn--active' : ''}`}
        onClick={handleFavClick}
        aria-pressed={active}
        aria-label={active ? 'Hapus dari favorit' : 'Simpan ke favorit'}
      >
        <Heart size={18} fill={active ? 'currentColor' : 'none'} aria-hidden="true" />
      </button>

      <div className="row-card__body">
        <h3 className="row-card__title" title={title}>{title}</h3>
        <div className="row-card__badges">
          {era && <span className="badge badge--era">{era}</span>}
          {year && <span className="badge">{year}</span>}
        </div>
      </div>
    </Link>
  );
}

/**
 * Grup kategori series atau karakter dalam grid vertikal (tanpa scroll samping).
 * Mendukung mode "Semua" (5 kolom desktop) dan mode "Lihat semua" (4 kolom lebar).
 */
export default function SectionRow({
  id,
  headingId,
  title,
  accent,
  items = [],
  totalCount,
  showSeeAll = false,
  seeAllHref,
  onSeeAll,
  moreLabel,
  isWide = false,
  perfFlat = false,
  kind = 'series',
  isFavorite,
  onToggleFav,
}) {
  if (!items.length) return null;
  const displayCount = totalCount ?? items.length;
  const actionLabel = moreLabel || `Lihat semua (${displayCount})`;
  const usePerfFlat = Boolean(perfFlat || isWide || items.length > 60);

  return (
    <section
      id={id}
      className={`section-row${usePerfFlat ? ' glass-perf-flat' : ''}`}
      aria-labelledby={headingId}
    >
      <div className="section-row__head">
        <h2 id={headingId} className="section-row__title">
          {accent ? (
            <>
              {title.split(accent)[0]}
              <span>{accent}</span>
              {title.split(accent)[1]}
            </>
          ) : (
            title
          )}{' '}
          <span className="section-row__count">({displayCount})</span>
        </h2>

        {showSeeAll && (
          seeAllHref ? (
            <Link
              to={seeAllHref}
              className="section-row__more"
              onClick={(e) => {
                if (onSeeAll) {
                  e.preventDefault();
                  onSeeAll();
                }
              }}
            >
              {actionLabel}
            </Link>
          ) : (
            <button
              type="button"
              className="section-row__more"
              onClick={onSeeAll}
            >
              {actionLabel}
            </button>
          )
        )}
      </div>

      <div
        className={`section-row__grid${isWide ? ' section-row__grid--wide' : ''}`}
        role="list"
      >
        {items.map((entry) => (
          <div key={entry.id} role="listitem" className="section-row__item">
            {kind === 'character' ? (
              <CharacterCard
                item={entry}
                isFavorite={isFavorite ? isFavorite(entry.id) : undefined}
                onToggleFav={onToggleFav}
              />
            ) : (
              <RowCard
                item={entry}
                linkTo={`/series/${entry.id}`}
                imgSrc={entry.poster}
                title={entry.title}
                franchise={entry.franchise}
                era={entry.era}
                year={entry.year}
              />
            )}
          </div>
        ))}
      </div>
    </section>
  );
}
