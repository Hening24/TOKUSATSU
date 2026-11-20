const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const { Pool } = require('pg');

const databaseUrl = process.env.DATABASE_URL;
if (!databaseUrl) {
  console.error('DATABASE_URL belum diisi. Buat file .env dari .env.example.');
  process.exit(1);
}

const disableSsl = /sslmode=disable/i.test(databaseUrl);

const pool = new Pool({
  connectionString: databaseUrl,
  ssl: disableSsl ? false : { rejectUnauthorized: false },
  max: 5,
});

pool.on('error', (err) => {
  console.error('Koneksi database terputus:', err?.code || 'DB_ERROR');
});

module.exports = pool;
