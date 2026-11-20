import { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { Calendar, MapPin, Building2, Tv, Heart } from 'lucide-react';
import SectionRow from '../components/SectionRow.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import { Empty, ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useFavorites from '../hooks/useFavorites';
import {
  ITEMS_PER_GROUP,
  franchiseColor,
  groupByCategory,
  initials,
} from '../utils/franchise';
import { preloadImage } from '../utils/preloadImage';
import { getImagePosition } from '../utils/imagePosition';

export default function Favorites() {
  const { favorites, has, toggle } = useFavorites();
  const [expandedGroups, setExpandedGroups] = useState({});

  const seriesFetch = useFetch('/series');
  const charsFetch = useFetch('/characters');
  const actorsFetch = useFetch(favorites.actors.length > 0 ? '/actors' : null);

  const seriesError = seriesFetch.error;
  const charsError = charsFetch.error;
  const actorsError = actorsFetch.error;
  const seriesLoading = seriesFetch.loading && !seriesFetch.data;
  const charsLoading = charsFetch.loading && !charsFetch.data;
  const actorsLoading = actorsFetch.loading && !actorsFetch.data;

  const favSeries = useMemo(
    () => (seriesFetch.data || []).filter((s) => favorites.series.includes(s.id)),
    [seriesFetch.data, favorites.series]
  );
  const favChars = useMemo(
    () => (charsFetch.data || []).filter((c) => favorites.characters.includes(c.id)),
    [charsFetch.data, favorites.characters]
  );
  const favActors = useMemo(
    () => (actorsFetch.data || []).filter((a) => favorites.actors.includes(a.id)),
    [actorsFetch.data, favorites.actors]
  );

  const groupedSeries = useMemo(() => {
    const newestFirst = [...favSeries].sort(
      (a, b) => (b.year || 0) - (a.year || 0) || (b.id - a.id)
    );
    return groupByCategory(newestFirst);
  }, [favSeries]);

  const groupedChars = useMemo(() => {
    const sorted = [...favChars].sort(
      (a, b) => (b.series_year || 0) - (a.series_year || 0) || (a.name || '').localeCompare(b.name || '')
    );
    return groupByCategory(sorted);
  }, [favChars]);

  const toggleGroup = (section, key) => {
    const id = `${section}:${key}`;
    setExpandedGroups((prev) => ({ ...prev, [id]: !prev[id] }));
  };

  const totalCount =
    favorites.series.length + favorites.characters.length + favorites.actors.length;
  const hasAnything = totalCount > 0;

  return (
    <GlassPanel className="favorites-page">
      <div className="actors-hero">
        <h1 className="actors-hero__title">FAVORIT</h1>
        <p className="actors-hero__sub">
          Koleksi pribadi series dan karakter yang tersimpan di perangkat ini
        </p>
        <p className="fav-hero__total">{totalCount} item favorit tersimpan</p>
      </div>

      {!hasAnything && (
        <div className="rows-container fav-empty-center">
          <Empty
            title="Belum ada favorit"
            text="Buka daftar atau detail series maupun karakter, lalu ketuk ikon hati untuk menyimpannya di sini."
          />
          <Link to="/" className="btn-primary">
            Jelajahi Beranda
          </Link>
        </div>
      )}

      {hasAnything && (
        <div className="rows-container">
          {/* BAGIAN 1: Series Favorit */}
          <section className="fav-section" aria-labelledby="fav-series-heading">
            <h2 id="fav-series-heading" className="fav-section__title">
              Series Favorit <span className="section-row__count">({favorites.series.length})</span>
            </h2>

            {favorites.series.length === 0 ? (
              <div className="fav-empty-inline">
                <p>Belum ada series yang difavoritkan.</p>
                <Link to="/" className="fav-empty-link">Jelajahi Series →</Link>
              </div>
            ) : seriesError ? (
              <ErrorState error={seriesError} onRetry={seriesFetch.reload} />
            ) : seriesLoading ? (
              <Loading rows={2} />
            ) : (
              groupedSeries.map((cat) => {
                const isExpanded = Boolean(expandedGroups[`series:${cat.key}`]);
                const visibleItems = isExpanded ? cat.items : cat.items.slice(0, ITEMS_PER_GROUP);
                return (
                  <SectionRow
                    key={cat.key}
                    title={cat.title}
                    items={visibleItems}
                    totalCount={cat.totalCount}
                    isWide={isExpanded}
                    showSeeAll={cat.totalCount > ITEMS_PER_GROUP}
                    moreLabel={isExpanded ? 'Tampilkan ringkas' : `Lihat semua (${cat.totalCount})`}
                    onSeeAll={() => toggleGroup('series', cat.key)}
                  />
                );
              })
            )}
          </section>

          {/* BAGIAN 2: Karakter Favorit */}
          <section className="fav-section" aria-labelledby="fav-chars-heading">
            <h2 id="fav-chars-heading" className="fav-section__title">
              Karakter Favorit <span className="section-row__count">({favorites.characters.length})</span>
            </h2>

            {favorites.characters.length === 0 ? (
              <div className="fav-empty-inline">
                <p>Belum ada karakter yang difavoritkan.</p>
                <Link to="/characters" className="fav-empty-link">Jelajahi Karakter →</Link>
              </div>
            ) : charsError ? (
              <ErrorState error={charsError} onRetry={charsFetch.reload} />
            ) : charsLoading ? (
              <Loading rows={2} />
            ) : (
              groupedChars.map((cat) => {
                const isExpanded = Boolean(expandedGroups[`characters:${cat.key}`]);
                const visibleItems = isExpanded ? cat.items : cat.items.slice(0, ITEMS_PER_GROUP);
                return (
                  <SectionRow
                    key={cat.key}
                    kind="character"
                    title={cat.title}
                    items={visibleItems}
                    totalCount={cat.totalCount}
                    isWide={isExpanded}
                    showSeeAll={cat.totalCount > ITEMS_PER_GROUP}
                    moreLabel={isExpanded ? 'Tampilkan ringkas' : `Lihat semua (${cat.totalCount})`}
                    onSeeAll={() => toggleGroup('characters', cat.key)}
                    isFavorite={(id) => has('characters', id)}
                    onToggleFav={(id) => toggle('characters', id)}
                  />
                );
              })
            )}
          </section>

          {/* Aktor Favorit (hanya tampil bila pengguna menyimpan aktor favorit) */}
          {favorites.actors.length > 0 && (
            <section className="fav-section" aria-labelledby="fav-actors-heading">
              <h2 id="fav-actors-heading" className="fav-section__title">
                Pemeran Favorit <span className="section-row__count">({favorites.actors.length})</span>
              </h2>

              {actorsError ? (
                <ErrorState error={actorsError} onRetry={actorsFetch.reload} />
              ) : actorsLoading ? (
                <Loading rows={2} />
              ) : (
                <div className="actors-container">
                  <div className={`actors-grid actors-grid--fav${favActors.length > 60 ? ' glass-perf-flat' : ''}`}>
                    {favActors.map((actor) => {
                      const color = franchiseColor(actor.franchise);
                      const isFav = has('actors', actor.id);
                      return (
                        <article
                          key={actor.id}
                          className="actor-card glass-card glass-card--interactive"
                          style={{ '--accent': color }}
                          onMouseEnter={() => preloadImage(actor.photo)}
                          onTouchStart={() => preloadImage(actor.photo)}
                        >
                          <div className="card-actions" style={{ opacity: 1 }}>
                            <button
                              type="button"
                              className={`card-action-btn card-action-btn--fav${isFav ? ' active' : ''}`}
                              onClick={() => toggle('actors', actor.id)}
                              aria-pressed={isFav}
                              aria-label={isFav ? 'Hapus dari favorit' : 'Simpan ke favorit'}
                            >
                              <Heart size={15} fill="currentColor" aria-hidden="true" />
                            </button>
                          </div>

                          <div className="actor-card__head">
                            <div className="actor-card__avatar">
                              {actor.photo && (
                                <img
                                  src={actor.photo}
                                  alt={actor.name}
                                  onError={(e) => { e.currentTarget.style.display = 'none'; }}
                                  style={{
                                    width: '100%',
                                    height: '100%',
                                    objectFit: 'cover',
                                    objectPosition: getImagePosition(actor).cssPosition,
                                    position: 'absolute',
                                    inset: 0,
                                    borderRadius: '50%',
                                  }}
                                />
                              )}
                              <div className="actor-card__avatar-glow" style={{ background: color }} />
                              <span className="actor-card__avatar-abbr">{initials(actor.name)}</span>
                            </div>
                            <div className="actor-card__title-wrap">
                              <div className="actor-card__kanji">{actor.kanji || '—'}</div>
                              <h3 className="actor-card__name">
                                <Link
                                  to={`/actors/${actor.id}`}
                                  className="actor-card__primary-link"
                                  aria-label={`Lihat profil ${actor.name}${actor.character ? ` (${actor.character})` : ''}`}
                                >
                                  {actor.name}
                                </Link>
                              </h3>
                              <div className="actor-card__badges">
                                {actor.franchise && (
                                  <span className="badge badge--franchise" style={{ color, borderColor: color }}>
                                    {actor.franchise}
                                  </span>
                                )}
                                {actor.era && <span className="badge badge--era">{actor.era}</span>}
                              </div>
                            </div>
                          </div>

                          <div className="actor-card__role-box">
                            <span className="actor-card__role-label">Karakter yang Diperankan</span>
                            <p className="actor-card__character">{actor.character}</p>
                            {actor.series_title && (
                              actor.series_id ? (
                                <Link to={`/series/${actor.series_id}`} className="actor-card__series-link">
                                  <Tv size={14} aria-hidden="true" /> <span>{actor.series_title}</span>
                                </Link>
                              ) : (
                                <span className="actor-card__series-link">
                                  <Tv size={14} aria-hidden="true" /> <span>{actor.series_title}</span>
                                </span>
                              )
                            )}
                          </div>

                          <dl className="actor-card__facts">
                            <div>
                              <dt><Calendar size={13} aria-hidden="true" /> Lahir</dt>
                              <dd>{actor.birth_date || '—'}</dd>
                            </div>
                            <div>
                              <dt><MapPin size={13} aria-hidden="true" /> Asal</dt>
                              <dd>{actor.birth_place || '—'}</dd>
                            </div>
                            <div>
                              <dt><Building2 size={13} aria-hidden="true" /> Agensi</dt>
                              <dd>{actor.agency || '—'}</dd>
                            </div>
                          </dl>
                        </article>
                      );
                    })}
                  </div>
                </div>
              )}
            </section>
          )}
        </div>
      )}
    </GlassPanel>
  );
}
