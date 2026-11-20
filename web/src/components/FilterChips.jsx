export default function FilterChips({ label, options, value, onChange, allLabel = 'Semua' }) {
  const items = [
    { value: '', label: allLabel },
    ...options.map((o) => (typeof o === 'string' ? { value: o, label: o } : o)),
  ];
  return (
    <div className="chips" role="group" aria-label={label}>
      {items.map((o) => (
        <button
          key={o.value || 'all'}
          type="button"
          className="chip-btn"
          aria-pressed={value === o.value}
          onClick={() => onChange(o.value)}
        >
          {o.label}
        </button>
      ))}
    </div>
  );
}
