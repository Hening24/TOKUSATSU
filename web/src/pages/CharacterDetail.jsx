import { useState, useMemo } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import PageHeader from '../components/PageHeader.jsx';
import FavoriteButton from '../components/FavoriteButton.jsx';
import HistoryArcsViewer from '../components/HistoryArcsViewer.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import DetailPosterCard from '../components/DetailPosterCard.jsx';
import CharacterModal from '../components/CharacterModal.jsx';
import ConfirmModal from '../components/ConfirmModal.jsx';
import { usePageBackground } from '../components/PageBackground.jsx';
import { ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useFavorites from '../hooks/useFavorites';
import { useToast } from '../context/ToastContext.jsx';
import { apiPut, apiDelete } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { notifySaveWithImagePosCheck } from '../utils/imagePosition';
import { franchiseColor, franchiseTextColor, hexToRgb } from '../utils/franchise';
import { findActorForCharacter } from '../utils/matching';
import {
  ExternalLink,
  ChevronRight,
  Tv,
  Shield,
  Activity,
  Pencil,
  Trash2,
} from 'lucide-react';

const idNumberFormat = new Intl.NumberFormat('id-ID', {
  maximumFractionDigits: 2,
});

function hasStat(val) {
  if (val === null || val === undefined || val === '') return false;
  const n = Number(val);
  return !Number.isNaN(n) && n > 0;
}

function hasText(val) {
  return typeof val === 'string' && val.trim().length > 0;
}

function formatHeight(cmVal) {
  const cm = Number(cmVal);
  if (Number.isNaN(cm) || cm <= 0) return null;
  if (cm < 300) return `${idNumberFormat.format(cm)} cm`;
  return `${idNumberFormat.format(cm / 100)} m`;
}

function formatWeight(kgVal) {
  const kg = Number(kgVal);
  if (Number.isNaN(kg) || kg <= 0) return null;
  if (kg < 1000) return `${idNumberFormat.format(kg)} kg`;
  return `${idNumberFormat.format(kg / 1000)} ton`;
}

export default function CharacterDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { data: c, loading, error, reload } = useFetch(`/characters/${id}`);
  const { data: rawAllChars } = useFetch('/characters');
  const { data: seriesDetail } = useFetch(c?.series_id ? `/series/${c.series_id}` : null);
  const { showToast } = useToast();
  const { data: seriesList } = useFetch('/series');

  const [editOpen, setEditOpen] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);

  const allChars = rawAllChars || [];
  const matchedActor = useMemo(
    () => findActorForCharacter(seriesDetail?.actors, c?.actor),
    [seriesDetail?.actors, c?.actor]
  );

  const { has, toggle } = useFavorites();

  usePageBackground(c?.image, c?.image_pos_x ?? 50, c?.image_pos_y ?? 50, {
    loading: loading && !c,
  });

  const color = c ? franchiseColor(c.franchise || c.series?.franchise) : '#dc2626';
  const accentText = c ? franchiseTextColor(c.franchise || c.series?.franchise) : '#ffffff';
  const accentRgb = hexToRgb(color);

  // Hitung perbandingan tinggi: manusia 170 cm dan karakter tertinggi di franchise yang sama
  const heightComparison = useMemo(() => {
    if (!c || !hasStat(c.height_cm)) return null;
    const currentCm = Number(c.height_cm);
    const currentFranchise = c.franchise || c.series?.franchise || '';
    const sameFranchise = allChars.filter(
      (item) =>
        hasStat(item.height_cm) &&
        (!currentFranchise || item.franchise === currentFranchise)
    );
    let maxHeightCm = currentCm;
    let maxCharName = c.rider_name || c.name;
    sameFranchise.forEach((item) => {
      const h = Number(item.height_cm);
      if (h > maxHeightCm) {
        maxHeightCm = h;
        maxCharName = item.rider_name || item.name;
      }
    });
    const humanRefCm = 170;
    const scaleMax = Math.max(maxHeightCm, humanRefCm, currentCm);
    const charPct = Math.min(100, Math.max(2, (currentCm / scaleMax) * 100));
    const humanPct = Math.min(100, Math.max(1.5, (humanRefCm / scaleMax) * 100));

    return {
      currentCm,
      currentFormatted: formatHeight(currentCm),
      humanFormatted: formatHeight(humanRefCm),
      maxHeightCm,
      maxFormatted: formatHeight(maxHeightCm),
      maxCharName,
      franchiseLabel: currentFranchise || 'Franchise ini',
      charPct,
      humanPct,
    };
  }, [allChars, c]);

  const displayName = c ? c.rider_name || c.name : '';
  const seriesObj = c?.series || {
    id: c?.series_id,
    title: c?.series_title,
    franchise: c?.franchise,
    era: c?.era,
    year: c?.year,
  };

  const primaryBodyStats = [];
  if (hasStat(c?.height_cm)) {
    primaryBodyStats.push({ key: 'height', label: 'Tinggi', value: formatHeight(c.height_cm) });
  }
  if (hasStat(c?.weight_kg)) {
    primaryBodyStats.push({ key: 'weight', label: 'Berat', value: formatWeight(c.weight_kg) });
  }

  const profileCards = [];
  if (hasText(c?.age_text)) profileCards.push({ label: 'Usia', value: c.age_text.trim() });
  if (hasText(c?.origin)) profileCards.push({ label: 'Asal', value: c.origin.trim() });
  if (hasText(c?.occupation)) profileCards.push({ label: 'Pekerjaan', value: c.occupation.trim() });
  if (hasText(c?.blood_type)) profileCards.push({ label: 'Golongan darah', value: c.blood_type.trim() });
  if (hasText(c?.species)) profileCards.push({ label: 'Species', value: c.species.trim() });
  if (hasText(c?.team)) profileCards.push({ label: 'Team', value: c.team.trim() });

  const extraStatsList = Array.isArray(c?.extra_stats)
    ? c.extra_stats.filter((st) => {
        if (!st || !hasText(st.label)) return false;
        const valEmpty = st.value === null || st.value === undefined || String(st.value).trim() === '';
        if (valEmpty) return false;
        const lbl = st.label.trim().toLowerCase();
        if (lbl === 'tinggi' && hasStat(c?.height_cm)) return false;
        if (lbl === 'berat' && hasStat(c?.weight_kg)) return false;
        if (lbl === 'usia' && hasText(c?.age_text)) return false;
        if (lbl === 'asal' && hasText(c?.origin)) return false;
        return true;
      })
    : [];

  const abilityItems = [];
  if (hasStat(c?.punch_power_t)) {
    abilityItems.push({ label: 'Pukulan', value: `${idNumberFormat.format(Number(c.punch_power_t))} ton` });
  }
  if (hasStat(c?.kick_power_t)) {
    abilityItems.push({ label: 'Tendangan', value: `${idNumberFormat.format(Number(c.kick_power_t))} ton` });
  }
  if (hasStat(c?.max_jump_m)) {
    abilityItems.push({ label: 'Lompatan', value: `${idNumberFormat.format(Number(c.max_jump_m))} m` });
  }
  if (hasStat(c?.run_100m_s)) {
    abilityItems.push({ label: 'Lari 100 m', value: `${idNumberFormat.format(Number(c.run_100m_s))} detik` });
  }

  const hasStatsNote = hasText(c?.stats_note);

  const anyStatPresent =
    c &&
    (primaryBodyStats.length > 0 ||
      profileCards.length > 0 ||
      extraStatsList.length > 0 ||
      abilityItems.length > 0 ||
      hasStatsNote);

  const fallbackBackTo = c?.series_id ? `/series/${c.series_id}` : '/characters';

  const handleSaveCharacter = async (formData) => {
    const saved = await apiPut(`/characters/${c.id}`, formData);
    reload();
    notifySaveWithImagePosCheck(showToast, saved, 'Perubahan karakter disimpan.');
  };

  const handleDeleteCharacter = async () => {
    await apiDelete(`/characters/${c.id}`);
    setDeleteOpen(false);
    showToast('Karakter berhasil dihapus.');
    navigate('/characters', { replace: true });
  };

  return (
    <>
      <PageHeader
        title="Detail Karakter"
        backTo={fallbackBackTo}
        right={
          ENABLE_EDIT && c ? (
            <div className="page-header__actions">
              <button
                type="button"
                className="icon-btn"
                onClick={() => setEditOpen(true)}
                aria-label="Edit karakter"
                title="Edit karakter"
              >
                <Pencil size={19} aria-hidden="true" />
              </button>
              <button
                type="button"
                className="icon-btn icon-btn--danger"
                onClick={() => setDeleteOpen(true)}
                aria-label="Hapus karakter"
                title="Hapus karakter"
              >
                <Trash2 size={19} aria-hidden="true" />
              </button>
            </div>
          ) : null
        }
      />

      <GlassPanel className="detail-panel">
        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !c && <Loading rows={3} />}

        {c && (
          <article
            className="char-detail"
            style={{ '--accent': color, '--accent-rgb': accentRgb, '--accent-text': accentText }}
          >
          {/* 1. HERO TERPUSAT DI TENGAH */}
          <header className="char-hero-center">
            <DetailPosterCard
              src={c.image}
              alt={displayName}
              fallbackLabel={seriesObj.franchise || 'TOKUSATSU'}
              accentColor={color}
              showGlow
            />

            <h1 className="char-hero-center__title">{displayName}</h1>

            {(c.civilian_name || c.actor) && (
              <p className="char-hero-center__identity">
                {c.civilian_name && <span>{c.civilian_name}</span>}
                {c.civilian_name && c.actor && (
                  <span className="char-hero-center__dot" aria-hidden="true">•</span>
                )}
                {c.actor && (
                  matchedActor ? (
                    <span className="char-hero-center__actor-wrap">
                      Diperankan oleh{' '}
                      <Link
                        to={`/actors/${matchedActor.id}`}
                        className="char-hero-center__actor-link"
                        aria-label={`Lihat profil pemeran ${c.actor}`}
                      >
                        {c.actor}
                      </Link>
                    </span>
                  ) : (
                    <span>Diperankan oleh {c.actor}</span>
                  )
                )}
              </p>
            )}

            <div className="char-hero-center__badges">
              {seriesObj.title && (
                <span className="chip chip--solid">{seriesObj.title}</span>
              )}
              {seriesObj.era && <span className="chip">{seriesObj.era}</span>}
              {c.role && <span className="chip">{c.role}</span>}
              {c.species && <span className="chip">{c.species}</span>}
              {c.team && <span className="chip">{c.team}</span>}
            </div>

            <div className="char-hero-center__actions">
              <FavoriteButton
                showLabel
                active={has('characters', c.id)}
                onClick={() => toggle('characters', c.id)}
              />
            </div>
          </header>

          {/* 2. BLOK STATISTIK */}
          <section className="char-section" aria-labelledby="stats-heading">
            <div className="char-section__head">
              <h2 id="stats-heading" className="char-section__title">
                <Activity size={20} aria-hidden="true" />
                <span>Statistik</span>
              </h2>
              {anyStatPresent && c.source_url && (
                <a
                  href={c.source_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="char-source-link glass-card glass-card--interactive"
                >
                  <span>Sumber data</span>
                  <ExternalLink size={14} aria-hidden="true" />
                </a>
              )}
            </div>

            {!anyStatPresent ? (
              <div className="char-stats-empty glass-card">
                <p>Data statistik belum tersedia untuk karakter ini.</p>
              </div>
            ) : (
              <div className="char-stats-stack">
                {/* Kartu besar: Tinggi & Berat */}
                {primaryBodyStats.length > 0 && (
                  <div className="char-primary-stats">
                    {primaryBodyStats.map((st) => (
                      <div key={st.key} className="stat-card stat-card--major glass-card">
                        <span className="stat-card__label">{st.label}</span>
                        <span className="stat-card__value stat-card__value--major">{st.value}</span>
                      </div>
                    ))}
                  </div>
                )}

                {/* Perbandingan tinggi (hanya muncul jika height_cm ada) */}
                {heightComparison && (
                  <div className="height-compare-card glass-card">
                    <div className="height-compare__head">
                      <span className="height-compare__title">Perbandingan tinggi</span>
                      <span className="height-compare__current">{heightComparison.currentFormatted}</span>
                    </div>

                    <div
                      className="height-compare__track"
                      role="img"
                      aria-label={`Perbandingan tinggi ${displayName} (${heightComparison.currentFormatted}) terhadap acuan manusia (${heightComparison.humanFormatted}) dan tertinggi di ${heightComparison.franchiseLabel} (${heightComparison.maxFormatted})`}
                    >
                      <div
                        className="height-compare__fill"
                        style={{ width: `${heightComparison.charPct}%` }}
                      />
                      <div
                        className="height-compare__ref-line"
                        style={{ left: `${heightComparison.humanPct}%` }}
                        title={`Acuan manusia: ${heightComparison.humanFormatted}`}
                      />
                    </div>

                    <div className="height-compare__legend">
                      <div className="height-compare__legend-item">
                        <span className="height-compare__dot height-compare__dot--accent" aria-hidden="true" />
                        <span>Karakter ini: <strong>{heightComparison.currentFormatted}</strong></span>
                      </div>
                      <div className="height-compare__legend-item">
                        <span className="height-compare__dot height-compare__dot--ref" aria-hidden="true" />
                        <span>Manusia rata-rata: <strong>{heightComparison.humanFormatted}</strong></span>
                      </div>
                      <div className="height-compare__legend-item">
                        <span className="height-compare__dot height-compare__dot--max" aria-hidden="true" />
                        <span>
                          Tertinggi di {heightComparison.franchiseLabel}:{' '}
                          <strong>{heightComparison.maxFormatted}</strong>
                          {heightComparison.maxCharName && heightComparison.maxCharName !== displayName
                            ? ` (${heightComparison.maxCharName})`
                            : ''}
                        </span>
                      </div>
                    </div>
                  </div>
                )}

                {/* Kartu profil & ekstra (kartu NULL disembunyikan) */}
                {(profileCards.length > 0 || extraStatsList.length > 0) && (
                  <div className="char-stats-grid">
                    {profileCards.map((item) => (
                      <div key={item.label} className="stat-card glass-card">
                        <span className="stat-card__label">{item.label}</span>
                        <span className="stat-card__value stat-card__value--profile">{item.value}</span>
                      </div>
                    ))}
                    {extraStatsList.map((st, idx) => (
                      <div key={`${st.label}-${idx}`} className="stat-card glass-card">
                        <span className="stat-card__label">{st.label}</span>
                        <span className="stat-card__value stat-card__value--profile">
                          {st.value}
                          {st.unit ? ` ${st.unit}` : ''}
                        </span>
                      </div>
                    ))}
                  </div>
                )}

                {/* Blok kecil Kemampuan fisik */}
                {abilityItems.length > 0 && (
                  <div className="char-abilities-card glass-card">
                    <h3 className="char-abilities-card__title">Kemampuan fisik</h3>
                    <ul className="char-abilities-list">
                      {abilityItems.map((ab) => (
                        <li key={ab.label} className="char-abilities-list__item">
                          <span className="char-abilities-list__label">{ab.label}</span>
                          <span className="char-abilities-list__value">{ab.value}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Keterangan statistik */}
                {hasStatsNote && (
                  <p className="char-stats-note">{c.stats_note.trim()}</p>
                )}
              </div>
            )}
          </section>

          {/* 3. TENTANG KARAKTER */}
          <section className="char-section" aria-labelledby="bio-heading">
            <h2 id="bio-heading" className="char-section__title">
              Tentang karakter
            </h2>
            <p className="char-prose">{c.bio || 'Belum ada deskripsi.'}</p>
          </section>

          {/* 4. KEKUATAN DAN SENJATA */}
          <section className="char-section" aria-labelledby="power-heading">
            <h2 id="power-heading" className="char-section__title">
              <Shield size={20} aria-hidden="true" />
              <span>Kekuatan dan senjata</span>
            </h2>
            <p className="char-prose">
              {c.power || 'Belum ada informasi kekuatan dan senjata.'}
            </p>
            {c.debut_episode && (
              <p className="char-debut-note glass-card">
                <strong>Debut:</strong> {c.debut_episode}
              </p>
            )}
          </section>

          {/* 5. SERIES ASAL */}
          {seriesObj.id && (
            <section className="char-section" aria-labelledby="origin-heading">
              <h2 id="origin-heading" className="char-section__title">
                Series asal
              </h2>
              <Link to={`/series/${seriesObj.id}`} className="origin-series-card glass-card glass-card--interactive">
                <div className="origin-series-card__icon">
                  <Tv size={20} aria-hidden="true" />
                </div>
                <div className="origin-series-card__info">
                  <span className="origin-series-card__name">{seriesObj.title}</span>
                  <span className="origin-series-card__meta">
                    {[seriesObj.franchise, seriesObj.era, seriesObj.year]
                      .filter(Boolean)
                      .join(' • ')}
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

          {/* 6. KRONOLOGI (arcs) */}
          <HistoryArcsViewer
            arcs={c.arcs}
            accentColor={color}
            title={`Kronologi & Sejarah: ${displayName}`}
          />
          </article>
        )}
      </GlassPanel>

      {ENABLE_EDIT && (
        <>
          <CharacterModal
            isOpen={editOpen}
            onClose={() => setEditOpen(false)}
            onSave={handleSaveCharacter}
            initialData={c}
            seriesList={seriesList || []}
          />

          <ConfirmModal
            isOpen={deleteOpen}
            itemName={displayName}
            onCancel={() => setDeleteOpen(false)}
            onConfirm={handleDeleteCharacter}
          />
        </>
      )}
    </>
  );
}
