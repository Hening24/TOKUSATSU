import { useState } from 'react';
import { Link } from 'react-router-dom';
import {
  Calendar, MapPin, Building2,
  Tv, Sparkles, Heart, Plus
} from 'lucide-react';
import SearchBar from '../components/SearchBar.jsx';
import FilterChips from '../components/FilterChips.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import ActorModal from '../components/ActorModal.jsx';
import { Empty, ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useFavorites from '../hooks/useFavorites';
import useDebounce from '../hooks/useDebounce';
import { useToast } from '../context/ToastContext.jsx';
import { apiPost } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { FRANCHISE_LIST, ERAS, franchiseColor, initials } from '../utils/franchise';
import { preloadImage } from '../utils/preloadImage';
import { getImagePosition, notifySaveWithImagePosCheck } from '../utils/imagePosition';

export default function Actors() {
  const [q, setQ] = useState('');
  const [franchise, setFranchise] = useState('');
  const [era, setEra] = useState('');
  const dq = useDebounce(q).trim();
  const { has, toggle } = useFavorites();
  const { showToast } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const { data: seriesList } = useFetch('/series');

  /* ── Fetch Data Aktor dari API ── */
  const params = new URLSearchParams();
  if (dq) params.set('q', dq);
  if (franchise) params.set('franchise', franchise);
  if (era) params.set('era', era);
  const qs = params.toString();

  const { data: actors, loading, error, reload } = useFetch(
    qs ? `/actors?${qs}` : '/actors'
  );

  const handleCreateActor = async (formData) => {
    const saved = await apiPost('/actors', formData);
    reload();
    notifySaveWithImagePosCheck(showToast, saved, 'Pemeran berhasil ditambahkan.');
  };

  return (
    <GlassPanel className={`actors-page${actors && actors.length > 60 ? ' glass-perf-flat' : ''}`}>
      {/* ── Hero Header ── */}
      <div className="actors-hero">
        <div className="list-hero-row list-hero-row--admin">
          <h1 className="actors-hero__title">PEMERAN UTAMA</h1>
          {ENABLE_EDIT && (
            <button
              type="button"
              className="btn-primary list-add-btn"
              onClick={() => setCreateOpen(true)}
              aria-label="Tambah pemeran"
            >
              <Plus size={18} aria-hidden="true" />
              <span className="list-add-btn__label">Tambah Pemeran</span>
            </button>
          )}
        </div>
        <p className="actors-hero__sub">
          Daftar aktor legendaris Jepang yang memerankan tokoh pahlawan utama di balik topeng Tokusatsu
        </p>
      </div>

      {/* ── Search + Filters ── */}
      <div className="search-filter-section">
        <div className="actors-header-row">
          <div className="search-wrap" style={{ flex: 1, marginBottom: 0 }}>
            <SearchBar
              value={q}
              onChange={setQ}
              placeholder="Cari nama aktor, karakter, kanji…"
            />
          </div>
        </div>

        <div className="filters-row">
          <div className="chips-wrap">
            <FilterChips
              label="Filter Franchise"
              options={FRANCHISE_LIST}
              value={franchise}
              onChange={setFranchise}
              allLabel="Semua Franchise"
            />
          </div>
          <div className="chips-wrap">
            <FilterChips
              label="Filter Era"
              options={ERAS}
              value={era}
              onChange={setEra}
              allLabel="Semua Era"
            />
          </div>
        </div>
      </div>

      {/* ── Grid Aktor ── */}
      <div className="actors-container">
        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !actors && <Loading rows={3} />}

        {!error && actors && (
          <>
            <p className="count">{actors.length} aktor ditemukan</p>

            {actors.length === 0 ? (
              <Empty
                title="Pemeran Tidak Ditemukan"
                text='Coba gunakan kata kunci pencarian lain atau pilih "Semua Franchise".'
              />
            ) : (
              <div className="actors-grid">
                {actors.map((actor) => {
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
                          onClick={(e) => { e.preventDefault(); toggle('actors', actor.id); }}
                          aria-pressed={isFav}
                          aria-label={isFav ? 'Hapus dari favorit' : 'Simpan ke favorit'}
                          title={isFav ? 'Hapus dari favorit' : 'Simpan ke favorit'}
                        >
                          <Heart size={15} fill={isFav ? 'currentColor' : 'none'} aria-hidden="true" />
                        </button>
                      </div>

                      {/* ── Avatar + Nama ── */}
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
                          <span className="actor-card__avatar-icon"><Sparkles size={14} /></span>
                        </div>

                        <div className="actor-card__title-wrap">
                          <div className="actor-card__kanji">{actor.kanji || '—'}</div>
                          <h2 className="actor-card__name">
                            <Link
                              to={`/actors/${actor.id}`}
                              className="actor-card__primary-link"
                              aria-label={`Lihat profil ${actor.name}${actor.character ? ` (${actor.character})` : ''}`}
                            >
                              {actor.name}
                            </Link>
                          </h2>
                          <div className="actor-card__badges">
                            {actor.franchise && (
                              <span className="badge badge--franchise" style={{ color, borderColor: color }}>
                                {actor.franchise}
                              </span>
                            )}
                            {actor.era && <span className="badge badge--era">{actor.era}</span>}
                            {actor.series_year && <span className="badge">{actor.series_year}</span>}
                          </div>
                        </div>
                      </div>

                      {/* ── Peran Karakter ── */}
                      <div className="actor-card__role-box">
                        <span className="actor-card__role-label">Karakter yang Diperankan</span>
                        <p className="actor-card__character">{actor.character}</p>
                        {actor.series_title && (
                          actor.series_id ? (
                            <Link to={`/series/${actor.series_id}`} className="actor-card__series-link">
                              <Tv size={14} aria-hidden="true" />
                              <span>{actor.series_title}</span>
                            </Link>
                          ) : (
                            <span className="actor-card__series-link">
                              <Tv size={14} aria-hidden="true" />
                              <span>{actor.series_title}</span>
                            </span>
                          )
                        )}
                      </div>

                      {/* ── Biodata ── */}
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

                      {actor.bio && (
                        <div className="actor-card__bio">
                          <p>{actor.bio}</p>
                        </div>
                      )}
                    </article>
                  );
                })}
              </div>
            )}
          </>
        )}
      </div>

      {ENABLE_EDIT && (
        <ActorModal
          isOpen={createOpen}
          onClose={() => setCreateOpen(false)}
          onSave={handleCreateActor}
          seriesList={seriesList || []}
        />
      )}
    </GlassPanel>
  );
}
