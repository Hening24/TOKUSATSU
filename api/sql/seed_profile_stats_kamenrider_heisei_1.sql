-- =============================================================================
-- SEED DATA: STATISTIK FISIK & PROFIL KAMEN RIDER ERA HEISEI — TAHAP 1 (2000–2008)
-- Prasyarat: Jalankan api/sql/migrations/004_profile_stats.sql terlebih dahulu.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE); tidak menimpa data lama
--     termasuk species, team, dan source_url yang sudah terisi.
--   - Tinggi (cm) dan berat (kg) memakai spesifikasi KOSTUM/RIDER/MONSTER bentuk dasar,
--     BUKAN tinggi/berat pribadi aktor. Tidak ada angka resmi = dibiarkan NULL.
--   - Satuan baku: height_cm (cm), weight_kg (kg), pukulan/tendangan (ton),
--     lompatan (m), lari 100 m (detik).
-- Sumber verifikasi: Kamen Rider Wiki (kamenrider.fandom.com) & Wikipedia.
-- =============================================================================


-- =============================================================================
-- 1. KAMEN RIDER KUUGA (2000) — 5 karakter dengan height_cm NULL
-- (Kamen Rider Kuuga sudah terisi 200 cm / 99 kg dan dilewati.)
-- =============================================================================

-- 1.1 Kaoru Ichijo (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '25–26 tahun (selama serial)'),
  origin     = COALESCE(origin, 'Kota Nagoya, Prefektur Aichi, Jepang'),
  occupation = COALESCE(occupation, 'Perwira Polisi / Inspektur Pembantu (Satgas Unidentified Life Form)'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider/kostum berskala resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kaoru_Ichijo')
WHERE name = 'Kaoru Ichijo'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- 1.2 Sakurako Sawatari (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '23 tahun'),
  origin     = COALESCE(origin, 'Prefektur Gunma, Jepang'),
  occupation = COALESCE(occupation, 'Mahasiswi pascasarjana / Peneliti naskah Linto di Universitas Johnan'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sakurako_Sawatari')
WHERE name = 'Sakurako Sawatari'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- 1.3 Minori Godai (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '22–23 tahun (lahir 4 September 1977)'),
  origin     = COALESCE(origin, 'Prefektur Hokkaido, Jepang'),
  occupation = COALESCE(occupation, 'Guru taman kanak-kanak / penitipan anak'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Minori_Godai')
WHERE name = 'Minori Godai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- 1.4 N-Daguva-Zeba (Villain)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Abadi / Ribuan tahun (suku kuno Gurongi)'),
  occupation = COALESCE(occupation, 'Pemimpin tertinggi suku Gurongi (Unidentified Life Form #0)'),
  stats_note = COALESCE(stats_note, 'Tinggi, berat, dan statistik tempur wujud monster tercantum Unknown pada lembar profil standar.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/N-Daguva-Zeba')
WHERE name = 'N-Daguva-Zeba'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- 1.5 Ra-Baruba-De (Villain)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Abadi / Ribuan tahun (suku kuno Gurongi)'),
  occupation = COALESCE(occupation, 'Hakim dan perancang strategi permainan Gegeru (Unidentified Life Form B#1)'),
  stats_note = COALESCE(stats_note, 'Tinggi, berat, dan statistik tempur wujud monster tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ra-Baruba-De')
WHERE name = 'Ra-Baruba-De'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 2. KAMEN RIDER AGITO (2001) — 6 karakter
-- =============================================================================

-- 2.1 Kamen Rider Agito (Main Rider — Ground Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 195),
  weight_kg     = COALESCE(weight_kg, 95),
  punch_power_t = COALESCE(punch_power_t, 7),
  kick_power_t  = COALESCE(kick_power_t, 15),
  max_jump_m    = COALESCE(max_jump_m, 30),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '21 tahun (selama serial)'),
  origin        = COALESCE(origin, 'Jepang'),
  occupation    = COALESCE(occupation, 'Penghuni rumah keluarga Misugi; kemudian koki / pemilik Restaurant Agito'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Ground Form (pukulan 15 t & tendangan 30 t saat Cross Horns terbuka).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shouichi_Tsugami')
WHERE name = 'Kamen Rider Agito'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2.2 Kamen Rider G3 (Secondary Rider — Unit G3)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 192),
  weight_kg     = COALESCE(weight_kg, 150),
  punch_power_t = COALESCE(punch_power_t, 1),
  kick_power_t  = COALESCE(kick_power_t, 3),
  max_jump_m    = COALESCE(max_jump_m, 10),
  run_100m_s    = COALESCE(run_100m_s, 10),
  age_text      = COALESCE(age_text, '23 tahun'),
  origin        = COALESCE(origin, 'Jepang'),
  occupation    = COALESCE(occupation, 'Perwira Polisi (Unit Khusus G3 / SAUL Kepolisian Metropolitan Tokyo)'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar unit mekanis G3 (G3-X memiliki pukulan 2.5 t, tendangan 7.5 t, lompatan 20 m, lari 8 dtk).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Makoto_Hikawa')
WHERE name = 'Kamen Rider G3'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2.3 Kamen Rider Gills (Secondary Rider — Base Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 100),
  punch_power_t = COALESCE(punch_power_t, 10),
  kick_power_t  = COALESCE(kick_power_t, 20),
  max_jump_m    = COALESCE(max_jump_m, 50),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '20 tahun'),
  occupation    = COALESCE(occupation, 'Mantan atlet renang mahasiswa / pengembara'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar normal Gills (saat tanduk pendek/incomplete awal: pukulan 1 t, tendangan 12 t, lompatan 5 m).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryo_Ashihara')
WHERE name = 'Kamen Rider Gills'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2.4 Mana Kazaya (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '17–18 tahun (selama serial)'),
  occupation = COALESCE(occupation, 'Pelajar SMA (kemudian pelayan Restaurant Agito)'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mana_Kazaya')
WHERE name = 'Mana Kazaya'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2.5 Sumiko Ozawa (Ally)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Ilmuwan & Kepala Pengembang Unit G3 / SAUL Kepolisian Metropolitan Tokyo'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; usia dan ukuran fisik resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sumiko_Ozawa')
WHERE name = 'Sumiko Ozawa'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2.6 Overlord of Darkness (Villain)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Jutaan tahun (entitas purba sejak awal semesta)'),
  occupation = COALESCE(occupation, 'Pencipta umat manusia dan penguasa para Lords (Unknown)'),
  stats_note = COALESCE(stats_note, 'Entitas ilahi berwujud manusia beragam usia; tidak memiliki angka tinggi/berat tetap.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Overlord_of_Darkness')
WHERE name = 'Overlord of Darkness'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 3. KAMEN RIDER RYUKI (2002) — 6 karakter dengan height_cm NULL
-- (Kamen Rider Ryuki sudah terisi 190 cm / 90 kg dan dilewati.)
-- =============================================================================

-- 3.1 Kamen Rider Knight (Secondary Rider — Base Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 195),
  weight_kg     = COALESCE(weight_kg, 95),
  punch_power_t = COALESCE(punch_power_t, 10),
  kick_power_t  = COALESCE(kick_power_t, 15),
  max_jump_m    = COALESCE(max_jump_m, 40),
  run_100m_s    = COALESCE(run_100m_s, 4.5),
  age_text      = COALESCE(age_text, '24 tahun (selama serial)'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Knight (200 AP pukulan / 300 AP tendangan, bukan Survive Form).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ren_Akiyama')
WHERE name = 'Kamen Rider Knight'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3.2 Kamen Rider Zolda (Secondary Rider — Shuichi Kitaoka)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 192),
  weight_kg     = COALESCE(weight_kg, 110),
  punch_power_t = COALESCE(punch_power_t, 15),
  kick_power_t  = COALESCE(kick_power_t, 15),
  max_jump_m    = COALESCE(max_jump_m, 15),
  run_100m_s    = COALESCE(run_100m_s, 7),
  age_text      = COALESCE(age_text, '30 tahun'),
  occupation    = COALESCE(occupation, 'Pengacara terkemuka'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Zolda (300 AP pukulan / 300 AP tendangan; beberapa sumber menulis tinggi 187 cm).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shuichi_Kitaoka')
WHERE name = 'Kamen Rider Zolda'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3.3 Kamen Rider Ohja (Villain Rider — Takeshi Asakura)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 98),
  punch_power_t = COALESCE(punch_power_t, 12.5),
  kick_power_t  = COALESCE(kick_power_t, 20),
  max_jump_m    = COALESCE(max_jump_m, 40),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '25 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Buronan kriminal'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Ohja (250 AP pukulan / 400 AP tendangan).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takeshi_Asakura')
WHERE name = 'Kamen Rider Ohja'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3.4 Yui Kanzaki (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '19–20 tahun (menjelang ulang tahun ke-20)'),
  occupation = COALESCE(occupation, 'Pelajar / Asisten di kedai Atori'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yui_Kanzaki')
WHERE name = 'Yui Kanzaki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3.5 Goro Yura (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '25 tahun'),
  occupation = COALESCE(occupation, 'Asisten hukum dan pengurus rumah tangga Shuichi Kitaoka'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (sempat mewarisi kontrak Zolda di episode akhir: 192 cm, 110 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Goro_Yura')
WHERE name = 'Goro Yura'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3.6 Shiro Kanzaki (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Mantan peneliti Universitas Seimeiin / Pengendali Rider War'),
  stats_note = COALESCE(stats_note, 'Pencipta sistem Advent Card dan Mirror Monsters; usia dan statistik fisik tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shiro_Kanzaki')
WHERE name = 'Shiro Kanzaki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 4. KAMEN RIDER 555 (2003) — 7 karakter
-- =============================================================================

-- 4.1 Kamen Rider Faiz (Main Rider — Base Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 186),
  weight_kg     = COALESCE(weight_kg, 91),
  punch_power_t = COALESCE(punch_power_t, 2.5),
  kick_power_t  = COALESCE(kick_power_t, 5),
  max_jump_m    = COALESCE(max_jump_m, 35),
  run_100m_s    = COALESCE(run_100m_s, 5.8),
  age_text      = COALESCE(age_text, '18–19 tahun (selama serial)'),
  origin        = COALESCE(origin, 'Jepang'),
  occupation    = COALESCE(occupation, 'Pengelana / Karyawan binatu Kikuchi Cleaning'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Faiz (wujud asli Wolf Orphnoch: tinggi 209 cm, berat 128 kg).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takumi_Inui')
WHERE name = 'Kamen Rider Faiz'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.2 Kamen Rider Kaixa (Secondary Rider — Masato Kusaka)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 189),
  weight_kg     = COALESCE(weight_kg, 95),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 7),
  max_jump_m    = COALESCE(max_jump_m, 30),
  run_100m_s    = COALESCE(run_100m_s, 6.3),
  age_text      = COALESCE(age_text, '21 tahun (selama serial)'),
  origin        = COALESCE(origin, 'Jepang'),
  occupation    = COALESCE(occupation, 'Mahasiswa Universitas Keisen / Alumni Ryusei School'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Kaixa.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Masato_Kusaka')
WHERE name = 'Kamen Rider Kaixa'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.3 Kamen Rider Delta (Secondary Rider — Shuji Mihara)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 190),
  weight_kg     = COALESCE(weight_kg, 96),
  punch_power_t = COALESCE(punch_power_t, 3.5),
  kick_power_t  = COALESCE(kick_power_t, 8),
  max_jump_m    = COALESCE(max_jump_m, 38),
  run_100m_s    = COALESCE(run_100m_s, 5.7),
  origin        = COALESCE(origin, 'Jepang'),
  occupation    = COALESCE(occupation, 'Pengasuh anak di panti asuhan / Alumni Ryusei School'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Delta; usia pasti Shuji Mihara tidak tercantum resmi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shuji_Mihara')
WHERE name = 'Kamen Rider Delta'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.4 Mari Sonoda (Ally)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Magang penata rambut / Karyawan binatu Kikuchi Cleaning'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; usia dan ukuran fisik resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mari_Sonoda')
WHERE name = 'Mari Sonoda'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.5 Yuji Kiba (Ally)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 210),
  weight_kg  = COALESCE(weight_kg, 137),
  age_text   = COALESCE(age_text, '23 tahun (secara biologis 21 tahun akibat koma dua tahun)'),
  occupation = COALESCE(occupation, 'Mantan pewaris perusahaan / sempat memimpin Smart Brain'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat berasal dari wujud Horse Orphnoch (wujud manusia tidak memiliki statistik resmi).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yuji_Kiba')
WHERE name = 'Yuji Kiba'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.6 Kyoji Murakami (Villain)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 212),
  weight_kg  = COALESCE(weight_kg, 127),
  occupation = COALESCE(occupation, 'Direktur / Pejabat Pimpinan Smart Brain'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat berasal dari wujud Rose Orphnoch; usia pasti tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kyoji_Murakami')
WHERE name = 'Kyoji Murakami'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4.7 Kitazaki (Villain)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 215),
  weight_kg  = COALESCE(weight_kg, 119),
  occupation = COALESCE(occupation, 'Pembunuh elite Lucky Clover (Smart Brain)'),
  stats_note = COALESCE(stats_note, 'Wujud Dragon Orphnoch Demon-Human Mode (Dragon-Human Mode: tinggi 225 cm, berat 167 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kitazaki')
WHERE name = 'Kitazaki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 5. KAMEN RIDER BLADE (2004) — 6 karakter
-- =============================================================================

-- 5.1 Kamen Rider Blade (Main Rider — Ace Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 201),
  weight_kg     = COALESCE(weight_kg, 101),
  punch_power_t = COALESCE(punch_power_t, 2.8),
  kick_power_t  = COALESCE(kick_power_t, 4.7),
  max_jump_m    = COALESCE(max_jump_m, 33),
  run_100m_s    = COALESCE(run_100m_s, 5.7),
  age_text      = COALESCE(age_text, '22 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Agen lapangan BOARD'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Blade (280 AP pukulan / 470 AP tendangan).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kazuma_Kenzaki')
WHERE name = 'Kamen Rider Blade'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5.2 Kamen Rider Garren (Secondary Rider — Ace Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 104),
  punch_power_t = COALESCE(punch_power_t, 2.6),
  kick_power_t  = COALESCE(kick_power_t, 4.5),
  max_jump_m    = COALESCE(max_jump_m, 38),
  run_100m_s    = COALESCE(run_100m_s, 5.4),
  age_text      = COALESCE(age_text, '25 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Peneliti & agen BOARD (kemudian Direktur BOARD)'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Garren (260 AP pukulan / 450 AP tendangan).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sakuya_Tachibana')
WHERE name = 'Kamen Rider Garren'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5.3 Kamen Rider Chalice (Secondary Rider — Base Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 204),
  weight_kg     = COALESCE(weight_kg, 109),
  punch_power_t = COALESCE(punch_power_t, 3.2),
  kick_power_t  = COALESCE(kick_power_t, 5.2),
  max_jump_m    = COALESCE(max_jump_m, 45),
  run_100m_s    = COALESCE(run_100m_s, 4.8),
  age_text      = COALESCE(age_text, 'Mengaku 23 tahun (entitas purba Joker Undead)'),
  occupation    = COALESCE(occupation, 'Fotografer lepas'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Chalice (320 AP pukulan / 520 AP tendangan).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hajime_Aikawa')
WHERE name = 'Kamen Rider Chalice'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5.4 Kamen Rider Leangle (Secondary Rider — Ace Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205),
  weight_kg     = COALESCE(weight_kg, 111),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 4.9),
  max_jump_m    = COALESCE(max_jump_m, 30),
  run_100m_s    = COALESCE(run_100m_s, 5),
  occupation    = COALESCE(occupation, 'Pelajar SMA / kemudian staf BOARD'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Leangle (300 AP pukulan / 490 AP tendangan).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mutsuki_Kamijo')
WHERE name = 'Kamen Rider Leangle'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5.5 Shiori Hirose (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 20 tahun (selama serial)'),
  occupation = COALESCE(occupation, 'Peneliti & operator teknis pelacak Undead BOARD'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shiori_Hirose')
WHERE name = 'Shiori Hirose'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5.6 Hiroshi Tennoji (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Mantan Ketua dan Pendiri BOARD'),
  stats_note = COALESCE(stats_note, 'Usia numerik dan tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hiroshi_Tennoji')
WHERE name = 'Hiroshi Tennoji'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 6. KAMEN RIDER HIBIKI (2005) — 7 karakter
-- =============================================================================

-- 6.1 Kamen Rider Hibiki (Main Rider — Base Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 222),
  weight_kg     = COALESCE(weight_kg, 156),
  punch_power_t = COALESCE(punch_power_t, 20),
  kick_power_t  = COALESCE(kick_power_t, 40),
  max_jump_m    = COALESCE(max_jump_m, 75),
  run_100m_s    = COALESCE(run_100m_s, 3),
  age_text      = COALESCE(age_text, '31 tahun'),
  occupation    = COALESCE(occupation, 'Prajurit Oni organisasi Takeshi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Hibiki (tinggi resmi 222 cm sedikit melampaui rentang 170–220 cm).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hitoshi_Hidaka')
WHERE name = 'Kamen Rider Hibiki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.2 Kamen Rider Ibuki (Secondary Rider)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 210),
  weight_kg     = COALESCE(weight_kg, 140),
  punch_power_t = COALESCE(punch_power_t, 15),
  kick_power_t  = COALESCE(kick_power_t, 30),
  max_jump_m    = COALESCE(max_jump_m, 80),
  run_100m_s    = COALESCE(run_100m_s, 2.5),
  age_text      = COALESCE(age_text, '20–21 tahun'),
  origin        = COALESCE(origin, 'Yoshino (keluarga utama Oni Takeshi)'),
  occupation    = COALESCE(occupation, 'Oni peniup instrumen tiup markas Yoshino Takeshi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Ibuki.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Iori_Izumi')
WHERE name = 'Kamen Rider Ibuki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.3 Kamen Rider Todoroki (Secondary Rider)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 212.1),
  weight_kg     = COALESCE(weight_kg, 157.5),
  punch_power_t = COALESCE(punch_power_t, 30),
  kick_power_t  = COALESCE(kick_power_t, 40),
  max_jump_m    = COALESCE(max_jump_m, 69.1),
  run_100m_s    = COALESCE(run_100m_s, 5),
  occupation    = COALESCE(occupation, 'Mantan petugas polisi; kemudian prajurit Oni Takeshi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Todoroki (konversi satuan tradisional resmi: 7 shaku = 212.1 cm, 42 kan = 157.5 kg).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tomizo_Todayama')
WHERE name = 'Kamen Rider Todoroki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.4 Asumu Adachi (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 15 tahun (kelas 3 SMP menuju SMA)'),
  occupation = COALESCE(occupation, 'Pelajar / Pekerja paruh waktu di toko manis Tachibana'),
  stats_note = COALESCE(stats_note, 'Karakter manusia ko-protagonis; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Asumu_Adachi')
WHERE name = 'Asumu Adachi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.5 Akira Amami (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 15 tahun (siswi tahun pertama SMA)'),
  occupation = COALESCE(occupation, 'Pelajar / Murid magang Oni di bawah bimbingan Ibuki'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tinggi dan berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Akira_Amami')
WHERE name = 'Akira Amami'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.6 Douji (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Pelayan buatan pemelihara monster Makamou'),
  stats_note = COALESCE(stats_note, 'Homunculus/klon abadi pengawal Makamou; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Douji_and_Hime')
WHERE name = 'Douji'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6.7 Hime (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Pelayan buatan pemelihara monster Makamou (pasangan Douji)'),
  stats_note = COALESCE(stats_note, 'Homunculus/klon abadi pengawal Makamou; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Douji_and_Hime')
WHERE name = 'Hime'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 7. KAMEN RIDER KABUTO (2006) — 8 karakter
-- =============================================================================

-- 7.1 Kamen Rider Kabuto (Main Rider — Rider Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 195),
  weight_kg     = COALESCE(weight_kg, 95),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 7),
  max_jump_m    = COALESCE(max_jump_m, 37),
  run_100m_s    = COALESCE(run_100m_s, 5.8),
  age_text      = COALESCE(age_text, 'Awal 20-an tahun'),
  origin        = COALESCE(origin, 'Bumi (Jepang)'),
  occupation    = COALESCE(occupation, 'Pekerja lepas / Koki rumah tangga untuk adik angkatnya'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Rider Form (Masked Form: tinggi 180 cm, berat 110 kg, pukulan 8 t, tendangan 10 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Souji_Tendou')
WHERE name = 'Kamen Rider Kabuto'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.2 Kamen Rider Gatack (Secondary Rider — Rider Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 194),
  weight_kg     = COALESCE(weight_kg, 97),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 7),
  max_jump_m    = COALESCE(max_jump_m, 36),
  run_100m_s    = COALESCE(run_100m_s, 5.8),
  age_text      = COALESCE(age_text, '20-an tahun'),
  origin        = COALESCE(origin, 'Bumi (Jepang)'),
  occupation    = COALESCE(occupation, 'Agen lapangan ZECT / Pekerja paruh waktu Bistro La Salle'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Rider Form (Masked Form: tinggi 190 cm, berat 134 kg, pukulan 8 t, tendangan 9 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Arata_Kagami')
WHERE name = 'Kamen Rider Gatack'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.3 Kamen Rider Drake (Secondary Rider — Rider Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 189),
  weight_kg     = COALESCE(weight_kg, 91),
  punch_power_t = COALESCE(punch_power_t, 3),
  kick_power_t  = COALESCE(kick_power_t, 6),
  max_jump_m    = COALESCE(max_jump_m, 39),
  run_100m_s    = COALESCE(run_100m_s, 5.5),
  age_text      = COALESCE(age_text, '20-an tahun'),
  origin        = COALESCE(origin, 'Bumi'),
  occupation    = COALESCE(occupation, 'Penata rias profesional keliling'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Rider Form (Masked Form: tinggi 191 cm, berat 125 kg, pukulan 7 t, tendangan 9 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Daisuke_Kazama')
WHERE name = 'Kamen Rider Drake'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.4 Kamen Rider Sasword (Secondary Rider — Rider Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 197),
  weight_kg     = COALESCE(weight_kg, 98),
  punch_power_t = COALESCE(punch_power_t, 3.5),
  kick_power_t  = COALESCE(kick_power_t, 6),
  max_jump_m    = COALESCE(max_jump_m, 36),
  run_100m_s    = COALESCE(run_100m_s, 5.4),
  age_text      = COALESCE(age_text, '20-an tahun'),
  origin        = COALESCE(origin, 'Bumi (pewaris keluarga bangsawan Discabil)'),
  occupation    = COALESCE(occupation, 'Bangsawan / Pekerja lepas'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Rider Form (Masked Form: tinggi 197 cm, berat 137 kg, pukulan 8 t, tendangan 9 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tsurugi_Kamishiro')
WHERE name = 'Kamen Rider Sasword'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.5 Hiyori Kusakabe (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '18 tahun'),
  occupation = COALESCE(occupation, 'Staf & juru masak Bistro La Salle'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (wujud asli Sisyra Worm memiliki tinggi 216 cm dan berat 115 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hiyori_Kusakabe')
WHERE name = 'Hiyori Kusakabe'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.6 Shuichi Tadokoro (Ally)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Ketua Regu Lapangan ZECT'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung; usia serta statistik tinggi dan berat tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Syuichi_Tadokoro')
WHERE name = 'Shuichi Tadokoro'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.7 Masato Mishima (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Tangan kanan pimpinan ZECT; sempat menjadi Kamen Rider TheBee & Gryllus Worm'),
  stats_note = COALESCE(stats_note, 'Statistik TheBee Masked Form tercatat 192 cm / 127 kg; statistik Gryllus Worm & usia resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Masato_Mishima')
WHERE name = 'Masato Mishima'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7.8 Reiji Nogi (Villain)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 228),
  weight_kg  = COALESCE(weight_kg, 139),
  occupation = COALESCE(occupation, 'Komandan tertinggi Worm (wujud manusia Cassis Worm)'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat berasal dari wujud Cassis Worm Dimidius (Gladius: 147 kg, Clipeus: 154 kg; tinggi 228 cm melampaui 220 cm).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Reiji_Nogi')
WHERE name = 'Reiji Nogi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 8. KAMEN RIDER DEN-O (2007) — 7 karakter dengan height_cm NULL
-- (Kamen Rider Den-O sudah terisi 190 cm / 87 kg dan dilewati.)
-- =============================================================================

-- 8.1 Kamen Rider Zeronos (Secondary Rider — Altair Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 192),
  weight_kg     = COALESCE(weight_kg, 89),
  punch_power_t = COALESCE(punch_power_t, 5),
  kick_power_t  = COALESCE(kick_power_t, 7),
  max_jump_m    = COALESCE(max_jump_m, 35),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '19 tahun (di serial Den-O)'),
  origin        = COALESCE(origin, 'Bumi (garis waktu utama)'),
  occupation    = COALESCE(occupation, 'Pelajar / Astronom penjelajah waktu'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar utama Kamen Rider Zeronos Altair Form.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yuto_Sakurai')
WHERE name = 'Kamen Rider Zeronos'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.2 Momotaros (Ally)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 185),
  weight_kg  = COALESCE(weight_kg, 102),
  age_text   = COALESCE(age_text, 'Abadi / Tanpa usia (Imagin dari masa depan)'),
  origin     = COALESCE(origin, 'Masa Depan (Imagin berdasarkan cerita rakyat Momotaro)'),
  occupation = COALESCE(occupation, 'Kru DenLiner & rekan tempur Den-O Sword Form'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat tubuh asli Imagin Momotaros (saat berubah menjadi Den-O Sword Form: 190 cm, 87 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Momotaros')
WHERE name = 'Momotaros'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.3 Urataros (Ally)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 182),
  weight_kg  = COALESCE(weight_kg, 110),
  age_text   = COALESCE(age_text, 'Abadi / Tanpa usia (Imagin dari masa depan)'),
  origin     = COALESCE(origin, 'Masa Depan (Imagin)'),
  occupation = COALESCE(occupation, 'Kru DenLiner & rekan tempur Den-O Rod Form'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat profil Urataros (wujud Den-O Rod Form: 187 cm, 102 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Urataros')
WHERE name = 'Urataros'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.4 Kintaros (Ally)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 187),
  weight_kg  = COALESCE(weight_kg, 107),
  age_text   = COALESCE(age_text, 'Abadi / Tanpa usia (Imagin dari masa depan)'),
  origin     = COALESCE(origin, 'Masa Depan (Imagin)'),
  occupation = COALESCE(occupation, 'Kru DenLiner & rekan tempur Den-O Ax Form'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat tubuh asli Imagin Kintaros (saat menjadi Den-O Ax Form: 185 cm, 93 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kintaros')
WHERE name = 'Kintaros'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.5 Ryutaros (Ally)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 171),
  weight_kg  = COALESCE(weight_kg, 80),
  age_text   = COALESCE(age_text, 'Abadi / Tanpa usia (Imagin dari masa depan)'),
  origin     = COALESCE(origin, 'Masa Depan (Imagin)'),
  occupation = COALESCE(occupation, 'Kru DenLiner & rekan tempur Den-O Gun Form'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat tubuh asli Imagin Ryutaros (saat menjadi Den-O Gun Form: 197 cm, 98 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryutaros')
WHERE name = 'Ryutaros'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.6 Hana (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '19 tahun (berubah menjadi 10 tahun sebagai Kohana)'),
  occupation = COALESCE(occupation, 'Penumpang DenLiner & pelindung aliran waktu'),
  stats_note = COALESCE(stats_note, 'Karakter manusia Singularity Point; tinggi dan berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hana')
WHERE name = 'Hana'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8.7 Kai (Villain)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Pemimpin dan pengendali pasukan Imagin'),
  stats_note = COALESCE(stats_note, 'Singularity Point antagonis; usia dan angka fisik resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kai')
WHERE name = 'Kai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- 9. KAMEN RIDER KIVA (2008) — 8 karakter
-- =============================================================================

-- 9.1 Kamen Rider Kiva (Main Rider — Kiva Form)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 98),
  punch_power_t = COALESCE(punch_power_t, 6),
  kick_power_t  = COALESCE(kick_power_t, 8),
  max_jump_m    = COALESCE(max_jump_m, 85),
  run_100m_s    = COALESCE(run_100m_s, 6.5),
  occupation    = COALESCE(occupation, 'Pembuat biola / Pewaris kekuatan Kiva'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kiva Form (tendangan pamungkas Darkness Moon Break berdaya 30 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Wataru_Kurenai')
WHERE name = 'Kamen Rider Kiva'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.2 Kamen Rider IXA (Secondary Rider — Save Mode / Keisuke Nago)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 218),
  weight_kg     = COALESCE(weight_kg, 160),
  punch_power_t = COALESCE(punch_power_t, 4.2),
  kick_power_t  = COALESCE(kick_power_t, 1.8),
  max_jump_m    = COALESCE(max_jump_m, 18),
  run_100m_s    = COALESCE(run_100m_s, 9.6),
  age_text      = COALESCE(age_text, 'Sekitar 21–22 tahun (lini masa 2008)'),
  occupation    = COALESCE(occupation, 'Pemburu hadiah & agen elite Wonderful Blue Sky Organization'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Save Mode (Burst Mode: tinggi 220 cm, berat 160 kg, pukulan 7 t, tendangan 3 t, lompatan 30 m, lari 6 dtk).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keisuke_Nago')
WHERE name = 'Kamen Rider IXA'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.3 Kamen Rider Saga (Secondary Rider — Taiga Nobori)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205),
  weight_kg     = COALESCE(weight_kg, 110),
  punch_power_t = COALESCE(punch_power_t, 12),
  kick_power_t  = COALESCE(kick_power_t, 35),
  max_jump_m    = COALESCE(max_jump_m, 90),
  run_100m_s    = COALESCE(run_100m_s, 2),
  age_text      = COALESCE(age_text, 'Sekitar 23 tahun'),
  occupation    = COALESCE(occupation, 'Presiden D&P (Development & Pioneer) & Raja ras Fangire 2008'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Saga (tendangan Snaking Death-Break 40 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Taiga_Nobori')
WHERE name = 'Kamen Rider Saga'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.4 Otoya Kurenai (Ally — Kamen Rider Dark Kiva)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205),
  weight_kg     = COALESCE(weight_kg, 112),
  punch_power_t = COALESCE(punch_power_t, 20),
  kick_power_t  = COALESCE(kick_power_t, 35),
  max_jump_m    = COALESCE(max_jump_m, 250),
  run_100m_s    = COALESCE(run_100m_s, 1.2),
  age_text      = COALESCE(age_text, '22–23 tahun di lini masa 1986 (lahir 8 Oktober 1963)'),
  occupation    = COALESCE(occupation, 'Pemain biola profesional & pengguna Ixa 1986 / Dark Kiva'),
  stats_note    = COALESCE(stats_note, 'Spesifikasi wujud Kamen Rider Dark Kiva (juga sempat memakai Ixa System 1986 Save Mode: 218 cm, 160 kg).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Otoya_Kurenai')
WHERE name = 'Otoya Kurenai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.5 Megumi Aso (Ally)
UPDATE characters SET
  age_text   = COALESCE(age_text, '22 tahun (lini masa 2008)'),
  occupation = COALESCE(occupation, 'Model busana & pemburu Fangire Wonderful Blue Sky Organization'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (sempat mengenakan Ixa System pada beberapa misi).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Megumi_Aso')
WHERE name = 'Megumi Aso'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.6 Kivat-bat the 3rd (Ally)
UPDATE characters SET
  occupation = COALESCE(occupation, 'Rekan dan sumber transformasi Kamen Rider Kiva'),
  stats_note = COALESCE(stats_note, 'Makhluk kelelawar keturunan keluarga Kivat; ukuran tinggi, berat, dan usia tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kivat-bat_the_3rd')
WHERE name = 'Kivat-bat the 3rd'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.7 King (1986) (Villain — Kamen Rider Dark Kiva)
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205),
  weight_kg     = COALESCE(weight_kg, 112),
  punch_power_t = COALESCE(punch_power_t, 20),
  kick_power_t  = COALESCE(kick_power_t, 35),
  max_jump_m    = COALESCE(max_jump_m, 250),
  run_100m_s    = COALESCE(run_100m_s, 1.2),
  occupation    = COALESCE(occupation, 'Raja ras Fangire tahun 1986 & pemimpin Checkmate Four'),
  stats_note    = COALESCE(stats_note, 'Spesifikasi Kamen Rider Dark Kiva (wujud monster asli Bat Fangire: tinggi 232 cm, berat 127 kg).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/King_(1986)')
WHERE name = 'King (1986)'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9.8 Bishop (Villain — Swallowtail Fangire)
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 245),
  weight_kg  = COALESCE(weight_kg, 95),
  age_text   = COALESCE(age_text, 'Abadi (anggota klan Fangire)'),
  occupation = COALESCE(occupation, 'Penegak hukum kemurnian Checkmate Four'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat berasal dari wujud Swallowtail Fangire (245 cm melampaui rentang 170–220 cm).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Bishop')
WHERE name = 'Bishop'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);
