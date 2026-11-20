export function Loading({ rows = 4 }) {
  return (
    <div className="skeleton-list" aria-busy="true" aria-label="Memuat data">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="skeleton" />
      ))}
    </div>
  );
}

export function ErrorState({ error, onRetry }) {
  return (
    <div className="state" role="alert">
      <h2>Data belum bisa dimuat</h2>
      <p>{error?.message || 'Terjadi kesalahan.'}</p>
      <p className="muted">Kalau API baru saja dibuka, tunggu beberapa detik lalu coba lagi.</p>
      {onRetry && (
        <button type="button" className="btn" onClick={onRetry}>
          Coba lagi
        </button>
      )}
    </div>
  );
}

export function Empty({ title, text }) {
  return (
    <div className="state">
      <h2>{title}</h2>
      {text && <p>{text}</p>}
    </div>
  );
}
