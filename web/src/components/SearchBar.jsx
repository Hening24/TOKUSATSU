import { Search, X } from 'lucide-react';

export default function SearchBar({ value, onChange, placeholder }) {
  return (
    <div className="search">
      <Search size={18} aria-hidden="true" />
      <input
        type="search"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        aria-label={placeholder}
      />
      {value && (
        <button type="button" onClick={() => onChange('')} aria-label="Hapus pencarian">
          <X size={18} aria-hidden="true" />
        </button>
      )}
    </div>
  );
}
