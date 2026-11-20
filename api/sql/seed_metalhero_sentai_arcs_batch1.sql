-- =============================================================================
-- SEED ARCS BATCH 1: METAL HERO ERA SHOWA (1982 - 1989)
-- IDEMPOTEN: ON CONFLICT (series_id, arc_order) DO NOTHING
-- Tidak menimpa arc yang sudah ada atau diedit manual.
-- Hubungkan karakter lewat arc_characters (ON CONFLICT DO NOTHING).
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
  v_arc_id INT;
  v_c1 INT;
  v_c2 INT;
  v_c3 INT;
  v_c4 INT;
  v_c5 INT;
  v_c6 INT;
  v_c7 INT;
  v_c8 INT;
BEGIN

  -- ===========================================================================
  -- 1. SPACE SHERIFF GAVAN (1982) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Gavan' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Gavan' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Mimi' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Don Horror' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Hunter Killer' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'San Doruba' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Queen Kiba' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Penugasan Bumi & Teror Ruang Makuu',
      'Episode 01–14',
      E'Organisasi kejahatan antariksa Makuu pimpinan Don Horror menjadikan Bumi target penaklukan berikutnya. Galactic Union Police menugaskan Retsu Ichijouji alias Space Sheriff Gavan untuk turun ke planet asal ibunya tersebut dengan menyamar sebagai pekerja sipil.\n\nDengan dukungan Mimi di atas kapal induk Dolgiran serta bimbingan Komandan Qom, Gavan berulang kali menghadapi jebakan komandan pengkhianat Hunter Killer yang menariknya masuk ke dimensi penguat monster, Makuu Space.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengemban misi pertama menjaga Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Membantu pemantauan radar di Dolgiran') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menugaskan Retsu ke Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Memimpin operasi lapangan awal Makuu') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Jejak Ayah yang Hilang & Penurunan Hunter Killer',
      'Episode 15–29',
      E'Selain melindungi warga Bumi dari eksperimen keji Monster Ganda Makuu, Retsu tak henti menelusuri petunjuk hilangnya sang ayah, Voicer, seorang mantan Space Sheriff yang dulu berjuang melawan sindikat tersebut.\n\nRentetan kegagalan Hunter Killer untuk menghabisi Gavan membuat posisinya di Makuu terus tergerus hingga Don Horror mulai menyiapkan komandan pengganti yang lebih kejam.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menemukan petunjuk nasib ayahnya Voicer') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Kehilangan kesabaran terhadap kegagalan komandannya') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Disingkirkan dari tampuk komando lapangan Makuu') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kedatangan San Doruba & Queen Kiba',
      'Episode 30–39',
      E'Putra Don Horror bernama San Doruba bersama ibunya, penyihir Queen Kiba, tiba mengambil alih kendali serangan lapangan Makuu. Kehadiran duo baru ini membawa ancaman senjata gelap trisula yang menyimpan otak Queen Kiba serta Monster Ganda yang lebih berbahaya.\n\nDi fase ini, Gavan juga menyelamatkan penjaga hutan pemberani bernama Den Iga yang terluka parah, membuka jalan lahirnya penerus Space Sheriff masa depan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menyelamatkan Den Iga & menghadapi strategi San Doruba') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Mengambil alih komando serangan Makuu') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Membekali putranya dengan ilmu sihir trisula') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kastel Makuu Runtuh & Lahirnya Sharivan',
      'Episode 40–44',
      E'Sebelum ajalnya tiba, Hunter Killer menebus pengkhianatannya dengan memberi informasi penting mengenai tempat penawanan Voicer. Setelah bersatu kembali secara haru meski akhirnya kehilangan sang ayah, tekad Gavan memuncak.\n\nGavan menghancurkan San Doruba serta Queen Kiba, lalu menyerbu langsung pusat Kastel Makuu dengan bantuan Space Sheriff baru, Sharivan (Den Iga), dan mengakhiri ambisi Don Horror untuk selamanya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menyerbu Kastel Makuu & menumpas Don Horror') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengoperasikan Dolgiran di pertempuran penentu') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Dikalahkan Gavan dalam pertempuran akhir') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Menebus dosa sebelum wafat dengan membantu Retsu') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 2. SPACE SHERIFF SHARIVAN (1983) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Sharivan' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Sharivan' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Lily' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Demon King Psycho' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'General Gyrer' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Doctor Polter' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Penjaga Bumi Baru & Sindikat Madou',
      'Episode 01–15',
      E'Setelah kejatuhan Makuu dan promosi Gavan sebagai kapten Galactic Union Police sektor lain, Den Iga ditugaskan resmi menjadi pelindung Bumi sebagai Space Sheriff Sharivan bersama mitra barunya, Lily.\n\nMereka langsung berhadapan dengan sindikat kejahatan psikis baru bernama Madou pimpinan Demon King Psycho yang memanfaatkan dunia ilusi Genmukai lewat kaki tangannya, General Gyrer dan Doctor Polter.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memulai tugas sebagai Space Sheriff pelindung Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bertugas mendampingi Den di atas Grand Birth') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memulai invasi tersembunyi dari Istana Genmu') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Warisan Keturunan Iga & Kristal Iga',
      'Episode 16–30',
      E'Penyelidikan atas rentetan operasi Madou membuka tabir masa lalu Den Iga yang ternyata berasal dari garis keturunan kuno Planet Iga—bangsa pejuang cahaya yang mengungsi ke Bumi dua ribu tahun silam.\n\nSharivan dan Lily mulai mengumpulkan pecahan Kristal Iga serta bertemu sesama penyintas ras Iga sembari terus menangkis siasat kotor Doctor Polter maupun gempuran fisik General Gyrer.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menelusuri asal-usul leluhur Planet Iga') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Memimpin pengejaran terhadap para pewaris Iga') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Merancang jebakan psikologis bagi sekutu Sharivan') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Persaingan Panglima Madou & Kebangkitan Kekuatan Iga',
      'Episode 31–44',
      E'Ketegangan internal di Istana Genmu meningkat tajam seiring ambisi pribadi General Gyrer dan kelicikan Doctor Polter untuk meraih posisi tertinggi di sisi Demon King Psycho.\n\nDi pihak lain, hubungan kerja sama Den Iga dengan sesama keturunan Planet Iga dan bimbingan Komandan Qom serta Gavan kian memperkuat tekadnya untuk mengakhiri kejahatan Madou sebelum Kristal Iga jatuh ke tangan yang salah.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memperkuat penguasaan energi surya & Kristal Iga') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyalurkan dukungan penuh dari Planet Bird') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Terlibat intrik kekuasaan melawan Polter') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Serbuan Terakhir ke Istana Genmu',
      'Episode 45–51',
      E'Mendekati babak akhir, rahasia utama istana musuh dan keberadaan Demon King Psycho terkuak seluruhnya. Doctor Polter dan General Gyrer tumbang satu per satu dalam perlawanan sengit sebelum benteng utama Madou dimasuki.\n\nDengan dukungan Gavan di sisi tempurnya, Sharivan melepaskan jurus pamungkas untuk memusnahkan Demon King Psycho serta menghancurkan Istana Genmu demi mengembalikan kedamaian Planet Iga dan Bumi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menumpas Psycho & memulihkan kejayaan Planet Iga') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengendalikan Grand Birth di serangan pamungkas') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Dihancurkan di klimaks penyerbuan Istana Genmu') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Tumbang menjelang keruntuhan Madou') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 3. SPACE SHERIFF SHAIDER (1984) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Space Sheriff Shaider' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Space Sheriff Shaider' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Annie' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Commander Qom' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Great Emperor Kublai' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Priest Poe' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Commander Hessler' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Pewaris Prajurit Kuno & Teror Dunia Fushigi',
      'Episode 01–13',
      E'Mahasiswa arkeologi Dai Sawamura dipilih Galactic Union Police menjadi Space Sheriff Shaider setelah memecahkan sandi purba Garis Nazca di Peru. Ia dipasangkan dengan perwira lapangan tangguh Annie yang planet asalnya telah dirusak organisasi kultus Fuuma.\n\nBerbeda dengan musuh dua pendahulunya, Fuuma pimpinan Great Emperor Kublai melancarkan kekacauan berselimut ritual surealis dan monster-monster aneh Fushigi Beasts demi mencuci pikiran masyarakat.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengambil mandat sebagai Space Sheriff Shaider') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Terjun langsung bertarung mendampingi Shaider') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Mengatur sihir dan strategi kultus Fuuma') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Jejak Kekaisaran Mu & Perlawanan Hessler',
      'Episode 14–28',
      E'Seiring berjalannya investigasi arkeologis Dai, hubungan langsung antara Fuuma dan kejayaan Kekaisaran Mu 12.000 tahun lalu makin terungkap lewat berbagai artefak dan aksara prasejarah.\n\nKomandan Hessler mengerahkan serbuan taktis dan pasukan elite wanita Gal Force untuk memojokkan Dai maupun Annie, memaksa keduanya terus mengandalkan kelincahan unit kendaraan Vavilos serta kerja sama erat di lapangan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengungkap peninggalan peradaban Mu') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Berduel langsung dengan agen Gal Force') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Memimpin gempuran militer Fuuma') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Ritual Kegelapan Poe & Krisis Anak Muda Bumi',
      'Episode 29–42',
      E'Memasuki paruh akhir, Priest Poe memperluas pengaruh kultus Fuuma melalui operasi pencucian otak terorganisasi yang menyasar generasi muda serta kebangkitan kekuatan sihir kuno Kublai.\n\nKomandan Qom dari Planet Bird terus memperbarui koordinasi keamanan semesta sementara Shaider menyingkap makna sejati pengorbanan sang prajurit Shaider pertama yang dahulu meruntuhkan Kekaisaran Mu.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Memberi arahan strategis menjelang puncak konflik') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Mempercepat persiapan kebangkitan penuh') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Melancarkan siasat pencucian otak berskala luas') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kejatuhan Kublai & Pertemuan Tiga Space Sheriff',
      'Episode 43–49',
      E'Setelah menaklukkan Commander Hessler dan menyaksikan kehancuran Priest Poe, Shaider serta Annie menyerbu langsung istana dimensi Fushigi untuk mengakhiri kekuasaan Great Emperor Kublai pada Episode 48.\n\nEpisode 49 menutup trilogi bersejarah ini dengan pertemuan akbar Retsu Ichijouji (Gavan), Den Iga (Sharivan), dan Dai Sawamura (Shaider) yang merayakan kemenangan Galactic Union Police menjaga perdamaian galaksi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengalahkan Kublai & bergabung bersama dua seniornya') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bertarung menumpas sisa pasukan Istana Fushigi') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Dimusnahkan di pertempuran penentu Episode 48') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Tumbang menjelang serangan ke markas Fuuma') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 4. KYOJUU TOKUSOU JUSPION (1985) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kyojuu Tokusou Juspion' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Juspion' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Anri' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Ejin' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Boomerang' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Mad Gallant' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Satan Gorth' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Ramalan Galaxy Bible & Pengembaraan Awal',
      'Episode 01–12',
      E'Pertapa Ejin membaca ramalan mengerikan di Galaxy Bible tentang bangkitnya Satan Gorth yang membangunkan para Megabeast. Ia mengutus Juspion bersama android Anri, Miya, dan kapal robot Daileon untuk memulai perjalanan melintasi planet-planet.\n\nSetibanya di Bumi, Juspion menghadapi pasukan anak angkat Satan Gorth, Mad Gallant, serta menerima bantuan mantan agen Interpol tangguh bernama Boomerang.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memulai misi Galaxy Bible hingga tiba di Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengoperasikan sistem navigasi Daileon') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyerahkan Metal Tec Suit & Daileon kepada Juspion') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membantu Juspion membongkar sindikat kejahatan') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Pencarian Lima Anak Burung Emas',
      'Episode 13–28',
      E'Mengetahui bahwa penyihir jahat seperti Kilza ikut memperburuk kegilaan para Megabeast, Juspion berpacu dengan waktu menyingkap rahasia ramalan Galaxy Bible mengenai keberadaan lima anak suci yang terhubung dengan kekuatan Burung Emas.\n\nMad Gallant berkali-kali turun langsung berduel pedang melawan Juspion demi mematahkan harapan munculnya kekuatan suci tersebut.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memburu petunjuk lima anak pemilik cahaya') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Menjegal pencarian melalui duel langsung') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Membangkitkan para Megabeast ganas di Bumi') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Wujud Sejati Satan Gorth & Kembalinya Boomerang',
      'Episode 29–39',
      E'Satan Gorth akhirnya melepaskan zirah luarnya untuk memamerkan wujud sejati berdaya hancur luar biasa yang jauh melampaui kekuatan tempur standar Daileon. Sementara itu, keluarga Nambara juga terus setia melindungi anak-anak kunci ramalan.\n\nBoomerang kembali turun membantu Juspion menyusup ke rencana jahat Mad Gallant saat ancaman Kekaisaran Megabeast kian dekat pada klimaksnya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Terdesak menghadapi evolusi wujud Satan Gorth') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Kembali bertempur di fase krisis') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Memperlihatkan kekuatan sejati penakluk galaksi') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Pedang Burung Emas & Kehancuran Kekaisaran Megabeast',
      'Episode 40–46',
      E'Setelah Ejin mengorbankan diri dan seluruh petunjuk Galaxy Bible menyatu lewat lima anak terpilih, kekuatan suci Burung Emas menempa pedang raksasa bagi Daileon. Di Episode 45, Juspion akhirnya menumbangkan rival terberatnya, Mad Gallant.\n\nPada episode penutup ke-46, Juspion mengendalikan Daileon berpedang emas untuk memusnahkan Satan Gorth untuk selamanya serta membawa perdamaian baru di galaksi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menumbangkan Mad Gallant & Satan Gorth') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mendampingi Juspion hingga akhir perang') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Tumbang di duel penentu Episode 45') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Dikalahkan pedang emas Daileon di Episode 46') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 5. JIKUU SENSHI SPIELBAN (1986) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Jikuu Senshi Spielban' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Spielban' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Diana Lady' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Helen Lady' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Doctor Bio' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Queen Pandora' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'General Deathzero' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Pelarian dari Planet Clin & Invasi Waller',
      'Episode 01–12',
      E'Planet Clin yang kaya air bersih dihancurkan Kekaisaran Waller pimpinan Ratu Pandora. Spielban dan sahabatnya Diana lolos ke Bumi di atas kapal induk Gran Nasca, lalu terbangun bertahun-tahun kemudian ketika Waller mulai mengincar sumber air Bumi.\n\nSaat menghadapi serbuan pasukan mekanik pimpinan General Deathzero, Spielban tersiksa secara batin setelah mengetahui bahwa ilmuwan kejam musuh, Doctor Bio, dan pembunuh Hellvira sesungguhnya adalah ayah serta kakaknya sendiri.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memulai perlawanan melawan Waller demi melindungi air Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bertarung sebagai Diana Lady mendampingi Spielban') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Mengomandoi invasi perampasan air Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Memimpin pasukan mesin pada fase pembuka') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Tragedi Keluarga Clin: Helen dan Doctor Bio',
      'Episode 13–23',
      E'Spielban berusaha keras menjangkau hati kakak kandungnya Helen yang terkekang manipulasi otak sebagai prajurit musuh Hellvira, sementara ayahnya tetap bekerja tanpa ingatan sebagai sibernetik Doctor Bio.\n\nMeski kendali Doctor Bio sempat membayangi konflik ini, naluri kasih ayah yang masih tersisa diam-diam membuat perubahan besar hingga Helen perlahan terlepas dari cengkeraman pencucian otak Waller.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Berjuang membebaskan kakak dan ayahnya dari Waller') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Terombang-ambing antara kendali musuh dan jati dirinya') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Mempertahankan sisa naluri kebapakan di tengah modifikasi kejam') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kedatangan Emperor Guillotine & Kebangkitan Helen Lady',
      'Episode 24–36',
      E'Dinamika kekuasaan di tubuh Kekaisaran Waller berubah drastis sekitar Episode 24 saat Emperor Guillotine datang dari abad ke-23 membawa teknologi monster mesin generasi baru yang lebih mematikan.\n\nDi pihak pejuang Clin, Helen berhasil melepaskan diri sepenuhnya dan bangkit sebagai Helen Lady untuk bertarung bahu-membahu bersama Spielban dan Diana Lady.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menghadapi eskalasi teknologi musuh dari masa depan') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bekerja sama dalam formasi tiga pejuang Clin') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Resmi bergabung ke kubu keadilan sebagai Helen Lady') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Penyerbuan Kastel Waller & Rahasia Planet Clin',
      'Episode 37–44',
      E'Menjelang puncak perang, Doctor Bio kembali ke jati diri sebagai Dr. Ben sebelum berkorban demi menyelamatkan anak-anaknya dari cengkeraman Queen Pandora.\n\nPada dua episode pamungkas (43–44), Spielban, Diana, dan Helen menyerbu langsung Kastel Waller untuk menumpas Queen Pandora sekaligus menyingkap rahasia mendalam tentang keterkaitan sejarah Planet Clin dan Bumi di masa depan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memimpin penyerbuan final ke Kastel Waller') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menuntaskan dendam keluarga terhadap Queen Pandora') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memulihkan ingatan sebagai Dr. Ben sebelum berkorban') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Tumbang dalam kejatuhan Kastel Waller') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 6. CHOUJINKI METALDER (1987) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Choujinki Metalder' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Metalder' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Mai Ougi' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Springer' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Top Gunder' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'God Neros' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Coolgin' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kebangkitan Android & Kematian Sang Pencipta',
      'Episode 01–10',
      E'Mengetahui mantan asistennya telah menjadi penguasa bayangan God Neros, ilmuwan sepuh Dr. Ryuichiro Koga membangunkan android militer rahasia ciptaannya sejak Perang Dunia II, Metalder, dan membekalinya robot anjing Springer.\n\nPembunuhan kejam terhadap Dr. Koga oleh kaki tangan Neros langsung memicu amarah Metalder hingga sirkuit transformasinya terbuka penuh. Ia memulai hidup sebagai Ryusei Tsurugi serta bersahabat dengan fotografer pemberani Mai Ougi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Aktif bertarung setelah gugurnya Dr. Koga') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menjadi sahabat manusia pertama Ryusei') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Mendampingi Ryusei di markas Silver Carcass') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Mengirim pasukan untuk menyingkirkan Dr. Koga') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Empat Divisi Neros & Kemunculan Top Gunder',
      'Episode 11–22',
      E'Kekaisaran Neros mengerahkan serangan terkoordinasi dari empat divisinya—Armored, Battle Robot, Monster, dan Armament—yang memaksa Metalder nyaris tanpa jeda bertahan dari pengepungan demi pengepungan.\n\nDi tengah tekanan pasukan kejam pimpinan Coolgin, penembak jitu terhormat dari Divisi Robot bernama Top Gunder justru mulai mempertanyakan cara curang Neros dan membentuk persaingan terhormat dengan Metalder.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Bertahan dari gempuran empat divisi tempur Neros') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membentuk rivalitas terhormat melawan Metalder') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Mengatur strategi pembasmian dari Divisi Armored') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Pemberontakan Robot & Duka di Tengah Mesin',
      'Episode 23–33',
      E'Serial ini menyoroti kedalaman emosi para prajurit mesin Neros yang perlahan menyadari bahwa diri mereka hanyalah alat sekali pakai bagi ambisi keserakahan God Neros.\n\nTop Gunder akhirnya memutuskan berkhianat dari Neros dan berdiri di sisi Metalder, sementara Mai Ougi dan Springer terus menjaga agar Ryusei tidak kehilangan sisi kemanusiaannya di tengah pertempuran brutal.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Bergulat memahami nurani dan arti kebebasan mesin') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menjadi jangkar moral kehidupan manusia Ryusei') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memutus ikatan dengan Neros demi keadilan') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Penyerbuan Benteng Ghost Bank & Kehancuran Neros',
      'Episode 34–39',
      E'Dalam seri Metal Hero paling ringkas ini, sisa-sisa komandan empat divisi berguguran saat Metalder dan Top Gunder berhasil menemukan serta menembus markas bawah tanah Ghost Bank.\n\nCoolgin tewas terjebak dalam rencananya sendiri, lalu Metalder menuntaskan konfrontasi pamungkas melawan God Neros di Episode 39 demi mengakhiri gurita kejahatan konglomerasi tersebut selamanya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menumbangkan God Neros di Ghost Bank') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Bahu-membahu menyerbu markas Neros') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Tumbang bersama runtuhnya benteng Ghost Bank') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Tewas dalam upaya terakhir menjebak Metalder') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 7. SEKAI NINJA SEN JIRAIYA (1988) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Sekai Ninja Sen Jiraiya' AND franchise = 'Metal Hero' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Jiraiya' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Himenin Emiha' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Tetsuzan Yamaji' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Kinin Reiha' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Manabu Yamaji' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Oninin Dokusai' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Benikiba' LIMIT 1;
    SELECT id INTO v_c8 FROM characters WHERE series_id = v_series_id AND name = 'Space Ninja Demost' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Sumpah Togakure & Perburuan Peta Pako',
      'Episode 01–14',
      E'Ketika Klan Penyihir pimpinan Oninin Dokusai menyerang kediaman keluarga Yamaji untuk merebut peta peninggalan harta karun kuno Pako, Grandmaster ke-34 Tetsuzan Yamaji memercayakan zirah pelindung Jiraiya kepada putra angkatnya, Toha.\n\nDengan dukungan adik angkatnya Kei (Emiha) serta sang adik kecil Manabu, Toha mempertahankan potongan peta tersebut dari serangan Benikiba dan puluhan ninja pemburu dari seluruh dunia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mewarisi baju zirah pelindung Jiraiya') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Ikut menjaga kediaman keluarga Yamaji') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyerahkan amanat penjagaan Pako kepada Toha') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Mengobarkan serangan demi merebut peta Pako') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Perang Ninja Dunia & Bangkitnya Dewa Jiraishin',
      'Episode 15–28',
      E'Kabar mengenai artefak Pako menyebar ke berbagai benua sehingga memicu kedatangan para master ninja internasional dengan jurus uniknya masing-masing, sebagian sebagai musuh dan sebagian lagi kelak menjadi sahabat Toha.\n\nDalam fase genting ini pula agen Polisi Rahasia Internasional Rei Yagyu (Reiha) hadir membantu keluarga Yamaji, sementara rahasia dewa pelindung raksasa kuno Jiraishin di Gunung Kongo mulai terungkap.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengasah jurus berduel melawan ninja lintas negara') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membantu menyelidiki jaringan ninja dunia') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Terlibat aktif membantu dalam situasi tak terduga') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Memanfaatkan para ninja bayaran melawan Toha') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Ancaman Kuno Space Ninja Demost',
      'Episode 29–41',
      E'Konflik bergeser ke tingkat paling berbahaya ketika entitas ninja luar angkasa berusia 2.300 tahun bernama Demost bangkit memburu Pako. Kehadirannya mengguncang dominasi Klan Penyihir sekalipun.\n\nJiraiya terpaksa menembus batas kemampuannya menghadapi seni ninjutsu antariksa Demost sambil menjaga agar kesatuan keluarga Yamaji dan para sekutu ninja dunia tetap utuh.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menghadapi kekuatan kuno ninja luar angkasa') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Membimbing Toha menghadapi krisis Demost') ON CONFLICT DO NOTHING; END IF;
    IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c8, 'Bangkit sebagai ancaman utama pemburu Pako') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Perang Ninja Dunia Terakhir & Misteri Sejati Pako',
      'Episode 42–50',
      E'Seluruh rahasia asal-usul Pako sebagai kapsul antariksa terungkap di babak penutup saat Demost dan sisa pasukan Klan Penyihir bertarung memperebutkannya secara langsung di medan laga.\n\nDengan dukungan seluruh sekutu ninja dunia dan kebangkitan penuh Jiraishin, Jiraiya mengalahkan Oninin Dokusai dan menuntaskan ancaman terbesar terhadap Pako, menutup babak panjang era Showa di Metal Hero.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengakhiri Perang Ninja Dunia & menjaga kedamaian Pako') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Mendampingi pertempuran terakhir bersama sekutu') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Tumbang di akhir perang Klan Penyihir') ON CONFLICT DO NOTHING; END IF;
    IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c8, 'Ditaklukkan dalam klimaks perburuan Pako') ON CONFLICT DO NOTHING; END IF;
  END IF;

END $$;
