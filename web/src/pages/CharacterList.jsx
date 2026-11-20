import { useEffect, useState, useMemo } from 'react';
import { useSearchParams } from 'react-router-dom';
import { Plus } from 'lucide-react';
import SearchBar from '../components/SearchBar.jsx';
import FilterChips from '../components/FilterChips.jsx';
import SectionRow from '../components/SectionRow.jsx';
import GlassPanel from '../components/GlassPanel.jsx';
import CharacterModal from '../components/CharacterModal.jsx';
import { Empty, ErrorState, Loading } from '../components/State.jsx';
import useFetch from '../hooks/useFetch';
import useDebounce from '../hooks/useDebounce';
import useFavorites from '../hooks/useFavorites';
import { useToast } from '../context/ToastContext.jsx';
import { apiPost } from '../api/client';
import { ENABLE_EDIT } from '../config';
import { notifySaveWithImagePosCheck } from '../utils/imagePosition';
import {
  ITEMS_PER_GROUP,
  SERIES_FRANCHISE_FILTERS,
  groupByCategory,
} from '../utils/franchise';

function slugId(key) {
  return `char-group-${key.toLowerCase().replace(/[^a-z0-9]+/g, '-')}`;
}

function characterRoleRank(role) {
  const r = String(role || '').toLowerCase().trim();
  if (!r) return 4;
  if (
    r.startsWith('main') ||
    r === 'hero' ||
    r.includes('utama') ||
    r.includes('protagonis') ||
    r.includes('leader')
  ) {
    return 0;
  }
  if (r.includes('secondary') || r.includes('partner') || r.includes('rider')) return 1;
  if (r.includes('ally') || r.includes('sekutu') || r.includes('support')) return 2;
  return 3;
}

export default function CharacterList() {
  const [sp, setSp] = useSearchParams();
  const franchise = sp.get('franchise') || '';
  const [q, setQ] = useState(sp.get('q') || '');
  const dq = useDebounce(q).trim();
  const { has } = useFavorites();
  const { showToast } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const { data: seriesList } = useFetch('/series');
  const isFiltered = !!(dq || franchise);

  const setParam = (key, value, { replace = false } = {}) =>
    setSp(
      (prev) => {
        const next = new URLSearchParams(prev);
        if (value) next.set(key, value);
        else next.delete(key);
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

  const params = new URLSearchParams();
  if (dq) params.set('q', dq);
  if (franchise) params.set('franchise', franchise);
  const qs = params.toString();

  const { data, loading, error, reload } = useFetch(`/characters${qs ? `?${qs}` : ''}`);

  const groupedChars = useMemo(() => {
    if (!Array.isArray(data) || data.length === 0) return [];
    const sorted = [...data].sort(
      (a, b) =>
        characterRoleRank(a.role) - characterRoleRank(b.role) ||
        (b.series_year || 0) - (a.series_year || 0) ||
        (a.name || '').localeCompare(b.name || '')
    );
    return groupByCategory(sorted, {
      limit: isFiltered ? null : ITEMS_PER_GROUP,
    }).map((cat) => ({
      ...cat,
      anchorId: slugId(cat.key),
    }));
  }, [data, isFiltered]);

  const handleJumpTo = (anchorId) => {
    const el = document.getElementById(anchorId);
    if (!el) return;
    const reduced =
      typeof window !== 'undefined' &&
      window.matchMedia?.('(prefers-reduced-motion: reduce)').matches;
    el.scrollIntoView({ behavior: reduced ? 'auto' : 'smooth', block: 'start' });
  };

  const handleCreateCharacter = async (formData) => {
    const saved = await apiPost('/characters', formData);
    reload();
    notifySaveWithImagePosCheck(showToast, saved, 'Karakter berhasil ditambahkan.');
  };

  return (
    <GlassPanel className="actors-page char-list-page glass-perf-flat">
      <div className="actors-hero">
        <div className="list-hero-row list-hero-row--admin">
          <h1 className="actors-hero__title">KARAKTER</h1>
          {ENABLE_EDIT && (
            <button
              type="button"
              className="btn-primary list-add-btn"
              onClick={() => setCreateOpen(true)}
              aria-label="Tambah karakter"
            >
              <Plus size={18} aria-hidden="true" />
              <span className="list-add-btn__label">Tambah Karakter</span>
            </button>
          )}
        </div>
        <p className="actors-hero__sub">
          Para pahlawan, musuh ikonik, dan sosok di balik topengnya
        </p>
      </div>

      <div className="search-filter-section">
        <div className="actors-header-row">
          <div className="search-wrap" style={{ flex: 1, marginBottom: 0 }}>
            <SearchBar value={q} onChange={setQ} placeholder="Cari nama karakter, pahlawan, musuh…" />
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
        </div>
      </div>

      <div className="rows-container">
        {error && <ErrorState error={error} onRetry={reload} />}
        {!error && loading && !data && <Loading />}
        {!error && data && (
          <>
            <div className="char-meta-bar">
              <p className="count count--flush">{data.length} karakter ditemukan</p>

              {!franchise && groupedChars.length > 1 && (
                <nav className="char-jump-links" aria-label="Lompat ke kategori karakter">
                  {groupedChars.map((cat) => (
                    <button
                      key={cat.key}
                      type="button"
                      className="char-jump-link"
                      onClick={() => handleJumpTo(cat.anchorId)}
                    >
                      <span>{cat.title}</span>
                      <span className="char-jump-link__count">{cat.totalCount}</span>
                    </button>
                  ))}
                </nav>
              )}
            </div>

            {groupedChars.length === 0 ? (
              <div className="char-empty-wrap">
                <Empty title="Karakter tidak ditemukan" text="Ubah kata kunci atau hapus filter." />
              </div>
            ) : (
              groupedChars.map((cat) => (
                <SectionRow
                  key={cat.key}
                  id={cat.anchorId}
                  headingId={`${cat.anchorId}-heading`}
                  kind="character"
                  title={cat.title}
                  items={cat.items}
                  totalCount={cat.totalCount}
                  isWide={isFiltered}
                  perfFlat
                  showSeeAll={!isFiltered}
                  seeAllHref={`/characters?franchise=${encodeURIComponent(cat.key)}`}
                  onSeeAll={() => setParam('franchise', cat.key)}
                  isFavorite={(id) => has('characters', id)}
                />
              ))
            )}
          </>
        )}
      </div>

      {ENABLE_EDIT && (
        <CharacterModal
          isOpen={createOpen}
          onClose={() => setCreateOpen(false)}
          onSave={handleCreateCharacter}
          seriesList={seriesList || []}
        />
      )}
    </GlassPanel>
  );
}
