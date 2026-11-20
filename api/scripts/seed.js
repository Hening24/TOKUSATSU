// Menjalankan schema.sql lalu seed.sql ke database Neon.  Pakai: npm run seed
const fs = require('fs');
const path = require('path');
const pool = require('../db');

(async () => {
  try {
    for (const file of ['schema.sql', 'seed.sql']) {
      const sql = fs.readFileSync(path.join(__dirname, '..', 'sql', file), 'utf8');
      await pool.query(sql);
      console.log('Selesai:', file);
    }
  } catch (err) {
    console.error('Seed gagal:', err.message);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
})();
