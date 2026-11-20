-- =============================================================================
-- SEED DATA: KAMEN RIDER (IDEMPOTEN — Aman dijalankan berulang kali)
-- Tidak menghapus data lama, tidak menimbulkan duplikat.
-- Tahap saat ini: ERA SHOWA (1971 - 1989)
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER (1971)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider' AND year = 1971 LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider',
      '仮面ライダー',
      'Kamen Rider',
      'Showa',
      1971,
      '1971-04-03',
      '1973-02-10',
      98,
      'Toei Company / Ishimori Productions',
      'Belalang (Grasshopper) / Cyborg',
      'Takeshi Hongo, seorang mahasiswa cerdas sekaligus pembalap motor berbakat, diculik oleh organisasi teroris rahasia Shocker untuk dijadikan prajurit cyborg. Sebelum cuci otak selesai dilakukan, ia berhasil meloloskan diri dan bertekad menggunakan kekuatan barunya demi melindungi umat manusia. Saat Hongo harus berjuang di luar negeri, fotografer Hayato Ichimonji meneruskan perjuangannya sebagai Kamen Rider kedua hingga keduanya bahu-membahu menumpas Shocker dan Gel-Shocker.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_(1971_TV_series)'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー'),
      aired_from = COALESCE(aired_from, '1971-04-03'),
      aired_to   = COALESCE(aired_to, '1973-02-10'),
      episodes   = COALESCE(episodes, 98),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Belalang (Grasshopper) / Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_(1971_TV_series)')
    WHERE id = v_series_id;
  END IF;

  -- Karakter Utama: Kamen Rider 1
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 1') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider 1', 'Kamen Rider 1', 'Takeshi Hongo', 'Hiroshi Fujioka', 'Main Rider',
      'Kekuatan cyborg belalang melalui sabuk Typhoon, menguasai serangan pamungkas Rider Kick dan Rider Punch.',
      'Takeshi Hongo adalah pahlawan bertopeng pertama yang mengawali sejarah panjang waralaba Kamen Rider. Setelah dimodifikasi paksa oleh Shocker dan nyaris dicuci otak, ia melarikan diri untuk melawan para monster mutan dengan motor Cyclone andalannya.',
      180, 70, 15, 22.5, 15.3, 12,
      'Episode 1: The Mysterious Spider Man',
      NULL,
      'https://kamenrider.fandom.com/wiki/Takeshi_Hongo'
    );
  ELSE
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Kamen Rider 1'),
      civilian_name = COALESCE(civilian_name, 'Takeshi Hongo'),
      actor         = COALESCE(actor, 'Hiroshi Fujioka'),
      role          = COALESCE(role, 'Main Rider'),
      height_cm     = COALESCE(height_cm, 180),
      weight_kg     = COALESCE(weight_kg, 70),
      punch_power_t = COALESCE(punch_power_t, 15),
      kick_power_t  = COALESCE(kick_power_t, 22.5),
      max_jump_m    = COALESCE(max_jump_m, 15.3),
      run_100m_s    = COALESCE(run_100m_s, 12),
      debut_episode = COALESCE(debut_episode, 'Episode 1: The Mysterious Spider Man'),
      source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takeshi_Hongo')
    WHERE series_id = v_series_id AND name = 'Kamen Rider 1';
  END IF;

  -- Karakter Pendukung: Kamen Rider 2
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 2') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider 2', 'Kamen Rider 2', 'Hayato Ichimonji', 'Takeshi Sasaki', 'Secondary Rider',
      'Kekuatan cyborg belalang dengan fokus daya pukul lebih besar, sabuk Typhoon, serta jurus Rider Punch dan Rider Kick.',
      'Hayato Ichimonji adalah seorang fotografer lepas yang diculik Shocker untuk menggantikan Takeshi Hongo, namun diselamatkan sebelum proses pencucian otak terjadi. Ia menjadi penjaga Jepang selama Hongo berada di Eropa sekaligus memperkenalkan pose transformasi ikonik Kamen Rider.',
      172, 65, 25, 30, 15.3, 2,
      'Episode 14: Raid of the Demon Sabotegron',
      NULL,
      'https://kamenrider.fandom.com/wiki/Hayato_Ichimonji'
    );
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER V3 (1973)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider V3',
      '仮面ライダーV3',
      'Kamen Rider',
      'Showa',
      1973,
      '1973-02-17',
      '1974-02-09',
      52,
      'Toei Company / Ishimori Productions',
      'Capung (Dragonfly) / Cyborg',
      'Setelah kehancuran Gel-Shocker, sindikat jahat baru bernama Destron muncul dan membantai keluarga mahasiswa Shiro Kazami. Sekarat akibat serangan monster Destron, Shiro dioperasi oleh Kamen Rider 1 dan Kamen Rider 2 agar bangkit sebagai cyborg generasi terbaru bernama Kamen Rider V3. Mengandalkan kekuatan gabungan dua pendahulunya, ia memburu pimpinan Destron bersama sekutu barunya, Riderman.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_V3'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーV3'),
      aired_from = COALESCE(aired_from, '1973-02-17'),
      aired_to   = COALESCE(aired_to, '1974-02-09'),
      episodes   = COALESCE(episodes, 52),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Capung (Dragonfly) / Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_V3')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider V3', 'Kamen Rider V3', 'Shiro Kazami', 'Hiroshi Miyauchi', 'Main Rider',
      'Sabuk Double Typhoon dengan 26 kemampuan rahasia, teknik V3 Kick, dan V3 Mach Kick.',
      'Shiro Kazami adalah pemuda penuh semangat yang kehilangan seluruh keluarganya akibat kekejaman Destron. Diubah menjadi cyborg oleh Double Riders, ia mewarisi teknik dari Rider 1 dan kekuatan fisik dari Rider 2 untuk membalaskan dendam keluarganya dan membela kedamaian.',
      180, 78, 90, 100, 60, 1.6,
      'Episode 1: Rider No. 3: His Name is V3!',
      NULL,
      'https://kamenrider.fandom.com/wiki/Shiro_Kazami'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Riderman') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Riderman', 'Riderman', 'Joji Yuki', 'Takehisa Yamaguchi', 'Secondary Rider',
      'Lengan bionik kanan Cassette Arm dengan beragam senjata modular seperti Rope Arm, Power Arm, dan Drill Arm.',
      'Joji Yuki awalnya adalah ilmuwan jenius di organisasi Destron sebelum dikhianati oleh komandannya sendiri, Marshal Armor, hingga kehilangan lengan kanannya. Ia mengganti lengannya dengan lengan mekanik tempur dan berjuang sebagai Riderman demi membersihkan namanya serta menghentikan kejahatan Destron.',
      175, 70, 5, 10, 20, NULL,
      'Episode 43: Friend or Foe? The Mysterious Riderman',
      NULL,
      'https://kamenrider.fandom.com/wiki/Joji_Yuki'
    );
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER X (1974)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider X',
      '仮面ライダーＸ',
      'Kamen Rider',
      'Showa',
      1974,
      '1974-02-16',
      '1974-10-12',
      35,
      'Toei Company / Ishimori Productions',
      'Belalang / Teknologi Laut Dalam (Kaizorg)',
      'Ketika organisasi teroris bawah tanah GOD mengincar teknologi robotik laut dalam milik Profesor Keitaro Jin, sang profesor dan putranya Keisuke mengalami serangan fatal. Sebelum mengembuskan napas terakhir, Profesor Jin merombak tubuh putranya menjadi cyborg laut dalam bernama Kaizorg. Keisuke bangkit sebagai Kamen Rider X dengan tongkat Ridol untuk mematahkan ambisi GOD menguasai dunia.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_X'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーＸ'),
      aired_from = COALESCE(aired_from, '1974-02-16'),
      aired_to   = COALESCE(aired_to, '1974-10-12'),
      episodes   = COALESCE(episodes, 35),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Belalang / Teknologi Laut Dalam (Kaizorg)'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_X')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider X', 'Kamen Rider X', 'Keisuke Jin', 'Ryo Hayami', 'Main Rider',
      'Sabuk Ridol yang dapat mengeluarkan tongkat multifungsi Ridol Stick/Whip/Rope, serta jurus pamungkas X-Kick dan Vacuum Hell Wheel.',
      'Keisuke Jin adalah mahasiswa teknik kelautan yang diubah oleh ayahnya sendiri menjadi cyborg Kaizorg agar selamat dari serangan GOD. Memiliki ketahanan terhadap tekanan air laut dalam, ia bertransformasi menggunakan Redizer dan Perfector untuk menghadapi para monster mitologi dan tokoh sejarah milik GOD.',
      NULL, NULL, NULL, NULL, 28.3, 2,
      'Episode 1: X-X-X-Rider is Born!!',
      NULL,
      'https://kamenrider.fandom.com/wiki/Keisuke_Jin'
    );
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER AMAZON (1974)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Amazon',
      '仮面ライダーアマゾン',
      'Kamen Rider',
      'Showa',
      1974,
      '1974-10-19',
      '1975-03-29',
      24,
      'Toei Company / Ishimori Productions',
      'Kadal Monitor / Piranha',
      'Daisuke Yamamoto adalah anak yang selamat dari kecelakaan pesawat dan tumbuh besar di pedalaman hutan Amazon. Ketika suku Inca penjaga rahasia dibantai oleh organisasi jahat Geddon, sang tetua Bago membekali Daisuke dengan gelang mistis GiGi Armlet serta memberinya kemampuan berubah menjadi manusia kadal. Kembali ke Jepang, Amazon harus beradaptasi dengan peradaban modern sambil bertarung secara buas melawan Geddon dan Kekaisaran Garanda.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Amazon'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーアマゾン'),
      aired_from = COALESCE(aired_from, '1974-10-19'),
      aired_to   = COALESCE(aired_to, '1975-03-29'),
      episodes   = COALESCE(episodes, 24),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Kadal Monitor / Piranha'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazon')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Amazon', 'Kamen Rider Amazon', 'Daisuke Yamamoto', 'Toru Okazaki', 'Main Rider',
      'Gelang mistis GiGi Armlet dan sabuk Condorer, bertarung dengan cakaran serta gigitan buas, jurus pamungkas Dai Setsudan.',
      'Daisuke Yamamoto, atau dipanggil Amazon, tidak berasal dari operasi cyborg mekanis melainkan hasil modifikasi ilmu mistis suku kuno Inka. Gaya bertarungnya sangat naluriah dan brutal menggunakan cakaran tangan untuk merobek musuh demi melindungi gelang GiGi dari incaran musuh.',
      NULL, NULL, NULL, NULL, 80, NULL,
      'Episode 1: Man or Beast? The Cool Guy Who Came From the Jungle!',
      NULL,
      'https://kamenrider.fandom.com/wiki/Daisuke_Yamamoto'
    );
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER STRONGER (1975)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Stronger' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Stronger',
      '仮面ライダーストロンガー',
      'Kamen Rider',
      'Showa',
      1975,
      '1975-04-05',
      '1975-12-27',
      39,
      'Toei Company / Ishimori Productions',
      'Kumbang Tanduk Jepang (Kabutomushi) / Listrik',
      'Demi membalas kematian sahabatnya di tangan kelompok Black Satan, Shigeru Jo secara sukarela menyusup dan menjalani operasi cyborg agar memperoleh kekuatan listrik super. Sebelum kendali pikirannya diambil alih, ia meloloskan diri sebagai Kamen Rider Stronger. Ditemani rekan seperjuangannya, Electro-Wave Human Tackle, Stronger menghadapi ancaman Black Satan hingga kebangkitan Pasukan Delza yang jauh lebih kejam.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Stronger'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーストロンガー'),
      aired_from = COALESCE(aired_from, '1975-04-05'),
      aired_to   = COALESCE(aired_to, '1975-12-27'),
      episodes   = COALESCE(episodes, 39),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Kumbang Tanduk Jepang (Kabutomushi) / Listrik'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Stronger')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Stronger', 'Kamen Rider Stronger', 'Shigeru Jo', 'Shigeru Araki', 'Main Rider',
      'Sabuk Electrer dengan generator listrik dalam tubuh, mampu beralih ke wujud Charge Up, jurus Electro Kick dan Electro Fire.',
      'Shigeru Jo adalah pahlawan bertemperamen berani dan percaya diri yang rela membiarkan dirinya dimodifikasi oleh Black Satan demi menuntut keadilan atas kematian temannya. Ia menjadi Rider Showa pertama yang memiliki bentuk penguatan (power-up form) bernama Charge Up.',
      NULL, NULL, NULL, NULL, NULL, NULL,
      'Episode 1: I am the Electric Human Stronger!!',
      NULL,
      'https://kamenrider.fandom.com/wiki/Shigeru_Jo'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Electro-Wave Human Tackle') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Electro-Wave Human Tackle', 'Electro-Wave Human Tackle', 'Yuriko Misaki', 'Kyoko Okada', 'Ally',
      'Gelombang elektromagnetik dengan teknik bantingan Denpa Nage dan serangan pengorbanan Ultra Cyclone.',
      'Yuriko Misaki diculik bersama Shigeru Jo oleh Black Satan dan diubah menjadi manusia gelombang elektromagnetik. Meski tidak dihitung secara resmi sebagai Kamen Rider bernomor, ia bertempur setia di sisi Stronger hingga mengorbankan nyawanya untuk menyelamatkan Shigeru dari racun Doctor Kate.',
      NULL, NULL, NULL, NULL, NULL, NULL,
      'Episode 1: I am the Electric Human Stronger!!',
      NULL,
      'https://kamenrider.fandom.com/wiki/Yuriko_Misaki'
    );
  END IF;


  -- ===========================================================================
  -- 6. SKYRIDER (1979)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Skyrider',
      '仮面ライダー（新）',
      'Kamen Rider',
      'Showa',
      1979,
      '1979-10-05',
      '1980-10-10',
      54,
      'Toei Company / Ishimori Productions',
      'Belalang (Locust) / Penerbangan',
      'Saat berkemah, mahasiswa pencinta alam Hiroshi Tsukuba menyelamatkan Profesor Keitaro Shido yang diburu organisasi teroris Neo-Shocker. Ketika Hiroshi terluka parah saat melindungi sang ilmuwan, Profesor Shido memohon Neo-Shocker mengubahnya menjadi cyborg dengan dalih menciptakan prajurit kuat, lalu melarikannya. Hiroshi bangkit sebagai Skyrider yang memiliki kemampuan terbang bebas demi menumpas Neo-Shocker bersama tujuh Rider senior.',
      NULL,
      'https://en.wikipedia.org/wiki/Skyrider_(TV_series)'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー（新）'),
      aired_from = COALESCE(aired_from, '1979-10-05'),
      aired_to   = COALESCE(aired_to, '1980-10-10'),
      episodes   = COALESCE(episodes, 54),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Belalang (Locust) / Penerbangan'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Skyrider_(TV_series)')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Skyrider') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Skyrider', 'Skyrider', 'Hiroshi Tsukuba', 'Hiroaki Murakami', 'Main Rider',
      'Sabuk Tornado dengan mekanisme anti-gravitasi Sailing Jump untuk terbang di udara serta jurus Sky Kick.',
      'Hiroshi Tsukuba adalah anggota klub layang gantung yang diubah menjadi cyborg oleh Profesor Shido agar tetap hidup sekaligus menyelamatkan bumi dari Neo-Shocker. Setelah berlatih intensif bersama tujuh Kamen Rider senior, warna kostumnya berubah lebih cerah dan kekuatannya meningkat drastis.',
      180, 70, NULL, 10, 30, 6,
      'Episode 1: A Cyborg Flies in the Sky',
      NULL,
      'https://kamenrider.fandom.com/wiki/Hiroshi_Tsukuba'
    );
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER SUPER-1 (1980)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Super-1',
      '仮面ライダースーパー１',
      'Kamen Rider',
      'Showa',
      1980,
      '1980-10-17',
      '1981-10-03',
      48,
      'Toei Company / Ishimori Productions',
      'Tawon (Hornet) / Eksplorasi Luar Angkasa / Kung Fu',
      'Kazuya Oki menjalani operasi cyborg secara sukarela sebagai bagian dari program eksplorasi luar angkasa Amerika Serikat. Namun pangkalan risetnya dihancurkan oleh Kerajaan Dogma demi menguasai teknologi tersebut. Lolos dari maut, Kazuya mempelajari seni bela diri Sekishin Shorinji Kenpo untuk mengendalikan perubahan wujudnya sebagai Kamen Rider Super-1 dan melawan pasukan Dogma serta Jin Dogma.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Super-1'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダースーパー１'),
      aired_from = COALESCE(aired_from, '1980-10-17'),
      aired_to   = COALESCE(aired_to, '1981-10-03'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Tawon (Hornet) / Eksplorasi Luar Angkasa / Kung Fu'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Super-1')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Super-1') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Super-1', 'Kamen Rider Super-1', 'Kazuya Oki', 'Shunsuke Takasugi', 'Main Rider',
      'Lima pasang sarung tangan tempur Five Hands (Super, Elec, Power, Cold/Heat, Radar), sabuk Cyclode, dan bela diri kung fu.',
      'Kazuya Oki merupakan relawan proyek penelitian antariksa yang dimodifikasi menjadi cyborg penjelajah luar angkasa tanpa bantuan sistem eksternal. Setelah dilatih Master Genkai, ia menguasai teknik pernapasan khusus untuk bertransformasi dan menggunakan lima jenis sarung tangan berbeda dalam pertempuran.',
      185, 80, 30, NULL, 100, 5,
      'Episode 1: The Planetary Cyborg''s Great Transformation',
      NULL,
      'https://kamenrider.fandom.com/wiki/Kazuya_Oki'
    );
  END IF;


  -- ===========================================================================
  -- 8. KAMEN RIDER BLACK (1987)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Black',
      '仮面ライダーBLACK',
      'Kamen Rider',
      'Showa',
      1987,
      '1987-10-04',
      '1988-10-09',
      51,
      'Toei Company / Ishimori Productions',
      'Belalang (Locust) / Bio-Cyborg',
      'Lahir pada malam gerhana matahari yang sama, dua sahabat masa kecil Kotaro Minami dan Nobuhiko Akizuki diculik oleh sekte jahat Gorgom pada ulang tahun ke-19 mereka. Keduanya ditanamkan batu suci Kingstone untuk dipersiapkan sebagai calon Raja Abad ke-21. Kotaro berhasil kabur sebelum ingatannya dihapus dan bangkit sebagai Kamen Rider Black, namun ia terpaksa berhadapan dengan sahabatnya sendiri yang terlahir kembali sebagai Shadow Moon.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Black'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーBLACK'),
      aired_from = COALESCE(aired_from, '1987-10-04'),
      aired_to   = COALESCE(aired_to, '1988-10-09'),
      episodes   = COALESCE(episodes, 51),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Belalang (Locust) / Bio-Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Black', 'Kamen Rider Black', 'Kotaro Minami', 'Tetsuo Kurata', 'Main Rider',
      'Batu Kingstone Matahari di sabuk Vital Charger, kekuatan otot biomekanik serta jurus mematikan Rider Punch dan Rider Kick.',
      'Kotaro Minami melarikan diri dari operasi Gorgom dengan bantuan ayah angkatnya sebelum cuci otak selesai. Membawa beban tragis karena harus bertarung demi menyelamatkan saudara tirinya Nobuhiko, ia berjuang sendirian dengan motor cerdas Battle Hopper.',
      198.7, 87, NULL, NULL, 30, NULL,
      'Episode 1: Black!! Transformation',
      NULL,
      'https://kamenrider.fandom.com/wiki/Kotaro_Minami'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shadow Moon') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Shadow Moon', 'Shadow Moon', 'Nobuhiko Akizuki', 'Takahito Horiuchi / Masaki Terasoma (Suara)', 'Villain',
      'Batu Kingstone Bulan di sabuk Shadow Charger, bersenjatakan pedang Satan Saber dan Shadow Saber serta jurus Shadow Kick.',
      'Nobuhiko Akizuki tidak sempat melarikan diri saat diculik bersama Kotaro, sehingga ingatannya terhapus sempurna oleh Gorgom dan ia dibangkitkan sebagai Shadow Moon. Menjadi rival terberat sekaligus saudara angkat Kotaro, ia berambisi menjadi Raja Penciptaan baru menggantikan posisi Gorgom.',
      197.4, 90, 4, 10, NULL, NULL,
      'Episode 35: Showdown! Two Princes',
      NULL,
      'https://kamenrider.fandom.com/wiki/Nobuhiko_Akizuki'
    );
  END IF;


  -- ===========================================================================
  -- 9. KAMEN RIDER BLACK RX (1988)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Black RX',
      '仮面ライダーBLACK RX',
      'Kamen Rider',
      'Showa',
      1988,
      '1988-10-23',
      '1989-09-24',
      47,
      'Toei Company / Ishimori Productions',
      'Belalang (Locust) / Energi Matahari',
      'Enam bulan setelah mengalahkan Gorgom, Kotaro Minami bekerja sebagai pilot helikopter sebelum diculik oleh Kekaisaran Crisis yang hendak menginvasi Bumi. Karena menolak bergabung, ia dibuang ke luar angkasa namun radiasi matahari memicu evolusi batu Kingstone di tubuhnya menjadi Kamen Rider Black RX. Sebagai Pangeran Matahari, ia bertempur melawan Crisis dengan kemampuan berubah menjadi Robo Rider dan Bio Rider.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Black_RX'
    )
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーBLACK RX'),
      aired_from = COALESCE(aired_from, '1988-10-23'),
      aired_to   = COALESCE(aired_to, '1989-09-24'),
      episodes   = COALESCE(episodes, 47),
      studio     = COALESCE(studio, 'Toei Company / Ishimori Productions'),
      motif      = COALESCE(motif, 'Belalang (Locust) / Energi Matahari'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black_RX')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black RX') THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Black RX', 'Kamen Rider Black RX', 'Kotaro Minami', 'Tetsuo Kurata', 'Main Rider',
      'Sabuk Sunriser bertenaga surya, pedang cahaya Revolcane, perubahan wujud Robo Rider dan Bio Rider, serta jurus RX Kick.',
      'Kotaro Minami berevolusi setelah Kingstone miliknya menyerap energi matahari murni di luar angkasa saat nyaris tewas oleh Kekaisaran Crisis. Sebagai penutup era Showa, ia menjadi Rider pertama yang dapat mengakses wujud alternatif sesuai emosi serta mengendarai mobil tempur Ridoron.',
      198.8, 88, 30, 45, 60, 1.1,
      'Episode 1: Child of the Sun! RX',
      NULL,
      'https://kamenrider.fandom.com/wiki/Kotaro_Minami'
    );
  END IF;

END $$;

-- Sinkronkan ulang sequence ID agar penambahan data baru lewat API tetap aman
SELECT setval(pg_get_serial_sequence('series', 'id'), COALESCE((SELECT MAX(id) FROM series), 1));
SELECT setval(pg_get_serial_sequence('characters', 'id'), COALESCE((SELECT MAX(id) FROM characters), 1));
