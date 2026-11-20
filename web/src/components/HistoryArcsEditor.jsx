import { Plus, Trash2, BookOpen, Quote, Tv, Image as ImageIcon } from 'lucide-react';

export default function HistoryArcsEditor({ arcs = [], onChange }) {
  const handleAddArc = () => {
    const newArc = {
      id: `arc-${Date.now()}-${Math.random().toString(36).substring(2, 6)}`,
      sub_title: '',
      quote_text: '',
      quote_speaker: '',
      story_paragraphs: '',
      scene_image_url: '',
      scene_caption: '',
      episode_reference: '',
    };
    onChange([...arcs, newArc]);
  };

  const handleUpdateArc = (index, field, value) => {
    const updated = arcs.map((arc, idx) => {
      if (idx === index) {
        return { ...arc, [field]: value };
      }
      return arc;
    });
    onChange(updated);
  };

  const handleRemoveArc = (index) => {
    const updated = arcs.filter((_, idx) => idx !== index);
    onChange(updated);
  };

  return (
    <div className="history-arcs-editor">
      <div className="history-arcs-editor__header">
        <div className="history-arcs-editor__title">
          <BookOpen size={18} className="text-red" />
          <span>Alur Cerita & Sub-bab Kronologis (History Arcs)</span>
        </div>
        <button
          type="button"
          className="btn-secondary btn-sm"
          onClick={handleAddArc}
          style={{ padding: '6px 14px', fontSize: '0.85rem' }}
        >
          <Plus size={15} />
          Tambah Sub-bab Cerita
        </button>
      </div>

      <p className="history-arcs-editor__hint">
        Bagi alur cerita menjadi beberapa bab terstruktur (contoh: Deployment, Anti-Shocker Alliance) lengkap dengan kutipan dialog, gambar adegan, dan referensi episode.
      </p>

      {arcs.length === 0 ? (
        <div className="history-arcs-editor__empty">
          <p>Belum ada sub-bab cerita.</p>
          <button
            type="button"
            className="history-arcs-editor__empty-btn"
            onClick={handleAddArc}
          >
            <Plus size={16} /> Tambah Sub-bab Pertama
          </button>
        </div>
      ) : (
        <div className="history-arcs-editor__list">
          {arcs.map((arc, index) => (
            <div key={arc.id || index} className="history-arc-form-card">
              <div className="history-arc-form-card__head">
                <span className="history-arc-form-card__badge">
                  SUB-BAB #{index + 1}
                </span>
                <button
                  type="button"
                  className="icon-btn icon-btn--danger icon-btn--sm"
                  onClick={() => handleRemoveArc(index)}
                  title="Hapus sub-bab ini"
                  aria-label="Hapus sub-bab"
                >
                  <Trash2 size={16} />
                </button>
              </div>

              {/* Judul Sub-bab */}
              <div className="form-group">
                <label>Judul Sub-bab / Nama Arc *</label>
                <input
                  type="text"
                  className="form-input"
                  required
                  placeholder="Contoh: Deployment / Anti-Shocker Alliance"
                  value={arc.sub_title || ''}
                  onChange={(e) => handleUpdateArc(index, 'sub_title', e.target.value)}
                />
              </div>

              {/* Kutipan Dialog & Pembicara */}
              <div className="form-row">
                <div className="form-group">
                  <label style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                    <Quote size={13} /> Kutipan Dialog (Opsional)
                  </label>
                  <input
                    type="text"
                    className="form-input"
                    placeholder="Contoh: There's only one person who can stop you, and that's me!"
                    value={arc.quote_text || ''}
                    onChange={(e) => handleUpdateArc(index, 'quote_text', e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Tokoh Pembicara</label>
                  <input
                    type="text"
                    className="form-input"
                    placeholder="Contoh: Aruto Hiden"
                    value={arc.quote_speaker || ''}
                    onChange={(e) => handleUpdateArc(index, 'quote_speaker', e.target.value)}
                  />
                </div>
              </div>

              {/* Paragraf Narasi Cerita */}
              <div className="form-group">
                <label>Paragraf Narasi Alur Cerita *</label>
                <textarea
                  rows={4}
                  className="form-input"
                  required
                  placeholder="Tuliskan narasi lengkap peristiwa cerita pada sub-bab ini. Pisahkan antar paragraf dengan tombol Enter dua kali…"
                  value={arc.story_paragraphs || ''}
                  onChange={(e) => handleUpdateArc(index, 'story_paragraphs', e.target.value)}
                />
              </div>

              {/* Cuplikan Adegan (Foto & Keterangan) */}
              <div className="form-row">
                <div className="form-group">
                  <label style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                    <ImageIcon size={13} /> URL Gambar Adegan (Opsional)
                  </label>
                  <input
                    type="url"
                    className="form-input"
                    placeholder="https://example.com/scene.jpg"
                    value={arc.scene_image_url || ''}
                    onChange={(e) => handleUpdateArc(index, 'scene_image_url', e.target.value)}
                  />
                </div>
                <div className="form-group">
                  <label>Keterangan Foto (Caption)</label>
                  <input
                    type="text"
                    className="form-input"
                    placeholder="Contoh: Konfrontasi di puncak tebing berbatu."
                    value={arc.scene_caption || ''}
                    onChange={(e) => handleUpdateArc(index, 'scene_caption', e.target.value)}
                  />
                </div>
              </div>

              {/* Referensi Episode */}
              <div className="form-group">
                <label style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}>
                  <Tv size={13} /> Referensi Episode (Opsional)
                </label>
                <input
                  type="text"
                  className="form-input"
                  placeholder="Contoh: Episode 01: I am the President and a Kamen Rider"
                  value={arc.episode_reference || ''}
                  onChange={(e) => handleUpdateArc(index, 'episode_reference', e.target.value)}
                />
              </div>
            </div>
          ))}

          <button
            type="button"
            className="history-arcs-editor__add-more"
            onClick={handleAddArc}
          >
            <Plus size={16} /> Tambah Sub-bab Cerita Berikutnya
          </button>
        </div>
      )}
    </div>
  );
}
