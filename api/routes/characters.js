const router = require('express').Router();
const pool = require('../db');
const { clean, hasImagePosColumns, withImagePosMeta, validateCharacterPayload } = require('../utils/validate');

// GET /characters?q=den&franchise=Kamen%20Rider
router.get('/', async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT c.*, s.title AS series_title, s.franchise, s.year AS series_year
       FROM characters c
       JOIN series s ON s.id = c.series_id
       WHERE ($1::text IS NULL OR c.name ILIKE '%' || $1::text || '%')
         AND (
           $2::text IS NULL
           OR (LOWER($2::text) = 'lainnya' AND s.franchise NOT IN ('Kamen Rider', 'Ultraman', 'Super Sentai'))
           OR (LOWER($2::text) <> 'lainnya' AND s.franchise = $2::text)
         )
       ORDER BY c.name`,
      [clean(req.query.q), clean(req.query.franchise)]
    );
    res.json(rows);
  } catch (err) {
    next(err);
  }
});

// GET /characters/:id (detail karakter lengkap dengan statistik, ringkasan series, dan list arcs)
router.get('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id)) return res.status(400).json({ error: 'ID tidak valid' });

    const { rows } = await pool.query(
      `SELECT c.*, s.title AS series_title, s.franchise, s.era, s.year
       FROM characters c
       JOIN series s ON s.id = c.series_id
       WHERE c.id = $1`,
      [id]
    );
    if (!rows.length) return res.status(404).json({ error: 'Karakter tidak ditemukan' });

    const char = rows[0];

    // Objek ringkas series
    const seriesBrief = {
      id: char.series_id,
      title: char.series_title,
      franchise: char.franchise,
      era: char.era,
      year: char.year,
    };

    // Ambil semua arc milik series, beri tanda appears: true jika karakter tercatat di arc_characters
    const arcsRes = await pool.query(
      `SELECT
         sa.*,
         CASE WHEN ac.character_id IS NOT NULL THEN true ELSE false END AS appears,
         ac.note AS arc_note
       FROM series_arcs sa
       LEFT JOIN arc_characters ac ON ac.arc_id = sa.id AND ac.character_id = $1
       WHERE sa.series_id = $2
       ORDER BY sa.arc_order ASC`,
      [id, char.series_id]
    );

    res.json({
      ...char,
      series: seriesBrief,
      arcs: arcsRes.rows,
    });
  } catch (err) {
    next(err);
  }
});

// POST /characters (Create karakter baru)
router.post('/', async (req, res, next) => {
  try {
    const { error, data } = validateCharacterPayload(req.body);
    if (error) return res.status(400).json({ error });

    const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [data.series_id]);
    if (!seriesCheck.rows.length) {
      return res.status(400).json({ error: 'Series asal tidak ditemukan.' });
    }

    const withPos = await hasImagePosColumns(pool, 'characters');
    const { rows } = withPos
      ? await pool.query(
          `INSERT INTO characters (
             series_id, name, actor, power, image, image_pos_x, image_pos_y, bio, history_arcs,
             rider_name, civilian_name, role, species, team, debut_episode,
             height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
             age_text, origin, blood_type, occupation, stats_note, source_url
           )
           VALUES (
             $1, $2, $3, $4, $5, $6, $7, $8, $9::jsonb,
             $10, $11, $12, $13, $14, $15,
             $16, $17, $18, $19, $20, $21,
             $22, $23, $24, $25, $26, $27
           )
           RETURNING *`,
          [
            data.series_id,
            data.name,
            data.actor,
            data.power,
            data.image,
            data.image_pos_x,
            data.image_pos_y,
            data.bio,
            data.arcsJson,
            data.rider_name,
            data.civilian_name,
            data.role,
            data.species,
            data.team,
            data.debut_episode,
            data.height_cm,
            data.weight_kg,
            data.punch_power_t,
            data.kick_power_t,
            data.max_jump_m,
            data.run_100m_s,
            data.age_text,
            data.origin,
            data.blood_type,
            data.occupation,
            data.stats_note,
            data.source_url,
          ]
        )
      : await pool.query(
          `INSERT INTO characters (
             series_id, name, actor, power, image, bio, history_arcs,
             rider_name, civilian_name, role, species, team, debut_episode,
             height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
             age_text, origin, blood_type, occupation, stats_note, source_url
           )
           VALUES (
             $1, $2, $3, $4, $5, $6, $7::jsonb,
             $8, $9, $10, $11, $12, $13,
             $14, $15, $16, $17, $18, $19,
             $20, $21, $22, $23, $24, $25
           )
           RETURNING *`,
          [
            data.series_id,
            data.name,
            data.actor,
            data.power,
            data.image,
            data.bio,
            data.arcsJson,
            data.rider_name,
            data.civilian_name,
            data.role,
            data.species,
            data.team,
            data.debut_episode,
            data.height_cm,
            data.weight_kg,
            data.punch_power_t,
            data.kick_power_t,
            data.max_jump_m,
            data.run_100m_s,
            data.age_text,
            data.origin,
            data.blood_type,
            data.occupation,
            data.stats_note,
            data.source_url,
          ]
        );

    const createdId = rows[0].id;
    const fullRes = await pool.query(
      `SELECT c.*, s.title AS series_title, s.franchise, s.era, s.year
       FROM characters c
       JOIN series s ON s.id = c.series_id
       WHERE c.id = $1`,
      [createdId]
    );

    res.status(201).json(withImagePosMeta(fullRes.rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// PUT /characters/:id (Update karakter)
router.put('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { error, data } = validateCharacterPayload(req.body);
    if (error) return res.status(400).json({ error });

    const seriesCheck = await pool.query('SELECT id FROM series WHERE id = $1', [data.series_id]);
    if (!seriesCheck.rows.length) {
      return res.status(400).json({ error: 'Series asal tidak ditemukan.' });
    }

    const body = req.body || {};
    const has = (k) => Object.prototype.hasOwnProperty.call(body, k);
    const withPos = await hasImagePosColumns(pool, 'characters');

    const { rows } = withPos
      ? await pool.query(
          `UPDATE characters
           SET series_id = $1, name = $2, actor = $3, power = $4, image = $5,
               image_pos_x = CASE WHEN $6::boolean THEN $7 ELSE image_pos_x END,
               image_pos_y = CASE WHEN $8::boolean THEN $9 ELSE image_pos_y END,
               bio = $10,
               history_arcs = CASE WHEN $11::boolean THEN $12::jsonb ELSE history_arcs END,
               rider_name = CASE WHEN $13::boolean THEN $14 ELSE rider_name END,
               civilian_name = CASE WHEN $15::boolean THEN $16 ELSE civilian_name END,
               role = CASE WHEN $17::boolean THEN $18 ELSE role END,
               species = CASE WHEN $19::boolean THEN $20 ELSE species END,
               team = CASE WHEN $21::boolean THEN $22 ELSE team END,
               debut_episode = CASE WHEN $23::boolean THEN $24 ELSE debut_episode END,
               height_cm = CASE WHEN $25::boolean THEN $26 ELSE height_cm END,
               weight_kg = CASE WHEN $27::boolean THEN $28 ELSE weight_kg END,
               punch_power_t = CASE WHEN $29::boolean THEN $30 ELSE punch_power_t END,
               kick_power_t = CASE WHEN $31::boolean THEN $32 ELSE kick_power_t END,
               max_jump_m = CASE WHEN $33::boolean THEN $34 ELSE max_jump_m END,
               run_100m_s = CASE WHEN $35::boolean THEN $36 ELSE run_100m_s END,
               age_text = CASE WHEN $37::boolean THEN $38 ELSE age_text END,
               origin = CASE WHEN $39::boolean THEN $40 ELSE origin END,
               blood_type = CASE WHEN $41::boolean THEN $42 ELSE blood_type END,
               occupation = CASE WHEN $43::boolean THEN $44 ELSE occupation END,
               stats_note = CASE WHEN $45::boolean THEN $46 ELSE stats_note END,
               source_url = CASE WHEN $47::boolean THEN $48 ELSE source_url END
           WHERE id = $49
           RETURNING *`,
          [
            data.series_id,
            data.name,
            data.actor,
            data.power,
            data.image,
            has('image_pos_x'), data.image_pos_x,
            has('image_pos_y'), data.image_pos_y,
            data.bio,
            has('history_arcs'), data.arcsJson,
            has('rider_name'), data.rider_name,
            has('civilian_name'), data.civilian_name,
            has('role'), data.role,
            has('species'), data.species,
            has('team'), data.team,
            has('debut_episode'), data.debut_episode,
            has('height_cm'), data.height_cm,
            has('weight_kg'), data.weight_kg,
            has('punch_power_t'), data.punch_power_t,
            has('kick_power_t'), data.kick_power_t,
            has('max_jump_m'), data.max_jump_m,
            has('run_100m_s'), data.run_100m_s,
            has('age_text'), data.age_text,
            has('origin'), data.origin,
            has('blood_type'), data.blood_type,
            has('occupation'), data.occupation,
            has('stats_note'), data.stats_note,
            has('source_url'), data.source_url,
            id,
          ]
        )
      : await pool.query(
          `UPDATE characters
           SET series_id = $1, name = $2, actor = $3, power = $4, image = $5, bio = $6,
               history_arcs = CASE WHEN $7::boolean THEN $8::jsonb ELSE history_arcs END,
               rider_name = CASE WHEN $9::boolean THEN $10 ELSE rider_name END,
               civilian_name = CASE WHEN $11::boolean THEN $12 ELSE civilian_name END,
               role = CASE WHEN $13::boolean THEN $14 ELSE role END,
               species = CASE WHEN $15::boolean THEN $16 ELSE species END,
               team = CASE WHEN $17::boolean THEN $18 ELSE team END,
               debut_episode = CASE WHEN $19::boolean THEN $20 ELSE debut_episode END,
               height_cm = CASE WHEN $21::boolean THEN $22 ELSE height_cm END,
               weight_kg = CASE WHEN $23::boolean THEN $24 ELSE weight_kg END,
               punch_power_t = CASE WHEN $25::boolean THEN $26 ELSE punch_power_t END,
               kick_power_t = CASE WHEN $27::boolean THEN $28 ELSE kick_power_t END,
               max_jump_m = CASE WHEN $29::boolean THEN $30 ELSE max_jump_m END,
               run_100m_s = CASE WHEN $31::boolean THEN $32 ELSE run_100m_s END,
               age_text = CASE WHEN $33::boolean THEN $34 ELSE age_text END,
               origin = CASE WHEN $35::boolean THEN $36 ELSE origin END,
               blood_type = CASE WHEN $37::boolean THEN $38 ELSE blood_type END,
               occupation = CASE WHEN $39::boolean THEN $40 ELSE occupation END,
               stats_note = CASE WHEN $41::boolean THEN $42 ELSE stats_note END,
               source_url = CASE WHEN $43::boolean THEN $44 ELSE source_url END
           WHERE id = $45
           RETURNING *`,
          [
            data.series_id,
            data.name,
            data.actor,
            data.power,
            data.image,
            data.bio,
            has('history_arcs'), data.arcsJson,
            has('rider_name'), data.rider_name,
            has('civilian_name'), data.civilian_name,
            has('role'), data.role,
            has('species'), data.species,
            has('team'), data.team,
            has('debut_episode'), data.debut_episode,
            has('height_cm'), data.height_cm,
            has('weight_kg'), data.weight_kg,
            has('punch_power_t'), data.punch_power_t,
            has('kick_power_t'), data.kick_power_t,
            has('max_jump_m'), data.max_jump_m,
            has('run_100m_s'), data.run_100m_s,
            has('age_text'), data.age_text,
            has('origin'), data.origin,
            has('blood_type'), data.blood_type,
            has('occupation'), data.occupation,
            has('stats_note'), data.stats_note,
            has('source_url'), data.source_url,
            id,
          ]
        );

    if (!rows.length) return res.status(404).json({ error: 'Karakter tidak ditemukan' });

    const fullRes = await pool.query(
      `SELECT c.*, s.title AS series_title, s.franchise, s.era, s.year
       FROM characters c
       JOIN series s ON s.id = c.series_id
       WHERE c.id = $1`,
      [id]
    );

    res.json(withImagePosMeta(fullRes.rows[0], withPos));
  } catch (err) {
    next(err);
  }
});

// DELETE /characters/:id (Delete karakter)
router.delete('/:id', async (req, res, next) => {
  try {
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ error: 'ID tidak valid' });

    const { rowCount } = await pool.query('DELETE FROM characters WHERE id = $1', [id]);
    if (rowCount === 0) return res.status(404).json({ error: 'Karakter tidak ditemukan' });

    res.json({ success: true, message: 'Karakter berhasil dihapus', id });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
