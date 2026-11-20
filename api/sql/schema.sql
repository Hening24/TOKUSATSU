-- Schema Tokusatsu Zukan (PostgreSQL Neon)
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS series;

CREATE TABLE series (
  id        SERIAL PRIMARY KEY,
  title     TEXT NOT NULL,
  franchise TEXT NOT NULL,      -- Kamen Rider | Super Sentai | Ultraman | Metal Hero
  era       TEXT NOT NULL,      -- Showa | Heisei | Reiwa
  year      INT,
  episodes  INT,
  studio    TEXT,
  poster    TEXT,               -- URL gambar poster
  synopsis     TEXT,               -- Sinopsis singkat
  full_plot    TEXT,               -- Alur cerita lengkap / ringkasan
  history_arcs JSONB DEFAULT '[]'::jsonb -- Sub-bab cerita terstruktur (sub_title, quote, paragraphs, image, ep_ref)
);

CREATE TABLE actors (
  id          SERIAL PRIMARY KEY,
  name        TEXT NOT NULL,
  kanji       TEXT,
  character   TEXT NOT NULL,    -- Nama Karakter & Hero
  role_type   TEXT DEFAULT 'MC',-- MC | Secondary Rider | Villain | Hero
  series_id   INT REFERENCES series(id) ON DELETE SET NULL,
  birth_date  TEXT,
  birth_place TEXT,
  agency      TEXT,
  photo       TEXT,
  bio         TEXT
);

CREATE TABLE characters (
  id        SERIAL PRIMARY KEY,
  series_id INT NOT NULL REFERENCES series(id) ON DELETE CASCADE,
  name      TEXT NOT NULL,
  actor     TEXT,
  power        TEXT,
  image        TEXT,
  bio          TEXT,
  history_arcs JSONB DEFAULT '[]'::jsonb -- Sub-bab cerita terstruktur (sub_title, quote, paragraphs, image, ep_ref)
);

CREATE INDEX idx_characters_series ON characters(series_id);
CREATE INDEX idx_actors_series ON actors(series_id);
