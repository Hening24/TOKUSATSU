export const FRANCHISES = {
  'Kamen Rider': { color: '#4CC26B', textColor: '#0E1530' },
  'Super Sentai': { color: '#FFC93C', textColor: '#0E1530' },
  Ultraman: { color: '#5BB8F5', textColor: '#0E1530' },
  'Metal Hero': { color: '#C7CEDD', textColor: '#0E1530' },
};

export const FRANCHISE_LIST = Object.keys(FRANCHISES);
export const ERAS = ['Showa', 'Heisei', 'Reiwa'];

export const MAIN_FRANCHISES = ['Kamen Rider', 'Ultraman', 'Super Sentai'];
export const ITEMS_PER_GROUP = 5;

export const SERIES_CATEGORIES = [
  { key: 'Kamen Rider', title: 'Kamen Rider', filterValue: 'Kamen Rider', linkAll: '/?franchise=Kamen%20Rider' },
  { key: 'Ultraman', title: 'Ultraman', filterValue: 'Ultraman', linkAll: '/?franchise=Ultraman' },
  { key: 'Super Sentai', title: 'Super Sentai', filterValue: 'Super Sentai', linkAll: '/?franchise=Super%20Sentai' },
  { key: 'lainnya', title: 'Tokusatsu Lainnya', filterValue: 'lainnya', linkAll: '/?franchise=lainnya' },
];

export const SERIES_FRANCHISE_FILTERS = SERIES_CATEGORIES.map(({ filterValue, title }) => ({
  value: filterValue,
  label: title,
}));

export function isOtherFranchise(franchise) {
  return !MAIN_FRANCHISES.includes(franchise);
}

export function matchesCategory(item, categoryKey) {
  if (categoryKey === 'lainnya') return isOtherFranchise(item?.franchise);
  return item?.franchise === categoryKey;
}

export function groupByCategory(items, { limit = null } = {}) {
  if (!Array.isArray(items) || items.length === 0) return [];
  return SERIES_CATEGORIES.map((cat) => {
    const matched = items.filter((item) => matchesCategory(item, cat.key));
    return {
      ...cat,
      totalCount: matched.length,
      items: limit ? matched.slice(0, limit) : matched,
    };
  }).filter((cat) => cat.totalCount > 0);
}

export function hexToRgb(hex = '#dc2626') {
  const h = hex.replace('#', '');
  if (h.length !== 6) return '220,38,38';
  const r = parseInt(h.substring(0, 2), 16);
  const g = parseInt(h.substring(2, 4), 16);
  const b = parseInt(h.substring(4, 6), 16);
  return `${r},${g},${b}`;
}

export function franchiseColor(name) {
  return FRANCHISES[name]?.color || '#D93A34';
}

export function franchiseTextColor(name) {
  if (FRANCHISES[name]?.textColor) return FRANCHISES[name].textColor;
  const hex = franchiseColor(name).replace('#', '');
  if (hex.length !== 6) return '#FFFFFF';
  const [r, g, b] = [0, 2, 4].map((i) => {
    const c = parseInt(hex.slice(i, i + 2), 16) / 255;
    return c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4;
  });
  const luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return luminance > 0.179 ? '#0E1530' : '#FFFFFF';
}

export function initials(title = '') {
  const words = title.split(/\s+/).filter(Boolean);
  const text = words.length > 1 ? words[0][0] + words[words.length - 1][0] : title.slice(0, 2);
  return text.toUpperCase();
}
