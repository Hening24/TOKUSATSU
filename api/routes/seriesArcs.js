const router = require('express').Router();
const pool = require('../db');
const { validateArcPayload } = require('../utils/validate');

// POST /series-arcs (Create arc untuk series tertentu)
router.post('/', async (req, res, next) => {
  try {
    const seriesId = Number(req.body?.series_id);
    if (!Number.isInteger(seriesId) || seriesId <= 0) {
      return res.status(400).json({ error: 'series_id tidak valid.' });
    }

    const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [seriesId]);
    if (!seriesCheck.rows.length) {
      return res.status(404).json({ error: 'Series tidak ditemukan.' });
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

    res.status(201).json(rows[0]);
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ error: 'Urutan arc (arc_order) sudah digunakan pada series ini.' });
    }
    next(err);
  }
});

// PUT /series-arcs/:id (Update arc)
router.put('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      return res.status(400).json({ error: 'ID arc tidak valid.' });
    }

    const { error, data } = validateArcPayload(req.body, { orderRequired: true });
    if (error) return res.status(400).json({ error });

    const { rows } = await pool.query(
      `UPDATE series_arcs
       SET arc_order = $1, chapter_label = $2, title = $3, episode_range = $4,
           summary = $5, quote_text = $6, quote_by = $7, image_url = $8, image_caption = $9
       WHERE id = $10
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
        id,
      ]
    );

    if (!rows.length) return res.status(404).json({ error: 'Arc kronologi tidak ditemukan.' });
    res.json(rows[0]);
  } catch (err) {
    if (err.code === '23505') {
      return res.status(409).json({ error: 'Urutan arc (arc_order) sudah digunakan pada series ini.' });
    }
    next(err);
  }
});

// DELETE /series-arcs/:id (Delete arc)
router.delete('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) {
      return res.status(400).json({ error: 'ID arc tidak valid.' });
    }

    const { rowCount } = await pool.query('DELETE FROM series_arcs WHERE id = $1', [id]);
    if (rowCount === 0) return res.status(404).json({ error: 'Arc kronologi tidak ditemukan.' });

    res.json({ success: true, message: 'Arc kronologi berhasil dihapus', id });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
