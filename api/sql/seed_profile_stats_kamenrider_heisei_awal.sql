-- =============================================================================
-- SEED DATA: STATISTIK FISIK & PROFIL KAMEN RIDER — ERA HEISEI AWAL (KUUGA–DECADE)
-- Prasyarat: Jalankan api/sql/migrations/004_profile_stats.sql terlebih dahulu.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE), tidak menimpa data lama.
--   - Semua ukuran adalah spesifikasi kostum/Rider bentuk dasar fiksi (BUKAN aktor).
--   - Satuan baku: height_cm (cm), weight_kg (kg), pukulan/tendangan (ton),
--     lompatan (m), lari 100 m (detik).
-- Catatan DB: Di database saat ini tersedia 3 karakter era Heisei awal
-- (Kamen Rider Kuuga, Kamen Rider Ryuki, Kamen Rider Den-O).
-- Sumber verifikasi: Kamen Rider Wiki (kamenrider.fandom.com) & Wikipedia.
-- =============================================================================

-- 1. Kamen Rider Kuuga (Kamen Rider Kuuga, 2000) — Mighty Form
UPDATE characters SET
  rider_name    = COALESCE(rider_name, 'Kamen Rider Kuuga'),
  civilian_name = COALESCE(civilian_name, 'Yusuke Godai'),
  role          = COALESCE(role, 'Main Rider'),
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 99),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 10),
  max_jump_m    = COALESCE(max_jump_m, 15),
  run_100m_s    = COALESCE(run_100m_s, 5.2),
  age_text      = COALESCE(age_text, '24–25 tahun (lahir 18 Maret 1975)'),
  origin        = COALESCE(origin, 'Hokkaido, Jepang'),
  occupation    = COALESCE(occupation, 'Petualang (pemilik 2.000 keahlian)'),
  blood_type    = COALESCE(blood_type, 'O'),
  species       = COALESCE(species, 'Manusia (diubah oleh Arcle / Amadam)'),
  team          = COALESCE(team, 'Kepolisian Metropolitan Tokyo & Kafe Pole Pole'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Mighty Form (tendangan pamungkas Mighty Kick berdaya 30 ton).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yusuke_Godai')
WHERE name = 'Kamen Rider Kuuga'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2. Kamen Rider Ryuki (Kamen Rider Ryuki, 2002) — Base Contract Form
UPDATE characters SET
  rider_name    = COALESCE(rider_name, 'Kamen Rider Ryuki'),
  civilian_name = COALESCE(civilian_name, 'Shinji Kido'),
  role          = COALESCE(role, 'Main Rider'),
  height_cm     = COALESCE(height_cm, 190),
  weight_kg     = COALESCE(weight_kg, 90),
  punch_power_t = COALESCE(punch_power_t, 10),
  kick_power_t  = COALESCE(kick_power_t, 20),
  max_jump_m    = COALESCE(max_jump_m, 35),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '23 tahun'),
  origin        = COALESCE(origin, 'Jepang (Bumi / Mirror World)'),
  occupation    = COALESCE(occupation, 'Wartawan magang di ORE Journal'),
  blood_type    = COALESCE(blood_type, 'B'),
  species       = COALESCE(species, 'Manusia'),
  team          = COALESCE(team, 'ORE Journal'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Ryuki (200 AP pukulan / 400 AP tendangan, bukan Survive Form).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shinji_Kido')
WHERE name = 'Kamen Rider Ryuki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3. Kamen Rider Den-O (Kamen Rider Den-O, 2007) — Sword Form
UPDATE characters SET
  rider_name    = COALESCE(rider_name, 'Kamen Rider Den-O'),
  civilian_name = COALESCE(civilian_name, 'Ryotaro Nogami'),
  role          = COALESCE(role, 'Main Rider'),
  height_cm     = COALESCE(height_cm, 190),
  weight_kg     = COALESCE(weight_kg, 87),
  punch_power_t = COALESCE(punch_power_t, 5),
  kick_power_t  = COALESCE(kick_power_t, 7),
  max_jump_m    = COALESCE(max_jump_m, 35),
  run_100m_s    = COALESCE(run_100m_s, 5.2),
  age_text      = COALESCE(age_text, '18 tahun (awal seri)'),
  origin        = COALESCE(origin, 'Bumi (Singularity Point)'),
  occupation    = COALESCE(occupation, 'Pekerja paruh waktu / Kafe Milk Dipper'),
  species       = COALESCE(species, 'Manusia (Singularity Point)'),
  team          = COALESCE(team, 'Kru DenLiner & Imagin Taros'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Sword Form (bersama Momotaros); Plat Form: tinggi 180 cm, berat 80 kg, pukulan 1 t, tendangan 3 t; golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryotaro_Nogami')
WHERE name = 'Kamen Rider Den-O'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);
