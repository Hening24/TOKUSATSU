-- =============================================================================
-- Migration 004: Statistik Fisik & Profil Karakter
-- Aman dijalankan berulang kali (Idempotent: ADD COLUMN IF NOT EXISTS)
-- Tanpa DROP dan tanpa mengubah atau menghapus data yang sudah ada.
--
-- Catatan kolom yang sudah ada dari migrasi 002 & 003 (tidak diduplikasi):
--   002: height_cm, weight_kg, punch_power_t, kick_power_t,
--        max_jump_m, run_100m_s, source_url
--   003: extra_stats, species, team
-- =============================================================================

ALTER TABLE characters ADD COLUMN IF NOT EXISTS age_text TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS origin TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS blood_type TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS occupation TEXT;
ALTER TABLE characters ADD COLUMN IF NOT EXISTS stats_note TEXT;
