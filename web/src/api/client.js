const BASE = (
  import.meta.env.VITE_API_URL ||
  (import.meta.env.DEV ? 'http://localhost:3000' : '')
).replace(/\/$/, '');

const getCache = new Map();

export function getCachedApi(path) {
  return getCache.get(path);
}

export function setCachedApi(path, data) {
  if (getCache.size >= 80) {
    const oldestKey = getCache.keys().next().value;
    getCache.delete(oldestKey);
  }
  getCache.set(path, data);
}

export function clearApiCache() {
  getCache.clear();
}

export async function api(path, signal) {
  let res;
  try {
    res = await fetch(BASE + path, { signal });
  } catch (err) {
    if (err.name === 'AbortError') throw err;
    throw new Error('Tidak bisa terhubung ke server. Cek koneksi internet lalu coba lagi.');
  }
  if (!res.ok) {
    let message = `Server mengembalikan status ${res.status}.`;
    try {
      const body = await res.json();
      if (body.error) message = body.error;
    } catch {
      /* abaikan, pakai pesan bawaan */
    }
    const err = new Error(message);
    err.status = res.status;
    throw err;
  }
  const data = await res.json();
  setCachedApi(path, data);
  return data;
}

async function sendWrite(method, path, data) {
  let res;
  try {
    res = await fetch(BASE + path, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: data !== undefined ? JSON.stringify(data) : undefined,
    });
  } catch {
    throw new Error('Tidak bisa terhubung ke server. Cek koneksi internet lalu coba lagi.');
  }

  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    const err = new Error(body.error || `Gagal memproses permintaan (status ${res.status})`);
    err.status = res.status;
    throw err;
  }

  clearApiCache();
  if (typeof window !== 'undefined' && 'caches' in window) {
    window.caches.delete('zukan-api').catch(() => {});
  }
  return res.json();
}

export async function apiPost(path, data) {
  return sendWrite('POST', path, data);
}

export async function apiPut(path, data) {
  return sendWrite('PUT', path, data);
}

export async function apiDelete(path) {
  return sendWrite('DELETE', path);
}

export const API_BASE = BASE;
