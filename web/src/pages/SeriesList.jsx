import { useEffect, useState, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import { Plus } from 'lucide-react';
import Hero from '../components/Hero.jsx';
import SectionRow from '../components/SectionRow.jsx';
import SearchBar from '../components/SearchBar.jsx';
import FilterChips from '../components/FilterChips.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import SeriesModal from '../components/SeriesModal.jsx';
import { Empty, ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useDebounce from '../hooks/useDebounce';
import useFavorites from '../hooks/useFavorites';
import { useToast } from '../context/ToastContext.jsx';
import { apiPost } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { notifySaveWithImagePosCheck } from '../utils/imagePosition';
import {
  ERAS,
  ITEMS_PER_GROUP,
  SERIES_CATEGORIES,
  SERIES_FRANCHISE_FILTERS,
  groupByCategory,
  matchesCategory,
} from '../utils/franchise';

function buildFeaturedSlides(allData) {
  if (!Array.isArray(allData) || allData.length === 0) return [];
  const newestFirst = [...allData].sort(
    (a, b) => (b.year || 0) - (a.year || 0) || (b.id - a.id)
  );
  const picked = [];
  const pickedIds = new Set();

  for (const cat of SERIES_CATEGORIES) {
    const match = newestFirst.find((s) => !pickedIds.has(s.id) && matchesCategory(s, cat.key));
    if (match) {
      picked.push(match);
      pickedIds.add(match.id);
    }
  }

  for (const s of newestFirst) {
    if (picked.length >= 5) break;
    if (!pickedIds.has(s.id)) {
      picked.push(s);
      pickedIds.add(s.id);
    }
  }

  return picked.slice(0, 5);
}

export default function SeriesList() {
  const [sp, setSp] = useSearchParams();
  const era = sp.get('era') || '';
  const franchise = sp.get('franchise') || '';
  const [q, setQ] = useState(sp.get('q') || '');
  const dq = useDebounce(q).trim();
  const { has, toggle } = useFavorites();
  const { showToast } = useToast();
  const [createOpen, setCreateOpen] = useState(false);

  /* mode: 'home' (beranda dengan hero) atau 'search' (ada filter/pencarian aktif) */
  const isFiltered = !!(dq || era || franchise);

  const setParam = (key, value, { replace = false } = {}) =>
    setSp(
      (prev) => {
        const next = new URLSearchParams(prev);
        if (value) next.set(key, value); else next.delete(key);
        return next;
      },
      { replace }
    );

  useEffect(() => {
    const urlQ = sp.get('q') || '';
    if (urlQ !== dq) setQ(urlQ);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sp]);

  useEffect(() => {
    if (dq !== (sp.get('q') || '')) setParam('q', dq, { replace: true });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [dq]);

  /* Ambil SEMUA series untuk hero & beranda, plus endpoint terfilter saat ada filter */
  const { data: allData, loading: allLoading, error: allError, reload: allReload } = useFetch('/series');

  const params = new URLSearchParams();
  if (dq) params.set('q', dq);
  if (era) params.set('era', era);
  if (franchise) params.set('franchise', franchise);
  const qs = params.toString();
  const { data: filteredData, loading: filtLoading, error: filtError, reload: filtReload } = useFetch(
    isFiltered ? `/series?${qs}` : null
  );

  const displayData = isFiltered ? filteredData : allData;
  const loading = isFiltered ? filtLoading : allLoading;
  const error = isFiltered ? filtError : allError;
  const reload = isFiltered ? filtReload : allReload;

  /* 5 unggulan hero carousel + kelompok kategori beranda terurut tahun terbaru -> terlama */
  const heroSlides = useMemo(() => buildFeaturedSlides(allData), [allData]);

  const categoryRows = useMemo(() => {
    if (!Array.isArray(displayData) || displayData.length === 0) return [];
    const newestFirst = [...displayData].sort(
      (a, b) => (b.year || 0) - (a.year || 0) || (b.id - a.id)
    );
    return groupByCategory(newestFirst, {
      limit: isFiltered ? null : ITEMS_PER_GROUP,
    });
  }, [displayData, isFiltered]);

  const handleCreateSeries = async (formData) => {
    const saved = await apiPost('/series', formData);
    allReload();
    if (isFiltered) filtReload();
    notifySaveWithImagePosCheck(showToast, saved, 'Series berhasil ditambahkan.');
  };

  return (
    <>
      {!isFiltered && heroSlides.length > 0 && (
        <Hero
          items={heroSlides}
          isFavorite={(id) => has('series', id)}
          onToggleFav={(id) => toggle('series', id)}
        />
      )}

      <GlassPanel>
        <div className="list-admin-head">
          <h1 className="list-admin-head__title">KATALOG SERIES</h1>
          {ENABLE_EDIT && (
            <button
              type="button"
              className="btn-primary list-add-btn"
              onClick={() => setCreateOpen(true)}
              aria-label="Tambah series"
            >
              <Plus size={18} aria-hidden="true" />
              <span className="list-add-btn__label">Tambah Series</span>
            </button>
          )}
        </div>

        <div className="search-filter-section">
          <div className="series-header-row">
            <div className="search-wrap" style={{ flex: 1, marginBottom: 0 }}>
              <SearchBar value={q} onChange={setQ} placeholder="Cari series, karakter…" />
            </div>
          </div>
          <div className="filters-row">
            <div className="chips-wrap">
              <FilterChips
                label="Filter franchise"
                options={SERIES_FRANCHISE_FILTERS}
                value={franchise}
                onChange={(v) => setParam('franchise', v)}
              />
            </div>
            <div className="chips-wrap">
              <FilterChips
                label="Filter era"
                options={ERAS}
                value={era}
                onChange={(v) => setParam('era', v)}
                allLabel="Semua era"
              />
            </div>
          </div>
        </div>

        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !displayData && <Loading />}
        {!error && displayData && (
          categoryRows.length === 0 ? (
            <div className="series-list-container">
              <Empty title="Series tidak ditemukan" text="Ubah kata kunci atau hapus filter." />
            </div>
          ) : (
            <div className="rows-container">
              {categoryRows.map((cat) => (
                <SectionRow
                  key={cat.key}
                  title={cat.title}
                  items={cat.items}
                  totalCount={cat.totalCount}
                  isWide={isFiltered}
                  showSeeAll={!isFiltered}
                  seeAllHref={`/?franchise=${encodeURIComponent(cat.key)}`}
                  onSeeAll={() => setParam('franchise', cat.key)}
                />
              ))}
            </div>
          )
        )}
      </GlassPanel>

      {ENABLE_EDIT && (
        <SeriesModal
          isOpen={createOpen}
          onClose={() => setCreateOpen(false)}
          onSave={handleCreateSeries}
        />
      )}
    </>
  );
}
