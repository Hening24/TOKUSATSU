const express = require('express');
const cors = require('cors');
require('./db'); // cek DATABASE_URL lebih awal
const { securityHeaders, createRateLimiter, writeGuard } = require('./middleware/security');

const app = express();
app.disable('x-powered-by');
app.set('trust proxy', 1);
app.use(securityHeaders);

// Endpoint kesehatan ringan untuk platform deploy (tanpa menyentuh database)
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

function getAllowedOrigins() {
  const raw = process.env.CORS_ORIGIN || '';
  const list = raw
    .split(',')
    .map((o) => o.trim().replace(/\/$/, ''))
    .filter(Boolean);
  if (list.length > 0) return list;
  if (process.env.NODE_ENV === 'production') return [];
  return ['http://localhost:5173', 'http://127.0.0.1:5173'];
}

const allowedOrigins = getAllowedOrigins();

app.use(cors({
  origin(origin, callback) {
    if (!origin) return callback(null, true);
    const normalized = origin.replace(/\/$/, '');
    if (allowedOrigins.includes('*') || allowedOrigins.includes(normalized)) {
      return callback(null, true);
    }
    const err = new Error('Origin tidak diizinkan oleh kebijakan CORS.');
    err.status = 403;
    return callback(err);
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type'],
}));

app.use(createRateLimiter({ windowMs: 60_000, max: 120 }));
app.use(express.json({ limit: '1mb' }));
app.use(writeGuard);

app.get('/', (req, res) => {
  res.json({
    name: 'Tokusatsu Zukan API',
    endpoints: [
      'GET /health',
      'GET /series?q=&era=&franchise=',
      'GET /series/:id',
      'POST /series',
      'PUT /series/:id',
      'DELETE /series/:id',
      'POST /series/:id/arcs',
      'PUT /series/:id/arcs/:arcId',
      'DELETE /series/:id/arcs/:arcId',
      'GET /characters?q=&franchise=',
      'GET /characters/:id',
      'POST /characters',
      'PUT /characters/:id',
      'DELETE /characters/:id',
      'GET /actors?q=&franchise=&era=',
      'GET /actors/:id',
      'POST /actors',
      'PUT /actors/:id',
      'DELETE /actors/:id',
    ],
  });
});

app.use('/series', require('./routes/series'));
app.use('/characters', require('./routes/characters'));
app.use('/actors', require('./routes/actors'));
app.use('/series-arcs', require('./routes/seriesArcs'));

app.use((req, res) => res.status(404).json({ error: 'Endpoint tidak ditemukan' }));

app.use((err, req, res, next) => {
  if (err && err.status === 403) {
    return res.status(403).json({ error: err.message });
  }
  if (err && err.code === '23505') {
    return res.status(409).json({ error: 'Data duplikat bentrok dengan aturan unik di database.' });
  }
  if (err && err.code === '23503') {
    return res.status(400).json({ error: 'Referensi data terkait tidak ditemukan.' });
  }
  console.error('Server error:', err?.code || err?.message || 'UNKNOWN');
  res.status(500).json({ error: 'Terjadi kesalahan di server' });
});

if (require.main === module && !process.env.VERCEL) {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => console.log(`API jalan di port ${PORT}`));
}

module.exports = app;
