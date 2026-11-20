import { useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import PageHeader from '../components/PageHeader.jsx';
import FavoriteButton from '../components/FavoriteButton.jsx';
import CharacterCard from '../components/CharacterCard.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import DetailPosterCard from '../components/DetailPosterCard.jsx';
import SeriesModal from '../components/SeriesModal.jsx';
import ArcModal from '../components/ArcModal.jsx';
import ActorModal from '../components/ActorModal.jsx';
import ConfirmModal from '../components/ConfirmModal.jsx';
import { usePageBackground } from '../components/PageBackground.jsx';
import { ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch.js';
import useFavorites from '../hooks/useFavorites';
import { useToast } from '../context/ToastContext.jsx';
import { apiPost, apiPut, apiDelete } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { franchiseColor, franchiseTextColor } from '../utils/franchise';
import { notifySaveWithImagePosCheck } from '../utils/imagePosition';
import { BookOpen, Pencil, Trash2, Plus } from 'lucide-react';
import HistoryArcsViewer from '../components/HistoryArcsViewer.jsx';

export default function SeriesDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { data: s, loading, error, reload } = useFetch(`/series/${id}`);
  const { has, toggle } = useFavorites();
  const { showToast } = useToast();
  const { data: allSeries } = useFetch('/series');

  const [showFullPlot, setShowFullPlot] = useState(false);

  usePageBackground(s?.poster, s?.image_pos_x ?? 50, s?.image_pos_y ?? 50, {
    loading: loading && !s,
  });

  const [editSeriesOpen, setEditSeriesOpen] = useState(false);
  const [arcModalState, setArcModalState] = useState({ open: false, arc: null });
  const [actorModalState, setActorModalState] = useState({ open: false, actor: null });
  const [deleteTarget, setDeleteTarget] = useState(null);

  const color = s ? franchiseColor(s.franchise) : '#dc2626';
  const textColor = s ? franchiseTextColor(s.franchise) : '#ffffff';

  const handleSaveSeries = async (formData) => {
    const saved = await apiPut(`/series/${s.id}`, formData);
    reload();
    notifySaveWithImagePosCheck(showToast, saved, 'Perubahan series disimpan.');
  };

  const handleSaveArc = async (formData) => {
    if (arcModalState.arc) {
      await apiPut(`/series/${s.id}/arcs/${arcModalState.arc.id}`, formData);
      showToast('Perubahan arc kronologi disimpan.');
    } else {
      await apiPost(`/series/${s.id}/arcs`, formData);
      showToast('Arc kronologi berhasil ditambahkan.');
    }
    reload();
  };

  const handleSaveActor = async (formData) => {
    if (actorModalState.actor) {
      const saved = await apiPut(`/actors/${actorModalState.actor.id}`, formData);
      notifySaveWithImagePosCheck(showToast, saved, 'Perubahan pemeran disimpan.');
    } else {
      const saved = await apiPost('/actors', formData);
      notifySaveWithImagePosCheck(showToast, saved, 'Pemeran berhasil ditambahkan.');
    }
    reload();
  };

  const handleConfirmDelete = async () => {
    if (!deleteTarget) return;
    if (deleteTarget.type === 'series') {
      await apiDelete(`/series/${s.id}`);
      setDeleteTarget(null);
      showToast('Series berhasil dihapus.');
      navigate('/', { replace: true });
    } else if (deleteTarget.type === 'arc') {
      await apiDelete(`/series/${s.id}/arcs/${deleteTarget.item.id}`);
      setDeleteTarget(null);
      reload();
      showToast('Arc kronologi berhasil dihapus.');
    } else if (deleteTarget.type === 'actor') {
      await apiDelete(`/actors/${deleteTarget.item.id}`);
      setDeleteTarget(null);
      reload();
      showToast('Pemeran berhasil dihapus.');
    }
  };

  const nextArcOrder = s?.arcs?.length
    ? Math.max(...s.arcs.map((a) => Number(a.arc_order) || 0)) + 1
    : 1;

  return (
    <>
      <PageHeader
        title="Detail Series"
        backTo="/"
        right={
          ENABLE_EDIT && s ? (
            <div className="page-header__actions">
              <button
                type="button"
                className="icon-btn"
                onClick={() => setEditSeriesOpen(true)}
                aria-label="Edit series"
                title="Edit series"
              >
                <Pencil size={19} aria-hidden="true" />
              </button>
              <button
                type="button"
                className="icon-btn icon-btn--danger"
                onClick={() => setDeleteTarget({ type: 'series', item: s, name: s.title })}
                aria-label="Hapus series"
                title="Hapus series"
              >
                <Trash2 size={19} aria-hidden="true" />
              </button>
            </div>
          ) : null
        }
      />

      <GlassPanel className="detail-panel">
        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !s && <Loading rows={3} />}

        {s && (
          <article className="detail" style={{ '--accent': color, '--accent-text': textColor }}>

            {/* Blok Teks & Info Terpusat (max-width: 720px) */}
            <div className="detail__body">
              <DetailPosterCard
                src={s.poster}
                alt={s.title}
                fallbackLabel={s.franchise}
                accentColor={color}
                showGlow
              />

              <header className="detail-series-head">
                <h2>{s.title}</h2>

                <div className="meta detail-series-head__meta">
                  <span className="chip chip--solid">{s.franchise}</span>
                  <span className="chip">{s.era}</span>
                  {s.year && <span className="chip">{s.year}</span>}
                </div>

                <div className="detail-series-head__actions">
                  <FavoriteButton
                    showLabel
                    active={has('series', s.id)}
                    onClick={() => toggle('series', s.id)}
                  />
                </div>
              </header>

              {/* Fakta */}
              <dl className="facts glass-card">
                <div><dt>Tahun tayang</dt><dd>{s.year || '-'}</dd></div>
                <div><dt>Jumlah episode</dt><dd>{s.episodes ? `${s.episodes} episode` : '-'}</dd></div>
                <div><dt>Produksi</dt><dd>{s.studio || '-'}</dd></div>
              </dl>

              {/* Sinopsis */}
              <h3>Sinopsis</h3>
              <p className="prose">{s.synopsis || 'Belum ada sinopsis.'}</p>

              {/* Alur Cerita Lengkap */}
              {s.full_plot && (
                <>
                  <h3 style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                    <BookOpen size={20} aria-hidden="true" />
                    Alur Cerita Lengkap
                  </h3>
                  <div className="full-plot-box">
                    <p className="prose full-plot-text" style={showFullPlot ? {} : { maxHeight: '8em', overflow: 'hidden' }}>
                      {s.full_plot}
                    </p>
                    <button
                      type="button"
                      className="full-plot-toggle"
                      onClick={() => setShowFullPlot((v) => !v)}
                    >
                      {showFullPlot ? '▲ Sembunyikan' : '▼ Lihat Selengkapnya'}
                    </button>
                  </div>
                </>
              )}

              {/* Sub-bab Alur Cerita Terstruktur */}
              <HistoryArcsViewer
                arcs={s.arcs}
                accentColor={color}
                title={`Kronologi & Sejarah: ${s.title}`}
                onAddArc={ENABLE_EDIT ? () => setArcModalState({ open: true, arc: null }) : undefined}
                onEditArc={ENABLE_EDIT ? (arc) => setArcModalState({ open: true, arc }) : undefined}
                onDeleteArc={
                  ENABLE_EDIT
                    ? (arc) => setDeleteTarget({ type: 'arc', item: arc, name: arc.title || arc.sub_title })
                    : undefined
                }
              />
            </div>

            {/* Karakter dalam wadah terpusat sejajar blok konten */}
            <section className="detail__grid-section" aria-labelledby="series-chars-heading">
              <h3 id="series-chars-heading">Karakter</h3>

              {s.characters.length === 0 ? (
                <p className="muted">Belum ada karakter yang ditambahkan.</p>
              ) : (
                <div className={`grid grid--flush${s.characters.length > 60 ? ' glass-perf-flat' : ''}`}>
                  {s.characters.map((c) => (
                    <CharacterCard
                      key={c.id}
                      item={{ ...c, franchise: s.franchise }}
                      isFavorite={has('characters', c.id)}
                    />
                  ))}
                </div>
              )}
            </section>

            {/* Pemeran dalam wadah terpusat sejajar blok konten */}
            <section
              className="detail__grid-section"
              aria-labelledby="series-actors-heading"
              style={{ marginTop: 28 }}
            >
              <div className="detail-section-head">
                <h3 id="series-actors-heading">Pemeran</h3>
                {ENABLE_EDIT && (
                  <button
                    type="button"
                    className="btn-outline btn-admin-compact"
                    onClick={() => setActorModalState({ open: true, actor: null })}
                    aria-label="Tambah pemeran"
                  >
                    <Plus size={16} aria-hidden="true" />
                    <span>Tambah Pemeran</span>
                  </button>
                )}
              </div>

              {!s.actors || s.actors.length === 0 ? (
                <p className="muted">Belum ada pemeran yang ditambahkan.</p>
              ) : (
                <div className="detail-actors-list">
                  {s.actors.map((a) => (
                    <div key={a.id} className="detail-actor-item">
                      <Link
                        to={`/actors/${a.id}`}
                        className="detail-actor-chip glass-card glass-card--interactive"
                        aria-label={`Lihat profil pemeran ${a.name}${a.character ? ` sebagai ${a.character}` : ''}`}
                      >
                        <span className="detail-actor-chip__name">{a.name}</span>
                        {a.character && (
                          <span className="detail-actor-chip__char">{a.character}</span>
                        )}
                      </Link>
                      {ENABLE_EDIT && (
                        <div className="detail-actor-item__actions">
                          <button
                            type="button"
                            className="icon-btn"
                            onClick={(e) => {
                              e.preventDefault();
                              e.stopPropagation();
                              setActorModalState({ open: true, actor: a });
                            }}
                            aria-label={`Edit pemeran ${a.name}`}
                            title="Edit pemeran"
                          >
                            <Pencil size={16} aria-hidden="true" />
                          </button>
                          <button
                            type="button"
                            className="icon-btn icon-btn--danger"
                            onClick={(e) => {
                              e.preventDefault();
                              e.stopPropagation();
                              setDeleteTarget({ type: 'actor', item: a, name: a.name });
                            }}
                            aria-label={`Hapus pemeran ${a.name}`}
                            title="Hapus pemeran"
                          >
                            <Trash2 size={16} aria-hidden="true" />
                          </button>
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              )}
            </section>
          </article>
        )}
      </GlassPanel>

      {ENABLE_EDIT && (
        <>
          <SeriesModal
            isOpen={editSeriesOpen}
            onClose={() => setEditSeriesOpen(false)}
            onSave={handleSaveSeries}
            initialData={s}
          />

          <ArcModal
            isOpen={arcModalState.open}
            onClose={() => setArcModalState({ open: false, arc: null })}
            onSave={handleSaveArc}
            initialData={arcModalState.arc}
            nextOrder={nextArcOrder}
          />

          <ActorModal
            isOpen={actorModalState.open}
            onClose={() => setActorModalState({ open: false, actor: null })}
            onSave={handleSaveActor}
            initialData={actorModalState.actor}
            seriesList={allSeries || (s ? [s] : [])}
            defaultSeriesId={s?.id}
          />

          <ConfirmModal
            isOpen={Boolean(deleteTarget)}
            itemName={deleteTarget?.name}
            onCancel={() => setDeleteTarget(null)}
            onConfirm={handleConfirmDelete}
          />
        </>
      )}
    </>
  );
}
