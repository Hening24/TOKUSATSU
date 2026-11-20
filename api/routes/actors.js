const router = require('express').Router();
const pool = require('../db');
const { clean, hasImagePosColumns, withImagePosMeta, validateActorPayload } = require('../utils/validate');

// GET /actors?q=takahashi&franchise=Kamen%20Rider&era=Reiwa
router.get('/', async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT a.*,
              s.title AS series_title,
              s.franchise,
              s.era,
              s.year AS series_year
       FROM actors a
       LEFT JOIN series s ON s.id = a.series_id
       WHERE ($1::text IS NULL OR a.name ILIKE '%' || $1::text || '%' OR a.character ILIKE '%' || $1::text || '%' OR a.kanji ILIKE '%' || $1::text || '%')
         AND ($2::text IS NULL OR s.franchise = $2::text)
         AND ($3::text IS NULL OR s.era = $3::text)
       ORDER BY a.id ASC`,
      [clean(req.query.q), clean(req.query.franchise), clean(req.query.era)]
    );
    res.json(rows);
  } catch (err) {
    next(err);
  }
});

// GET /actors/:id
router.get('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id)) return res.status(400).json({ error: 'ID tidak valid' });

    const { rows } = await pool.query(
      `SELECT a.*,
              s.title AS series_title,
              s.franchise,
              s.era,
              s.year AS series_year
       FROM actors a
       LEFT JOIN series s ON s.id = a.series_id
       WHERE a.id = $1`,
      [id]
    );

    if (!rows.length) return res.status(404).json({ error: 'Aktor tidak ditemukan' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
});

// POST /actors (Create Actor baru)
router.post('/', async (req, res, next) => {
  try {
    const { error, data } = validateActorPayload(req.body);
    if (error) return res.status(400).json({ error });

    if (data.series_id !== null) {
      const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [data.series_id]);
      if (!seriesCheck.rows.length) {
        return res.status(400).json({ error: 'Series yang dipilih tidak ditemukan.' });
      }
    }

    const withPos = await hasImagePosColumns(pool, 'actors');
    const { rows } = withPos
      ? await pool.query(
          `INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, agency, photo, image_pos_x, image_pos_y, bio)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
           RETURNING *`,
          [
            data.name,
            data.kanji,
            data.character,
            data.role_type,
            data.series_id,
            data.birth_date,
            data.birth_place,
            data.agency,
            data.photo,
            data.image_pos_x,
            data.image_pos_y,
            data.bio,
          ]
        )
      : await pool.query(
          `INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, agency, photo, bio)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
           RETURNING *`,
          [
            data.name,
            data.kanji,
            data.character,
            data.role_type,
            data.series_id,
            data.birth_date,
            data.birth_place,
            data.agency,
            data.photo,
            data.bio,
          ]
        );

    // Ambil data lengkap dengan relasi series
    const createdId = rows[0].id;
    const fullRes = await pool.query(
      `SELECT a.*, s.title AS series_title, s.franchise, s.era, s.year AS series_year
       FROM actors a
       LEFT JOIN series s ON s.id = a.series_id
       WHERE a.id = $1`,
      [createdId]
    );

    res.status(201).json(withImagePosMeta(fullRes.rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// PUT /actors/:id (Update Actor)
router.put('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { error, data } = validateActorPayload(req.body);
    if (error) return res.status(400).json({ error });

    if (data.series_id !== null) {
      const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [data.series_id]);
      if (!seriesCheck.rows.length) {
        return res.status(400).json({ error: 'Series yang dipilih tidak ditemukan.' });
      }
    }

    const withPos = await hasImagePosColumns(pool, 'actors');
    const { rows } = withPos
      ? await pool.query(
          `UPDATE actors
           SET name = $1, kanji = $2, character = $3, role_type = $4, series_id = $5,
               birth_date = $6, birth_place = $7, agency = $8, photo = $9,
               image_pos_x = $10, image_pos_y = $11, bio = $12
           WHERE id = $13
           RETURNING *`,
          [
            data.name,
            data.kanji,
            data.character,
            data.role_type,
            data.series_id,
            data.birth_date,
            data.birth_place,
            data.agency,
            data.photo,
            data.image_pos_x,
            data.image_pos_y,
            data.bio,
            id,
          ]
        )
      : await pool.query(
          `UPDATE actors
           SET name = $1, kanji = $2, character = $3, role_type = $4, series_id = $5,
               birth_date = $6, birth_place = $7, agency = $8, photo = $9, bio = $10
           WHERE id = $11
           RETURNING *`,
          [
            data.name,
            data.kanji,
            data.character,
            data.role_type,
            data.series_id,
            data.birth_date,
            data.birth_place,
            data.agency,
            data.photo,
            data.bio,
            id,
          ]
        );

    if (!rows.length) return res.status(404).json({ error: 'Aktor tidak ditemukan' });

    // Ambil data lengkap dengan relasi series
    const fullRes = await pool.query(
      `SELECT a.*, s.title AS series_title, s.franchise, s.era, s.year AS series_year
       FROM actors a
       LEFT JOIN series s ON s.id = a.series_id
       WHERE a.id = $1`,
      [id]
    );

    res.json(withImagePosMeta(fullRes.rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// DELETE /actors/:id (Delete Actor)
router.delete('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { rowCount } = await pool.query('DELETE FROM actors WHERE id = $1', [id]);
    if (rowCount === 0) return res.status(404).json({ error: 'Aktor tidak ditemukan' });

    res.json({ success: true, message: 'Aktor berhasil dihapus', id });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
