const WRITE_METHODS = new Set(['POST', 'PUT', 'PATCH', 'DELETE']);

function securityHeaders(req, res, next) {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  res.setHeader('Permissions-Policy', 'camera=(), microphone=(), geolocation=()');
  res.setHeader('Cross-Origin-Resource-Policy', 'cross-origin');
  if (process.env.NODE_ENV === 'production') {
    res.setHeader('Strict-Transport-Security', 'max-age=15552000; includeSubDomains');
  }
  next();
}

function createRateLimiter({ windowMs = 60_000, max = 120 } = {}) {
  const hits = new Map();

  const cleanup = setInterval(() => {
    const now = Date.now();
    for (const [key, entry] of hits.entries()) {
      if (now >= entry.resetAt) hits.delete(key);
    }
  }, windowMs);
  cleanup.unref?.();

  return function rateLimiter(req, res, next) {
    const ip = req.ip || req.socket?.remoteAddress || 'unknown';
    const now = Date.now();
    let entry = hits.get(ip);

    if (!entry || now >= entry.resetAt) {
      entry = { count: 0, resetAt: now + windowMs };
      hits.set(ip, entry);
    }

    entry.count += 1;
    const remaining = Math.max(0, max - entry.count);
    res.setHeader('X-RateLimit-Limit', String(max));
    res.setHeader('X-RateLimit-Remaining', String(remaining));
    res.setHeader('X-RateLimit-Reset', String(Math.ceil(entry.resetAt / 1000)));

    if (entry.count > max) {
      const retrySec = Math.max(1, Math.ceil((entry.resetAt - now) / 1000));
      res.setHeader('Retry-After', String(retrySec));
      return res.status(429).json({
        error: 'Terlalu banyak permintaan. Tunggu sebentar lalu coba lagi.',
      });
    }

    next();
  };
}

function writeGuard(req, res, next) {
  if (!WRITE_METHODS.has(req.method)) return next();
  const allowWrite = String(process.env.ALLOW_WRITE ?? 'true').trim().toLowerCase();
  if (allowWrite === 'false') {
    return res.status(403).json({
      error: 'Mode publik hanya-baca aktif (ALLOW_WRITE=false). Penulisan data dinonaktifkan.',
    });
  }
  return next();
}

module.exports = {
  securityHeaders,
  createRateLimiter,
  writeGuard,
};
