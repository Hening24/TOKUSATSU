import { useSyncExternalStore } from 'react';

const KEY = 'zukan:favorites';
const listeners = new Set();

function read() {
  try {
    const v = JSON.parse(localStorage.getItem(KEY));
    return {
      series: Array.isArray(v?.series) ? v.series : [],
      characters: Array.isArray(v?.characters) ? v.characters : [],
      actors: Array.isArray(v?.actors) ? v.actors : [],
    };
  } catch {
    return { series: [], characters: [], actors: [] };
  }
}

let state = read();

function write(next) {
  state = next;
  try {
    localStorage.setItem(KEY, JSON.stringify(next));
  } catch {
    /* penyimpanan penuh atau diblokir, abaikan */
  }
  listeners.forEach((l) => l());
}

const subscribe = (l) => {
  listeners.add(l);
  return () => listeners.delete(l);
};

// type: 'series' | 'characters' | 'actors'
export default function useFavorites() {
  const snapshot = useSyncExternalStore(subscribe, () => state);
  return {
    favorites: snapshot,
    has: (type, id) => (snapshot[type] || []).includes(id),
    toggle: (type, id) => {
      const list = snapshot[type] || [];
      write({
        ...snapshot,
        [type]: list.includes(id) ? list.filter((x) => x !== id) : [...list, id],
      });
    },
  };
}
