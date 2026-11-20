-- =============================================================================
-- Migration 005: Posisi Titik Fokus Latar Gambar (image_pos_x, image_pos_y)
-- Aman dijalankan berulang kali (Idempotent: ADD COLUMN IF NOT EXISTS + CHECK)
-- Tidak mengubah data yang sudah ada (default 50% 50% tengah)
-- =============================================================================

ALTER TABLE series ADD COLUMN IF NOT EXISTS image_pos_x SMALLINT NOT NULL DEFAULT 50;
ALTER TABLE series ADD COLUMN IF NOT EXISTS image_pos_y SMALLINT NOT NULL DEFAULT 50;

ALTER TABLE characters ADD COLUMN IF NOT EXISTS image_pos_x SMALLINT NOT NULL DEFAULT 50;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS image_pos_y SMALLINT NOT NULL DEFAULT 50;

ALTER TABLE actors ADD COLUMN IF NOT EXISTS image_pos_x SMALLINT NOT NULL DEFAULT 50;
ALTER TABLE actors ADD COLUMN IF NOT EXISTS image_pos_y SMALLINT NOT NULL DEFAULT 50;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'series_image_pos_x_check') THEN
    ALTER TABLE series ADD CONSTRAINT series_image_pos_x_check CHECK (image_pos_x BETWEEN 0 AND 100);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'series_image_pos_y_check') THEN
    ALTER TABLE series ADD CONSTRAINT series_image_pos_y_check CHECK (image_pos_y BETWEEN 0 AND 100);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'characters_image_pos_x_check') THEN
    ALTER TABLE characters ADD CONSTRAINT characters_image_pos_x_check CHECK (image_pos_x BETWEEN 0 AND 100);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'characters_image_pos_y_check') THEN
    ALTER TABLE characters ADD CONSTRAINT characters_image_pos_y_check CHECK (image_pos_y BETWEEN 0 AND 100);
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'actors_image_pos_x_check') THEN
    ALTER TABLE actors ADD CONSTRAINT actors_image_pos_x_check CHECK (image_pos_x BETWEEN 0 AND 100);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'actors_image_pos_y_check') THEN
    ALTER TABLE actors ADD CONSTRAINT actors_image_pos_y_check CHECK (image_pos_y BETWEEN 0 AND 100);
  END IF;
END $$;
