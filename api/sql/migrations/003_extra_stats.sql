-- =============================================================================
-- Migration 003: Statistik Fleksibel (extra_stats), Spesies, dan Tim Pertahanan
-- Aman dijalankan berulang kali (ADD COLUMN IF NOT EXISTS, tanpa DROP)
-- =============================================================================

ALTER TABLE characters ADD COLUMN IF NOT EXISTS extra_stats JSONB;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS species TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS team TEXT;
