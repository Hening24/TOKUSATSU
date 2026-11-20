-- =============================================================================
-- SEED DATA: STATISTIK FISIK & PROFIL KAMEN RIDER (BATCH 1: PRIORITAS TINGGI & SEDANG)
-- Mencakup seluruh karakter Kamen Rider (Showa & Heisei) yang masih NULL
-- pada height_cm/weight_kg dengan prioritas TINGGI (Main/Secondary Rider & Rider sekutu)
-- dan SEDANG (sekutu penting). Prioritas RENDAH (Villain tanpa statistik) dilewati.
-- ATURAN:
--   - Hanya UPDATE (tanpa INSERT/DELETE/DROP).
--   - Mencocokkan berdasarkan name dan series (subquery title di tabel series).
--   - HANYA mengisi kolom yang masih NULL (COALESCE); tidak menimpa data lama.
--   - Tinggi (cm) dan berat (kg) memakai spesifikasi KOSTUM/RIDER/MONSTER bentuk dasar,
--     BUKAN ukuran fisik pribadi aktor asli. Tidak ada di sumber = dibiarkan NULL.
-- Sumber verifikasi: Kamen Rider Wiki (kamenrider.fandom.com) & Wikipedia.
-- =============================================================================


-- =============================================================================
-- BAGIAN A: ERA SHOWA — 18 karakter SEDANG (Ally)
-- Seluruh Rider utama/pendukung Showa sudah memiliki height_cm & weight_kg.
-- =============================================================================

UPDATE characters SET
  occupation = COALESCE(occupation, 'Mantan pembalap motor, pemilik Snack Amigo & mentor para Kamen Rider'),
  stats_note = COALESCE(stats_note, 'Karakter manusia sekutu utama; tidak memiliki wujud kostum Rider berskala resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana')
WHERE name = 'Tobei Tachibana'
  AND series_id IN (
    SELECT id FROM series
    WHERE franchise = 'Kamen Rider'
      AND title IN ('Kamen Rider', 'Kamen Rider V3', 'Kamen Rider Amazon', 'Kamen Rider X', 'Kamen Rider Stronger')
  );

UPDATE characters SET
  occupation = COALESCE(occupation, 'Petugas stasiun komunikasi & sekutu sipil Shiro Kazami'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Junko_Tama')
WHERE name = 'Junko Tama'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Mantan monster Destron yang membelot menjadi sekutu Kamen Rider Amazon'),
  stats_note = COALESCE(stats_note, 'Monster sekutu (Mole Beastman); angka tinggi/berat resmi tidak tercantum di kotak info.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mole_Beastman')
WHERE name = 'Mogura Beastman'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Ilmuwan teknologi kelautan & robotika, ayah Keisuke Jin'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keitaro_Jin')
WHERE name = 'Keitaro Jin'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Ilmuwan pencipta cyborg Skyrider & pendiri Shido Hang Glide Club'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Keitaro_Shido')
WHERE name = 'Dr. Keitaro Shido'
  AND series_id = (SELECT id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Pemilik Blanca Coffee Shop / Tani Motor Shop & mentor Skyrider/Super-1'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Genjiro_Tani')
WHERE name = 'Genjiro Tani'
  AND series_id IN (
    SELECT id FROM series WHERE franchise = 'Kamen Rider' AND title IN ('Skyrider', 'Kamen Rider Super-1')
  );

UPDATE characters SET
  occupation = COALESCE(occupation, 'Guru seni bela diri Sekishin Shao Lin Fist & mentor Kazuya Oki'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Master_Genkai')
WHERE name = 'Master Genkai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Sekutu sipil Ryo Murasame dan Dr. Hajime Kaido'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Rumi_Ichijo')
WHERE name = 'Rumi Ichijo'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Profesor universitas dan peneliti biokimia'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hajime_Kaido')
WHERE name = 'Dr. Hajime Kaido'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Pelajar & adik kandung Nobuhiko Akizuki'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kyoko_Akizuki')
WHERE name = 'Kyoko Akizuki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Sekutu sipil Kotaro Minami & kekasih Nobuhiko Akizuki'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Katsumi_Kida')
WHERE name = 'Katsumi Kida'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Fotografer & jurnalis foto'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Reiko_Shiratori')
WHERE name = 'Reiko Shiratori'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Pejuang perlawanan & sekutu tempur Kotaro Minami melawan Crisis Empire'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung manusia; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kasumi_no_Joe')
WHERE name = 'Joe the Haze'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- BAGIAN B: ERA HEISEI AWAL (2000–2008) — 45 karakter (24 TINGGI, 21 SEDANG)
-- =============================================================================

-- Kuuga (3 SEDANG)
UPDATE characters SET
  age_text   = COALESCE(age_text, '25–26 tahun (selama serial)'),
  origin     = COALESCE(origin, 'Kota Nagoya, Prefektur Aichi, Jepang'),
  occupation = COALESCE(occupation, 'Perwira Polisi / Inspektur Pembantu (Satgas Unidentified Life Form)'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider berskala resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kaoru_Ichijo')
WHERE name = 'Kaoru Ichijo'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '23 tahun'),
  origin     = COALESCE(origin, 'Prefektur Gunma, Jepang'),
  occupation = COALESCE(occupation, 'Mahasiswi pascasarjana / Peneliti naskah Linto di Universitas Johnan'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sakurako_Sawatari')
WHERE name = 'Sakurako Sawatari'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '22–23 tahun (lahir 4 September 1977)'),
  origin     = COALESCE(origin, 'Prefektur Hokkaido, Jepang'),
  occupation = COALESCE(occupation, 'Guru taman kanak-kanak / penitipan anak'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Minori_Godai')
WHERE name = 'Minori Godai'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1);

-- Agito (3 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, '17–18 tahun (selama serial)'),
  occupation = COALESCE(occupation, 'Pelajar SMA (kemudian pelayan Restaurant Agito)'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki angka tinggi/berat resmi dalam kanon.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mana_Kazaya')
WHERE name = 'Mana Kazaya'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Ilmuwan & Kepala Pengembang Unit G3 / SAUL Kepolisian Metropolitan Tokyo'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; usia dan ukuran fisik resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sumiko_Ozawa')
WHERE name = 'Sumiko Ozawa'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1);

-- Ryuki (2 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, '19–20 tahun (menjelang ulang tahun ke-20)'),
  occupation = COALESCE(occupation, 'Pelajar / Asisten di kedai Atori'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yui_Kanzaki')
WHERE name = 'Yui Kanzaki'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '25 tahun'),
  occupation = COALESCE(occupation, 'Asisten hukum dan pengurus rumah tangga Shuichi Kitaoka'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (sempat mewarisi kontrak Zolda di episode akhir: 192 cm, 110 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Goro_Yura')
WHERE name = 'Goro Yura'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1);

-- 555 (3 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  occupation = COALESCE(occupation, 'Magang penata rambut / Karyawan binatu Kikuchi Cleaning'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; usia dan ukuran fisik resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mari_Sonoda')
WHERE name = 'Mari Sonoda'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm  = COALESCE(height_cm, 210),
  weight_kg  = COALESCE(weight_kg, 137),
  age_text   = COALESCE(age_text, '23 tahun (secara biologis 21 tahun akibat koma dua tahun)'),
  occupation = COALESCE(occupation, 'Mantan pewaris perusahaan / sempat memimpin Smart Brain'),
  stats_note = COALESCE(stats_note, 'Tinggi & berat berasal dari wujud Horse Orphnoch (wujud manusia tidak memiliki statistik resmi).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yuji_Kiba')
WHERE name = 'Yuji Kiba'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1);

-- Blade (4 TINGGI, 1 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 20 tahun (selama serial)'),
  occupation = COALESCE(occupation, 'Peneliti & operator teknis pelacak Undead BOARD'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shiori_Hirose')
WHERE name = 'Shiori Hirose'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1);

-- Hibiki (3 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 15 tahun (kelas 3 SMP menuju SMA)'),
  occupation = COALESCE(occupation, 'Pelajar / Pekerja paruh waktu di toko manis Tachibana'),
  stats_note = COALESCE(stats_note, 'Karakter manusia ko-protagonis; tidak memiliki wujud Rider maupun tinggi/berat resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Asumu_Adachi')
WHERE name = 'Asumu Adachi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 15 tahun (siswi tahun pertama SMA)'),
  occupation = COALESCE(occupation, 'Pelajar / Murid magang Oni di bawah bimbingan Ibuki'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tinggi dan berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Akira_Amami')
WHERE name = 'Akira Amami'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1);

-- Kabuto (4 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, '18 tahun'),
  occupation = COALESCE(occupation, 'Staf & juru masak Bistro La Salle'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (wujud asli Sisyra Worm memiliki tinggi 216 cm dan berat 115 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hiyori_Kusakabe')
WHERE name = 'Hiyori Kusakabe'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Ketua Regu Lapangan ZECT'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung; usia serta statistik tinggi dan berat tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Syuichi_Tadokoro')
WHERE name = 'Shuichi Tadokoro'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1);

-- Den-O (1 TINGGI, 5 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, '19 tahun (berubah menjadi 10 tahun sebagai Kohana)'),
  occupation = COALESCE(occupation, 'Penumpang DenLiner & pelindung aliran waktu'),
  stats_note = COALESCE(stats_note, 'Karakter manusia Singularity Point; tinggi dan berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hana')
WHERE name = 'Hana'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1);

-- Kiva (4 TINGGI, 2 SEDANG)
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

UPDATE characters SET
  age_text   = COALESCE(age_text, '22 tahun (lini masa 2008)'),
  occupation = COALESCE(occupation, 'Model busana & pemburu Fangire Wonderful Blue Sky Organization'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (sempat mengenakan Ixa System pada beberapa misi).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Megumi_Aso')
WHERE name = 'Megumi Aso'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Rekan dan sumber transformasi Kamen Rider Kiva'),
  stats_note = COALESCE(stats_note, 'Makhluk kelelawar keturunan keluarga Kivat; ukuran tinggi, berat, dan usia tidak tercantum resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kivat-bat_the_3rd')
WHERE name = 'Kivat-bat the 3rd'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1);


-- =============================================================================
-- BAGIAN C: ERA HEISEI AKHIR (2009–2019) — 49 karakter (35 TINGGI, 14 SEDANG)
-- =============================================================================

-- 1. Kamen Rider Decade (2009) — 2 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 192),
  weight_kg     = COALESCE(weight_kg, 83),
  punch_power_t = COALESCE(punch_power_t, 4),
  kick_power_t  = COALESCE(kick_power_t, 8),
  max_jump_m    = COALESCE(max_jump_m, 25),
  run_100m_s    = COALESCE(run_100m_s, 6),
  age_text      = COALESCE(age_text, '20-an tahun'),
  occupation    = COALESCE(occupation, 'Fotografer pengelana dunia'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Decadriver standar (NeoDecadriver: 15.8 t pukul, 36.4 t tendang, 40.2 m lompat, 3.7 dtk lari).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tsukasa_Kadoya')
WHERE name = 'Kamen Rider Decade'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Decade' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 194),
  weight_kg     = COALESCE(weight_kg, 88),
  punch_power_t = COALESCE(punch_power_t, 6),
  kick_power_t  = COALESCE(kick_power_t, 8),
  max_jump_m    = COALESCE(max_jump_m, 30),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '20-an tahun'),
  occupation    = COALESCE(occupation, 'Pencuri harta karun lintas dimensi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Diendriver standar (NeoDiendriver: 24.5 t pukul, 36.4 t tendang, 48.2 m lompat, 3.1 dtk lari).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Daiki_Kaito')
WHERE name = 'Kamen Rider Diend'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Decade' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 20 tahun'),
  occupation = COALESCE(occupation, 'Pengelola Hikari Photo Studio & rekan perjalanan Tsukasa Kadoya'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi wujud Kamen Rider Kiva-la tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Natsumi_Hikari')
WHERE name = 'Natsumi Hikari'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Decade' AND franchise = 'Kamen Rider' LIMIT 1);

-- 2. Kamen Rider W (2009) — 3 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 195),
  weight_kg     = COALESCE(weight_kg, 85),
  punch_power_t = COALESCE(punch_power_t, 2.5),
  kick_power_t  = COALESCE(kick_power_t, 6),
  max_jump_m    = COALESCE(max_jump_m, 60),
  run_100m_s    = COALESCE(run_100m_s, 5.2),
  age_text      = COALESCE(age_text, 'Awal 20-an tahun (sekitar 22 tahun di awal seri)'),
  occupation    = COALESCE(occupation, 'Detektif swasta Agensi Detektif Narumi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar CycloneJoker (hasil penyatuan Shotaro Hidari & Philip; Joker Extreme 12 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shotaro_Hidari')
WHERE name = 'Kamen Rider W'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider W' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 195),
  weight_kg     = COALESCE(weight_kg, 85),
  punch_power_t = COALESCE(punch_power_t, 2.5),
  kick_power_t  = COALESCE(kick_power_t, 6),
  max_jump_m    = COALESCE(max_jump_m, 60),
  run_100m_s    = COALESCE(run_100m_s, 5.2),
  age_text      = COALESCE(age_text, 'Sekitar 16–17 tahun (entitas data Gaia Memory)'),
  occupation    = COALESCE(occupation, 'Peneliti informasi Agensi Detektif Narumi'),
  stats_note    = COALESCE(stats_note, 'Berbagi tubuh transformasi dasar Kamen Rider W CycloneJoker bersama Shotaro Hidari.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Philip')
WHERE name = 'Philip'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider W' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 197),
  weight_kg     = COALESCE(weight_kg, 93),
  punch_power_t = COALESCE(punch_power_t, 10),
  kick_power_t  = COALESCE(kick_power_t, 12),
  max_jump_m    = COALESCE(max_jump_m, 47),
  run_100m_s    = COALESCE(run_100m_s, 3),
  age_text      = COALESCE(age_text, '20-an akhir / awal 30-an tahun'),
  occupation    = COALESCE(occupation, 'Inspektur Divisi Investigasi Kejahatan Supranatural Kepolisian Fuuto'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Accel (tendangan Accel Glanzer 35 t).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryu_Terui')
WHERE name = 'Kamen Rider Accel'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider W' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 20 tahun di awal seri'),
  occupation = COALESCE(occupation, 'Pemilik & direktur Agensi Detektif Narumi'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Akiko_Narumi')
WHERE name = 'Akiko Narumi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider W' AND franchise = 'Kamen Rider' LIMIT 1);

-- 3. Kamen Rider OOO (2010) — 2 TINGGI, 2 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 194),
  weight_kg     = COALESCE(weight_kg, 86),
  punch_power_t = COALESCE(punch_power_t, 4.5),
  kick_power_t  = COALESCE(kick_power_t, 12),
  max_jump_m    = COALESCE(max_jump_m, 190),
  run_100m_s    = COALESCE(run_100m_s, 4.5),
  age_text      = COALESCE(age_text, '21 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Pengelana / pekerja serabutan di Restoran Cous Coussier'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Tatoba Combo (tinggi lompatan 190 m berasal dari daya lompat Batta Legs).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Eiji_Hino')
WHERE name = 'Kamen Rider OOO'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider OOO' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 199),
  weight_kg     = COALESCE(weight_kg, 92),
  punch_power_t = COALESCE(punch_power_t, 3.5),
  kick_power_t  = COALESCE(kick_power_t, 8),
  max_jump_m    = COALESCE(max_jump_m, 45),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '29 tahun'),
  occupation    = COALESCE(occupation, 'Mantan dokter tempur / pengguna pertama sistem Birth Kougami Foundation'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Birth (versi produksi dan Proto Type memiliki parameter dasar identik).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Akira_Date')
WHERE name = 'Kamen Rider Birth'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider OOO' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Lebih dari 800 tahun (entitas Greeed; inang Shingo Izumi sekitar 23–24 tahun)'),
  occupation = COALESCE(occupation, 'Greeed tipe burung & rekan tempur Eiji Hino'),
  stats_note = COALESCE(stats_note, 'Tubuh inang manusia Shingo Izumi tidak memiliki parameter resmi (wujud Ankh Lost: tinggi 214 cm, berat 117 kg).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ankh')
WHERE name = 'Ankh'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider OOO' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '18 tahun'),
  occupation = COALESCE(occupation, 'Mahasiswi mode & staf paruh waktu Cous Coussier'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hina_Izumi')
WHERE name = 'Hina Izumi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider OOO' AND franchise = 'Kamen Rider' LIMIT 1);

-- 4. Kamen Rider Fourze (2011) — 2 TINGGI, 2 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 95),
  punch_power_t = COALESCE(punch_power_t, 2.1),
  kick_power_t  = COALESCE(kick_power_t, 6.3),
  max_jump_m    = COALESCE(max_jump_m, 20),
  run_100m_s    = COALESCE(run_100m_s, 6.2),
  age_text      = COALESCE(age_text, '17–18 tahun (pelajar kelas 2–3 SMA)'),
  occupation    = COALESCE(occupation, 'Siswa SMA Amanogawa & pendiri Kamen Rider Club'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Fourze Base States.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Gentaro_Kisaragi')
WHERE name = 'Kamen Rider Fourze'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Fourze' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 210),
  weight_kg     = COALESCE(weight_kg, 93),
  punch_power_t = COALESCE(punch_power_t, 3.3),
  kick_power_t  = COALESCE(kick_power_t, 8.4),
  max_jump_m    = COALESCE(max_jump_m, 25),
  run_100m_s    = COALESCE(run_100m_s, 5.8),
  age_text      = COALESCE(age_text, '17–18 tahun (siswa pindahan SMA)'),
  occupation    = COALESCE(occupation, 'Siswa SMA Subaruboshi / pindahan SMA Amanogawa'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Meteor.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryusei_Sakuta')
WHERE name = 'Kamen Rider Meteor'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Fourze' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '16–17 tahun (pelajar kelas 2 SMA di awal seri)'),
  occupation = COALESCE(occupation, 'Siswi SMA Amanogawa & anggota Kamen Rider Club'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yuki_Jojima')
WHERE name = 'Yuki Jojima'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Fourze' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '17–18 tahun (pelajar kelas 2–3 SMA)'),
  occupation = COALESCE(occupation, 'Siswa SMA Amanogawa & ahli teknik Kamen Rider Club'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (Core Child); tidak memiliki parameter tempur Rider.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kengo_Utahoshi')
WHERE name = 'Kengo Utahoshi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Fourze' AND franchise = 'Kamen Rider' LIMIT 1);

-- 5. Kamen Rider Wizard (2012) — 2 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 198),
  weight_kg     = COALESCE(weight_kg, 90),
  punch_power_t = COALESCE(punch_power_t, 4.5),
  kick_power_t  = COALESCE(kick_power_t, 7.3),
  max_jump_m    = COALESCE(max_jump_m, 35),
  run_100m_s    = COALESCE(run_100m_s, 5),
  occupation    = COALESCE(occupation, 'Penyihir lepas / penyintas ritual Sabbath'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Flame Style (Flame Dragon: 205 cm, 95 kg, 6.7 t pukul, 10.9 t tendang).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Haruto_Soma')
WHERE name = 'Kamen Rider Wizard'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Wizard' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 198),
  weight_kg     = COALESCE(weight_kg, 94),
  punch_power_t = COALESCE(punch_power_t, 5.3),
  kick_power_t  = COALESCE(kick_power_t, 7.5),
  max_jump_m    = COALESCE(max_jump_m, 31),
  run_100m_s    = COALESCE(run_100m_s, 4.6),
  origin        = COALESCE(origin, 'Prefektur Fukui, Jepang'),
  occupation    = COALESCE(occupation, 'Mahasiswa arkeologi'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Beast.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kosuke_Nitoh')
WHERE name = 'Kamen Rider Beast'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Wizard' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Asisten toko antik Omokagedou & pembaca ramalan kartu'),
  stats_note = COALESCE(stats_note, 'Karakter pendukung (boneka sihir); angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Koyomi')
WHERE name = 'Koyomi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Wizard' AND franchise = 'Kamen Rider' LIMIT 1);

-- 6. Kamen Rider Gaim (2013) — 4 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 203),
  weight_kg     = COALESCE(weight_kg, 105),
  punch_power_t = COALESCE(punch_power_t, 6.7),
  kick_power_t  = COALESCE(kick_power_t, 10.2),
  max_jump_m    = COALESCE(max_jump_m, 28),
  run_100m_s    = COALESCE(run_100m_s, 5.9),
  age_text      = COALESCE(age_text, '20–21 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Pekerja paruh waktu / Mantan penari Team Gaim'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Orange Arms.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kouta_Kazuraba')
WHERE name = 'Kamen Rider Gaim'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 208),
  weight_kg     = COALESCE(weight_kg, 114),
  punch_power_t = COALESCE(punch_power_t, 8.8),
  kick_power_t  = COALESCE(kick_power_t, 12.4),
  max_jump_m    = COALESCE(max_jump_m, 24),
  run_100m_s    = COALESCE(run_100m_s, 6.1),
  age_text      = COALESCE(age_text, '20–22 tahun'),
  occupation    = COALESCE(occupation, 'Pendiri & pemimpin kelompok tari Team Baron'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Banana Arms.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kaito_Kumon')
WHERE name = 'Kamen Rider Baron'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 206),
  weight_kg     = COALESCE(weight_kg, 105),
  punch_power_t = COALESCE(punch_power_t, 6.7),
  kick_power_t  = COALESCE(kick_power_t, 10.2),
  max_jump_m    = COALESCE(max_jump_m, 28),
  run_100m_s    = COALESCE(run_100m_s, 5.9),
  age_text      = COALESCE(age_text, '16 tahun'),
  occupation    = COALESCE(occupation, 'Pelajar SMA / anggota Team Gaim'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Budou Arms (parameter lompatan & kecepatan lari sejajar kerangka dasar Gaim).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mitsuzane_Kureshima')
WHERE name = 'Kamen Rider Ryugen'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 206),
  weight_kg     = COALESCE(weight_kg, 109),
  punch_power_t = COALESCE(punch_power_t, 10.2),
  kick_power_t  = COALESCE(kick_power_t, 13),
  max_jump_m    = COALESCE(max_jump_m, 24),
  run_100m_s    = COALESCE(run_100m_s, 6.1),
  age_text      = COALESCE(age_text, '26 tahun'),
  occupation    = COALESCE(occupation, 'Eksekutif & pemimpin riset cabang Zawame Yggdrasill Corporation'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Melon Arms.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takatora_Kureshima')
WHERE name = 'Kamen Rider Zangetsu'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '17–18 tahun (selama serial)'),
  occupation = COALESCE(occupation, 'Penari Team Gaim & pelayan kedai buah Drupers'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tidak memiliki parameter kostum Rider resmi.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mai_Takatsukasa')
WHERE name = 'Mai Takatsukasa'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1);

-- 7. Kamen Rider Drive (2014) — 3 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 199),
  weight_kg     = COALESCE(weight_kg, 105),
  punch_power_t = COALESCE(punch_power_t, 6.2),
  kick_power_t  = COALESCE(kick_power_t, 10.7),
  max_jump_m    = COALESCE(max_jump_m, 31.8),
  run_100m_s    = COALESCE(run_100m_s, 5.9),
  age_text      = COALESCE(age_text, '23–24 tahun'),
  occupation    = COALESCE(occupation, 'Detektif Divisi Investigasi Khusus (Tokujou-ka) Kepolisian Metropolitan'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Type Speed.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shinnosuke_Tomari')
WHERE name = 'Kamen Rider Drive'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Drive' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205.5),
  weight_kg     = COALESCE(weight_kg, 96.6),
  punch_power_t = COALESCE(punch_power_t, 9.7),
  kick_power_t  = COALESCE(kick_power_t, 16.7),
  max_jump_m    = COALESCE(max_jump_m, 40.3),
  run_100m_s    = COALESCE(run_100m_s, 2.4),
  age_text      = COALESCE(age_text, '19 tahun (debut serial)'),
  occupation    = COALESCE(occupation, 'Fotografer lepas & pemburu Roidmude'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Mach.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Go_Shijima')
WHERE name = 'Kamen Rider Mach'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Drive' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 199.5),
  weight_kg     = COALESCE(weight_kg, 114),
  punch_power_t = COALESCE(punch_power_t, 19.7),
  kick_power_t  = COALESCE(kick_power_t, 25.8),
  max_jump_m    = COALESCE(max_jump_m, 43.1),
  run_100m_s    = COALESCE(run_100m_s, 3),
  age_text      = COALESCE(age_text, 'Tanpa usia (Roidmude Proto-Zero)'),
  occupation    = COALESCE(occupation, 'Mantan penegak hukum Roidmude; pelindung umat manusia'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Chaser.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Chase')
WHERE name = 'Kamen Rider Chaser'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Drive' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '21–22 tahun'),
  occupation = COALESCE(occupation, 'Perwira Polisi Unit Khusus (Tokujou-ka) & rekan Shinnosuke Tomari'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; tinggi/berat kostum Rider tidak tercantum (angka 166 cm pada halaman wiki merujuk tinggi pemeran/sipil sehingga dikosongkan).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kiriko_Shijima')
WHERE name = 'Kiriko Shijima'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Drive' AND franchise = 'Kamen Rider' LIMIT 1);

-- 8. Kamen Rider Ghost (2015) — 3 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 204),
  weight_kg     = COALESCE(weight_kg, 96),
  punch_power_t = COALESCE(punch_power_t, 5.5),
  kick_power_t  = COALESCE(kick_power_t, 10),
  max_jump_m    = COALESCE(max_jump_m, 42),
  run_100m_s    = COALESCE(run_100m_s, 5.8),
  age_text      = COALESCE(age_text, '18 tahun (awal seri)'),
  occupation    = COALESCE(occupation, 'Pemburu hantu / Pengurus Kuil Daitenkū'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Ore Damashii.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takeru_Tenkuji')
WHERE name = 'Kamen Rider Ghost'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ghost' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 202.5),
  weight_kg     = COALESCE(weight_kg, 96.5),
  punch_power_t = COALESCE(punch_power_t, 6),
  kick_power_t  = COALESCE(kick_power_t, 10.5),
  max_jump_m    = COALESCE(max_jump_m, 43),
  run_100m_s    = COALESCE(run_100m_s, 5.6),
  occupation    = COALESCE(occupation, 'Pengumpul Eyecon & mantan penghuni Dunia Gamma'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Specter Damashii.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Makoto_Fukami')
WHERE name = 'Kamen Rider Specter'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ghost' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 204),
  weight_kg     = COALESCE(weight_kg, 99),
  punch_power_t = COALESCE(punch_power_t, 15.1),
  kick_power_t  = COALESCE(kick_power_t, 17.4),
  max_jump_m    = COALESCE(max_jump_m, 47.8),
  run_100m_s    = COALESCE(run_100m_s, 3.7),
  occupation    = COALESCE(occupation, 'Mantan pangeran kekaisaran Gamma; sekutu tim Kuil Daitenkū'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Necrom Damashii.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Alain')
WHERE name = 'Kamen Rider Necrom'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ghost' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, 'Sekitar 19 tahun'),
  occupation = COALESCE(occupation, 'Mahasiswi fisika & asisten riset Kuil Daitenkū'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Akari_Tsukimura')
WHERE name = 'Akari Tsukimura'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ghost' AND franchise = 'Kamen Rider' LIMIT 1);

-- 9. Kamen Rider Amazons (2016) — 2 TINGGI, 3 SEDANG
UPDATE characters SET
  height_cm  = COALESCE(height_cm, 188),
  weight_kg  = COALESCE(weight_kg, 92.7),
  age_text   = COALESCE(age_text, '2 tahun di Musim 1 / 7 tahun di Musim 2 (tumbuh cepat sebagai Amazon)'),
  occupation = COALESCE(occupation, 'Mantan anggota Nozama Peston Service & pelindung Amazon damai'),
  stats_note = COALESCE(stats_note, 'Bentuk Kamen Rider Amazon Omega (wujud Amazon Origin: 186.5 cm, 88.1 kg; parameter ton/m/dtk tidak diterbitkan).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Haruka_Mizusawa')
WHERE name = 'Kamen Rider Amazon Omega'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm  = COALESCE(height_cm, 186.5),
  weight_kg  = COALESCE(weight_kg, 91.4),
  occupation = COALESCE(occupation, 'Mantan peneliti genetik Nozama Pharmacy & pemburu Amazon'),
  stats_note = COALESCE(stats_note, 'Bentuk Kamen Rider Amazon Alpha (parameter ton/m/dtk tidak diterbitkan).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Jin_Takayama')
WHERE name = 'Kamen Rider Amazon Alpha'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Pelajar / Anggota tim 4C pada Musim 2'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mizuki_Mizusawa')
WHERE name = 'Mizuki Mizusawa'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  occupation = COALESCE(occupation, 'Mantan anggota regu pembasmi Nozama Peston Service (Mole Amazon)'),
  stats_note = COALESCE(stats_note, 'Sekutu Amazon tipe tikus tanah; angka tinggi/berat resmi tidak tercantum di kotak info.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Mamoru')
WHERE name = 'Mamoru'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '25 tahun (Musim 1) / 30 tahun (Musim 2)'),
  occupation = COALESCE(occupation, 'Pendamping Jin Takayama'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Nanaha_Izumi')
WHERE name = 'Nanaha Izumi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1);

-- 10. Kamen Rider Ex-Aid (2016) — 5 TINGGI
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 205),
  weight_kg     = COALESCE(weight_kg, 97),
  punch_power_t = COALESCE(punch_power_t, 5.7),
  kick_power_t  = COALESCE(kick_power_t, 10.2),
  max_jump_m    = COALESCE(max_jump_m, 43.1),
  run_100m_s    = COALESCE(run_100m_s, 3.2),
  age_text      = COALESCE(age_text, '24 tahun (selama serial)'),
  occupation    = COALESCE(occupation, 'Dokter magang pediatri RS Universitas Seito & anggota CR'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Action Gamer Level 2.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Emu_Hojo')
WHERE name = 'Kamen Rider Ex-Aid'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 203.5),
  weight_kg     = COALESCE(weight_kg, 99.5),
  punch_power_t = COALESCE(punch_power_t, 7.5),
  kick_power_t  = COALESCE(kick_power_t, 13.5),
  max_jump_m    = COALESCE(max_jump_m, 32.7),
  run_100m_s    = COALESCE(run_100m_s, 4.2),
  occupation    = COALESCE(occupation, 'Dokter bedah jenius RS Universitas Seito & anggota CR'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Quest Gamer Level 2.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hiiro_Kagami')
WHERE name = 'Kamen Rider Brave'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 199.5),
  weight_kg     = COALESCE(weight_kg, 98.5),
  punch_power_t = COALESCE(punch_power_t, 6.6),
  kick_power_t  = COALESCE(kick_power_t, 11.9),
  max_jump_m    = COALESCE(max_jump_m, 37.9),
  run_100m_s    = COALESCE(run_100m_s, 3.7),
  age_text      = COALESCE(age_text, '29 tahun'),
  occupation    = COALESCE(occupation, 'Mantan dokter radiologi RS Universitas Seito / dokter tak berizin'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Shooting Gamer Level 2.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Taiga_Hanaya')
WHERE name = 'Kamen Rider Snipe'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm  = COALESCE(height_cm, 222),
  weight_kg  = COALESCE(weight_kg, 144),
  age_text   = COALESCE(age_text, '26 tahun'),
  occupation = COALESCE(occupation, 'Dokter pemeriksa medis (koroner) & anggota CR'),
  stats_note = COALESCE(stats_note, 'Spesifikasi wujud humanoid Lazer Turbo Bike Gamer Level 0 (Level 2 berbentuk sepeda motor seberat 139 kg tanpa tinggi humanoid; tinggi 222 cm melampaui 220 cm).'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kiriya_Kujo')
WHERE name = 'Kamen Rider Lazer'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 199),
  weight_kg     = COALESCE(weight_kg, 88.5),
  punch_power_t = COALESCE(punch_power_t, 60.3),
  kick_power_t  = COALESCE(kick_power_t, 70.1),
  max_jump_m    = COALESCE(max_jump_m, 64),
  run_100m_s    = COALESCE(run_100m_s, 1.7),
  age_text      = COALESCE(age_text, '6 tahun secara kronologis di 2016 (entitas Bugster)'),
  occupation    = COALESCE(occupation, 'Perawat pendamping CR & pemandu permainan DoReMiFa Beat'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Toki Meki Crisis Gamer Level X (daya serang tinggi khas Level X).'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Poppy_Pipopapo')
WHERE name = 'Kamen Rider Poppy'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1);

-- 11. Kamen Rider Build (2017) — 3 TINGGI, 1 SEDANG
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 197),
  weight_kg     = COALESCE(weight_kg, 102.4),
  punch_power_t = COALESCE(punch_power_t, 27.6),
  kick_power_t  = COALESCE(kick_power_t, 33.7),
  max_jump_m    = COALESCE(max_jump_m, 57.7),
  run_100m_s    = COALESCE(run_100m_s, 3.2),
  age_text      = COALESCE(age_text, '23 tahun (2017)'),
  occupation    = COALESCE(occupation, 'Mantan petarung MMA & rekan Sento Kiryu'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Cross-Z.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryuga_Banjo')
WHERE name = 'Kamen Rider Cross-Z'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 203),
  weight_kg     = COALESCE(weight_kg, 118.3),
  punch_power_t = COALESCE(punch_power_t, 31.3),
  kick_power_t  = COALESCE(kick_power_t, 34.3),
  max_jump_m    = COALESCE(max_jump_m, 54),
  run_100m_s    = COALESCE(run_100m_s, 2.5),
  occupation    = COALESCE(occupation, 'Pemilik lahan pertanian Hokuto & komandan Hokuto Three Crows'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Grease.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Kazumi_Sawatari')
WHERE name = 'Kamen Rider Grease'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 194),
  weight_kg     = COALESCE(weight_kg, 110.8),
  punch_power_t = COALESCE(punch_power_t, 32.7),
  kick_power_t  = COALESCE(kick_power_t, 37.5),
  max_jump_m    = COALESCE(max_jump_m, 57.2),
  run_100m_s    = COALESCE(run_100m_s, 2.3),
  age_text      = COALESCE(age_text, '35 tahun'),
  occupation    = COALESCE(occupation, 'Mantan Perdana Menteri Touto / Kepala Institut Fisika Lanjutan Touto'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Rogue.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Gentoku_Himuro')
WHERE name = 'Kamen Rider Rogue'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  age_text   = COALESCE(age_text, '19 tahun'),
  occupation = COALESCE(occupation, 'Idol daring (Mii-tan) & pemurni Fullbottle di kafe nascitā'),
  stats_note = COALESCE(stats_note, 'Karakter manusia pendukung; angka tinggi/berat resmi tidak tercantum.'),
  source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Misora_Isurugi')
WHERE name = 'Misora Isurugi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1);

-- 12. Kamen Rider Zi-O (2018) — 4 TINGGI
UPDATE characters SET
  height_cm     = COALESCE(height_cm, 200),
  weight_kg     = COALESCE(weight_kg, 92),
  punch_power_t = COALESCE(punch_power_t, 8.2),
  kick_power_t  = COALESCE(kick_power_t, 19),
  max_jump_m    = COALESCE(max_jump_m, 30.2),
  run_100m_s    = COALESCE(run_100m_s, 5),
  age_text      = COALESCE(age_text, '18 tahun di awal seri (berusia 19 tahun pada Episode 34)'),
  occupation    = COALESCE(occupation, 'Siswa SMA & calon Raja Waktu (Kujigoji-do)'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Zi-O.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sougo_Tokiwa')
WHERE name = 'Kamen Rider Zi-O'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Zi-O' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 194.5),
  weight_kg     = COALESCE(weight_kg, 92),
  punch_power_t = COALESCE(punch_power_t, 8.5),
  kick_power_t  = COALESCE(kick_power_t, 18.7),
  max_jump_m    = COALESCE(max_jump_m, 30),
  run_100m_s    = COALESCE(run_100m_s, 5.2),
  age_text      = COALESCE(age_text, '18 tahun'),
  occupation    = COALESCE(occupation, 'Pejuang perlawanan dari tahun 2068 & penghuni Kujigoji-do'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Geiz.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Geiz_Myokoin')
WHERE name = 'Kamen Rider Geiz'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Zi-O' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 198.2),
  weight_kg     = COALESCE(weight_kg, 94.2),
  punch_power_t = COALESCE(punch_power_t, 16.7),
  kick_power_t  = COALESCE(kick_power_t, 38.8),
  max_jump_m    = COALESCE(max_jump_m, 61.6),
  run_100m_s    = COALESCE(run_100m_s, 2.9),
  occupation    = COALESCE(occupation, 'Pelayan setia Oma Zi-O & penulis kronik dari masa depan'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Woz.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Woz')
WHERE name = 'Kamen Rider Woz'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Zi-O' AND franchise = 'Kamen Rider' LIMIT 1);

UPDATE characters SET
  height_cm     = COALESCE(height_cm, 193),
  weight_kg     = COALESCE(weight_kg, 88.7),
  punch_power_t = COALESCE(punch_power_t, 27.2),
  kick_power_t  = COALESCE(kick_power_t, 61.3),
  max_jump_m    = COALESCE(max_jump_m, 72.2),
  run_100m_s    = COALESCE(run_100m_s, 2),
  age_text      = COALESCE(age_text, '18 tahun'),
  occupation    = COALESCE(occupation, 'Anggota perlawanan masa depan 2068 & penghuni Kujigoji-do'),
  stats_note    = COALESCE(stats_note, 'Bentuk dasar Kamen Rider Tsukuyomi.'),
  source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Tsukuyomi')
WHERE name = 'Kamen Rider Tsukuyomi'
  AND series_id = (SELECT id FROM series WHERE title = 'Kamen Rider Zi-O' AND franchise = 'Kamen Rider' LIMIT 1);
