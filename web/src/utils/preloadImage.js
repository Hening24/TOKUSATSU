const preloadedUrls = new Set();

/**
 * Preload ringan untuk foto detail saat kartu di-hover atau disentuh.
 * Tidak memicu request baru saat daftar pertama kali dirender.
 */
export function preloadImage(url) {
  if (typeof window === 'undefined') return;
  const src = typeof url === 'string' ? url.trim() : '';
  if (!src || preloadedUrls.has(src)) return;
  if (preloadedUrls.size >= 200) {
    const oldest = preloadedUrls.values().next().value;
    preloadedUrls.delete(oldest);
  }
  preloadedUrls.add(src);
  const img = new window.Image();
  img.src = src;
}
