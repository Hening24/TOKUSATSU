-- =============================================================================
-- SEED DATA: STATISTIK FISIK & PROFIL KAMEN RIDER — ERA HEISEI AKHIR (W–ZI-O)
-- Prasyarat: Jalankan api/sql/migrations/004_profile_stats.sql terlebih dahulu.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE), tidak menimpa data lama.
--   - Semua ukuran adalah spesifikasi kostum/Rider bentuk dasar fiksi (BUKAN aktor).
--   - Satuan baku: height_cm (cm), weight_kg (kg), pukulan/tendangan (ton),
--     lompatan (m), lari 100 m (detik).
-- Catatan DB: Di database saat ini tersedia 1 karakter era Heisei akhir
-- (Kamen Rider Build).
-- Sumber verifikasi: Kamen Rider Wiki (kamenrider.fandom.com) & TV Asahi resmi.
-- =============================================================================

-- 1. Kamen Rider Build (Kamen Rider Build, 2017) — RabbitTank Form
UPDATE characters SET
  rider_name    = COALESCE(rider_name, 'Kamen Rider Build'),
  civilian_name = COALESCE(civilian_name, 'Sento Kiryu'),
  role          = COALESCE(role, 'Main Rider'),
  height_cm     = COALESCE(height_cm, 196),
  weight_kg     = COALESCE(weight_kg, 99),
  punch_power_t = COALESCE(punch_power_t, 17),
  kick_power_t  = COALESCE(kick_power_t, 23.7),
  max_jump_m    = COALESCE(max_jump_m, 55),
  run_100m_s    = COALESCE(run_100m_s, 2.9),
  age_text      = COALESCE(age_text, 'Awal 20-an tahun'),
  origin        = COALESCE(origin, 'Touto (identitas asli Takumi Katsuragi)'),
  occupation    = COALESCE(occupation, 'Fisikawan (mantan peneliti Institut Fisika Materi Mutakhir Touto)'),
  blood_type    = COALESCE(blood_type, 'AB'),
  species       = COALESCE(species, 'Manusia'),
  team          = COALESCE(team, 'Team Build / Nascita'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar RabbitTank Form: pukulan kanan 9,9 t / kiri 17,0 t; tendangan kanan 23,7 t / kiri 17,8 t (disimpan nilai tertinggi per sisi).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sento_Kiryu')
WHERE name = 'Kamen Rider Build'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1);
