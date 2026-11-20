import { useEffect, useState } from 'react';
import { BookOpen } from 'lucide-react';
import ImageUrlField from './ImageUrlField.jsx';
import Modal from './Modal.jsx';

export default function ArcModal({ isOpen, onClose, onSave, initialData, nextOrder = 1 }) {
  const [formData, setFormData] = useState({
    arc_order: nextOrder,
    chapter_label: '',
    title: '',
    episode_range: '',
    summary: '',
    quote_text: '',
    quote_by: '',
    image_url: '',
    image_caption: '',
  });
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!isOpen) return undefined;
    if (initialData) {
      setFormData({
        arc_order: initialData.arc_order ?? nextOrder,
        chapter_label: initialData.chapter_label || '',
        title: initialData.title || initialData.sub_title || '',
        episode_range: initialData.episode_range || initialData.episode_reference || '',
        summary: initialData.summary || initialData.story_paragraphs || '',
        quote_text: initialData.quote_text || '',
        quote_by: initialData.quote_by || initialData.quote_speaker || '',
        image_url: initialData.image_url || initialData.scene_image_url || '',
        image_caption: initialData.image_caption || initialData.scene_caption || '',
      });
    } else {
      setFormData({
        arc_order: nextOrder,
        chapter_label: `ARC ${String(nextOrder).padStart(2, '0')}`,
        title: '',
        episode_range: '',
        summary: '',
        quote_text: '',
        quote_by: '',
        image_url: '',
        image_caption: '',
      });
    }
    setError('');
  }, [initialData, isOpen, nextOrder]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.title.trim()) {
      setError('Judul arc wajib diisi.');
      return;
    }
    const orderNum = Number(formData.arc_order);
    if (!Number.isInteger(orderNum) || orderNum < 1) {
      setError('Urutan arc harus berupa angka bulat minimal 1.');
      return;
    }
    try {
      setSaving(true);
      setError('');
      await onSave({
        ...formData,
        arc_order: orderNum,
      });
      onClose();
    } catch (err) {
      setError(err.message || 'Gagal menyimpan arc kronologi.');
    } finally {
      setSaving(false);
    }
  };

  return (
    <Modal
      isOpen={isOpen}
      onClose={onClose}
      title={initialData ? 'Edit Arc Kronologi' : 'Tambah Arc Kronologi'}
      titleId="arc-modal-title"
      icon={<BookOpen className="text-red" size={22} aria-hidden="true" />}
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
                <label htmlFor="arc-order">Urutan Arc *</label>
                <input
                  id="arc-order"
                  type="number"
                  min={1}
                  max={1000}
                  required
                  className="form-input"
                  value={formData.arc_order}
                  onChange={(e) => setFormData({ ...formData, arc_order: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="arc-label">Label Bab</label>
                <input
                  id="arc-label"
                  type="text"
                  className="form-input"
                  placeholder="Contoh: ARC 01"
                  value={formData.chapter_label}
                  onChange={(e) => setFormData({ ...formData, chapter_label: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="arc-title">Judul Arc *</label>
              <input
                id="arc-title"
                type="text"
                required
                className="form-input"
                placeholder="Contoh: Lahirnya Zero-One"
                value={formData.title}
                onChange={(e) => setFormData({ ...formData, title: e.target.value })}
              />
            </div>

            <div className="form-group">
              <label htmlFor="arc-episodes">Referensi Episode</label>
              <input
                id="arc-episodes"
                type="text"
                className="form-input"
                placeholder="Contoh: Episode 1–16"
                value={formData.episode_range}
                onChange={(e) => setFormData({ ...formData, episode_range: e.target.value })}
              />
            </div>

            <div className="form-row">
              <div className="form-group">
                <label htmlFor="arc-quote">Kutipan Dialog</label>
                <input
                  id="arc-quote"
                  type="text"
                  className="form-input"
                  placeholder="Kutipan ikonik pada arc ini…"
                  value={formData.quote_text}
                  onChange={(e) => setFormData({ ...formData, quote_text: e.target.value })}
                />
              </div>

              <div className="form-group">
                <label htmlFor="arc-speaker">Tokoh Pembicara</label>
                <input
                  id="arc-speaker"
                  type="text"
                  className="form-input"
                  placeholder="Contoh: Aruto Hiden"
                  value={formData.quote_by}
                  onChange={(e) => setFormData({ ...formData, quote_by: e.target.value })}
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="arc-summary">Narasi / Ringkasan</label>
              <textarea
                id="arc-summary"
                rows={4}
                className="form-input"
                placeholder="Tuliskan alur peristiwa penting pada bab ini…"
                value={formData.summary}
                onChange={(e) => setFormData({ ...formData, summary: e.target.value })}
              />
            </div>

            <ImageUrlField
              id="arc-image"
              label="URL Gambar Adegan"
              value={formData.image_url}
              onChange={(image_url) => setFormData({ ...formData, image_url })}
              placeholder="https://example.com/scene.jpg"
              previewAlt={formData.title || 'Pratinjau gambar adegan'}
              aspectRatio="16 / 9"
            />

            <div className="form-group" style={{ marginBottom: 0 }}>
              <label htmlFor="arc-caption">Keterangan Gambar</label>
              <input
                id="arc-caption"
                type="text"
                className="form-input"
                placeholder="Deskripsi singkat adegan…"
                value={formData.image_caption}
                onChange={(e) => setFormData({ ...formData, image_caption: e.target.value })}
              />
            </div>
    </Modal>
  );
}
