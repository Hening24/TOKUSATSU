import { useState, useEffect } from 'react';
import { Tv } from 'lucide-react';
import { FRANCHISE_LIST, ERAS } from '../utils/franchise';
import ImageUrlField from './ImageUrlField.jsx';
import Modal from './Modal.jsx';

export default function SeriesModal({ isOpen, onClose, onSave, initialData }) {
  const [formData, setFormData] = useState({
    title: '',
    franchise: 'Kamen Rider',
    era: 'Reiwa',
    year: new Date().getFullYear(),
    episodes: '',
    studio: 'Toei Company',
    poster: '',
    image_pos_x: 50,
    image_pos_y: 50,
    synopsis: '',
    full_plot: '',
  });

  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isOpen) return undefined;
    if (initialData) {
      setFormData({
        title: initialData.title || '',
        franchise: initialData.franchise || 'Kamen Rider',
        era: initialData.era || 'Reiwa',
        year: initialData.year ?? '',
        episodes: initialData.episodes ?? '',
        studio: initialData.studio || '',
        poster: initialData.poster || '',
        image_pos_x: initialData.image_pos_x ?? 50,
        image_pos_y: initialData.image_pos_y ?? 50,
        synopsis: initialData.synopsis || '',
        full_plot: initialData.full_plot || '',
      });
    } else {
      setFormData({
        title: '',
        franchise: 'Kamen Rider',
        era: 'Reiwa',
        year: new Date().getFullYear(),
        episodes: '',
        studio: 'Toei Company',
        poster: '',
        image_pos_x: 50,
        image_pos_y: 50,
        synopsis: '',
        full_plot: '',
      });
    }
    setError('');
  }, [initialData, isOpen]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.title.trim()) {
      setError('Judul series wajib diisi.');
      return;
    }
    if (formData.year !== '' && (!Number.isInteger(Number(formData.year)) || Number(formData.year) < 1950 || Number(formData.year) > 2100)) {
      setError('Tahun tayang harus antara 1950 dan 2100.');
      return;
    }
    if (formData.episodes !== '' && (!Number.isInteger(Number(formData.episodes)) || Number(formData.episodes) < 1)) {
      setError('Jumlah episode harus bilangan bulat minimal 1.');
      return;
    }
    try {
      setSaving(true);
      setError('');
      await onSave({
        ...formData,
        year: formData.year === '' ? null : Number(formData.year),
        episodes: formData.episodes === '' ? null : Number(formData.episodes),
        image_pos_x: formData.image_pos_x === '' ? 50 : Number(formData.image_pos_x),
        image_pos_y: formData.image_pos_y === '' ? 50 : Number(formData.image_pos_y),
      });
      onClose();
    } catch (err) {
      setError(err.message || 'Gagal menyimpan series.');
    } finally {
      setSaving(false);
    }
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      title={initialData ? 'Edit Data Series' : 'Tambah Series Tokusatsu Baru'}
      titleId="series-modal-title"
      icon={<Tv className="text-red" size={24} aria-hidden="true" />}
      size="lg"
      busy={saving}
      onSubmit={handleSubmit}
      footer={
        <>
          <button type="button" className="btn-secondary" onClick={onClose} disabled={saving}>
            Batal
          </button>
          <button type="submit" className="btn-primary" disabled={saving}>
            {saving ? 'Menyimpan…' : 'Simpan perubahan'}
          </button>
        </>
      }
    >
      {error && <div className="form-error" role="alert">{error}</div>}

            <div className="form-group">
              <label htmlFor="series-title">Judul Series *</label>
              <input
                id="series-title"
                type="text"
                className="form-input"
                required
                placeholder="Contoh: Kamen Rider Gavv"
                value={formData.title}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              />
            </div>

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="series-franchise">Franchise *</label>
                <select
                  id="series-franchise"
                  className="form-input"
                  value={formData.franchise}
                  onChange={(e) => setFormData({ ...formData, franchise: e.target.value })}
                >
                  {FRANCHISE_LIST.map((f) => (
                    <option key={f} value={f}>{f}</option>
                  ))}
                </select>
              </div>

              <div className="form-group">
                <label htmlFor="series-era">Era *</label>
                <select
                  id="series-era"
                  className="form-input"
                  value={formData.era}
                  onChange={(e) => setFormData({ ...formData, era: e.target.value })}
                >
                  {ERAS.map((er) => (
                    <option key={er} value={er}>{er}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="series-year">Tahun Tayang</label>
                <input
                  id="series-year"
                  type="number"
                  min={1950}
                  max={2100}
                  className="form-input"
                  placeholder="Contoh: 2024"
                  value={formData.year}
                  onChange={(e) => setFormData({ ...formData, year: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="series-episodes">Jumlah Episode</label>
                <input
                  id="series-episodes"
                  type="number"
                  min={1}
                  max={2000}
                  className="form-input"
                  placeholder="Contoh: 49"
                  value={formData.episodes}
                  onChange={(e) => setFormData({ ...formData, episodes: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="series-studio">Produksi / Studio</label>
              <input
                id="series-studio"
                type="text"
                className="form-input"
                placeholder="Contoh: Toei Company / Ishimori Productions"
                value={formData.studio}
                onChange={(e) => setFormData({ ...formData, studio: e.target.value })}
              />
            </div>

            <ImageUrlField
              id="series-poster"
              label="URL Gambar / Poster"
              value={formData.poster}
              onChange={(poster) => setFormData({ ...formData, poster })}
              placeholder="https://example.com/poster.jpg"
              previewAlt={formData.title || 'Pratinjau poster series'}
              aspectRatio="16 / 9"
              defaultFrame="hero"
              posX={formData.image_pos_x}
              posY={formData.image_pos_y}
              onPositionChange={(image_pos_x, image_pos_y) =>
                setFormData((prev) => ({ ...prev, image_pos_x, image_pos_y }))
              }
            />

            <div className="form-group">
              <label htmlFor="series-synopsis">Sinopsis</label>
              <textarea
                id="series-synopsis"
                rows={3}
                className="form-input"
                placeholder="Ringkasan singkat series…"
                value={formData.synopsis}
                onChange={(e) => setFormData({ ...formData, synopsis: e.target.value })}
              />
            </div>

            <div className="form-group" style={{ marginBottom: 0 }}>
              <label htmlFor="series-plot">Alur Cerita Lengkap</label>
              <textarea
                id="series-plot"
                rows={4}
                className="form-input"
                placeholder="Garis besar alur cerita keseluruhan…"
                value={formData.full_plot}
                onChange={(e) => setFormData({ ...formData, full_plot: e.target.value })}
              />
            </div>
    </Modal>
  );
}
