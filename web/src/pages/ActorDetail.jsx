import { useMemo, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import {
  Building2,
  Calendar,
  ChevronRight,
  MapPin,
  Pencil,
  Sparkles,
  Trash2,
  Tv,
  User,
} from 'lucide-react';
import PageHeader from '../components/PageHeader.jsx';
import FavoriteButton from '../components/FavoriteButton.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import DetailPosterCard from '../components/DetailPosterCard.jsx';
import ActorModal from '../components/ActorModal.jsx';
import ConfirmModal from '../components/ConfirmModal.jsx';
import { usePageBackground } from '../components/PageBackground.jsx';
import { ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useFavorites from '../hooks/useFavorites';
import { useToast } from '../context/ToastContext.jsx';
import { apiPut, apiDelete } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { notifySaveWithImagePosCheck } from '../utils/imagePosition';
import { franchiseColor, franchiseTextColor, hexToRgb, initials } from '../utils/franchise';
import { findRelatedCharactersForActor } from '../utils/matching';

export default function ActorDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { data: actor, loading, error, reload } = useFetch(`/actors/${id}`);
  const { data: seriesData } = useFetch(actor?.series_id ? `/series/${actor.series_id}` : null);
  const { showToast } = useToast();
  const { data: seriesList } = useFetch('/series');

  const { has, toggle } = useFavorites();
  const [editOpen, setEditOpen] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);

  usePageBackground(actor?.photo, actor?.image_pos_x ?? 50, actor?.image_pos_y ?? 50, {
    loading: loading && !actor,
  });

  const color = actor ? franchiseColor(actor.franchise) : '#dc2626';
  const accentText = actor ? franchiseTextColor(actor.franchise) : '#ffffff';
  const accentRgb = hexToRgb(color);

  const relatedCharacters = useMemo(
    () => findRelatedCharactersForActor(seriesData?.characters, actor),
    [seriesData?.characters, actor]
  );

  const facts = useMemo(() => {
    if (!actor) return [];
    return [
      { label: 'Tanggal Lahir', value: actor.birth_date, icon: Calendar },
      { label: 'Asal', value: actor.birth_place, icon: MapPin },
      { label: 'Agensi', value: actor.agency, icon: Building2 },
    ].filter((item) => typeof item.value === 'string' && item.value.trim().length > 0);
  }, [actor]);

  const fallbackBackTo = actor?.series_id ? `/series/${actor.series_id}` : '/actors';

  const handleSaveActor = async (formData) => {
    const saved = await apiPut(`/actors/${actor.id}`, formData);
    reload();
    notifySaveWithImagePosCheck(showToast, saved, 'Perubahan pemeran disimpan.');
  };

  const handleDeleteActor = async () => {
    await apiDelete(`/actors/${actor.id}`);
    setDeleteOpen(false);
    showToast('Pemeran berhasil dihapus.');
    navigate('/actors', { replace: true });
  };

  return (
    <>
      <PageHeader
        title="Profil Pemeran"
        backTo={fallbackBackTo}
        right={
          ENABLE_EDIT && actor ? (
            <div className="page-header__actions">
              <button
                type="button"
                className="icon-btn"
                onClick={() => setEditOpen(true)}
                aria-label="Edit pemeran"
                title="Edit pemeran"
              >
                <Pencil size={19} aria-hidden="true" />
              </button>
              <button
                type="button"
                className="icon-btn icon-btn--danger"
                onClick={() => setDeleteOpen(true)}
                aria-label="Hapus pemeran"
                title="Hapus pemeran"
              >
                <Trash2 size={19} aria-hidden="true" />
              </button>
            </div>
          ) : null
        }
      />

      <GlassPanel className="detail-panel">
        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !actor && <Loading />}

        {!error && actor && (
          <article
            className="char-detail actor-detail"
            style={{ '--accent': color, '--accent-rgb': accentRgb, '--accent-text': accentText }}
          >
          {/* Hero Profil Aktor (Rata Tengah) */}
          <header className="char-hero-center actor-hero-center">
            <DetailPosterCard
              src={actor.photo}
              alt={actor.name}
              fallbackLabel={actor.franchise || 'PEMERAN'}
              accentColor={color}
              showGlow
            />

            <h1 className="char-hero-center__title">{actor.name}</h1>

            {actor.kanji && (
              <p className="actor-detail__kanji">{actor.kanji}</p>
            )}

            {actor.character && (
              <p className="actor-detail__role">
                Memerankan <strong>{actor.character}</strong>
              </p>
            )}

            <div className="char-hero-center__badges">
              {actor.role_type && (
                <span className="chip chip--solid">{actor.role_type}</span>
              )}
              {actor.franchise && <span className="chip">{actor.franchise}</span>}
              {actor.era && <span className="chip">{actor.era}</span>}
              {actor.series_year && <span className="chip">{actor.series_year}</span>}
            </div>

            <div className="char-hero-center__actions">
              <FavoriteButton
                showLabel
                active={has('actors', actor.id)}
                onClick={() => toggle('actors', actor.id)}
              />
            </div>
          </header>

          {/* Biodata Singkat */}
          {facts.length > 0 && (
            <section className="char-section" aria-labelledby="actor-facts-heading">
              <h2 id="actor-facts-heading" className="char-section__title">
                <User size={20} aria-hidden="true" />
                <span>Biodata Pemeran</span>
              </h2>
              <dl className="char-info-grid">
                {facts.map((fact) => {
                  const Icon = fact.icon;
                  return (
                    <div key={fact.label} className="char-info-grid__item glass-card">
                      <dt className="char-info-grid__label">
                        <Icon size={14} aria-hidden="true" style={{ marginRight: 6, verticalAlign: '-2px' }} />
                        {fact.label}
                      </dt>
                      <dd className="char-info-grid__value">{fact.value}</dd>
                    </div>
                  );
                })}
              </dl>
            </section>
          )}

          {/* Biografi */}
          <section className="char-section" aria-labelledby="actor-bio-heading">
            <h2 id="actor-bio-heading" className="char-section__title">
              Tentang Pemeran
            </h2>
            <p className="char-prose">
              {actor.bio || 'Belum ada biografi yang ditambahkan untuk pemeran ini.'}
            </p>
          </section>

          {/* Karakter Terkait dari Series Asal */}
          {relatedCharacters.length > 0 && (
            <section className="char-section" aria-labelledby="actor-chars-heading">
              <h2 id="actor-chars-heading" className="char-section__title">
                <Sparkles size={20} aria-hidden="true" />
                <span>Karakter Terkait</span>
              </h2>
              <div className="actor-related-chars">
                {relatedCharacters.map((ch) => (
                  <Link
                    key={ch.id}
                    to={`/characters/${ch.id}`}
                    className="origin-series-card actor-related-char-card glass-card glass-card--interactive"
                    aria-label={`Lihat karakter ${ch.rider_name || ch.name}`}
                  >
                    <div className="actor-related-char-card__thumb">
                      {ch.image ? (
                        <img src={ch.image} alt={ch.rider_name || ch.name} loading="lazy" />
                      ) : (
                        <span>{initials(ch.rider_name || ch.name)}</span>
                      )}
                    </div>
                    <div className="origin-series-card__info">
                      <span className="origin-series-card__name">
                        {ch.rider_name || ch.name}
                      </span>
                      <span className="origin-series-card__meta">
                        {[ch.civilian_name, ch.role].filter(Boolean).join(' • ') || actor.series_title}
                      </span>
                    </div>
                    <ChevronRight
                      size={20}
                      className="origin-series-card__arrow"
                      aria-hidden="true"
                    />
                  </Link>
                ))}
              </div>
            </section>
          )}

          {/* Series Asal */}
          {actor.series_id && actor.series_title && (
            <section className="char-section" aria-labelledby="actor-series-heading">
              <h2 id="actor-series-heading" className="char-section__title">
                Series Asal
              </h2>
              <Link
                to={`/series/${actor.series_id}`}
                className="origin-series-card glass-card glass-card--interactive"
                aria-label={`Buka series ${actor.series_title}`}
              >
                <div className="origin-series-card__icon">
                  <Tv size={20} aria-hidden="true" />
                </div>
                <div className="origin-series-card__info">
                  <span className="origin-series-card__name">{actor.series_title}</span>
                  <span className="origin-series-card__meta">
                    {[actor.franchise, actor.era, actor.series_year].filter(Boolean).join(' • ')}
                  </span>
                </div>
                <ChevronRight
                  size={20}
                  className="origin-series-card__arrow"
                  aria-hidden="true"
                />
              </Link>
            </section>
          )}
          </article>
        )}
      </GlassPanel>

      {ENABLE_EDIT && (
        <>
          <ActorModal
            isOpen={editOpen}
            onClose={() => setEditOpen(false)}
            onSave={handleSaveActor}
            initialData={actor}
            seriesList={seriesList || []}
          />

          <ConfirmModal
            isOpen={deleteOpen}
            itemName={actor?.name}
            onCancel={() => setDeleteOpen(false)}
            onConfirm={handleDeleteActor}
          />
        </>
      )}
    </>
  );
}
