import { useState, useEffect } from 'react';
import { Shield } from 'lucide-react';
import ImageUrlField from './ImageUrlField.jsx';
import Modal from './Modal.jsx';

export default function CharacterModal({ isOpen, onClose, onSave, initialData, seriesList = [], defaultSeriesId = '' }) {
  const [formData, setFormData] = useState({
    name: '',
    rider_name: '',
    civilian_name: '',
    role: '',
    series_id: '',
    actor: '',
    power: '',
    image: '',
    image_pos_x: 50,
    image_pos_y: 50,
    bio: '',
    debut_episode: '',
    species: '',
    team: '',
    origin: '',
    occupation: '',
    age_text: '',
    blood_type: '',
    height_cm: '',
    weight_kg: '',
    punch_power_t: '',
    kick_power_t: '',
    max_jump_m: '',
    run_100m_s: '',
    stats_note: '',
    source_url: '',
  });

  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isOpen) return undefined;
    if (initialData) {
      setFormData({
        name: initialData.name || '',
        rider_name: initialData.rider_name || '',
        civilian_name: initialData.civilian_name || '',
        role: initialData.role || '',
        series_id: initialData.series_id || (seriesList[0]?.id || ''),
        actor: initialData.actor || '',
        power: initialData.power || '',
        image: initialData.image || '',
        image_pos_x: initialData.image_pos_x ?? 50,
        image_pos_y: initialData.image_pos_y ?? 50,
        bio: initialData.bio || '',
        debut_episode: initialData.debut_episode || '',
        species: initialData.species || '',
        team: initialData.team || '',
        origin: initialData.origin || '',
        occupation: initialData.occupation || '',
        age_text: initialData.age_text || '',
        blood_type: initialData.blood_type || '',
        height_cm: initialData.height_cm ?? '',
        weight_kg: initialData.weight_kg ?? '',
        punch_power_t: initialData.punch_power_t ?? '',
        kick_power_t: initialData.kick_power_t ?? '',
        max_jump_m: initialData.max_jump_m ?? '',
        run_100m_s: initialData.run_100m_s ?? '',
        stats_note: initialData.stats_note || '',
        source_url: initialData.source_url || '',
      });
    } else {
      setFormData({
        name: '',
        rider_name: '',
        civilian_name: '',
        role: '',
        series_id: defaultSeriesId || seriesList[0]?.id || '',
        actor: '',
        power: '',
        image: '',
        image_pos_x: 50,
        image_pos_y: 50,
        bio: '',
        debut_episode: '',
        species: '',
        team: '',
        origin: '',
        occupation: '',
        age_text: '',
        blood_type: '',
        height_cm: '',
        weight_kg: '',
        punch_power_t: '',
        kick_power_t: '',
        max_jump_m: '',
        run_100m_s: '',
        stats_note: '',
        source_url: '',
      });
    }
    setError('');
  }, [initialData, isOpen, seriesList, defaultSeriesId]);

  const toNumOrNull = (v) => (v === '' || v === null || v === undefined ? null : Number(v));

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.name.trim()) {
      setError('Nama karakter tidak boleh kosong.');
      return;
    }
    if (!formData.series_id) {
      setError('Pilih series asal karakter.');
      return;
    }

    try {
      setSaving(true);
      setError('');
      await onSave({
        ...formData,
        series_id: Number(formData.series_id),
        image_pos_x: formData.image_pos_x === '' ? 50 : Number(formData.image_pos_x),
        image_pos_y: formData.image_pos_y === '' ? 50 : Number(formData.image_pos_y),
        height_cm: toNumOrNull(formData.height_cm),
        weight_kg: toNumOrNull(formData.weight_kg),
        punch_power_t: toNumOrNull(formData.punch_power_t),
        kick_power_t: toNumOrNull(formData.kick_power_t),
        max_jump_m: toNumOrNull(formData.max_jump_m),
        run_100m_s: toNumOrNull(formData.run_100m_s),
      });
      onClose();
    } catch (err) {
      setError(err.message || 'Gagal menyimpan data karakter.');
    } finally {
      setSaving(false);
    }
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      title={initialData ? 'Edit Data Karakter' : 'Tambah Karakter Baru'}
      titleId="char-modal-title"
      icon={<Shield className="text-red" size={24} aria-hidden="true" />}
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

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="char-name">Nama Karakter / Hero *</label>
                <input
                  id="char-name"
                  type="text"
                  className="form-input"
                  required
                  placeholder="Contoh: Kamen Rider Zero-One"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="char-series">Series Asal *</label>
                <select
                  id="char-series"
                  className="form-input"
                  required
                  value={formData.series_id}
                  onChange={(e) => setFormData({ ...formData, series_id: e.target.value })}
                >
                  <option value="">-- Pilih Series Asal --</option>
                  {seriesList.map((s) => (
                    <option key={s.id} value={s.id}>
                      {s.title} ({s.franchise} - {s.year || '-'})
                    </option>
                  ))}
                </select>
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="char-actor">Aktor / Pengisi Suara</label>
              <input
                id="char-actor"
                type="text"
                className="form-input"
                placeholder="Contoh: Fumiya Takahashi"
                value={formData.actor}
                onChange={(e) => setFormData({ ...formData, actor: e.target.value })}
              />
            </div>

            <ImageUrlField
              id="char-image"
              label="URL Foto / Gambar Karakter"
              value={formData.image}
              onChange={(image) => setFormData({ ...formData, image })}
              placeholder="https://example.com/character.jpg"
              previewAlt={formData.name || 'Pratinjau gambar karakter'}
              aspectRatio="3 / 4"
              defaultFrame="2:3"
              posX={formData.image_pos_x}
              posY={formData.image_pos_y}
              onPositionChange={(image_pos_x, image_pos_y) =>
                setFormData((prev) => ({ ...prev, image_pos_x, image_pos_y }))
              }
            />

            <div className="form-group">
              <label htmlFor="char-power">Kekuatan & Senjata Khas</label>
              <input
                id="char-power"
                type="text"
                className="form-input"
                placeholder="Contoh: Rising Hopper Progrisekey, Attache Calibur"
                value={formData.power}
                onChange={(e) => setFormData({ ...formData, power: e.target.value })}
              />
            </div>

            <div className="form-group">
              <label htmlFor="char-bio">Biografi / Deskripsi Singkat</label>
              <textarea
                id="char-bio"
                rows={3}
                className="form-input"
                placeholder="Deskripsi ringkas profil karakter…"
                value={formData.bio}
                onChange={(e) => setFormData({ ...formData, bio: e.target.value })}
              />
            </div>

            <details className="modal-details-group">
              <summary className="modal-details-summary">
                Profil Tambahan & Statistik Fisik (Opsional)
              </summary>
              <div className="modal-details-body">
                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-rider-name">Nama Wujud Hero</label>
                    <input
                      id="char-rider-name"
                      type="text"
                      className="form-input"
                      value={formData.rider_name}
                      onChange={(e) => setFormData({ ...formData, rider_name: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-civilian">Nama Sipil</label>
                    <input
                      id="char-civilian"
                      type="text"
                      className="form-input"
                      value={formData.civilian_name}
                      onChange={(e) => setFormData({ ...formData, civilian_name: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-role">Peran</label>
                    <input
                      id="char-role"
                      type="text"
                      className="form-input"
                      placeholder="Contoh: Main Hero / Secondary Rider"
                      value={formData.role}
                      onChange={(e) => setFormData({ ...formData, role: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-debut">Episode Debut</label>
                    <input
                      id="char-debut"
                      type="text"
                      className="form-input"
                      value={formData.debut_episode}
                      onChange={(e) => setFormData({ ...formData, debut_episode: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-species">Species</label>
                    <input
                      id="char-species"
                      type="text"
                      className="form-input"
                      value={formData.species}
                      onChange={(e) => setFormData({ ...formData, species: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-team">Team</label>
                    <input
                      id="char-team"
                      type="text"
                      className="form-input"
                      value={formData.team}
                      onChange={(e) => setFormData({ ...formData, team: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-origin">Asal</label>
                    <input
                      id="char-origin"
                      type="text"
                      className="form-input"
                      value={formData.origin}
                      onChange={(e) => setFormData({ ...formData, origin: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-occupation">Pekerjaan</label>
                    <input
                      id="char-occupation"
                      type="text"
                      className="form-input"
                      value={formData.occupation}
                      onChange={(e) => setFormData({ ...formData, occupation: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-age">Usia</label>
                    <input
                      id="char-age"
                      type="text"
                      className="form-input"
                      value={formData.age_text}
                      onChange={(e) => setFormData({ ...formData, age_text: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-blood">Golongan Darah</label>
                    <input
                      id="char-blood"
                      type="text"
                      className="form-input"
                      value={formData.blood_type}
                      onChange={(e) => setFormData({ ...formData, blood_type: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-height">Tinggi (cm)</label>
                    <input
                      id="char-height"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.height_cm}
                      onChange={(e) => setFormData({ ...formData, height_cm: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-weight">Berat (kg)</label>
                    <input
                      id="char-weight"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.weight_kg}
                      onChange={(e) => setFormData({ ...formData, weight_kg: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-punch">Pukulan (ton)</label>
                    <input
                      id="char-punch"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.punch_power_t}
                      onChange={(e) => setFormData({ ...formData, punch_power_t: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-kick">Tendangan (ton)</label>
                    <input
                      id="char-kick"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.kick_power_t}
                      onChange={(e) => setFormData({ ...formData, kick_power_t: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-row">
                  <div className="form-group">
                    <label htmlFor="char-jump">Lompatan (m)</label>
                    <input
                      id="char-jump"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.max_jump_m}
                      onChange={(e) => setFormData({ ...formData, max_jump_m: e.target.value })}
                    />
                  </div>
                  <div className="form-group">
                    <label htmlFor="char-run">Lari 100m (detik)</label>
                    <input
                      id="char-run"
                      type="number"
                      step="any"
                      min={0}
                      className="form-input"
                      value={formData.run_100m_s}
                      onChange={(e) => setFormData({ ...formData, run_100m_s: e.target.value })}
                    />
                  </div>
                </div>

                <div className="form-group">
                  <label htmlFor="char-source">URL Sumber Data</label>
                  <input
                    id="char-source"
                    type="url"
                    className="form-input"
                    value={formData.source_url}
                    onChange={(e) => setFormData({ ...formData, source_url: e.target.value })}
                  />
                </div>

                <div className="form-group" style={{ marginBottom: 0 }}>
                  <label htmlFor="char-stats-note">Catatan Statistik</label>
                  <textarea
                    id="char-stats-note"
                    rows={2}
                    className="form-input"
                    value={formData.stats_note}
                    onChange={(e) => setFormData({ ...formData, stats_note: e.target.value })}
                  />
                </div>
              </div>
            </details>
    </Modal>
  );
}
