import { Quote, Tv, Image as ImageIcon, BookOpen, Plus, Pencil, Trash2 } from 'lucide-react';

export default function HistoryArcsViewer({
  arcs = [],
  accentColor = '#dc2626',
  title = 'Alur Cerita & History',
  emptyText = 'Kronologi untuk series ini belum tersedia.',
  onAddArc,
  onEditArc,
  onDeleteArc,
}) {
  const hasArcs = Array.isArray(arcs) && arcs.length > 0;

  return (
    <section className="history-arcs-section" style={{ '--accent': accentColor }}>
      <div className="history-arcs-header">
        <div className="history-arcs-header__top">
          <div>
            <div className="history-arcs-badge">
              <BookOpen size={16} aria-hidden="true" />
              <span>CHRONOLOGICAL ARCHIVES</span>
            </div>
            <h3 className="history-arcs-title">{title}</h3>
          </div>
          {onAddArc && (
            <button
              type="button"
              className="btn-outline btn-admin-compact"
              onClick={onAddArc}
              aria-label="Tambah arc kronologi"
            >
              <Plus size={16} aria-hidden="true" />
              <span>Tambah Arc</span>
            </button>
          )}
        </div>
        <p className="history-arcs-desc">
          Dokumentasi sejarah, alur peristiwa penting, dan kutipan dialog yang disusun secara kronologis
        </p>
      </div>

      {!hasArcs ? (
        <div className="history-arcs-empty glass-card">
          <p>{emptyText}</p>
        </div>
      ) : (
        <div className="history-arcs-timeline">
        {arcs.map((arc, index) => {
          const arcNumber = String(arc.arc_order || index + 1).padStart(2, '0');
          const chapterLabel = arc.chapter_label || `ARC ${arcNumber}`;
          const arcTitle = arc.title || arc.sub_title;
          const rawSummary = arc.summary || arc.story_paragraphs || '';
          const quoteText = arc.quote_text;
          const quoteBy = arc.quote_by || arc.quote_speaker;
          const imageUrl = arc.image_url || arc.scene_image_url;
          const imageCaption = arc.image_caption || arc.scene_caption;
          const episodeRange = arc.episode_range || arc.episode_reference;

          const paragraphs = rawSummary
            .split(/\n\n+/)
            .filter((p) => p.trim());

          const isDimmed = arc.appears === false;

          return (
            <article
              key={arc.id || index}
              className={`history-arc-card glass-card${isDimmed ? ' history-arc-card--dimmed' : ''}`}
            >
              {/* Timeline Marker & Header */}
              <div className="history-arc__top">
                <div className="history-arc__index">
                  <span className="history-arc__index-num">{arcNumber}</span>
                  <span className="history-arc__index-line" />
                </div>
                <div className="history-arc__title-wrap">
                  <span className="history-arc__label">
                    {chapterLabel}
                    {arc.appears === true && (
                      <span
                        className="badge badge--franchise history-arc__appears-badge"
                      >
                        Karakter ini muncul
                      </span>
                    )}
                  </span>
                  <h4 className="history-arc__subtitle">{arcTitle}</h4>
                </div>
                {(onEditArc || onDeleteArc) && (
                  <div className="history-arc__admin-actions">
                    {onEditArc && (
                      <button
                        type="button"
                        className="icon-btn"
                        onClick={() => onEditArc(arc)}
                        aria-label={`Edit arc ${arcTitle}`}
                        title="Edit arc"
                      >
                        <Pencil size={17} aria-hidden="true" />
                      </button>
                    )}
                    {onDeleteArc && (
                      <button
                        type="button"
                        className="icon-btn icon-btn--danger"
                        onClick={() => onDeleteArc(arc)}
                        aria-label={`Hapus arc ${arcTitle}`}
                        title="Hapus arc"
                      >
                        <Trash2 size={17} aria-hidden="true" />
                      </button>
                    )}
                  </div>
                )}
              </div>

              {/* Kutipan Dialog Ikonik (disembunyikan jika kosong) */}
              {quoteText && (
                <div className="history-arc__quote-box">
                  <Quote className="history-arc__quote-icon" size={24} aria-hidden="true" />
                  <blockquote className="history-arc__quote-text">
                    "{quoteText}"
                  </blockquote>
                  {quoteBy && (
                    <cite className="history-arc__quote-speaker">
                      — {quoteBy}
                    </cite>
                  )}
                </div>
              )}

              {/* Konten Narasi + Kartu Adegan Ensiklopedia (tampil rapi tanpa gambar jika NULL) */}
              <div className="history-arc__content-flow">
                {imageUrl && (
                  <figure className="history-arc__scene-card">
                    <div className="history-arc__scene-media">
                      <img
                        src={imageUrl}
                        alt={imageCaption || arcTitle}
                        loading="lazy"
                        onError={(e) => {
                          e.currentTarget.style.display = 'none';
                        }}
                      />
                      <div className="history-arc__scene-overlay" />
                    </div>
                    {imageCaption && (
                      <figcaption className="history-arc__scene-caption">
                        <ImageIcon size={12} className="history-arc__scene-icon" />
                        <span>{imageCaption}</span>
                      </figcaption>
                    )}
                  </figure>
                )}

                <div className="history-arc__narrative">
                  {paragraphs.length > 0 ? (
                    paragraphs.map((p, pIdx) => (
                      <p key={pIdx} className="history-arc__paragraph">
                        {p}
                      </p>
                    ))
                  ) : (
                    <p className="history-arc__paragraph text-muted">
                      Belum ada uraian narasi untuk sub-bab ini.
                    </p>
                  )}
                  {arc.arc_note && (
                    <p className="muted" style={{ marginTop: 8, fontSize: '0.85rem' }}>
                      <strong>Peran:</strong> {arc.arc_note}
                    </p>
                  )}
                </div>
              </div>

              {/* Referensi Episode di Akhir Sub-bab */}
              {episodeRange && (
                <div className="history-arc__footer">
                  <span className="history-arc__ep-badge">
                    <Tv size={13} aria-hidden="true" />
                    <span>{episodeRange}</span>
                  </span>
                </div>
              )}
            </article>
          );
        })}
        </div>
      )}
    </section>
  );
}
