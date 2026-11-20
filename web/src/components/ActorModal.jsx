import { useState, useEffect } from 'react';
import { Clapperboard } from 'lucide-react';
import ImageUrlField from './ImageUrlField.jsx';
import Modal from './Modal.jsx';

const ROLE_TYPES = [
  { value: 'MC', label: 'Main Character / Pemeran Utama' },
  { value: 'Secondary Rider', label: 'Secondary Rider / Rekan Pahlawan' },
  { value: 'Hero', label: 'Pahlawan / Anggota Tim' },
  { value: 'Villain', label: 'Villain / Antagonis Utama' },
];

export default function ActorModal({
  isOpen,
  onClose,
  onSave,
  initialData,
  seriesList: seriesListProp = [],
  defaultSeriesId = '',
}) {
  const seriesList = seriesListProp || [];
  const [formData, setFormData] = useState({
    name: '',
    kanji: '',
    character: '',
    role_type: 'MC',
    series_id: '',
    birth_date: '',
    birth_place: '',
    agency: '',
    photo: '',
    image_pos_x: 50,
    image_pos_y: 50,
    bio: '',
  });

  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isOpen) return undefined;
    if (initialData) {
      setFormData({
        name: initialData.name || '',
        kanji: initialData.kanji || '',
        character: initialData.character || '',
        role_type: initialData.role_type || 'MC',
        series_id: initialData.series_id ?? (defaultSeriesId || seriesList[0]?.id || ''),
        birth_date: initialData.birth_date || '',
        birth_place: initialData.birth_place || '',
        agency: initialData.agency || '',
        photo: initialData.photo || '',
        image_pos_x: initialData.image_pos_x ?? 50,
        image_pos_y: initialData.image_pos_y ?? 50,
        bio: initialData.bio || '',
      });
    } else {
      setFormData({
        name: '',
        kanji: '',
        character: '',
        role_type: 'MC',
        series_id: defaultSeriesId || seriesList[0]?.id || '',
        birth_date: '',
        birth_place: '',
        agency: '',
        photo: '',
        image_pos_x: 50,
        image_pos_y: 50,
        bio: '',
      });
    }
    setError('');
  }, [initialData, isOpen, seriesList, defaultSeriesId]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.name.trim() || !formData.character.trim()) {
      setError('Nama aktor dan nama karakter wajib diisi.');
      return;
    }
    try {
      setSaving(true);
      setError('');
      await onSave({
        ...formData,
        series_id: formData.series_id ? Number(formData.series_id) : null,
        image_pos_x: formData.image_pos_x === '' ? 50 : Number(formData.image_pos_x),
        image_pos_y: formData.image_pos_y === '' ? 50 : Number(formData.image_pos_y),
      });
      onClose();
    } catch (err) {
      setError(err.message || 'Gagal menyimpan data pemeran.');
    } finally {
      setSaving(false);
    }
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      title={initialData ? 'Edit Data Pemeran' : 'Tambah Pemeran Baru'}
      titleId="actor-modal-title"
      icon={<Clapperboard className="text-red" size={24} aria-hidden="true" />}
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

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="actor-name">Nama Aktor (Romaji) *</label>
                <input
                  id="actor-name"
                  type="text"
                  className="form-input"
                  required
                  placeholder="Contoh: Fumiya Takahashi"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="actor-kanji">Nama Kanji</label>
                <input
                  id="actor-kanji"
                  type="text"
                  className="form-input"
                  placeholder="Contoh: 高橋 文哉"
                  value={formData.kanji}
                  onChange={(e) => setFormData({ ...formData, kanji: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="actor-character">Nama Karakter & Wujud Hero *</label>
              <input
                id="actor-character"
                type="text"
                className="form-input"
                required
                placeholder="Contoh: Aruto Hiden / Kamen Rider Zero-One"
                value={formData.character}
                onChange={(e) => setFormData({ ...formData, character: e.target.value })}
              />
            </div>

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="actor-role">Peran dalam Cerita</label>
                <select
                  id="actor-role"
                  className="form-input"
                  value={formData.role_type}
                  onChange={(e) => setFormData({ ...formData, role_type: e.target.value })}
                >
                  {ROLE_TYPES.map((r) => (
                    <option key={r.value} value={r.value}>{r.label}</option>
                  ))}
                </select>
              </div>

              <div className="form-group">
                <label htmlFor="actor-series">Series yang Dibintangi</label>
                <select
                  id="actor-series"
                  className="form-input"
                  value={formData.series_id}
                  onChange={(e) => setFormData({ ...formData, series_id: e.target.value })}
                >
                  <option value="">-- Tanpa Series / Series Lain --</option>
                  {seriesList.map((s) => (
                    <option key={s.id} value={s.id}>
                      {s.title} ({s.franchise} - {s.year || '-'})
                    </option>
                  ))}
                </select>
              </div>
            </div>

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="actor-birth">Tanggal Lahir</label>
                <input
                  id="actor-birth"
                  type="text"
                  className="form-input"
                  placeholder="Contoh: 12 Maret 2001"
                  value={formData.birth_date}
                  onChange={(e) => setFormData({ ...formData, birth_date: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="actor-origin">Asal</label>
                <input
                  id="actor-origin"
                  type="text"
                  className="form-input"
                  placeholder="Contoh: Saitama, Jepang"
                  value={formData.birth_place}
                  onChange={(e) => setFormData({ ...formData, birth_place: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="actor-agency">Agensi</label>
              <input
                id="actor-agency"
                type="text"
                className="form-input"
                placeholder="Contoh: A-Plus Entertainment"
                value={formData.agency}
                onChange={(e) => setFormData({ ...formData, agency: e.target.value })}
              />
            </div>

            <ImageUrlField
              id="actor-photo"
              label="URL Foto / Avatar"
              value={formData.photo}
              onChange={(photo) => setFormData({ ...formData, photo })}
              placeholder="https://example.com/photo.jpg"
              previewAlt={formData.name || 'Pratinjau foto pemeran'}
              aspectRatio="1 / 1"
              defaultFrame="viewport"
              posX={formData.image_pos_x}
              posY={formData.image_pos_y}
              onPositionChange={(image_pos_x, image_pos_y) =>
                setFormData((prev) => ({ ...prev, image_pos_x, image_pos_y }))
              }
            />

            <div className="form-group" style={{ marginBottom: 0 }}>
              <label htmlFor="actor-bio">Biografi Singkat</label>
              <textarea
                id="actor-bio"
                rows={4}
                className="form-input"
                placeholder="Latar belakang aktor dan catatan peran…"
                value={formData.bio}
                onChange={(e) => setFormData({ ...formData, bio: e.target.value })}
              />
            </div>
    </Modal>
  );
}
