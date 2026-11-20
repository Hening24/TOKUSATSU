const router = require('express').Router();
const pool = require('../db');
const { clean, hasImagePosColumns, withImagePosMeta, validateSeriesPayload, validateArcPayload } = require('../utils/validate');

// GET /series?q=kuuga&era=Heisei&franchise=Kamen%20Rider&sort=year_desc&limit=10
router.get('/', async (req, res, next) => {
  try {
    const sortParam = req.query.sort === 'year_asc' ? 'year_asc' : 'year_desc';
    const limitNum = req.query.limit && !isNaN(Number(req.query.limit)) && Number(req.query.limit) > 0
      ? parseInt(req.query.limit, 10)
      : null;

    const { rows } = await pool.query(
      `SELECT * FROM series
       WHERE ($1::text IS NULL OR title ILIKE '%' || $1::text || '%')
         AND ($2::text IS NULL OR era = $2::text)
         AND (
           $3::text IS NULL
           OR (LOWER($3::text) = 'lainnya' AND franchise NOT IN ('Kamen Rider', 'Ultraman', 'Super Sentai'))
           OR (LOWER($3::text) <> 'lainnya' AND franchise = $3::text)
         )
       ORDER BY
         CASE WHEN $4::text = 'year_asc' THEN year END ASC NULLS LAST,
         CASE WHEN $4::text = 'year_asc' THEN id END ASC,
         CASE WHEN $4::text = 'year_desc' THEN year END DESC NULLS LAST,
         id DESC
       LIMIT $5::int`,
      [clean(req.query.q), clean(req.query.era), clean(req.query.franchise), sortParam, limitNum]
    );
    res.json(rows);
  } catch (err) {
    next(err);
  }
});

// GET /series/:id (membawa daftar karakter, aktor, dan daftar kronologi arcs)
router.get('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id)) return res.status(400).json({ error: 'ID tidak valid' });

    const s = await pool.query('SELECT * FROM series WHERE id = $1', [id]);
    if (!s.rows.length) return res.status(404).json({ error: 'Series tidak ditemukan' });

    const c = await pool.query('SELECT * FROM characters WHERE series_id = $1 ORDER BY id', [id]);
    const a = await pool.query('SELECT * FROM actors WHERE series_id = $1 ORDER BY id', [id]);
    const arcs = await pool.query('SELECT * FROM series_arcs WHERE series_id = $1 ORDER BY arc_order ASC', [id]);

    res.json({
      ...s.rows[0],
      characters: c.rows,
      actors: a.rows,
      arcs: arcs.rows,
    });
  } catch (err) {
    next(err);
  }
});

// POST /series (Create series baru)
router.post('/', async (req, res, next) => {
  try {
    const { error, data } = validateSeriesPayload(req.body);
    if (error) return res.status(400).json({ error });

    const withPos = await hasImagePosColumns(pool, 'series');
    const { rows } = withPos
      ? await pool.query(
          `INSERT INTO series (title, franchise, era, year, episodes, studio, poster, image_pos_x, image_pos_y, synopsis, full_plot, history_arcs)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12::jsonb)
           RETURNING *`,
          [
            data.title,
            data.franchise,
            data.era,
            data.year,
            data.episodes,
            data.studio,
            data.poster,
            data.image_pos_x,
            data.image_pos_y,
            data.synopsis,
            data.full_plot,
            data.arcsJson,
          ]
        )
      : await pool.query(
          `INSERT INTO series (title, franchise, era, year, episodes, studio, poster, synopsis, full_plot, history_arcs)
           VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10::jsonb)
           RETURNING *`,
          [
            data.title,
            data.franchise,
            data.era,
            data.year,
            data.episodes,
            data.studio,
            data.poster,
            data.synopsis,
            data.full_plot,
            data.arcsJson,
          ]
        );

    res.status(201).json(withImagePosMeta(rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// PUT /series/:id (Update series)
router.put('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { error, data } = validateSeriesPayload(req.body);
    if (error) return res.status(400).json({ error });

    const hasHistoryArcs = Object.prototype.hasOwnProperty.call(req.body || {}, 'history_arcs');
    const withPos = await hasImagePosColumns(pool, 'series');

    const { rows } = withPos
      ? await pool.query(
          `UPDATE series
           SET title = $1, franchise = $2, era = $3, year = $4, episodes = $5,
               studio = $6, poster = $7, image_pos_x = $8, image_pos_y = $9,
               synopsis = $10, full_plot = $11,
               history_arcs = CASE WHEN $12::boolean THEN $13::jsonb ELSE history_arcs END
           WHERE id = $14
           RETURNING *`,
          [
            data.title,
            data.franchise,
            data.era,
            data.year,
            data.episodes,
            data.studio,
            data.poster,
            data.image_pos_x,
            data.image_pos_y,
            data.synopsis,
            data.full_plot,
            hasHistoryArcs,
            data.arcsJson,
            id,
          ]
        )
      : await pool.query(
          `UPDATE series
           SET title = $1, franchise = $2, era = $3, year = $4, episodes = $5,
               studio = $6, poster = $7, synopsis = $8, full_plot = $9,
               history_arcs = CASE WHEN $10::boolean THEN $11::jsonb ELSE history_arcs END
           WHERE id = $12
           RETURNING *`,
          [
            data.title,
            data.franchise,
            data.era,
            data.year,
            data.episodes,
            data.studio,
            data.poster,
            data.synopsis,
            data.full_plot,
            hasHistoryArcs,
            data.arcsJson,
            id,
          ]
        );

    if (!rows.length) return res.status(404).json({ error: 'Series tidak ditemukan' });
    res.json(withImagePosMeta(rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// DELETE /series/:id (Delete series)
router.delete('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { rowCount } = await pool.query('DELETE FROM series WHERE id = $1', [id]);
    if (rowCount === 0) return res.status(404).json({ error: 'Series tidak ditemukan' });

    res.json({ success: true, message: 'Series berhasil dihapus', id });
  } catch (err) {
    next(err);
  }
});

// POST /series/:id/arcs (Create arc kronologi pada series)
router.post('/:id/arcs', async (req, res, next) => {
  try {
    const seriesId = Number(req.params.id);
    if (!Number.isInteger(seriesId) || seriesId <= 0) {
      return res.status(400).json({ error: 'ID series tidak valid' });
    }

    const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [seriesId]);
    if (!seriesCheck.rows.length) {
      return res.status(404).json({ error: 'Series tidak ditemukan' });
    }

    const { error, data } = validateArcPayload(req.body);
    if (error) return res.status(400).json({ error });

    let arcOrder = data.arc_order;
    if (arcOrder === null) {
      const maxRes = await pool.query(
        'SELECT COALESCE(MAX(arc_order), 0) + 1 AS next_order FROM series_arcs WHERE series_id = $1',
        [seriesId]
      );
      arcOrder = Number(maxRes.rows[0].next_order);
    }

    const { rows } = await pool.query(
      `INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
       RETURNING *`,
      [
        seriesId,
        arcOrder,
        data.chapter_label,
        data.title,
        data.episode_range,
        data.summary,
        data.quote_text,
        data.quote_by,
        data.image_url,
        data.image_caption,
      ]
    );

    res.status(201).json(withImagePosMeta(rows[0], withPos));
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ error: 'Urutan arc (arc_order) sudah digunakan pada series ini.' });
    }
    next(err);
  }
});

// PUT /series/:id/arcs/:arcId (Update arc kronologi)
router.put('/:id/arcs/:arcId', async (req, res, next) => {
  try {
    const seriesId = Number(req.params.id);
    const arcId = Number(req.params.arcId);
    if (!Number.isInteger(seriesId) || seriesId <= 0 || !Number.isInteger(arcId) || arcId <= 0) {
      return res.status(400).json({ error: 'ID tidak valid' });
    }

    const { error, data } = validateArcPayload(req.body, { orderRequired: true });
    if (error) return res.status(400).json({ error });

    const { rows } = await pool.query(
      `UPDATE series_arcs
       SET arc_order = $1, chapter_label = $2, title = $3, episode_range = $4,
           summary = $5, quote_text = $6, quote_by = $7, image_url = $8, image_caption = $9
       WHERE id = $10 AND series_id = $11
       RETURNING *`,
      [
        data.arc_order,
        data.chapter_label,
        data.title,
        data.episode_range,
        data.summary,
        data.quote_text,
        data.quote_by,
        data.image_url,
        data.image_caption,
        arcId,
        seriesId,
      ]
    );

    if (!rows.length) return res.status(404).json({ error: 'Arc kronologi tidak ditemukan' });
    res.json(rows[0]);
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ error: 'Urutan arc (arc_order) sudah digunakan pada series ini.' });
    }
    next(err);
  }
});

// DELETE /series/:id/arcs/:arcId (Delete arc kronologi)
router.delete('/:id/arcs/:arcId', async (req, res, next) => {
  try {
    const seriesId = Number(req.params.id);
    const arcId = Number(req.params.arcId);
    if (!Number.isInteger(seriesId) || seriesId <= 0 || !Number.isInteger(arcId) || arcId <= 0) {
      return res.status(400).json({ error: 'ID tidak valid' });
    }

    const { rowCount } = await pool.query(
      'DELETE FROM series_arcs WHERE id = $1 AND series_id = $2',
      [arcId, seriesId]
    );
    if (rowCount === 0) return res.status(404).json({ error: 'Arc kronologi tidak ditemukan' });

    res.json({ success: true, message: 'Arc kronologi berhasil dihapus', id: arcId });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
