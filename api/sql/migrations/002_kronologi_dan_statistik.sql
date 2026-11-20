-- =============================================================================
-- Migration 002: Kronologi dan Statistik
-- Aman dijalankan berulang kali (Idempotent: ADD COLUMN IF NOT EXISTS & CREATE TABLE IF NOT EXISTS)
-- DILARANG MENGGUNAKAN DROP TABLE ATAU MENGUBAH KOLOM LAMA
-- =============================================================================

-- 1. Tabel series: tambah kolom informasi metadata & penayangan
ALTER TABLE series ADD COLUMN IF NOT EXISTS title_jp TEXT;
ALTER TABLE series ADD COLUMN IF NOT EXISTS aired_from DATE;
ALTER TABLE series ADD COLUMN IF NOT EXISTS aired_to DATE;
ALTER TABLE series ADD COLUMN IF NOT EXISTS motif TEXT;
ALTER TABLE series ADD COLUMN IF NOT EXISTS source_url TEXT;

-- 2. Tabel characters: tambah kolom statistik tempur & profil lengkap
ALTER TABLE characters ADD COLUMN IF NOT EXISTS rider_name TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS civilian_name TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS role TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS height_cm NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS weight_kg NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS punch_power_t NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS kick_power_t NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS max_jump_m NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS run_100m_s NUMERIC;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS debut_episode TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS source_url TEXT;

-- 3. Tabel baru series_arcs: bab / kronologi alur cerita per series
CREATE TABLE IF NOT EXISTS series_arcs (
  id SERIAL PRIMARY KEY,
  series_id INT REFERENCES series(id) ON DELETE CASCADE,
  arc_order INT NOT NULL,
  chapter_label TEXT,
  title TEXT NOT NULL,
  episode_range TEXT,
  summary TEXT,
  quote_text TEXT,
  quote_by TEXT,
  image_url TEXT,
  image_caption TEXT,
  UNIQUE(series_id, arc_order)
);

-- 4. Tabel baru arc_characters: penghubung many-to-many arc dan karakter yang terlibat
CREATE TABLE IF NOT EXISTS arc_characters (
  arc_id INT REFERENCES series_arcs(id) ON DELETE CASCADE,
  character_id INT REFERENCES characters(id) ON DELETE CASCADE,
  note TEXT,
  PRIMARY KEY (arc_id, character_id)
);

-- 5. Index pendukung performa query
CREATE INDEX IF NOT EXISTS idx_series_arcs_series_order ON series_arcs(series_id, arc_order);
CREATE INDEX IF NOT EXISTS idx_arc_characters_character ON arc_characters(character_id);
