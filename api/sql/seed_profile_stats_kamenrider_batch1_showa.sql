-- =============================================================================
-- SEED DATA BATCH 1: STATISTIK FISIK & PROFIL KAMEN RIDER — ERA SHOWA (1971–1988)
-- Prasyarat: Jalankan api/sql/migrations/004_profile_stats.sql terlebih dahulu.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE), tidak menimpa data lama.
--   - Semua ukuran adalah spesifikasi karakter/kostum fiksi (BUKAN data aktor).
--   - Satuan baku: height_cm (cm), weight_kg (kg), pukulan/tendangan (ton),
--     lompatan (m), lari 100 m (detik).
-- Sumber verifikasi: Kamen Rider Wiki (kamenrider.fandom.com) & Kamen Rider Zukan Toei.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- A. MELENGKAPI PROFIL & KEKUATAN NULL PADA 10 KARAKTER SHOWA YANG SUDAH PUNYA TINGGI/BERAT
-- ---------------------------------------------------------------------------

-- 1. Kamen Rider 1 (Kamen Rider, 1971)
UPDATE characters SET
  age_text   = COALESCE(age_text, '22–23 tahun (awal seri)'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi oleh Shocker)'),
  occupation = COALESCE(occupation, 'Mahasiswa biokimia & pembalap motor'),
  species    = COALESCE(species, 'Cyborg (Manusia Rekonstruksi)'),
  team       = COALESCE(team, 'Double Riders / Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar / kostum Kamen Rider 1; golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takeshi_Hongo')
WHERE name = 'Kamen Rider 1'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2. Kamen Rider 2 (Kamen Rider, 1971)
UPDATE characters SET
  age_text   = COALESCE(age_text, '21–22 tahun (awal kemunculan)'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi oleh Shocker)'),
  occupation = COALESCE(occupation, 'Fotografer lepas'),
  species    = COALESCE(species, 'Cyborg (Manusia Rekonstruksi)'),
  team       = COALESCE(team, 'Double Riders / Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Kamen Rider 2; golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hayato_Ichimonji')
WHERE name = 'Kamen Rider 2'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3. Kamen Rider V3 (Kamen Rider V3, 1973)
UPDATE characters SET
  age_text   = COALESCE(age_text, '22 tahun'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi oleh Double Riders)'),
  occupation = COALESCE(occupation, 'Mahasiswa / Peneliti'),
  species    = COALESCE(species, 'Cyborg (Manusia Rekonstruksi)'),
  team       = COALESCE(team, 'Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Kamen Rider V3; golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shiro_Kazami')
WHERE name = 'Kamen Rider V3'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4. Riderman (Kamen Rider V3, 1973)
UPDATE characters SET
  age_text   = COALESCE(age_text, '23 tahun'),
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Mantan ilmuwan utama Destron'),
  species    = COALESCE(species, 'Cyborg Parsial (Lengan Kanan)'),
  team       = COALESCE(team, 'Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Riderman; lari 100 m & golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Joji_Yuki')
WHERE name = 'Riderman'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5. Skyrider (Skyrider, 1979)
UPDATE characters SET
  age_text   = COALESCE(age_text, '20-an tahun'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi Neo-Shocker, diselamatkan Dr. Shido)'),
  occupation = COALESCE(occupation, 'Mahasiswa & pegiat layang gantung'),
  species    = COALESCE(species, 'Cyborg (Manusia Rekonstruksi)'),
  team       = COALESCE(team, 'Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Skyrider; kekuatan pukulan & golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hiroshi_Tsukuba')
WHERE name = 'Skyrider'
  AND series_id = (SELECT id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6. Kamen Rider Super-1 (Kamen Rider Super-1, 1980)
UPDATE characters SET
  age_text   = COALESCE(age_text, '27 tahun'),
  origin     = COALESCE(origin, 'Jepang (Program Antariksa Internasional di AS)'),
  occupation = COALESCE(occupation, 'Astronaut & peneliti eksplorasi antariksa'),
  species    = COALESCE(species, 'Cyborg Eksplorasi Antariksa'),
  team       = COALESCE(team, 'Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Super-1; kekuatan tendangan bervariasi dan golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kazuya_Oki')
WHERE name = 'Kamen Rider Super-1'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7. Kamen Rider ZX (Kamen Rider ZX, 1984)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang (dimodifikasi Kekaisaran Badan)'),
  occupation = COALESCE(occupation, 'Pilot pesawat'),
  species    = COALESCE(species, 'Cyborg (99% sibernetik)'),
  team       = COALESCE(team, '10 Showa Riders'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Kamen Rider ZX; usia pasti & golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryo_Murasame')
WHERE name = 'Kamen Rider ZX'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8. Kamen Rider Black (Kamen Rider Black, 1987)
UPDATE characters SET
  punch_power_t = COALESCE(punch_power_t, 4.5),
  kick_power_t  = COALESCE(kick_power_t, 10),
  run_100m_s    = COALESCE(run_100m_s, 7),
  age_text      = COALESCE(age_text, '19 tahun (awal seri)'),
  origin        = COALESCE(origin, 'Jepang (dimodifikasi Gorgom saat gerhana matahari)'),
  occupation    = COALESCE(occupation, 'Pelajar / Mahasiswa'),
  species       = COALESCE(species, 'Cyborg (Century King Black Sun)'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Black; golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kotaro_Minami')
WHERE name = 'Kamen Rider Black'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9. Shadow Moon (Kamen Rider Black, 1987)
UPDATE characters SET
  age_text   = COALESCE(age_text, '19 tahun (saat penculikan Gorgom)'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi Gorgom saat gerhana matahari)'),
  occupation = COALESCE(occupation, 'Kandidat Century King / Pemimpin Gorgom'),
  species    = COALESCE(species, 'Cyborg (Century King Shadow Moon)'),
  team       = COALESCE(team, 'Gorgom'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Shadow Moon; lompatan maks & lari 100 m tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Nobuhiko_Akizuki')
WHERE name = 'Shadow Moon'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

-- 10. Kamen Rider Black RX (Kamen Rider Black RX, 1988)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 20–22 tahun'),
  origin     = COALESCE(origin, 'Jepang (bermutasi akibat radiasi matahari di antariksa)'),
  occupation = COALESCE(occupation, 'Pilot helikopter keluarga Sahara'),
  species    = COALESCE(species, 'Cyborg Bermutasi (Child of the Sun)'),
  stats_note = COALESCE(stats_note, 'Bentuk dasar Black RX (bukan Roborider/Biorider); golongan darah tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kotaro_Minami')
WHERE name = 'Kamen Rider Black RX'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1);


-- ---------------------------------------------------------------------------
-- B. RIDER, HEROINE, & EVIL RIDER SHOWA YANG height_cm-NYA MASIH NULL (5 KARAKTER)
-- ---------------------------------------------------------------------------

-- 11. Kamen Rider X (1974)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 178),
  weight_kg     = COALESCE(weight_kg, 70),
  punch_power_t = COALESCE(punch_power_t, 75),
  kick_power_t  = COALESCE(kick_power_t, 90),
  max_jump_m    = COALESCE(max_jump_m, 85),
  run_100m_s    = COALESCE(run_100m_s, 2),
  age_text      = COALESCE(age_text, '24 tahun'),
  origin        = COALESCE(origin, 'Jepang (dioperasi Dr. Keitaro Jin)'),
  occupation    = COALESCE(occupation, 'Oseanografer / Ilmuwan kelautan'),
  species       = COALESCE(species, 'Kaizorg (Cyborg Eksplorasi Bawah Laut)'),
  team          = COALESCE(team, 'Showa Riders'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar / databook Kamen Rider Wiki (loncatan tercatat 28,3 m hingga 85 m pasca-Mercury Circuit).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keisuke_Jin')
WHERE name = 'Kamen Rider X'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1);

-- 12. Kamen Rider Amazon (1974)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 175),
  weight_kg     = COALESCE(weight_kg, 62),
  punch_power_t = COALESCE(punch_power_t, 25),
  kick_power_t  = COALESCE(kick_power_t, 30),
  max_jump_m    = COALESCE(max_jump_m, 80),
  run_100m_s    = COALESCE(run_100m_s, 0.9),
  age_text      = COALESCE(age_text, '23 tahun (awal seri)'),
  origin        = COALESCE(origin, 'Lahir di Jepang, tumbuh di Hutan Amazon'),
  occupation    = COALESCE(occupation, 'Penyintas hutan rimba'),
  species       = COALESCE(species, 'Manusia (diperkuat sihir & sains suku Inka)'),
  team          = COALESCE(team, 'Showa Riders'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Amazon (lompatan vertikal 80 m); golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Daisuke_Yamamoto')
WHERE name = 'Kamen Rider Amazon'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1);

-- 13. Kamen Rider Stronger (1975)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 183),
  weight_kg  = COALESCE(weight_kg, 78),
  age_text   = COALESCE(age_text, '23 tahun'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi sukarela di Black Satan)'),
  occupation = COALESCE(occupation, 'Pemain American Football / Seniman bela diri'),
  species    = COALESCE(species, 'Cyborg Elektro-Magnetik'),
  team       = COALESCE(team, 'Showa Riders'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat dari Kamen Rider Zukan resmi Toei; angka pukulan/tendangan/lompatan tidak dipublikasikan standar.'),
  source_url = COALESCE(source_url, 'https://www.kamen-rider-official.com/zukan/kamen_rider_members/59')
WHERE name = 'Kamen Rider Stronger'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Stronger' AND franchise = 'Kamen Rider' LIMIT 1);

-- 14. Electro-Wave Human Tackle (Kamen Rider Stronger, 1975)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 160),
  weight_kg     = COALESCE(weight_kg, 49),
  punch_power_t = COALESCE(punch_power_t, 1),
  kick_power_t  = COALESCE(kick_power_t, 3),
  max_jump_m    = COALESCE(max_jump_m, 10),
  run_100m_s    = COALESCE(run_100m_s, 8),
  age_text      = COALESCE(age_text, '16 tahun'),
  origin        = COALESCE(origin, 'Jepang (dimodifikasi paksa oleh Black Satan)'),
  occupation    = COALESCE(occupation, 'Cyborg Pejuang Kebebasan'),
  species       = COALESCE(species, 'Cyborg Gelombang Elektro'),
  team          = COALESCE(team, 'Sekutu Kamen Rider Stronger'),
  stats_note    = COALESCE(stats_note, 'Bentuk Electro-Wave Human Tackle; golongan darah tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yuriko_Misaki')
WHERE name = 'Electro-Wave Human Tackle'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Stronger' AND franchise = 'Kamen Rider' LIMIT 1);

-- 15. Shocker Rider No. 1 (Kamen Rider, 1971)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 180),
  weight_kg  = COALESCE(weight_kg, 70),
  origin     = COALESCE(origin, 'Markas Shocker / Gel-Shocker'),
  occupation = COALESCE(occupation, 'Cyborg Pasukan Peniru Shocker'),
  species    = COALESCE(species, 'Cyborg (Manusia Rekonstruksi)'),
  team       = COALESCE(team, 'Shocker / Gel-Shocker'),
  stats_note = COALESCE(stats_note, 'Spesifikasi Shocker Rider No. 1 menurut Kamen Rider Wiki; pukulan/tendangan & usia tidak dirinci terpisah.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shocker_Riders')
WHERE name = 'Shocker Rider No. 1'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider' AND franchise = 'Kamen Rider' LIMIT 1);


-- ---------------------------------------------------------------------------
-- C. SEKUTU PENTING ERA SHOWA (18 BARIS — TANPA MENGARANG TINGGI/BERAT AKTOR)
-- ---------------------------------------------------------------------------

-- 16-20. Tobei Tachibana (5 series era Showa awal)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Mantan pembalap motor, mentor Rider & pemilik Snack Amigo / klub balap'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Pendukung Showa Riders'),
  stats_note = COALESCE(stats_note, 'Sekutu manusia non-tempur; tinggi, berat, usia angka, & golongan darah karakter fiksi tidak dipublikasikan resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana')
WHERE name = 'Tobei Tachibana'
  AND series_id IN (
    SELECT id FROM series
    WHERE franchise = 'Kamen Rider'
      AND title IN ('Kamen Rider', 'Kamen Rider V3', 'Kamen Rider X', 'Kamen Rider Amazon', 'Kamen Rider Stronger')
  );

-- 21. Junko Tama (Kamen Rider V3)
UPDATE characters SET
  age_text   = COALESCE(age_text, '18 tahun'),
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Asisten stasiun komunikasi & sekutu V3'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Pendukung Kamen Rider V3'),
  stats_note = COALESCE(stats_note, 'Sekutu manusia non-tempur; tinggi & berat karakter fiksi tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Junko_Tama')
WHERE name = 'Junko Tama'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1);

-- 22. Keitaro Jin (Kamen Rider X)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Ilmuwan robotika & sibernetika eksplorasi laut dalam'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Pendukung Kamen Rider X'),
  stats_note = COALESCE(stats_note, 'Ilmuwan pencipta Kamen Rider X; tinggi, berat, & usia pasti tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keitaro_Jin')
WHERE name = 'Keitaro Jin'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1);

-- 23. Mogura Beastman (Kamen Rider Amazon)
UPDATE characters SET
  origin     = COALESCE(origin, 'Kekaisaran Geddon (membelot menjadi sekutu Amazon)'),
  occupation = COALESCE(occupation, 'Mantan prajurit Beastman & sahabat setia Amazon'),
  species    = COALESCE(species, 'Beastman (Tikus Tanah)'),
  team       = COALESCE(team, 'Sekutu Kamen Rider Amazon'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat resmi Mogura Beastman tidak tercantum di profil standar wiki.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mole_Beastman')
WHERE name = 'Mogura Beastman'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1);

-- 24. Dr. Keitaro Shido (Skyrider)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Ilmuwan robotika & pendiri Shido Hang Glide Club'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Skyrider'),
  stats_note = COALESCE(stats_note, 'Ilmuwan penyelamat Skyrider; tinggi, berat, & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keitaro_Shido')
WHERE name = 'Dr. Keitaro Shido'
  AND series_id = (SELECT id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1);

-- 25-26. Genjiro Tani (Skyrider & Kamen Rider Super-1)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Pemilik Blanca Coffee Shop (Skyrider) & Tani Motor Shop (Super-1)'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Pendukung Showa Riders'),
  stats_note = COALESCE(stats_note, 'Mentor & mekanik pendukung; tinggi, berat, & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Genjiro_Tani')
WHERE name = 'Genjiro Tani'
  AND series_id IN (
    SELECT id FROM series
    WHERE franchise = 'Kamen Rider' AND title IN ('Skyrider', 'Kamen Rider Super-1')
  );

-- 27. Master Genkai (Kamen Rider Super-1)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Guru besar bela diri Sekishin Shao Lin Fist'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Kamen Rider Super-1'),
  stats_note = COALESCE(stats_note, 'Guru bela diri Kazuya Oki; tinggi, berat, & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Master_Genkai')
WHERE name = 'Master Genkai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1);

-- 28. Rumi Ichijo (Kamen Rider ZX)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Warga sipil & sekutu Ryo Murasame'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Kamen Rider ZX'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung TV Special; spesifikasi fisik & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Rumi_Ichijo')
WHERE name = 'Rumi Ichijo'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1);

-- 29. Dr. Hajime Kaido (Kamen Rider ZX)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Profesor biokimia universitas & ilmuwan peneliti'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Kamen Rider ZX'),
  stats_note = COALESCE(stats_note, 'Ilmuwan pendukung Kamen Rider ZX; spesifikasi fisik & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hajime_Kaido')
WHERE name = 'Dr. Hajime Kaido'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1);

-- 30. Kyoko Akizuki (Kamen Rider Black)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Remaja (pelajar SMA)'),
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Pelajar'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Keluarga Akizuki / Sekutu Black'),
  stats_note = COALESCE(stats_note, 'Adik Nobuhiko & sahabat Kotaro; tinggi/berat fiksi tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kyoko_Akizuki')
WHERE name = 'Kyoko Akizuki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

-- 31. Katsumi Kida (Kamen Rider Black)
UPDATE characters SET
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Mahasiswi & sahabat Kotaro Minami'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Kotaro Minami'),
  stats_note = COALESCE(stats_note, 'Sekutu manusia non-tempur; tinggi/berat & usia angka tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Katsumi_Kida')
WHERE name = 'Katsumi Kida'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

-- 32. Reiko Shiratori (Kamen Rider Black RX)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Dewasa muda'),
  origin     = COALESCE(origin, 'Jepang'),
  occupation = COALESCE(occupation, 'Fotografer profesional'),
  species    = COALESCE(species, 'Manusia'),
  team       = COALESCE(team, 'Sekutu Black RX'),
  stats_note = COALESCE(stats_note, 'Sekutu manusia & kekasih Kotaro Minami; tinggi/berat fiksi tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Reiko_Shiratori')
WHERE name = 'Reiko Shiratori'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1);

-- 33. Joe the Haze (Kamen Rider Black RX)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Dewasa muda'),
  origin     = COALESCE(origin, 'Jepang (dimodifikasi Crisis Empire sebelum membelot)'),
  occupation = COALESCE(occupation, 'Ahli bela diri Kasumi Kenpo'),
  species    = COALESCE(species, 'Cyborg (Mantan Agen Crisis)'),
  team       = COALESCE(team, 'Sekutu Black RX'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat resmi tidak tercantum standar di profil wiki utama.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Joe_the_Haze')
WHERE name = 'Joe the Haze'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1);
