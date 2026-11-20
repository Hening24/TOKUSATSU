-- =============================================================================
-- SEED DATA: SHOWA ERA (KAMEN RIDER, ULTRAMAN, SUPER SENTAI)
-- ATURAN IDEMPOTENSI:
-- 1. Cek data berdasarkan title / (series_id, name) sebelum INSERT.
-- 2. JANGAN menghapus data lama.
-- 3. JANGAN menimpa data yang sudah diisi/diedit manual (hanya isi kolom NULL dengan COALESCE).
-- =============================================================================

-- #############################################################################
-- BAGIAN 1: KAMEN RIDER ERA SHOWA (1971 - 1989)
-- #############################################################################

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER (1971)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider', '仮面ライダー', 'Kamen Rider', 'Showa', 1971, '1971-04-03', '1973-02-10',
      98, 'Toei Company / Ishimori Productions', 'Belalang (Grasshopper) / Cyborg',
      'Takeshi Hongo, mahasiswa cerdas dan pembalap motor, diculik sindikat jahat Shocker untuk diubah menjadi cyborg. Ia lolos sebelum cuci otak dilakukan dan berbalik menumpas Shocker sebagai Kamen Rider, lalu dibantu Hayato Ichimonji (Kamen Rider 2) hingga mengalahkan penerusnya, Gel-Shocker.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_(1971_TV_series)'
    ) RETURNING id INTO v_series_id;
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

  -- Characters (Kamen Rider 1971)
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 1') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s, debut_episode, image, source_url)
    VALUES (v_series_id, 'Kamen Rider 1', 'Kamen Rider 1', 'Takeshi Hongo', 'Hiroshi Fujioka', 'Main Rider', 'Sabuk Typhoon bertenaga angin, kekuatan cyborg belalang, jurus Rider Kick dan Rider Punch.', 'Pemuda cerdas yang dimodifikasi paksa oleh Shocker namun berhasil melarikan diri sebelum ingatannya dihapus. Ia menjadi pahlawan pertama yang mengawali legenda Kamen Rider bersama motor Cyclone.', 180, 70, 15, 22.5, 15.3, 12, 'Episode 1: The Eerie Man Spider', NULL, 'https://kamenrider.fandom.com/wiki/Takeshi_Hongo');
  ELSE
    UPDATE characters SET
      rider_name = COALESCE(rider_name, 'Kamen Rider 1'), civilian_name = COALESCE(civilian_name, 'Takeshi Hongo'),
      actor = COALESCE(actor, 'Hiroshi Fujioka'), role = COALESCE(role, 'Main Rider'),
      height_cm = COALESCE(height_cm, 180), weight_kg = COALESCE(weight_kg, 70),
      punch_power_t = COALESCE(punch_power_t, 15), kick_power_t = COALESCE(kick_power_t, 22.5),
      max_jump_m = COALESCE(max_jump_m, 15.3), run_100m_s = COALESCE(run_100m_s, 12),
      debut_episode = COALESCE(debut_episode, 'Episode 1: The Eerie Man Spider'),
      source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Takeshi_Hongo')
    WHERE series_id = v_series_id AND name = 'Kamen Rider 1';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 2') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s, debut_episode, image, source_url)
    VALUES (v_series_id, 'Kamen Rider 2', 'Kamen Rider 2', 'Hayato Ichimonji', 'Takeshi Sasaki', 'Secondary Rider', 'Sabuk Typhoon, kekuatan otot cyborg berdaya pukul tinggi, jurus Rider Punch dan Rider Kick.', 'Fotografer lepas yang diculik Shocker sebagai pengganti Hongo namun selamat dari cuci otak. Ia mempertahankan Jepang saat Hongo berada di Eropa dan menjadi pasangan abadi Double Riders.', 172, 65, 25, 30, 15.3, 2, 'Episode 14: Raid of the Demon Sabotegron', NULL, 'https://kamenrider.fandom.com/wiki/Hayato_Ichimonji');
  ELSE
    UPDATE characters SET
      rider_name = COALESCE(rider_name, 'Kamen Rider 2'), civilian_name = COALESCE(civilian_name, 'Hayato Ichimonji'),
      actor = COALESCE(actor, 'Takeshi Sasaki'), role = COALESCE(role, 'Secondary Rider'),
      height_cm = COALESCE(height_cm, 172), weight_kg = COALESCE(weight_kg, 65),
      punch_power_t = COALESCE(punch_power_t, 25), kick_power_t = COALESCE(kick_power_t, 30),
      max_jump_m = COALESCE(max_jump_m, 15.3), run_100m_s = COALESCE(run_100m_s, 2),
      debut_episode = COALESCE(debut_episode, 'Episode 14: Raid of the Demon Sabotegron'),
      source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Hayato_Ichimonji')
    WHERE series_id = v_series_id AND name = 'Kamen Rider 2';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shocker Rider No. 1') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'Shocker Rider No. 1', 'Shocker Rider No. 1', NULL, 'Eiji Okada (Suara)', 'Villain', 'Kekuatan cyborg identik dengan Kamen Rider 1, semburan api dari ujung jari, dan peluru beracun.', 'Prajurit cyborg tiruan ciptaan Gel-Shocker dengan syal kuning yang bertugas memfitnah nama baik Kamen Rider.', 'Episode 91: Gel-Shocker Appears! Kamen Rider Assassination Plan!!', NULL, 'https://kamenrider.fandom.com/wiki/Shocker_Riders');
  ELSE
    UPDATE characters SET
      rider_name = COALESCE(rider_name, 'Shocker Rider No. 1'),
      role = COALESCE(role, 'Villain'),
      debut_episode = COALESCE(debut_episode, 'Episode 91: Gel-Shocker Appears! Kamen Rider Assassination Plan!!'),
      source_url = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shocker_Riders')
    WHERE series_id = v_series_id AND name = 'Shocker Rider No. 1';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'Tobei Tachibana', 'Tobei Tachibana', 'Akiji Kobayashi', 'Ally', 'Mekanik ahli balap motor, pembimbing taktis, dan pemilik klub balap Tachibana Racing.', 'Sosok mentor sekaligus ayah angkat bagi Takeshi Hongo, Hayato Ichimonji, hingga para Rider Showa berikutnya. Ia selalu mendukung perjuangan para pahlawan dengan merawat kendaraan tempur mereka.', 'Episode 1: The Eerie Man Spider', NULL, 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Colonel Zol') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'Colonel Zol', 'Colonel Zol', 'Jiro Miyaguchi', 'Villain', 'Ahli strategi militer kejam, mampu berubah menjadi monster serigala Golden Wolfman.', 'Komandan tertinggi pertama cabang Shocker di Jepang yang didatangkan dari Timur Tengah. Ia merancang berbagai operasi sabotase berskala besar untuk menghancurkan Hayato Ichimonji.', 'Episode 26: The Terrifying Antlion Pit', NULL, 'https://kamenrider.fandom.com/wiki/Colonel_Zol');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Dr. Shinigami') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'Dr. Shinigami', 'Dr. Shinigami', 'Hideyo Amamoto', 'Villain', 'Ahli rekayasa biologi monster cyborg, mampu berubah wujud menjadi Ikadevil.', 'Ilmuwan eksentrik asal Eropa sekaligus komandan kedua Shocker di Jepang yang menciptakan pasukan monster mengerikan. Ia menaruh obsesi tinggi untuk mengalahkan Double Riders dengan kecerdasan ilmiahnya.', 'Episode 40: Deathmatch! The Monster Snowman vs. The Two Riders', NULL, 'https://kamenrider.fandom.com/wiki/Doctor_Shinigami');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ambassador Hell') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'Ambassador Hell', 'Ambassador Hell', 'Kenji Ushio', 'Villain', 'Pimpinan militer tangan besi, dapat bertransformasi menjadi Garagaranda.', 'Komandan ketiga cabang Shocker Jepang asal Asia Tenggara yang dikenal sangat brutal bahkan terhadap bawahannya sendiri. Ia menjadi lawan sengit Takeshi Hongo saat kembali ke Jepang.', 'Episode 53: The Monster Jaguarman, Decisive Deadly Autobike Battle', NULL, 'https://kamenrider.fandom.com/wiki/Ambassador_Hell');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Black') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, image, source_url)
    VALUES (v_series_id, 'General Black', 'General Black', 'Matasaburo Niwa', 'Villain', 'Komandan militer tertinggi Gel-Shocker, wujud asli monster Hiruchameleon.', 'Pemimpin operasional organisasi gabungan Gel-Shocker yang memimpin proyek enam Shocker Riders. Ia menjadi penghalang terakhir sebelum Double Riders menghadapi Pemimpin Besar.', 'Episode 80: Gel Shocker''s Debut! The Last Day of Kamen Rider!!', NULL, 'https://kamenrider.fandom.com/wiki/General_Black');
  END IF;

  -- Actors (Kamen Rider 1971)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroshi Fujioka') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, agency, bio)
    VALUES ('Hiroshi Fujioka', '藤岡 弘、', 'Takeshi Hongo / Kamen Rider 1', 'MC', v_series_id, '19 Februari 1946', 'Ehime, Jepang', 'Sanki Promotion', 'Aktor aksi legendaris sekaligus master bela diri yang memerankan pahlawan bertopeng pertama dalam sejarah Kamen Rider.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Takeshi Sasaki') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_place, bio)
    VALUES ('Takeshi Sasaki', '佐々木 剛', 'Hayato Ichimonji / Kamen Rider 2', 'Secondary Rider', v_series_id, 'Shibata, Niigata, Jepang', 'Memerankan Kamen Rider 2 mulai episode 14 saat Hiroshi Fujioka mengalami cedera syuting, sekaligus memopulerkan pose transformasi ikonik Kamen Rider.');
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER V3 (1973)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider V3', '仮面ライダーV3', 'Kamen Rider', 'Showa', 1973, '1973-02-17', '1974-02-09', 52, 'Toei Company / Ishimori Productions', 'Capung (Dragonfly) / Cyborg', 'Setelah keluarganya dibantai sindikat Destron, Shiro Kazami yang sekarat diubah menjadi cyborg oleh Kamen Rider 1 dan 2 agar bangkit sebagai Kamen Rider V3. Mengandalkan kekuatan gabungan dua pendahulunya, ia memburu Destron bersama sekutu barunya, Riderman.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_V3')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーV3'), aired_from = COALESCE(aired_from, '1973-02-17'),
      aired_to = COALESCE(aired_to, '1974-02-09'), episodes = COALESCE(episodes, 52),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Capung (Dragonfly) / Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_V3')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider V3', 'Kamen Rider V3', 'Shiro Kazami', 'Hiroshi Miyauchi', 'Main Rider', 'Sabuk Double Typhoon dengan 26 rahasia kemampuan tempur, jurus V3 Kick dan V3 Mach Kick.', 'Pemuda pemberani yang dioperasi oleh Double Riders setelah terluka fatal menyelamatkan diri dari serangan Destron. Ia membawa tekad membalas kematian keluarganya sambil melindungi kedamaian.', 180, 78, 90, 100, 60, 1.6, 'Episode 1: Rider No. 3: His Name is V3!', 'https://kamenrider.fandom.com/wiki/Shiro_Kazami');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Riderman') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, debut_episode, source_url)
    VALUES (v_series_id, 'Riderman', 'Riderman', 'Joji Yuki', 'Takehisa Yamaguchi', 'Secondary Rider', 'Lengan bionik Cassette Arm dengan beragam lampiran senjata modular (Rope, Power, Drill, Hook Arm).', 'Mantan ilmuwan cerdas Destron yang dikhianati Marshal Armor hingga kehilangan lengan kanannya. Ia mengganti lengannya dengan senjata bionik dan berjuang bersama V3 hingga diakui sebagai Kamen Rider keempat.', 175, 70, 5, 10, 20, 'Episode 43: Friend or Foe? The Mysterious Riderman', 'https://kamenrider.fandom.com/wiki/Joji_Yuki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Tobei Tachibana', 'Tobei Tachibana', 'Akiji Kobayashi', 'Ally', 'Pendukung logistik, mekanik motor Hurricane, dan pemimpin kelompok Boy Rider Squad.', 'Mentor setia yang terus mendampingi Shiro Kazami setelah kepergian Hongo dan Ichimonji. Ia mengarahkan jaringan anak-anak Boy Rider untuk mengumpulkan informasi pergerakan Destron.', 'Episode 1: Rider No. 3: His Name is V3!', 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Junko Tama') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Junko Tama', 'Junko Tama', 'Hizuru Ono', 'Ally', 'Ahli komunikasi radio di Boy Rider Squad serta pendukung moral tim Shiro Kazami.', 'Wanita muda berani yang menjadi rekan dekat Shiro Kazami sejak awal kemunculan Destron. Meski kerap menjadi sasaran penculikan musuh, ia tetap teguh membantu penyelidikan Tobei Tachibana.', 'Episode 1: Rider No. 3: His Name is V3!', 'https://kamenrider.fandom.com/wiki/Junko_Tama');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Doctor G') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Doctor G', 'Doctor G', 'Jotaro Senba', 'Villain', 'Komandan militer Destron bersenjata kapak besar, wujud asli monster Kani Laser.', 'Komandan lapangan pertama Destron yang selalu mengenakan baju zirah ksatria abad pertengahan dan menjadi rival langsung Shiro Kazami.', 'Episode 13: Terrifying Commandant: Doctor G!!', 'https://kamenrider.fandom.com/wiki/Doctor_G');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Marshal Armor') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Marshal Armor', 'Marshal Armor', 'Bunya Nakamura', 'Villain', 'Pimpinan kejam pasukan Destron, berwujud monster kerang Zarigarna.', 'Jenderal tertinggi terakhir Destron yang terkenal bengis dan menjadi dalang pengkhianatan terhadap Joji Yuki sebelum berduel mati-matian melawan V3.', 'Episode 41: Oh! People Are Melting! Enter, General Yoroi', 'https://kamenrider.fandom.com/wiki/Marshal_Armor');
  END IF;

  -- Actors (V3)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroshi Miyauchi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Hiroshi Miyauchi', '宮内 洋', 'Shiro Kazami / Kamen Rider V3', 'MC', v_series_id, '14 Januari 1947', 'Choshi, Chiba, Jepang', 'Aktor aksi ternama era 1970-an yang dikenal berkarisma memerankan Shiro Kazami, sekaligus melakoni banyak adegan aksi berbahaya sendiri.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Takehisa Yamaguchi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_place, bio)
    VALUES ('Takehisa Yamaguchi', '山口 豪久', 'Joji Yuki / Riderman', 'Secondary Rider', v_series_id, 'Tokyo, Jepang', 'Memerankan ilmuwan yang berbalik melawan Destron sebagai Riderman dan menjadi karakter favorit penggemar di era Showa.');
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER X (1974)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider X', '仮面ライダーＸ', 'Kamen Rider', 'Showa', 1974, '1974-02-16', '1974-10-12', 35, 'Toei Company / Ishimori Productions', 'Belalang / Teknologi Laut Dalam (Kaizorg)', 'Untuk menyelamatkan nyawa putranya Keisuke dari serangan organisasi jahat GOD, Profesor Keitaro Jin merombak tubuhnya menjadi cyborg laut dalam Kaizorg. Keisuke pun bertarung sebagai Kamen Rider X bersenjatakan tongkat Ridol.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_X')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーＸ'), aired_from = COALESCE(aired_from, '1974-02-16'),
      aired_to = COALESCE(aired_to, '1974-10-12'), episodes = COALESCE(episodes, 35),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Belalang / Teknologi Laut Dalam (Kaizorg)'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_X')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider X', 'Kamen Rider X', 'Keisuke Jin', 'Ryo Hayami', 'Main Rider', 'Sabuk Ridol dengan senjata tongkat multifungsi Ridol Whip/Stick/Rope serta jurus X-Kick.', 'Mahasiswa teknik kelautan yang diubah menjadi cyborg Kaizorg oleh ayahnya demi menyelamatkan nyawanya dari serangan GOD. Ia bertarung di darat maupun kedalaman laut menggunakan kendaraan Cruiser.', 28.3, 2, 'Episode 1: X-X-X-Rider is Born!!', 'https://kamenrider.fandom.com/wiki/Keisuke_Jin');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Keitaro Jin') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Keitaro Jin', 'Keitaro Jin', 'Jun Tazaki', 'Ally', 'Ilmuwan ahli robotika laut dalam pencipta sistem Kaizorg dan stasiun bawah laut.', 'Ayah Keisuke Jin yang mengorbankan dirinya demi mengubah Keisuke menjadi Kamen Rider X. Setelah wafat, kesadarannya sempat terhubung melalui komputer di markas bawah laut untuk membimbing putranya.', 'Episode 1: X-X-X-Rider is Born!!', 'https://kamenrider.fandom.com/wiki/Keitaro_Jin');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Tobei Tachibana', 'Tobei Tachibana', 'Akiji Kobayashi', 'Ally', 'Pemilik kedai kopi COL yang menjadi titik kumpul dan pendukung utama Keisuke Jin.', 'Pembimbing setia para Kamen Rider yang membantu Keisuke beradaptasi menghadapi tekanan pertarungan melawan organisasi teroris GOD.', 'Episode 1: X-X-X-Rider is Born!!', 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Apollo Geist') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Apollo Geist', 'Apollo Geist', 'Yasuhiko Uchida', 'Villain', 'Polisi rahasia elite GOD bersenjata Double Barrelled Gun dan perisai Geist Shield.', 'Kepala polisi rahasia organisasi GOD sekaligus rival utama Kamen Rider X yang kejam, licik, dan memiliki kode kehormatan sebagai petarung.', 'Episode 10: G.O.D. Secret Police! Apollogeist!!', 'https://kamenrider.fandom.com/wiki/Apollo_Geist');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'King Dark') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'King Dark', 'King Dark', 'Ayao Wada (Suara)', 'Villain', 'Robot raksasa penguasa organisasi GOD yang dikendalikan oleh Dr. Noroi dari dalam tubuhnya.', 'Pemimpin tertinggi sekaligus benteng hidup organisasi GOD yang melepaskan para monster bersejarah untuk merebut cetak biru RS Device.', 'Episode 22: The Terrible Great Giant! King Dark Appears!!', 'https://kamenrider.fandom.com/wiki/King_Dark');
  END IF;

  -- Actors (X)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Ryo Hayami') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Ryo Hayami', '速水 亮', 'Keisuke Jin / Kamen Rider X', 'MC', v_series_id, '14 November 1949', 'Yokohama, Kanagawa, Jepang', 'Aktor Jepang yang memerankan cyborg laut dalam Keisuke Jin dalam serial Kamen Rider X.');
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER AMAZON (1974)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider Amazon', '仮面ライダーアマゾン', 'Kamen Rider', 'Showa', 1974, '1974-10-19', '1975-03-29', 24, 'Toei Company / Ishimori Productions', 'Kadal Monitor / Piranha', 'Daisuke Yamamoto tumbuh liar di hutan Amazon sebelum dibekali gelang mistis GiGi Armlet oleh tetua suku Inca untuk melindunginya dari organisasi Geddon. Kembali ke Jepang, ia bertarung buas sebagai Kamen Rider Amazon menumpas Geddon dan Kekaisaran Garanda.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazon')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーアマゾン'), aired_from = COALESCE(aired_from, '1974-10-19'),
      aired_to = COALESCE(aired_to, '1975-03-29'), episodes = COALESCE(episodes, 24),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Kadal Monitor / Piranha'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazon')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, max_jump_m, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider Amazon', 'Kamen Rider Amazon', 'Daisuke Yamamoto', 'Toru Okazaki', 'Main Rider', 'Gelang mistis GiGi Armlet, gaya bertarung liar mencakar musuh, serta jurus pamungkas Dai Setsudan.', 'Pemuda yang terdampar dan dibesarkan di rimba Amazon sejak bayi. Tidak seperti Rider lainnya yang berasal dari operasi mekanis, ia memperoleh kekuatannya melalui ilmu kuno suku Inca.', 80, 'Episode 1: Man or Beast? The Cool Guy Who Came From the Jungle!', 'https://kamenrider.fandom.com/wiki/Daisuke_Yamamoto');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Tobei Tachibana', 'Tobei Tachibana', 'Akiji Kobayashi', 'Ally', 'Pembuat motor Jungler serta guru bahasa dan adat masyarakat Jepang bagi Amazon.', 'Sahabat sekaligus pembimbing yang mengajarkan Daisuke cara beradaptasi dengan kehidupan modern di Jepang saat memburu komplotan Geddon.', 'Episode 2: Man or Beast? The Cool Guy Who Came From the Jungle!', 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mogura Beastman') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Mogura Beastman', 'Mogura Beastman', 'Ryuji Saikachi (Suara)', 'Ally', 'Kemampuan menggali terowongan bawah tanah dengan cepat sebagai mata-mata sekutu.', 'Monster tikus tanah ciptaan Geddon yang membelot setelah diselamatkan dan diperlakukan dengan baik oleh Amazon. Ia menjadi sahabat setia Daisuke hingga gugur dalam pertempuran.', 'Episode 5: The Weirdo Who Came From Underground!!', 'https://kamenrider.fandom.com/wiki/Mole_Beastman');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ten-Faced Demon Gorgos') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Ten-Faced Demon Gorgos', 'Ten-Faced Demon Gorgos', 'Ritsuo Sawa / Ryuji Saikachi (Suara)', 'Villain', 'Tubuh batu raksasa bertubuh sepuluh wajah penjahat kuno serta tongkat penyembuh.', 'Pemimpin kejam organisasi Geddon yang memburu gelang GiGi Armlet milik Amazon demi menguasai kekuatan mutlak suku Inca.', 'Episode 1: Man or Beast? The Cool Guy Who Came From the Jungle!', 'https://kamenrider.fandom.com/wiki/Ten-Faced_Demon_Gorgos');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Zero Great Emperor') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Zero Great Emperor', 'Zero Great Emperor', 'Hirohisa Nakata', 'Villain', 'Pemimpin Kekaisaran Garanda bersenjatakan tombak energi dan pengendali gelang GaGa Armlet.', 'Penguasa organisasi baru Garanda Empire yang muncul setelah kehancuran Geddon untuk menyatukan kedua gelang GiGi dan GaGa demi menaklukkan dunia.', 'Episode 15: He Came Forth! The Terrible Zero the Great', 'https://kamenrider.fandom.com/wiki/Zero_Great_Emperor');
  END IF;

  -- Actors (Amazon)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Toru Okazaki') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Toru Okazaki', '岡崎 徹', 'Daisuke Yamamoto / Kamen Rider Amazon', 'MC', v_series_id, '3 Desember 1948', 'Nagasaki, Jepang', 'Memerankan karakter unik Daisuke Yamamoto yang berperilaku liar dari hutan rimba namun berhati murni.');
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER STRONGER (1975)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Stronger' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider Stronger', '仮面ライダーストロンガー', 'Kamen Rider', 'Showa', 1975, '1975-04-05', '1975-12-27', 39, 'Toei Company / Ishimori Productions', 'Kumbang Tanduk Jepang / Listrik', 'Shigeru Jo membiarkan dirinya dioperasi organisasi Black Satan demi membalas kematian sahabatnya, lalu kabur sebelum dicuci otak sebagai Kamen Rider Stronger. Ditemani Tackle, ia menghadapi Black Satan hingga munculnya Pasukan Delza.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Stronger')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーストロンガー'), aired_from = COALESCE(aired_from, '1975-04-05'),
      aired_to = COALESCE(aired_to, '1975-12-27'), episodes = COALESCE(episodes, 39),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Kumbang Tanduk Jepang / Listrik'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Stronger')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider Stronger', 'Kamen Rider Stronger', 'Shigeru Jo', 'Shigeru Araki', 'Main Rider', 'Sabuk Electrer bertenaga listrik bertegangan tinggi, wujud penguatan Charge Up, serta Electro Kick.', 'Pemuda pemberani yang rela menyusup menjadi bahan eksperimen cyborg Black Satan demi keadilan sahabatnya. Ia menjadi Kamen Rider pertama yang memperkenalkan bentuk upgrade Charge Up.', 'Episode 1: I am the Electric Human Stronger!!', 'https://kamenrider.fandom.com/wiki/Shigeru_Jo');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Electro-Wave Human Tackle') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Electro-Wave Human Tackle', 'Electro-Wave Human Tackle', 'Yuriko Misaki', 'Kyoko Okada', 'Ally', 'Gelombang elektromagnetik dengan teknik bantingan Denpa Nage dan serangan Ultra Cyclone.', 'Rekan seperjuangan Shigeru Jo yang juga merupakan hasil modifikasi paksa Black Satan. Ia setia bertempur di sisi Stronger hingga rela mengorbankan nyawanya demi menyelamatkan Shigeru.', 'Episode 1: I am the Electric Human Stronger!!', 'https://kamenrider.fandom.com/wiki/Yuriko_Misaki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Tobei Tachibana', 'Tobei Tachibana', 'Akiji Kobayashi', 'Ally', 'Pendukung logistik dan mentor di balik perjalanan Shigeru Jo serta Yuriko Misaki.', 'Sosok mentor yang menyusul Shigeru dan Tackle selama perjalanan mereka menelusuri markas Black Satan hingga pertarungan akhir bersama tujuh Rider legendaris.', 'Episode 3: Thriller House Calls Out to the Demon!', 'https://kamenrider.fandom.com/wiki/Tobei_Tachibana');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hitotsume Titan') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Hitotsume Titan', 'Hitotsume Titan', 'Akira Hamada', 'Villain', 'Kekuatan fisik raksasa bermata satu dan pengendali energi panas magma.', 'Jenderal eksekutif pertama organisasi Black Satan yang terus bersaing dengan Stronger sebelum gugur dan bangkit kembali dalam wujud yang lebih kuat.', 'Episode 1: I am the Electric Human Stronger!!', 'https://kamenrider.fandom.com/wiki/Titan');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Shadow') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'General Shadow', 'General Shadow', 'Hidekatsu Shibata (Suara)', 'Villain', 'Ahli taktik bermodal kartu tarot mematikan dan pedang Shadow Saber.', 'Pemimpin pasukan elite Delza Army yang licik dan ambisius. Setelah menjatuhkan Black Satan, ia menantang Stronger secara langsung dengan pasukan cyborg keturunan monster.', 'Episode 13: Hitotsume Titan! The Final Counter Attack!!', 'https://kamenrider.fandom.com/wiki/General_Shadow');
  END IF;

  -- Actors (Stronger)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shigeru Araki') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Shigeru Araki', '荒木 しげる', 'Shigeru Jo / Kamen Rider Stronger', 'MC', v_series_id, '9 Februari 1949', 'Izumi, Kagoshima, Jepang', 'Mantan personel grup musik Four Leaves yang sukses membawakan karakter Shigeru Jo yang gagah dan penuh percaya diri.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kyoko Okada') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_place, bio)
    VALUES ('Kyoko Okada', '岡田 京子', 'Yuriko Misaki / Electro-Wave Human Tackle', 'Hero', v_series_id, 'Tokyo, Jepang', 'Memerankan karakter pahlawan wanita ikonik pertama di era Showa yang mendampingi perjuangan Kamen Rider Stronger.');
  END IF;


  -- ===========================================================================
  -- 6. SKYRIDER (1979)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Skyrider', '仮面ライダー（新）', 'Kamen Rider', 'Showa', 1979, '1979-10-05', '1980-10-10', 54, 'Toei Company / Ishimori Productions', 'Belalang / Penerbangan', 'Terluka parah saat menyelamatkan Profesor Shido dari Neo-Shocker, Hiroshi Tsukuba diubah menjadi cyborg dengan kemampuan terbang bebas oleh sang profesor sebelum melarikannya. Ia bertarung sebagai Skyrider dibantu tujuh Rider senior.', NULL, 'https://en.wikipedia.org/wiki/Skyrider_(TV_series)')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダー（新）'), aired_from = COALESCE(aired_from, '1979-10-05'),
      aired_to = COALESCE(aired_to, '1980-10-10'), episodes = COALESCE(episodes, 54),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Belalang / Penerbangan'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Skyrider_(TV_series)')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Skyrider') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, kick_power_t, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Skyrider', 'Skyrider', 'Hiroshi Tsukuba', 'Hiroaki Murakami', 'Main Rider', 'Sabuk Tornado dilengkapi mesin anti-gravitasi Sailing Jump untuk terbang di udara dan jurus Sky Kick.', 'Anggota klub layang gantung yang diubah menjadi cyborg oleh Dr. Shido agar nyawanya selamat. Ia berlatih keras bersama tujuh seniornya hingga mendapat warna kostum baru yang lebih cerah.', 180, 70, 10, 30, 6, 'Episode 1: A Cyborg Flies in the Sky', 'https://kamenrider.fandom.com/wiki/Hiroshi_Tsukuba');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Dr. Keitaro Shido') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Dr. Keitaro Shido', 'Keitaro Shido', 'Takashi Tabata', 'Ally', 'Ilmuwan ahli teknologi cyborg perancang mekanisme terbang pada sabuk Tornado.', 'Ilmuwan yang berhasil melarikan diri dari Neo-Shocker bersama Hiroshi Tsukuba. Ia membimbing Hiroshi menggunakan kekuatan Skyrider pada paruh awal serial sebelum ditugaskan ke luar negeri.', 'Episode 1: A Cyborg Flies in the Sky', 'https://kamenrider.fandom.com/wiki/Keitaro_Shido');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Genjiro Tani') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Genjiro Tani', 'Genjiro Tani', 'Nobuo Tsukamoto', 'Ally', 'Pemilik kedai kopi Blanca dan senior terpercaya yang mendukung operasi Skyrider.', 'Rekanan lama Tobei Tachibana yang menggantikan peran Dr. Shido dalam membantu Hiroshi Tsukuba menghadapi ancaman Neo-Shocker hingga serial Kamen Rider Super-1.', 'Episode 14: Haejigokujin, Kamen Rider Close Call', 'https://kamenrider.fandom.com/wiki/Genjiro_Tani');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Monster') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'General Monster', 'General Monster', 'Shinzo Hotta', 'Villain', 'Komandan kejam cabang Jepang Neo-Shocker, wujud asli monster Yamori Jin.', 'Jenderal lapangan pertama Neo-Shocker yang memimpin pengejaran terhadap Profesor Shido dan kerap mengeksekusi monster bawahannya yang gagal.', 'Episode 1: A Cyborg Flies in the Sky', 'https://kamenrider.fandom.com/wiki/General_Monster');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Admiral Majin') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Admiral Majin', 'Admiral Majin', 'Yosuke Naka', 'Villain', 'Panglima tinggi Neo-Shocker dengan pedang tempur dan kemampuan bertarung langsung.', 'Pimpinan militer kedua Neo-Shocker yang mengambil alih kendali setelah tumbangnya General Monster untuk memburu Skyrider serta tujuh Rider senior.', 'Episode 18: Admiral Majin''s Great Electric Hell Operation', 'https://kamenrider.fandom.com/wiki/Admiral_Majin');
  END IF;

  -- Actors (Skyrider)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroaki Murakami') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Hiroaki Murakami', '村上 弘明', 'Hiroshi Tsukuba / Skyrider', 'MC', v_series_id, '22 Desember 1956', 'Rikuzentakata, Iwate, Jepang', 'Aktor papan atas Jepang yang memulai debut akting utamanya lewat serial Skyrider sebelum berkarier luas di film dan drama sejarah.');
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER SUPER-1 (1980)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider Super-1', '仮面ライダースーパー１', 'Kamen Rider', 'Showa', 1980, '1980-10-17', '1981-10-03', 48, 'Toei Company / Ishimori Productions', 'Tawon / Eksplorasi Luar Angkasa / Kung Fu', 'Kazuya Oki menjadi cyborg sukarela untuk proyek eksplorasi antariksa sebelum markasnya dihancurkan Kerajaan Dogma. Ia mempelajari kung fu demi mengendalikan kekuatannya sebagai Kamen Rider Super-1 bersenjatakan lima sarung tangan tempur.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Super-1')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダースーパー１'), aired_from = COALESCE(aired_from, '1980-10-17'),
      aired_to = COALESCE(aired_to, '1981-10-03'), episodes = COALESCE(episodes, 48),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Tawon / Eksplorasi Luar Angkasa / Kung Fu'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Super-1')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Super-1') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider Super-1', 'Kamen Rider Super-1', 'Kazuya Oki', 'Shunsuke Takasugi', 'Main Rider', 'Lima sarung tangan tempur Five Hands (Super, Elec, Power, Cold/Heat, Radar) dan jurus kung fu Sekishin Shorinji Kenpo.', 'Relawan program cyborg penjelajah antariksa yang selamat dari penghancuran laboratorium oleh Kerajaan Dogma. Ia berlatih keras menguasai ilmu bela diri kung fu agar bisa bertransformasi secara mandiri.', 185, 80, 30, 100, 5, 'Episode 1: The Planetary Cyborg''s Great Transformation', 'https://kamenrider.fandom.com/wiki/Kazuya_Oki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Master Genkai') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Master Genkai', 'Genkai', 'Munemaru Koda', 'Ally', 'Guru besar seni bela diri Sekishin Shorinji Kenpo.', 'Pendeta sekaligus guru kung fu yang menerima Kazuya Oki sebagai murid dan mengajarinya teknik pengendalian diri agar dapat mengaktifkan perubahan wujud Super-1.', 'Episode 1: The Planetary Cyborg''s Great Transformation', 'https://kamenrider.fandom.com/wiki/Master_Genkai');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Genjiro Tani') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Genjiro Tani', 'Genjiro Tani', 'Nobuo Tsukamoto', 'Ally', 'Pemilik bengkel sepeda motor Tani Motor Shop sekaligus pendukung logistik Kazuya Oki.', 'Pembimbing kelompok Junior Rider Team dan rekan dekat yang mendukung penuh perjuangan Kamen Rider Super-1 melawan Dogma maupun Jin Dogma.', 'Episode 1: The Planetary Cyborg''s Great Transformation', 'https://kamenrider.fandom.com/wiki/Genjiro_Tani');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Emperor Terror Macro') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Emperor Terror Macro', 'Terror Macro', 'Akira Shioji', 'Villain', 'Kaisar tertinggi Kerajaan Dogma, wujud asli naga raksasa Kaiser Crow.', 'Penguasa tirani Kerajaan Dogma yang terobsesi menciptakan dunia bagi manusia pilihan saja dan memerintahkan pembantaian di markas riset tempat Kazuya Oki berasal.', 'Episode 1: The Planetary Cyborg''s Great Transformation', 'https://kamenrider.fandom.com/wiki/Emperor_Terror_Macro');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Megarl') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'General Megarl', 'Megarl', 'Toshihiko Miki', 'Villain', 'Panglima pasukan lapangan Kerajaan Dogma, wujud monster jangkrik Shitanikingu.', 'Komandan militer setia Kaisar Terror Macro yang memimpin operasi lapangan Kerajaan Dogma untuk memburu Kazuya Oki.', 'Episode 1: The Planetary Cyborg''s Great Transformation', 'https://kamenrider.fandom.com/wiki/General_Megarl');
  END IF;

  -- Actors (Super-1)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shunsuke Takasugi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Shunsuke Takasugi', '高杉 俊介', 'Kazuya Oki / Kamen Rider Super-1', 'MC', v_series_id, '22 Juli 1949', 'Ichinomiya, Aichi, Jepang', 'Memerankan Kazuya Oki serta turut menyanyikan lagu tema pembuka ikonik serial Kamen Rider Super-1.');
  END IF;


  -- ===========================================================================
  -- 8. KAMEN RIDER ZX (1984 TV Special)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider ZX', '10号誕生! 仮面ライダー全員集合!!', 'Kamen Rider', 'Showa', 1984, '1984-01-03', '1984-01-03', 1, 'Toei Company / Ishimori Productions', 'Kumbang / Ninja Cyborg', 'Ryo Murasame diculik oleh Kekaisaran Badan bersama saudarinya di hutan Amazon dan diubah menjadi prajurit cyborg ninja bernama Kamen Rider ZX. Setelah ingatannya pulih dari kendali musuh, ia bergabung dengan sembilan Rider pendahulunya untuk menggagalkan proyek senjata kiamat Badan.', NULL, 'https://en.wikipedia.org/wiki/Birth_of_the_10th!_Kamen_Riders_All_Together!!')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '10号誕生! 仮面ライダー全員集合!!'), aired_from = COALESCE(aired_from, '1984-01-03'),
      aired_to = COALESCE(aired_to, '1984-01-03'), episodes = COALESCE(episodes, 1),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Kumbang / Ninja Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Birth_of_the_10th!_Kamen_Riders_All_Together!!')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider ZX') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider ZX', 'Kamen Rider ZX', 'Ryo Murasame', 'Shun Sugata', 'Main Rider', 'Perlengkapan ninja mekanik seperti Cross Shuriken, Impact Bomb, dan ilusi Micro-Chain.', 'Pemuda yang selamat dari pembantaian oleh Kekaisaran Badan dan diubah menjadi cyborg tempur dengan kecakapan ala ninja. Ia diakui secara resmi sebagai Kamen Rider ke-10 oleh sembilan pendahulunya.', 188, 78, 60, 0.6, 'Birth of the 10th! Kamen Riders All Together!!', 'https://kamenrider.fandom.com/wiki/Ryo_Murasame');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Rumi Ichijo') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Rumi Ichijo', 'Rumi Ichijo', 'Yumiko Miyake', 'Ally', 'Peran pendukung sipil dan saksi kekejaman proyek senjata Badan.', 'Putri seorang ilmuwan yang dibunuh oleh agen Badan karena menolak bekerja sama, yang kemudian berteman dengan Ryo Murasame.', 'Birth of the 10th! Kamen Riders All Together!!', 'https://kamenrider.fandom.com/wiki/Rumi_Ichijo');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Dr. Hajime Kaido') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Dr. Hajime Kaido', 'Hajime Kaido', 'Eiji Karasawa', 'Ally', 'Peneliti biokimia serta penasihat ilmiah bagi Ryo Murasame.', 'Rekan ilmuwan ayah Rumi yang membantu Ryo Murasame menyingkap rencana pembangunan sistem penghancur Space Break System milik Badan.', 'Birth of the 10th! Kamen Riders All Together!!', 'https://kamenrider.fandom.com/wiki/Hajime_Kaido');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ambassador Darkness') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Ambassador Darkness', 'Kurayami Taishi', 'Kenji Ushio', 'Villain', 'Komandan militer berpakaian gelap dan pedang tempur Kekaisaran Badan.', 'Panglima lapangan utama Kekaisaran Badan yang memimpin operasi pembangunan senjata Space Break System serta memerangi para Kamen Rider.', 'Birth of the 10th! Kamen Riders All Together!!', 'https://kamenrider.fandom.com/wiki/Ambassador_Darkness');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Generalissimo of Badan') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Generalissimo of Badan', 'Generalissimo of Badan', 'Goro Naya (Suara)', 'Villain', 'Entitas pengendali tertinggi Kekaisaran Badan dari dimensi gelap.', 'Pemimpin misterius Kekaisaran Badan yang memerintahkan penciptaan ZX dan berambisi menaklukkan bumi.', 'Birth of the 10th! Kamen Riders All Together!!', 'https://kamenrider.fandom.com/wiki/Generalissimo_of_Badan');
  END IF;

  -- Actors (ZX)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shun Sugata') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Shun Sugata', '菅田 俊', 'Ryo Murasame / Kamen Rider ZX', 'MC', v_series_id, '17 Februari 1955', 'Yamanashi, Jepang', 'Aktor watak senior perfilman Jepang yang memulai salah satu peran ikonik awalnya sebagai Kamen Rider ke-10.');
  END IF;


  -- ===========================================================================
  -- 9. KAMEN RIDER BLACK (1987)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider Black', '仮面ライダーBLACK', 'Kamen Rider', 'Showa', 1987, '1987-10-04', '1988-10-09', 51, 'Toei Company / Ishimori Productions', 'Belalang / Bio-Cyborg', 'Diculik oleh sekte Gorgom dan ditanamkan batu suci Kingstone, Kotaro Minami meloloskan diri sebelum dicuci otak dan bertarung sebagai Kamen Rider Black, namun terpaksa berhadapan dengan saudara angkatnya sendiri yang menjadi Shadow Moon.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーBLACK'), aired_from = COALESCE(aired_from, '1987-10-04'),
      aired_to = COALESCE(aired_to, '1988-10-09'), episodes = COALESCE(episodes, 51),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Belalang / Bio-Cyborg'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, max_jump_m, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider Black', 'Kamen Rider Black', 'Kotaro Minami', 'Tetsuo Kurata', 'Main Rider', 'Batu Kingstone Matahari di sabuk Vital Charger, jurus maut Rider Punch dan Rider Kick.', 'Pemuda yang diculik Gorgom pada ulang tahunnya ke-19 namun lolos sebelum pencucian otak. Ia berjuang sendirian dengan motor cerdas Battle Hopper demi menyelamatkan bumi dan saudaranya.', 198.7, 87, 30, 'Episode 1: Black!! Transformation', 'https://kamenrider.fandom.com/wiki/Kotaro_Minami');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shadow Moon') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, debut_episode, source_url)
    VALUES (v_series_id, 'Shadow Moon', 'Shadow Moon', 'Nobuhiko Akizuki', 'Takahito Horiuchi / Masaki Terasoma (Suara)', 'Villain', 'Batu Kingstone Bulan, pedang Satan Saber dan Shadow Saber, serta jurus Shadow Kick.', 'Sahabat sekaligus saudara angkat Kotaro yang tidak sempat melarikan diri dari operasi Gorgom, sehingga ia dibangkitkan sebagai musuh terberat Kamen Rider Black.', 197.4, 90, 4, 10, 'Episode 35: Showdown! Two Princes', 'https://kamenrider.fandom.com/wiki/Nobuhiko_Akizuki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kyoko Akizuki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kyoko Akizuki', 'Kyoko Akizuki', 'Akemi Inoue', 'Ally', 'Keterikatan batin dengan Nobuhiko serta pendukung moral terdekat Kotaro.', 'Adik kandung Nobuhiko dan adik angkat Kotaro Minami. Ia menjadi alasan utama Kotaro berjuang mempertahankan kedamaian sekaligus berusaha menyadarkan kembali kakaknya.', 'Episode 1: Black!! Transformation', 'https://kamenrider.fandom.com/wiki/Kyoko_Akizuki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Katsumi Kida') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Katsumi Kida', 'Katsumi Kida', 'Ayumi Taguchi', 'Ally', 'Pendukung investigasi yang membantu Kotaro dan Kyoko di luar pertarungan.', 'Kekasih Nobuhiko yang ikut terjebak dalam konspirasi Gorgom bersama Kyoko dan terus berharap Nobuhiko dapat kembali seperti semula.', 'Episode 1: Black!! Transformation', 'https://kamenrider.fandom.com/wiki/Katsumi_Kida');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'High Priest Darom') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'High Priest Darom', 'Darom', 'Shozo Iizuka (Suara)', 'Villain', 'Kemampuan telekinesis kuat dan pancaran energi destruktif sebagai Pendeta Agung.', 'Pemimpin dari Tiga Pendeta Agung Gorgom yang memimpin operasi penciptaan mutan serta kebangkitan Raja Penciptaan.', 'Episode 1: Black!! Transformation', 'https://kamenrider.fandom.com/wiki/Darom');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'High Priest Baraom') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'High Priest Baraom', 'Baraom', 'Toshimichi Takahashi (Suara)', 'Villain', 'Serangan gelombang energi dari gading dan kekuatan fisik tangguh.', 'Salah satu dari Tiga Pendeta Agung Gorgom yang berfokus pada operasi militer dan perburuan langsung terhadap Black.', 'Episode 1: Black!! Transformation', 'https://kamenrider.fandom.com/wiki/Baraom');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Sword Saint Bilgenia') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Sword Saint Bilgenia', 'Bilgenia', 'Jun Yoshida', 'Villain', 'Pendekar pedang ulung bersenjatakan pedang Bilgenia Sword dan perisai Bill.', 'Prajurit kuno Gorgom yang dibangkitkan kembali dari peti mati ribuan tahun karena Tiga Pendeta Agung membutuhkan tandingan tangguh bagi Kamen Rider Black.', 'Episode 18: Sword Saint Bilgenia!!', 'https://kamenrider.fandom.com/wiki/Bilgenia');
  END IF;

  -- Actors (Black)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Tetsuo Kurata') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Tetsuo Kurata', '倉田 てつを', 'Kotaro Minami / Kamen Rider Black', 'MC', v_series_id, '11 September 1968', 'Tokyo, Jepang', 'Aktor ikonik yang memerankan Kotaro Minami dalam dua serial berturut-turut, Kamen Rider Black dan Kamen Rider Black RX.');
  END IF;


  -- ===========================================================================
  -- 10. KAMEN RIDER BLACK RX (1988)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Kamen Rider Black RX', '仮面ライダーBLACK RX', 'Kamen Rider', 'Showa', 1988, '1988-10-23', '1989-09-24', 47, 'Toei Company / Ishimori Productions', 'Belalang / Energi Matahari', 'Dibuang ke luar angkasa oleh Kekaisaran Crisis, batu Kingstone dalam tubuh Kotaro Minami menyerap energi surya dan mengevolusikannya menjadi Kamen Rider Black RX. Ia melawan Crisis bersama kemampuan berubah menjadi Robo Rider dan Bio Rider.', NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black_RX')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, '仮面ライダーBLACK RX'), aired_from = COALESCE(aired_from, '1988-10-23'),
      aired_to = COALESCE(aired_to, '1989-09-24'), episodes = COALESCE(episodes, 47),
      studio = COALESCE(studio, 'Toei Company / Ishimori Productions'), motif = COALESCE(motif, 'Belalang / Energi Matahari'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Black_RX')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black RX') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, power, bio, height_cm, weight_kg, punch_power_t, kick_power_t, max_jump_m, run_100m_s, debut_episode, source_url)
    VALUES (v_series_id, 'Kamen Rider Black RX', 'Kamen Rider Black RX', 'Kotaro Minami', 'Tetsuo Kurata', 'Main Rider', 'Sabuk Sunriser bertenaga surya, pedang cahaya Revolcane, perubahan wujud Robo Rider dan Bio Rider.', 'Wujud evolusi Kotaro Minami setelah terpapar radiasi matahari di luar angkasa. Sebagai penutup era Showa, ia dapat beralih bentuk sesuai emosi dan mengendarai mobil Ridoron.', 198.8, 88, 30, 45, 60, 1.1, 'Episode 1: Child of the Sun! RX', 'https://kamenrider.fandom.com/wiki/Kotaro_Minami');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Reiko Shiratori') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Reiko Shiratori', 'Reiko Shiratori', 'Makoto Sumikawa', 'Ally', 'Fotografer pemberani serta petarung bela diri ringan yang membantu operasi Kotaro.', 'Rekan sekaligus kekasih Kotaro Minami yang mengetahui rahasia identitasnya dan ikut membantu menghadapi pasukan Crisis.', 'Episode 1: Child of the Sun! RX', 'https://kamenrider.fandom.com/wiki/Reiko_Shiratori');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Joe the Haze') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Joe the Haze', 'Joe Kazama', 'Rikiya Koyama', 'Ally', 'Kemampuan bertarung bela diri cyborg yang lincah sebagai sekutu terdekat RX.', 'Pemuda yang sempat hilang ingatan akibat eksperimen Crisis sebelum berteman dekat dengan Kotaro dan bertarung di sisinya sebagai saudara angkat.', 'Episode 15: Roborider''s Birth', 'https://kamenrider.fandom.com/wiki/Joe_the_Haze');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Jark') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'General Jark', 'General Jark', 'Seizo Kato / Hidekatsu Shibata (Suara)', 'Villain', 'Komandan tertinggi angkatan perang Crisis bersenjatakan tombak energi serta wujud Jark Midla.', 'Panglima pasukan invasi Kekaisaran Crisis yang memimpin empat divisi militer di Bumi dan menaruh respek tinggi pada ketangguhan Black RX.', 'Episode 1: Child of the Sun! RX', 'https://kamenrider.fandom.com/wiki/General_Jark');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Bosgun') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Commander Bosgun', 'Bosgun', 'Shozo Iizuka (Suara)', 'Villain', 'Komandan divisi monster iblis dengan dua bilah pedang dan ambisi kudeta.', 'Salah satu dari empat komandan utama pasukan Crisis yang memimpin unit monster berbasis sihir dan makhluk mitos.', 'Episode 1: Child of the Sun! RX', 'https://kamenrider.fandom.com/wiki/Commander_Bosgun');
  END IF;

  -- Actors (Black RX)
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Tetsuo Kurata') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, bio)
    VALUES ('Tetsuo Kurata', '倉田 てつを', 'Kotaro Minami / Kamen Rider Black RX', 'MC', v_series_id, '11 September 1968', 'Tokyo, Jepang', 'Kembali memerankan Kotaro Minami dalam evolusi barunya sebagai Pangeran Matahari, Kamen Rider Black RX.');
  END IF;

END $$;

-- Sinkronkan ulang sequence ID
SELECT setval(pg_get_serial_sequence('series', 'id'), COALESCE((SELECT MAX(id) FROM series), 1));
SELECT setval(pg_get_serial_sequence('characters', 'id'), COALESCE((SELECT MAX(id) FROM characters), 1));
SELECT setval(pg_get_serial_sequence('actors', 'id'), COALESCE((SELECT MAX(id) FROM actors), 1));
