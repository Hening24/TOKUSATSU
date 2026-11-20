import { useEffect, useState } from 'react';
import { Image as ImageIcon } from 'lucide-react';
import ImagePositioner from './ImagePositioner.jsx';

export default function ImageUrlField({
  id,
  label,
  value,
  onChange,
  placeholder = 'https://example.com/gambar.jpg',
  previewAlt = 'Pratinjau gambar',
  aspectRatio = '16 / 9',
  posX = 50,
  posY = 50,
  defaultFrame = 'viewport',
  onPositionChange,
}) {
  const trimmed = String(value || '').trim();
  const isCandidateUrl = /^https?:\/\/\S+$/i.test(trimmed) || /^data:image\/\S+/i.test(trimmed) || trimmed.startsWith('/');
  const [failed, setFailed] = useState(false);

  useEffect(() => {
    setFailed(false);
  }, [trimmed]);

  const supportsPositioning = typeof onPositionChange === 'function';

  const handleClear = () => {
    onChange('');
    onPositionChange?.(50, 50);
  };

  return (
    <div className="form-group">
      <label htmlFor={id}>{label}</label>
      <input
        id={id}
        type="url"
        className="form-input"
        placeholder={placeholder}
        value={value}
        onChange={(e) => onChange(e.target.value)}
      />

      {supportsPositioning ? (
        <ImagePositioner
          src={value}
          alt={previewAlt}
          posX={posX}
          posY={posY}
          defaultFrame={defaultFrame}
          onPositionChange={onPositionChange}
          onClearImage={handleClear}
        />
      ) : (
        <div
          className={`image-preview-box${aspectRatio === '3 / 4' ? ' image-preview-box--portrait' : ''}${aspectRatio === '1 / 1' ? ' image-preview-box--square' : ''}`}
        >
          {isCandidateUrl && !failed ? (
            <img
              src={trimmed}
              alt={previewAlt}
              onError={() => setFailed(true)}
              onLoad={() => setFailed(false)}
            />
          ) : (
            <div className="image-preview-box__empty">
              <ImageIcon size={20} aria-hidden="true" />
              <span>
                {trimmed && failed
                  ? 'Gambar gagal dimuat. Periksa kembali URL gambar.'
                  : trimmed && !isCandidateUrl
                    ? 'Masukkan URL diawali http://, https://, atau /'
                    : 'Pratinjau gambar tampil di sini saat URL diisi'}
              </span>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
