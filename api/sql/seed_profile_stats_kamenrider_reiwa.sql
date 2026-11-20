-- =============================================================================
-- SEED DATA: STATISTIK FISIK & PROFIL KAMEN RIDER — ERA REIWA (ZERO-ONE–GAVV)
-- Prasyarat: Jalankan api/sql/migrations/004_profile_stats.sql terlebih dahulu.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE), tidak menimpa data lama.
--   - Semua ukuran adalah spesifikasi kostum/Rider bentuk dasar fiksi (BUKAN aktor).
--   - Satuan baku: height_cm (cm), weight_kg (kg), pukulan/tendangan (ton),
--     lompatan (m), lari 100 m (detik).
-- Catatan DB: Di database saat ini tersedia 3 karakter era Reiwa
-- (Kamen Rider Zero-One, Kamen Rider Geats, Kamen Rider Gavv).
-- Sumber verifikasi: Situs resmi TV Asahi, Kamen Rider Wiki, & Wikipedia.
-- =============================================================================

-- 1. Kamen Rider Zero-One (Kamen Rider Zero-One, 2019) — Rising Hopper Form
UPDATE characters SET
  rider_name    = COALESCE(rider_name, 'Kamen Rider Zero-One'),
  civilian_name = COALESCE(civilian_name, 'Aruto Hiden'),
  role          = COALESCE(role, 'Main Rider'),
  height_cm     = COALESCE(height_cm, 196.5),
  weight_kg     = COALESCE(weight_kg, 87),
  punch_power_t = COALESCE(punch_power_t, 8.4),
  kick_power_t  = COALESCE(kick_power_t, 49),
  max_jump_m    = COALESCE(max_jump_m, 60.1),
  run_100m_s    = COALESCE(run_100m_s, 4.1),
  age_text      = COALESCE(age_text, '22 tahun (awal seri)'),
  origin        = COALESCE(origin, 'Jepang (Bumi)'),
  occupation    = COALESCE(occupation, 'CEO Hiden Intelligence (mantan komedian)'),
  species       = COALESCE(species, 'Manusia'),
  team          = COALESCE(team, 'Hiden Intelligence'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Rising Hopper Form; golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Aruto_Hiden')
WHERE name = 'Kamen Rider Zero-One'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Zero-One' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2. Kamen Rider Geats (Kamen Rider Geats, 2022) — MagnumBoost Form
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205.2),
  weight_kg     = COALESCE(weight_kg, 88.7),
  punch_power_t = COALESCE(punch_power_t, 2.4),
  kick_power_t  = COALESCE(kick_power_t, 58.5),
  max_jump_m    = COALESCE(max_jump_m, 78),
  run_100m_s    = COALESCE(run_100m_s, 2.7),
  age_text      = COALESCE(age_text, 'Dewasa muda (bereinkarnasi lebih dari 2.000 tahun)'),
  origin        = COALESCE(origin, '21 SM (putra Mitsume, Dewi Penciptaan)'),
  occupation    = COALESCE(occupation, 'Selebriti & Kontestan Desire Grand Prix'),
  species       = COALESCE(species, 'Manusia / Dewa Penciptaan'),
  team          = COALESCE(team, 'Desire Grand Prix'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar khas MagnumBoost Form menurut TV Asahi resmi (Entry Form: berat 78 kg, pukulan 1,8 t, tendangan 4,5 t, lompatan 6 m, 100 m 7,9 dtk); golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ace_Ukiyo')
WHERE name = 'Kamen Rider Geats'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Geats' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3. Kamen Rider Gavv (Kamen Rider Gavv, 2024) — Poppingummy Form
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 192.9),
  weight_kg     = COALESCE(weight_kg, 72.3),
  punch_power_t = COALESCE(punch_power_t, 1),
  kick_power_t  = COALESCE(kick_power_t, 2),
  max_jump_m    = COALESCE(max_jump_m, 4.2),
  run_100m_s    = COALESCE(run_100m_s, 7.6),
  age_text      = COALESCE(age_text, 'Awal 20-an tahun'),
  origin        = COALESCE(origin, 'Dunia Granute (terasing ke Dunia Manusia)'),
  occupation    = COALESCE(occupation, 'Pekerja paruh waktu Hapipare'),
  species       = COALESCE(species, 'Hibrida Granute - Manusia'),
  team          = COALESCE(team, 'Hapipare'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Poppingummy Form; golongan darah & usia eksak tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shoma')
WHERE name = 'Kamen Rider Gavv'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gavv' AND franchise = 'Kamen Rider' LIMIT 1);
