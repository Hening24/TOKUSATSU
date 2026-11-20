-- =============================================================================
-- SEED DATA BATCH 1: METAL HERO ERA SHOWA (1982 - 1989)
-- IDEMPOTEN: Cek berdasarkan title / (series_id, name) sebelum INSERT.
-- HANYA mengisi kolom NULL pada data yang sudah ada (COALESCE), tidak menimpa editan manual.
-- Terhubung ke tabel series, characters, dan actors (Pemeran Utama).
-- Cakupan (7 Series):
--   1. Space Sheriff Gavan (1982)
--   2. Space Sheriff Sharivan (1983)
--   3. Space Sheriff Shaider (1984)
--   4. Kyojuu Tokusou Juspion (1985)
--   5. Jikuu Senshi Spielban (1986)
--   6. Choujinki Metalder (1987)
--   7. Sekai Ninja Sen Jiraiya (1988)
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. SPACE SHERIFF GAVAN (1982)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Gavan' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Space Sheriff Gavan', '宇宙刑事ギャバン', 'Metal Hero', 'Showa', 1982, '1982-03-05', '1983-02-25',
      44, 'Toei Company', 'Polisi Antariksa / Baju Zirah Krom',
      'Serial pembuka waralaba Metal Hero yang mengisahkan Retsu Ichijouji, seorang perwira Galactic Union Police berdarah campuran Bumi dan Planet Bird yang bertugas melindungi Bumi dengan nama sandi Space Sheriff Gavan. Dibantu rekannya Mimi dan kapal induk raksasa Dolgiran, Gavan menumpas sindikat kejahatan antariksa Makuu pimpinan Don Horror sekaligus mencari ayahnya yang hilang.',
      NULL, 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '宇宙刑事ギャバン'),
      aired_from = COALESCE(aired_from, '1982-03-05'),
      aired_to   = COALESCE(aired_to, '1983-02-25'),
      episodes   = COALESCE(episodes, 44),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Polisi Antariksa / Baju Zirah Krom'),
      synopsis   = COALESCE(synopsis, 'Serial pembuka waralaba Metal Hero yang mengisahkan Retsu Ichijouji, seorang perwira Galactic Union Police berdarah campuran Bumi dan Planet Bird yang bertugas melindungi Bumi dengan nama sandi Space Sheriff Gavan. Dibantu rekannya Mimi dan kapal induk raksasa Dolgiran, Gavan menumpas sindikat kejahatan antariksa Makuu pimpinan Don Horror sekaligus mencari ayahnya yang hilang.'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan')
    WHERE id = v_series_id;
  END IF;

  -- Karakter eksisting Space Sheriff Gavan: hanya lengkapi kolom NULL
  IF EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Gavan') THEN
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Space Sheriff Gavan'),
      civilian_name = COALESCE(civilian_name, 'Retsu Ichijouji'),
      actor         = COALESCE(actor, 'Kenji Ohba'),
      role          = COALESCE(role, 'Main Hero'),
      species       = COALESCE(species, 'Hibrida Manusia - Planet Bird'),
      team          = COALESCE(team, 'Galactic Union Police'),
      power         = COALESCE(power, 'Laser Blade, Laser Z Beam, Silver Beam, Combat Suit bertenaga partikel Granium dari kapal Dolgiran'),
      bio           = COALESCE(bio, 'Perwira muda Galactic Union Police yang ditugaskan mempertahankan Bumi dari sindikat Makuu. Ia bertransformasi melalui proses vapor-deposition Jo-Chaku dalam 0,05 detik sambil mencari jejak ayahnya, Voicer.'),
      debut_episode = COALESCE(debut_episode, 'Episode 1'),
      source_url    = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'),
      extra_stats   = COALESCE(extra_stats, '[
        {"label":"Tinggi","value":"200","unit":"cm"},
        {"label":"Berat","value":"90","unit":"kg"},
        {"label":"Lompatan maks","value":"150","unit":"m"},
        {"label":"Asal","value":"Planet Bird / Bumi","unit":""},
        {"label":"Peralatan khas","value":"Laser Blade & Dolgiran","unit":""}
      ]'::jsonb)
    WHERE series_id = v_series_id AND name = 'Space Sheriff Gavan';
  ELSE
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Space Sheriff Gavan', 'Space Sheriff Gavan', 'Retsu Ichijouji', 'Kenji Ohba', 'Main Hero',
      'Hibrida Manusia - Planet Bird', 'Galactic Union Police',
      'Laser Blade, Laser Z Beam, Silver Beam, Combat Suit bertenaga partikel Granium dari kapal Dolgiran',
      'Perwira muda Galactic Union Police yang ditugaskan mempertahankan Bumi dari sindikat Makuu. Ia bertransformasi melalui proses vapor-deposition Jo-Chaku dalam 0,05 detik sambil mencari jejak ayahnya, Voicer.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan',
      '[
        {"label":"Tinggi","value":"200","unit":"cm"},
        {"label":"Berat","value":"90","unit":"kg"},
        {"label":"Lompatan maks","value":"150","unit":"m"},
        {"label":"Asal","value":"Planet Bird / Bumi","unit":""},
        {"label":"Peralatan khas","value":"Laser Blade & Dolgiran","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mimi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mimi', 'Mimi', 'Wakiko Kano', 'Ally',
      'Penduduk Planet Bird', 'Galactic Union Police',
      'Dapat berubah wujud menjadi burung parkit hijau untuk misi pengintaian dan komunikasi dengan Gavan.',
      'Putri Komandan Qom yang menjadi mitra setia Retsu Ichijouji di Bumi. Ia memantau pergerakan musuh dari ruang kendali kapal induk Dolgiran sekaligus membantu penyamaran Retsu di Klub Avalon.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Commander Qom', 'Commander Qom', 'Toshiaki Nishizawa', 'Ally',
      'Penduduk Planet Bird', 'Galactic Union Police',
      'Otoritas komando tertinggi Galactic Union Police serta pengarah strategi antarplanet.',
      'Komandan utama Galactic Union Police yang berkedudukan di Planet Bird dan menugaskan Gavan menjaga Bumi dari ancaman Makuu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Don Horror') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Don Horror', 'Takeshi Watabe', 'Villain',
      'Entitas Antariksa',
      'Manipulasi energi kegelapan, penciptaan ruang dimensi Makuu Space, dan kekuatan tempur wujud sejatinya di puncak kastel.',
      'Pemimpin tertinggi Space Crime Organization Makuu yang bercita-cita menaklukkan seluruh galaksi dan memonopoli perdagangan senjata ilegal dari balik takhtanya di Kastel Makuu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hunter Killer') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Hunter Killer', 'Michiro Iida', 'Villain',
      'Mantan Polisi Antariksa',
      'Kecerdasan taktis militer antariksa dan persenjataan blaster jarak jauh.',
      'Mantan rekan sesama Space Sheriff yang berkhianat dan menjadi komandan lapangan pertama Makuu di Bumi. Setelah disingkirkan oleh San Doruba, ia berbalik menebus kesalahannya dengan mengungkap lokasi ayah Gavan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'San Doruba') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'San Doruba', 'Ken Nishida', 'Villain',
      'Putra Don Horror',
      'Zirah merah bertenaga gelap dan tombak trisula yang menyimpan otak penyihir Queen Kiba.',
      'Putra Don Horror dan Queen Kiba yang dikirim menggantikan Hunter Killer pada paruh akhir seri untuk membasmi Gavan dengan strategi yang jauh lebih brutal.',
      NULL, 'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Queen Kiba') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Queen Kiba', 'Noboru Mitani', 'Villain',
      'Penyihir Antariksa',
      'Sihir hitam antariksa serta kemampuan membimbing putra kandungnya lewat trisula tempur.',
      'Ibunda San Doruba dan penyihir kejam Makuu yang berambisi menyingkirkan Gavan serta memperkuat cengkeraman Don Horror atas Bumi.',
      'https://en.wikipedia.org/wiki/Space_Sheriff_Gavan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kenji Ohba') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Kenji Ohba', '大葉 健二', 'Retsu Ichijouji / Space Sheriff Gavan', 'MC', v_series_id, 'Aktor laga legendaris Jepang dan alumni Japan Action Club yang memerankan Retsu Ichijouji tanpa pemeran pengganti dalam berbagai adegan aksi.');
  END IF;


  -- ===========================================================================
  -- 2. SPACE SHERIFF SHARIVAN (1983)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Sharivan' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Space Sheriff Sharivan', '宇宙刑事シャリバン', 'Metal Hero', 'Showa', 1983, '1983-03-04', '1984-02-24',
      51, 'Toei Company', 'Polisi Antariksa / Zirah Merah Tenaga Surya',
      'Sekuel langsung Gavan yang mengikuti Den Iga, mantan penjaga hutan yang diangkat menjadi Space Sheriff kedua dengan nama sandi Sharivan. Bersama mitra barunya Lily dari Planet Bird dan kapal induk raksasa Grand Birth, Den menghadapi sindikat kejahatan antardimensi Madou pimpinan Demon King Psycho sembari menyingkap rahasia garis keturunan Planet Iga miliknya.',
      NULL, 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '宇宙刑事シャリバン'),
      aired_from = COALESCE(aired_from, '1983-03-04'),
      aired_to   = COALESCE(aired_to, '1984-02-24'),
      episodes   = COALESCE(episodes, 51),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Polisi Antariksa / Zirah Merah Tenaga Surya'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Sharivan') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Space Sheriff Sharivan', 'Space Sheriff Sharivan', 'Den Iga', 'Hiroshi Watari', 'Main Hero',
      'Keturunan Planet Iga', 'Galactic Union Police',
      'Laser Blade (Sharivan Crash), Solar Metal Combat Suit lewat perintah Seki-Sha, Sharivan Scope, dan kapal induk Grand Birth',
      'Mantan penjaga hutan pemberani yang diselamatkan Gavan dan dilatih di Planet Bird untuk menggantikannya menjaga Bumi. Ia menemukan bahwa dalam dirinya mengalir darah keturunan kuno Planet Iga yang ditakuti sindikat Madou.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan',
      '[
        {"label":"Tinggi","value":"210","unit":"cm"},
        {"label":"Berat","value":"95","unit":"kg"},
        {"label":"Asal","value":"Keturunan Planet Iga / Bumi","unit":""},
        {"label":"Peralatan khas","value":"Laser Blade & Grand Birth","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Lily') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Lily', 'Lily', 'Yumiko Furuya', 'Ally',
      'Penduduk Planet Bird', 'Galactic Union Police',
      'Operasional sistem navigasi dan sensor kapal induk Grand Birth serta dukungan tempur ringan.',
      'Rekan resmi Sharivan dari Planet Bird yang menggantikan peran Mimi sebagai asisten operasional di Bumi dan mendukung Den dalam menelusuri misteri Kristal Iga.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Commander Qom', 'Commander Qom', 'Toshiaki Nishizawa', 'Ally',
      'Penduduk Planet Bird', 'Galactic Union Police',
      'Komando strategis Galactic Union Police dalam menghadapi sindikat kejahatan antargalaksi.',
      'Pemimpin tertinggi Galactic Union Police yang melatih Den Iga menjadi Sharivan setelah keberaniannya menyelamatkan anak-anak dari monster Makuu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Demon King Psycho') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Demon King Psycho', 'Shozo Iizuka', 'Villain',
      'Entitas Psikis',
      'Kekuatan psikokinesis raksasa, ilusi dimensi Genmukai, serta manipulasi jarak jauh lewat proyeksi mental.',
      'Penguasa tertinggi Space Crime Syndicate Madou yang mengincar kehancuran keturunan Iga agar rencananya menaklukkan alam semesta tak terhalang.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Gyrer') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'General Gyrer', 'Satoshi Kurihara', 'Villain',
      'Komandan Madou',
      'Kemampuan bela diri pedang berat serta komando pasukan Makai Beasts di lapangan.',
      'Jenderal lapangan ambisius milik sindikat Madou yang memimpin operasi penyerangan Bumi bersama Doctor Polter.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Doctor Polter') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Doctor Polter', 'Hitomi Yoshioka', 'Villain',
      'Ilmuwan & Ahli Okultisme Madou',
      'Ilmu hitam, manipulasi psikologis manusia, dan perancangan strategi sabotase ilmiah.',
      'Ilmuwan wanita kejam sekaligus ahli taktik sindikat Madou yang kerap bersaing dan bekerja sama dengan General Gyrer demi menjebak Sharivan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Sharivan'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroshi Watari') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hiroshi Watari', '渡 洋史', 'Den Iga / Space Sheriff Sharivan', 'MC', v_series_id, 'Aktor laga lulusan Japan Action Club yang menjadi wajah penting era awal Metal Hero sebagai pemeran utama Sharivan dan kelak Spielban.');
  END IF;


  -- ===========================================================================
  -- 3. SPACE SHERIFF SHAIDER (1984)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Shaider' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Space Sheriff Shaider', '宇宙刑事シャイダー', 'Metal Hero', 'Showa', 1984, '1984-03-02', '1985-03-08',
      49, 'Toei Company', 'Polisi Antariksa / Zirah Biru Legenda Mu',
      'Penutup trilogi Space Sheriff yang mengikuti Dai Sawamura, mahasiswa arkeologi yang berhasil memecahkan rahasia garis Nazca di Peru sehingga direkrut oleh Galactic Union Police menjadi Space Sheriff Shaider. Bersama rekannya Annie dan kapal induk Vavilos, ia melawan organisasi misterius Fuuma pimpinan Great Emperor Kublai yang berniat membangkitkan kekuasaan Kekaisaran Mu kuno.',
      NULL, 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '宇宙刑事シャイダー'),
      aired_from = COALESCE(aired_from, '1984-03-02'),
      aired_to   = COALESCE(aired_to, '1985-03-08'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Polisi Antariksa / Zirah Biru Legenda Mu'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Shaider') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Space Sheriff Shaider', 'Space Sheriff Shaider', 'Dai Sawamura', 'Hiroshi Tsuburaya', 'Main Hero',
      'Manusia', 'Galactic Union Police',
      'Laser Blade (Shaider Blue Flash), Video Beam Gun, Combat Suit Granium Alpha lewat perintah Shouketsu, dan kapal tempur Vavilos',
      'Mahasiswa arkeologi berbakat yang memecahkan aksara kuno Nazca sebelum dilatih di Planet Bird menjadi pewaris gelar prajurit legendaris Shaider. Ia memadukan kecerdasan riset sejarah dan teknik bela diri untuk menghadapi teror Fuuma.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider',
      '[
        {"label":"Tinggi","value":"210","unit":"cm"},
        {"label":"Berat","value":"95","unit":"kg"},
        {"label":"Asal","value":"Bumi","unit":""},
        {"label":"Peralatan khas","value":"Laser Blade, Video Beam Gun & Vavilos","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Annie') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Annie', 'Annie', 'Naomi Morinaga', 'Ally',
      'Alien (Planet Mount)', 'Galactic Union Police',
      'Penembak jitu pistol laser, seni bela diri akrobatik, serta pengemudi unit tempur Vavilos.',
      'Asisten polisi antariksa pemberani yang planet asalnya dihancurkan oleh Fuuma. Berbeda dari dua pendahulunya yang bekerja di ruang kendali, Annie aktif terjun langsung ke medan laga bersama Dai.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Commander Qom', 'Commander Qom', 'Toshiaki Nishizawa', 'Ally',
      'Penduduk Planet Bird', 'Galactic Union Police',
      'Pengarah misi Galactic Union Police serta koordinator lintas tiga Space Sheriff.',
      'Komandan tertinggi Galactic Union Police yang melatih dan memercayakan gelar prajurit legendaris Shaider kepada Dai Sawamura.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Great Emperor Kublai') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Great Emperor Kublai', 'Shozo Iizuka', 'Villain',
      'Entitas Kuno Kekaisaran Mu',
      'Sihir kuno, pengendalian dimensi Fushigi World, serta kekuatan kehancuran absolut dari tubuh kepala raksasa emasnya.',
      'Penguasa absolut Fushigi World Fuuma yang pernah memimpin Kekaisaran Mu ribuan tahun lalu sebelum ditaklukkan Shaider terdahulu dan kini berusaha bangkit menguasai Bumi.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Priest Poe') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Priest Poe', 'Jun Yoshida', 'Villain',
      'Pendeta Agung Fuuma',
      'Ritual sihir dimensi Fushigi, penciptaan Fushigi Beasts, serta kemampuan manipulasi kejiwaan.',
      'Pendeta tinggi eksentrik kepercayaan Kublai yang merancang sebagian besar rencana aneh serta kebangkitan monster-monster Fushigi di Bumi.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Hessler') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Commander Hessler', 'Kazuhiko Kubo', 'Villain',
      'Prajurit Fuuma',
      'Keahlian pedang jarak dekat, komando pasukan serbu, dan pengendalian pesawat tempur Fuuma.',
      'Komandan militer lapangan Fuuma yang sering berduel langsung dengan Shaider serta berambisi merebut penghargaan tertinggi Kublai.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Space_Sheriff_Shaider'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroshi Tsuburaya') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hiroshi Tsuburaya', '円谷 浩', 'Dai Sawamura / Space Sheriff Shaider', 'MC', v_series_id, 'Cucu maestro efek khusus Eiji Tsuburaya yang dikenal luas melalui perannya sebagai Dai Sawamura dalam penutup trilogi Space Sheriff.');
  END IF;


  -- ===========================================================================
  -- 4. KYOJUU TOKUSOU JUSPION (1985)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kyojuu Tokusou Juspion' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kyojuu Tokusou Juspion', '巨獣特捜ジャスピオン', 'Metal Hero', 'Showa', 1985, '1985-03-15', '1986-03-24',
      46, 'Toei Company', 'Penyelidik Monster Raksasa / Robot Tempur',
      'Serial keempat Metal Hero yang mengangkat kisah Juspion, yatim piatu luar angkasa yang dibesarkan oleh pertapa bijak Ejin demi menghentikan ramalan kehancuran semesta oleh dewa kegelapan Satan Gorth. Bersama android Anri, makhluk mungil Miya, dan kapal tempur yang dapat berubah menjadi robot raksasa Daileon, Juspion menumpas para Megabeast buas serta menghadapi rival bebuyutannya, Mad Gallant.',
      NULL, 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '巨獣特捜ジャスピオン'),
      aired_from = COALESCE(aired_from, '1985-03-15'),
      aired_to   = COALESCE(aired_to, '1986-03-24'),
      episodes   = COALESCE(episodes, 46),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Penyelidik Monster Raksasa / Robot Tempur'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Juspion') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Juspion', 'Juspion', 'Juspion', 'Hikaru Kurosaki', 'Main Hero',
      'Manusia (Yatim Piatu Antariksa)',
      'Metal Tec Suit berbahan metal Ejin, pedang Spadium Laser, Beam Scanner Gun, dan robot raksasa Daileon (Cosmic Crash)',
      'Pemuda liar yang dibesarkan sang nabi Ejin di planet terpencil dan dipercaya menunaikan ramalan Galaxy Bible untuk membasmi ancaman Megabeast yang dibangkitkan Satan Gorth.',
      'Episode 1', 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion',
      '[
        {"label":"Asal","value":"Luar Angkasa (Diasuh di Planet Ejin)","unit":""},
        {"label":"Peralatan khas","value":"Metal Tec Suit, Spadium Laser & Daileon","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Anri') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Anri', 'Anri', 'Kiyomi Tsukada', 'Ally',
      'Android',
      'Analisis komputer antariksa, navigasi Daileon, dan pertahanan diri dasar.',
      'Android pendamping ciptaan Ejin yang setia menemani Juspion menjelajahi galaksi hingga tiba di Bumi untuk melawan pasukan Satan Gorth.',
      'Episode 1', 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ejin') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Ejin', 'Ejin', 'Noboru Nakaya', 'Ally',
      'Pertapa Antariksa',
      'Pengetahuan mendalam tentang Galaxy Bible serta penciptaan teknologi Metal Tec Suit dan robot Daileon.',
      'Ilmuwan sekaligus pertapa antariksa yang menyelamatkan Juspion kecil, membekalinya persenjataan canggih, dan memandu pencariannya akan lima anak pemilik cahaya Burung Emas.',
      'Episode 1', 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Boomerang') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Boomerang', 'Boomerang', 'Hiroshi Watari', 'Ally',
      'Manusia (Polisi Interpol)',
      'Bela diri akrobatik dan lemparan senjata bumerang tajam.',
      'Mantan petugas Interpol pemberani yang bekerja sama dengan Juspion di Bumi untuk membongkar jaringan penyelundupan kejahatan yang didalangi Mad Gallant.',
      'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mad Gallant') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Mad Gallant', 'Jun''ichi Haruta', 'Villain',
      'Cyborg / Anak Angkat Satan Gorth',
      'Zirah hitam tandingan Metal Tec Suit dan pedang kegelapan berkecepatan tinggi.',
      'Putra angkat sekaligus komandan utama pasukan Satan Gorth yang memiliki kemampuan bertarung seimbang dengan Juspion dan menjadi rival abadinya sepanjang seri.',
      'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Satan Gorth') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Satan Gorth', 'Shozo Iizuka', 'Villain',
      'Entitas Kegelapan Kosmik',
      'Energi kegelapan yang mampu membuat monster raksasa menjadi buas serta bertransformasi menjadi raksasa sejati Daileon-class.',
      'Dewa iblis kosmik dari ramalan Galaxy Bible yang membangunkan para Megabeast demi membangun Kekaisaran Megabeast di Bumi dan melenyapkan kehidupan damai.',
      'Episode 1', 'https://en.wikipedia.org/wiki/MegaBeast_Investigator_Juspion'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hikaru Kurosaki') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hikaru Kurosaki', '黒崎 輝', 'Juspion', 'MC', v_series_id, 'Aktor aksi populer tahun 1980-an yang memerankan tokoh utama Juspion yang sangat ikonik di Jepang maupun Amerika Latin.');
  END IF;


  -- ===========================================================================
  -- 5. JIKUU SENSHI SPIELBAN (1986)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Jikuu Senshi Spielban' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Jikuu Senshi Spielban', '時空戦士スピルバン', 'Metal Hero', 'Showa', 1986, '1986-04-07', '1987-03-09',
      44, 'Toei Company', 'Prajurit Ruang Waktu / Kristal',
      'Setelah planet asal mereka Clin dihancurkan oleh Kekaisaran Waller yang haus sumber air bersih, dua anak bernama Spielban dan Diana dikirim ke Bumi di atas kapal perang Gran Nasca. Bertahun-tahun kemudian ketika Waller mulai mengincar Bumi, keduanya bangun menjadi prajurit berlapis kristal untuk menumpas Ratu Pandora sekaligus berjuang menyelamatkan ayah dan kakak Spielban yang dicuci otak oleh musuh.',
      NULL, 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '時空戦士スピルバン'),
      aired_from = COALESCE(aired_from, '1986-04-07'),
      aired_to   = COALESCE(aired_to, '1987-03-09'),
      episodes   = COALESCE(episodes, 44),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Prajurit Ruang Waktu / Kristal'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Spielban') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Spielban', 'Spielban', 'Yousuke Jou', 'Hiroshi Watari', 'Main Hero',
      'Penduduk Planet Clin',
      'Zirah Hi-Tech Crystal bertenaga Kesshou, Twin Blade (Arc Impulse), Sniper gun, dan kapal induk Gran Nasca',
      'Penyintas Planet Clin yang menyamar sebagai pemuda Bumi bernama Yousuke Jou setelah terbangun dari tidur panjang kriogenik. Ia memburu Kekaisaran Waller demi melindungi sumber air Bumi dan membebaskan keluarganya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban',
      '[
        {"label":"Asal","value":"Planet Clin","unit":""},
        {"label":"Peralatan khas","value":"Twin Blade & Gran Nasca","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Diana Lady') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Diana Lady', 'Diana Lady', 'Diana', 'Makoto Sumikawa', 'Ally',
      'Penduduk Planet Clin',
      'Zirah Crystal perempuan berwarna putih-ungu, senjata Diana Sniper, dan kemampuan bela diri cepat.',
      'Sahabat masa kecil Spielban dari Planet Clin yang sama-sama lolos menggunakan Gran Nasca dan bertempur di sisinya sebagai Diana Lady.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Helen Lady') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Helen Lady', 'Helen Lady', 'Helen', 'Naomi Morinaga', 'Ally',
      'Penduduk Planet Clin',
      'Zirah hitam-perak Helen Lady setelah bebas dari kendali Hellvira serta keahlian tempur jarak dekat.',
      'Kakak kandung Spielban yang diculik Kekaisaran Waller saat kehancuran Clin dan sempat dicuci otak menjadi pembunuh dingin Hellvira sebelum terselamatkan dan berjuang bersama kedua sahabatnya.',
      'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Doctor Bio') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Doctor Bio', 'Doctor Ben', 'Ichiro Mizuki', 'Villain',
      'Cyborg (Mantan Ilmuwan Clin)',
      'Rekayasa bioteknologi, penciptaan monster bio-mechanoid, serta naluri ilmiah yang tetap tersisa bagi putri sulungnya.',
      'Ayah kandung Spielban dan Helen yang diculik Waller dan dimodifikasi menjadi ilmuwan sibernetik Doctor Bio tanpa ingatan masa lalu, meski diam-diam masih menyayangi Helen.',
      'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Queen Pandora') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Queen Pandora', 'Machiko Soga', 'Villain',
      'Penguasa Kekaisaran Waller',
      'Sihir kejam, tipu daya politik di balik kedok Dewa Waller, serta pengendalian pasukan invasi antargalaksi.',
      'Penguasa kejam Kekaisaran Waller yang menghancurkan Planet Clin dan memerintahkan perampasan air Bumi sambil memanipulasi jenderal-jenderalnya atas nama entitas Waller.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'General Deathzero') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'General Deathzero', 'Shozo Iizuka', 'Villain',
      'Jenderal Sibernetik Waller',
      'Komandan pasukan Machine Mechanoids serta kekuatan bertarung jarak dekat menggunakan pedang energi berat.',
      'Jenderal lapangan utama Waller Empire pada paruh pertama seri yang memimpin serangan pasukan mesin terhadap Bumi sebelum posisi kekuasaannya terguncang oleh kedatangan Emperor Guillotine.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Jikuu_Senshi_Spielban'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroshi Watari') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hiroshi Watari', '渡 洋史', 'Yousuke Jou / Spielban', 'MC', v_series_id, 'Pemeran utama kedua kalinya di jajaran Metal Hero Showa setelah Sharivan, memerankan Yousuke Jou dalam kisah bernuansa fiksi ilmiah kelam.');
  END IF;


  -- ===========================================================================
  -- 6. CHOUJINKI METALDER (1987)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Choujinki Metalder' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Choujinki Metalder', '超人機メタルダー', 'Metal Hero', 'Showa', 1987, '1987-03-16', '1988-01-17',
      39, 'Toei Company', 'Android Perang / Asimetris Merah-Biru',
      'Diciptakan pada akhir Perang Dunia II oleh Dr. Ryuichiro Koga berdasarkan mendiang putranya, android tempur canggih Metalder baru diaktifkan lebih dari empat dekade kemudian demi menghentikan Kekaisaran Neros yang menguasai bayang-bayang ekonomi dunia. Mengambil identitas Ryusei Tsurugi, Metalder bergulat antara nurani manusiawi dan fungsi mesinnya sambil menghadapi empat divisi pasukan Neros.',
      NULL, 'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '超人機メタルダー'),
      aired_from = COALESCE(aired_from, '1987-03-16'),
      aired_to   = COALESCE(aired_to, '1988-01-17'),
      episodes   = COALESCE(episodes, 39),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Android Perang / Asimetris Merah-Biru'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Choujinki_Metalder')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Metalder') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Metalder', 'Metalder', 'Ryusei Tsurugi', 'Akira Seno', 'Main Hero',
      'Android (Choujinki)',
      'Laser Arm, Plasma Punch, G-Kick, bertenaga energi surya serta sistem emosi yang bangkit lewat amarah terhadap kejahatan',
      'Android perang rahasia ciptaan Dr. Koga yang dibangkitkan di era modern untuk melawan Kekaisaran Neros. Berbekal amarah setelah kematian sang pencipta, ia belajar memahami arti kebebasan manusia dan pengorbanan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Choujinki_Metalder',
      '[
        {"label":"Tinggi","value":"190","unit":"cm"},
        {"label":"Berat","value":"250","unit":"kg"},
        {"label":"Kekuatan Pukulan","value":"1.0","unit":"ton"},
        {"label":"Kekuatan Tendangan","value":"2.0","unit":"ton"},
        {"label":"Lompatan maks","value":"150","unit":"m"},
        {"label":"Lari 100 m","value":"1.5","unit":"detik"},
        {"label":"Peralatan khas","value":"Laser Arm","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mai Ougi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mai Ougi', 'Mai Ougi', 'Hiroko Aota', 'Ally',
      'Manusia',
      'Fotografi investigasi majalah Weekly Up serta dukungan moril bagi Ryusei Tsurugi.',
      'Fotografer majalah yang menjadi sahabat manusia pertama Metalder dan secara tak sengaja terseret membongkar konspirasi Kekaisaran Neros di balik perusahaan konglomerat Kirihara.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Springer') THEN
    INSERT INTO characters (series_id, name, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Springer', 'Ally',
      'Robot Anjing',
      'Navigasi pangkalan Silver Carcass, analisis taktis medan tempur, serta perawatan sistem Metalder.',
      'Robot anjing setia ciptaan Dr. Koga yang dapat berbicara, bertugas merawat markas rahasia Silver Carcass sekaligus menjadi penasihat cerdas bagi Ryusei.',
      'Episode 2', 'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Top Gunder') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Top Gunder', 'Takeshi Kuwahara', 'Ally',
      'Robot Tempur (Mantan Neros)',
      'Senapan laser jarak jauh berakurasi tinggi serta kecepatan menembak luar biasa.',
      'Prajurit penembak jitu dari Divisi Robot Kekaisaran Neros yang menjunjung tinggi kehormatan duel sejati. Ia perlahan memberontak terhadap kelicikan Neros dan berbalik menjadi sekutu terpercaya Metalder.',
      'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'God Neros') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'God Neros', 'Gozo Kirihara', 'Shinji Todo', 'Villain',
      'Manusia Termodifikasi Alkimia',
      'Kontrol ekonomi global, kendali penuh empat divisi tempur Neros dari benteng Ghost Bank, dan kekuatan bertarung super.',
      'Mantan asisten Dr. Koga yang memperpanjang usianya memakai ilmu alkimia dan menyamar sebagai konglomerat dermawan Gozo Kirihara untuk mengendalikan kejahatan dunia sebagai God Neros.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Coolgin') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Coolgin', 'Atsuo Mori', 'Villain',
      'Ksatria Zirah Divisi Armored',
      'Bela diri pedang kilat serta kepemimpinan tertinggi Divisi Armored Neros.',
      'Tangan kanan paling loyal dan kejam milik God Neros sekaligus pemimpin Pasukan Berzirah yang terus berusaha membasmi Metalder sampai runtuhnya benteng Ghost Bank.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Choujinki_Metalder'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Akira Seno') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Akira Seno', '妹尾 青洸', 'Ryusei Tsurugi / Metalder', 'MC', v_series_id, 'Pemeran Ryusei Tsurugi yang membawakan pergulatan batin emosional antara identitas manusia dan mesin android.');
  END IF;


  -- ===========================================================================
  -- 7. SEKAI NINJA SEN JIRAIYA (1988)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Sekai Ninja Sen Jiraiya' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Sekai Ninja Sen Jiraiya', '世界忍者戦ジライヤ', 'Metal Hero', 'Showa', 1988, '1988-01-24', '1989-01-22',
      50, 'Toei Company', 'Ninja Modern / Seni Ninjutsu Dunia',
      'Satu-satunya serial Metal Hero era Showa yang mengusung tema seni bela diri ninja tradisional. Toha Yamaji, pewaris muda aliran Togakure-ryu Ninpo, mengenakan baju zirah pelindung Jiraiya untuk mempertahankan rahasia harta karun luar angkasa Pako dari incaran Klan Penyihir pimpinan Oninin Dokusai dan puluhan master ninja pemburu dari seluruh dunia.',
      NULL, 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '世界忍者戦ジライヤ'),
      aired_from = COALESCE(aired_from, '1988-01-24'),
      aired_to   = COALESCE(aired_to, '1989-01-22'),
      episodes   = COALESCE(episodes, 50),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Ninja Modern / Seni Ninjutsu Dunia'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Jiraiya') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url, extra_stats)
    VALUES (
      v_series_id, 'Jiraiya', 'Jiraiya', 'Toha Yamaji', 'Takumi Tsutsui', 'Main Hero',
      'Manusia', 'Togakure-ryu Ninpo',
      'Jiraiya Suit, Magnetic Light Sword (Jikoushin Ken - Magnet Flash Split), dan patung dewa raksasa Jiraishin',
      'Pemuda pemberani yang diadopsi dan dididik oleh guru besar Tetsuzan Yamaji dalam tradisi Togakure-ryu Ninpo. Ia mengemban tugas menjaga peta Pako sambil menghadapi perang ninja antarbangsa.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya',
      '[
        {"label":"Asal","value":"Jepang (Aliran Togakure-ryu)","unit":""},
        {"label":"Peralatan khas","value":"Magnetic Light Sword & Jiraishin","unit":""}
      ]'::jsonb
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Himenin Emiha') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Himenin Emiha', 'Himenin Emiha', 'Kei Yamaji', 'Megumi Sekiguchi', 'Ally',
      'Manusia', 'Togakure-ryu Ninpo',
      'Teknik ninjutsu wanita Togakure dan keahlian belati tersembunyi.',
      'Adik angkat Toha Yamaji yang juga berlatih keras sebagai kunoichi aliran Togakure untuk mendukung perjuangan keluarganya menjaga Pako.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tetsuzan Yamaji') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Tetsuzan Yamaji', 'Tetsuzan Yamaji', 'Masaaki Hatsumi', 'Ally',
      'Manusia', 'Togakure-ryu Ninpo',
      'Penguasaan tertinggi seni ninjutsu Togakure-ryu sebagai Grandmaster ke-34.',
      'Guru besar sekaligus ayah angkat Toha dan ayah kandung Manabu yang membimbing para pewaris muda Togakure menghadapi ancaman Klan Penyihir.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kinin Reiha') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kinin Reiha', 'Kinin Reiha', 'Rei Yagyu', 'Tomoko Taya', 'Ally',
      'Manusia', 'Polisi Rahasia Internasional',
      'Teknik penyusupan ninjutsu Yagyu dan persenjataan rahasia intelejen internasional.',
      'Agen polisi rahasia internasional sekaligus kunoichi terampil yang sering turun membantu Jiraiya menyelidiki keterlibatan ninja asing.',
      'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Manabu Yamaji') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Manabu Yamaji', 'Manabu Yamaji', 'Takumi Hashimoto', 'Ally',
      'Manusia', 'Togakure-ryu Ninpo',
      'Semangat muda calon ninja Togakure serta kepiawaian menyusup di situasi tak terduga.',
      'Putra bungsu Tetsuzan yang ceria dan penuh rasa ingin tahu. Meski masih kecil, keberaniannya kerap membantu Toha membongkar penyamaran musuh.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Oninin Dokusai') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Oninin Dokusai', 'Noriaki Kaneda', 'Villain',
      'Pemimpin Klan Penyihir (Yoma Clan)',
      'Sihir kuno Klan Penyihir, ilmu pedang gelap, dan strategi pemecah belah antar-ninja dunia.',
      'Pemimpin bertopeng iblis dari Klan Penyihir yang telah lama mendambakan kekuatan harta karun kosmik Pako demi menguasai dunia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Benikiba') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Benikiba', 'Hiromi Nohara', 'Villain',
      'Kunoichi Klan Penyihir',
      'Ilmu ninjutsu racun bermotif kupu-kupu, ilusi bayangan, dan kelincahan serangan jarak dekat.',
      'Salah satu panglima wanita terkejam di Klan Penyihir yang setia melayani Dokusai dan sering memimpin langsung penyergapan terhadap keluarga Yamaji.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Space Ninja Demost') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, source_url)
    VALUES (
      v_series_id, 'Space Ninja Demost', 'Eisuke Yoda', 'Villain',
      'Ninja Luar Angkasa (Youma-ou)',
      'Ninjutsu antariksa berusia lebih dari dua milenium dan kekuatan penghancur luar biasa.',
      'Ninja luar angkasa kuno berusia 2.300 tahun yang kembali bangkit pada paruh kedua seri sebagai ancaman terbesar di balik artefak Pako.',
      'https://en.wikipedia.org/wiki/Sekai_Ninja_Sen_Jiraiya'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Takumi Tsutsui') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Takumi Tsutsui', '筒井 巧', 'Toha Yamaji / Jiraiya', 'MC', v_series_id, 'Aktor sekaligus pengisi suara Jepang yang memerankan Toha Yamaji dalam seluruh seri Sekai Ninja Sen Jiraiya serta kembali tampil di film reuni bertahun-tahun kemudian.');
  END IF;

END $$;
