-- =============================================================================
-- SEED DATA: KAMEN RIDER ERA HEISEI TAHAP 1 (2000–2008: KUUGA–KIVA)
-- IDEMPOTEN: Cek berdasarkan title (series) dan (series_id, name) (characters/actors).
-- HANYA mengisi kolom NULL pada data yang sudah ada (COALESCE), tidak menimpa editan manual.
-- TIDAK mengisi statistik fisik (height_cm, weight_kg, dll.) pada tahap ini.
-- Mencari series_id lewat subquery berdasarkan title.
-- Cakupan (9 Series):
--   1. Kamen Rider Kuuga (2000)   [sudah ada — diperkaya]
--   2. Kamen Rider Agito (2001)   [baru]
--   3. Kamen Rider Ryuki (2002)   [sudah ada — diperkaya]
--   4. Kamen Rider 555 (2003)     [baru]
--   5. Kamen Rider Blade (2004)   [baru]
--   6. Kamen Rider Hibiki (2005)  [baru]
--   7. Kamen Rider Kabuto (2006)  [baru]
--   8. Kamen Rider Den-O (2007)   [sudah ada — diperkaya]
--   9. Kamen Rider Kiva (2008)    [baru]
-- Sumber verifikasi: Wikipedia ("List of Kamen Rider series") & Kamen Rider Wiki.
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER KUUGA (2000)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Kuuga', '仮面ライダークウガ', 'Kamen Rider', 'Heisei', 2000, '2000-01-30', '2001-01-21',
      49, 'Toei Company', 'Kumbang Rusa / Peradaban Linto Kuno',
      'Serial pembuka era Heisei yang mengikuti Yusuke Godai, pemuda berjiwa petualang pemilik 2.000 keahlian yang menemukan sabuk kuno Arcle di situs penggalian Nagano. Bersama detektif kepolisian Kaoru Ichijo dan peneliti arkeologi Sakurako Sawatari, ia berjuang melindungi senyuman manusia sebagai Kamen Rider Kuuga melawan suku kuno Gurongi.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kuuga'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダークウガ'),
      aired_from = COALESCE(aired_from, '2000-01-30'),
      aired_to   = COALESCE(aired_to, '2001-01-21'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Kumbang Rusa / Peradaban Linto Kuno'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kuuga')
    WHERE id = v_series_id;
  END IF;

  IF EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kuuga') THEN
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Kamen Rider Kuuga'),
      civilian_name = COALESCE(civilian_name, 'Yusuke Godai'),
      actor         = COALESCE(actor, 'Joe Odagiri'),
      role          = COALESCE(role, 'Main Rider'),
      species       = COALESCE(species, 'Manusia (diubah oleh Arcle / Amadam)'),
      team          = COALESCE(team, 'Kepolisian Metropolitan Tokyo & Kafe Pole Pole'),
      power         = COALESCE(power, 'Sabuk Arcle dengan batu Amadam yang memungkinkan berbagai wujud seperti Mighty, Dragon, Pegasus, Titan, hingga Ultimate Form.'),
      bio           = COALESCE(bio, 'Pemuda optimis pemilik 2.000 bakat yang menyatu dengan sabuk peninggalan peradaban Linto. Ia bertarung bukan demi kekuasaan, melainkan untuk menjaga senyuman semua orang di sekitarnya.'),
      debut_episode = COALESCE(debut_episode, 'Episode 1'),
      source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Yusuke_Godai')
    WHERE series_id = v_series_id AND name = 'Kamen Rider Kuuga';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kaoru Ichijo') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kaoru Ichijo', 'Kaoru Ichijo', 'Shingo Katsurayama', 'Ally',
      'Manusia', 'Kepolisian Prefektur Nagano / Satgas Unidentified Lifeform',
      'Kemampuan menembak jitu dengan peluru khusus anti-Gurongi, koordinasi kepolisian, dan kendaraan TryChaser 2000.',
      'Inspektur polisi yang tegas dan penuh dedikasi dalam menangani kasus Unidentified Lifeform. Ia menjadi sekutu paling dipercaya Yusuke Godai di lingkungan aparat keamanan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kuuga'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Sakurako Sawatari') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Sakurako Sawatari', 'Sakurako Sawatari', 'Kazumi Murata', 'Ally',
      'Manusia', 'Universitas Jonan',
      'Keahlian menerjemahkan aksara kuno peradaban Linto untuk mengungkap cara kerja kekuatan Kuuga.',
      'Sahabat dekat Yusuke Godai dan peneliti arkeologi di Universitas Jonan. Terjemahannya atas prasasti Linto kerap menjadi kunci bagi Yusuke untuk membuka wujud serta jurus baru Kuuga.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kuuga'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Minori Godai') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Minori Godai', 'Minori Godai', 'Wakana Aoi', 'Ally',
      'Manusia', 'Taman Kanak-kanak Wakaba',
      'Dukungan emosional dan kepedulian terhadap anak-anak yang memberi Yusuke kekuatan moral.',
      'Adik kandung Yusuke Godai yang bekerja sebagai guru taman kanak-kanak. Meskipun cemas melihat kakaknya bertarung setiap hari, ia selalu mendukung perjuangan Yusuke dengan sepenuh hati.',
      'Episode 1', 'https://kamenrider.fandom.com/wiki/Minori_Godai'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'N-Daguva-Zeba') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'N-Daguva-Zeba', 'Kenji Urai', 'Villain',
      'Suku Gurongi', 'Suku Gurongi',
      'Pengendalian api pyrokinesis mematikan pada tingkat atom dan kekuatan fisik absolut setara Ultimate Kuuga.',
      'Pemimpin tertinggi suku Gurongi yang dijuluki Unidentified Lifeform #0 dan bermotif kumbang rusa hitam. Ia merupakan lawan terakhir yang memaksa Kuuga mengerahkan kekuatan Ultimate Form.',
      'https://kamenrider.fandom.com/wiki/N-Daguva-Zeba'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ra-Baruba-De') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Ra-Baruba-De', 'Mie Nanamori', 'Villain',
      'Suku Gurongi', 'Suku Gurongi',
      'Otoritas pengawas aturan permainan pembantaian Gegeru serta ketahanan fisik dan kecerdasan strategis tinggi.',
      'Wanita bertato mawar yang bertindak sebagai hakim sekaligus koordinator permainan pembunuhan suku Gurongi di kota Tokyo.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kuuga'
    );
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER AGITO (2001)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Agito', '仮面ライダーアギト', 'Kamen Rider', 'Heisei', 2001, '2001-01-28', '2002-01-27',
      51, 'Toei Company', 'Naga & Evolusi Cahaya',
      'Menindaklanjuti misteri pembunuhan berantai oleh makhluk bersimbol cahaya bernama Unknown, tiga pemuda dengan latar belakang berbeda terhubung oleh kekuatan misterius. Shouichi Tsugami yang hilang ingatan mampu berubah menjadi Kamen Rider Agito, perwira polisi Makoto Hikawa mengoperasikan zirah mekanik G3, dan mantan perenang Ryo Ashihara bertransformasi secara biologis menjadi Gills.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーアギト'),
      aired_from = COALESCE(aired_from, '2001-01-28'),
      aired_to   = COALESCE(aired_to, '2002-01-27'),
      episodes   = COALESCE(episodes, 51),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Naga & Evolusi Cahaya'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Agito') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Agito', 'Kamen Rider Agito', 'Shouichi Tsugami', 'Toshiki Kashu', 'Main Rider',
      'Manusia (Seed of Agito)', 'Keluarga Misugi',
      'Sabuk Alter Ring dengan kekuatan evolusi cahaya, Flame Saber, Storm Halberd, serta bentuk Trinity dan Shining Form.',
      'Pemuda ceria yang gemar memasak dan berkebun sambil tinggal bersama keluarga Profesor Misugi setelah kehilangan ingatannya. Setiap kali makhluk Unknown muncul, insting tempurnya bangkit dan ia berubah menjadi Kamen Rider Agito.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider G3') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider G3', 'Kamen Rider G3', 'Makoto Hikawa', 'Jun Kaname', 'Secondary Rider',
      'Manusia', 'Kepolisian Metropolitan Tokyo (Unit G3)',
      'Zirah mekanik tempur buatan manusia G3 System (kemudian ditingkatkan menjadi G3-X) berbekal persenjataan peluncur berat dan senapan.',
      'Perwira polisi jujur dan pekerja keras yang dipercaya mengenakan zirah tempur canggih G3 tanpa kekuatan supranatural. Ia menjalin persahabatan erat dengan Shouichi demi melindungi warga sipil.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gills') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Gills', 'Kamen Rider Gills', 'Ryo Ashihara', 'Yusuke Tomoi', 'Secondary Rider',
      'Manusia (Mutasi Agito Tak Sempurna)', 'Independen',
      'Meta Factor yang memicu transformasi biologis buas dengan cakar lengan, taring cambuk, dan tendangan Heel Claw.',
      'Mantan atlet renang berbakat yang hidupnya hancur setelah tubuhnya mulai bermutasi menjadi wujud organik Gills. Meski awalnya penuh kepedihan dan amarah, ia perlahan bahu-membahu bersama Agito.',
      'Episode 6', 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mana Kazaya') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mana Kazaya', 'Mana Kazaya', 'Rina Akiyama', 'Ally',
      'Manusia (Psikis)', 'Keluarga Misugi',
      'Kemampuan telepati dan pembacaan ingatan lewat sentuhan tangan yang terhubung dengan benih kekuatan Agito.',
      'Siswi sekolah menengah yang menjadi sahabat Shouichi di kediaman pamannya, Profesor Misugi. Ia membantu Shouichi menyibak misteri kematian ayahnya serta asal-usul kekuatan Agito.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Sumiko Ozawa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Sumiko Ozawa', 'Sumiko Ozawa', 'Toko Fujita', 'Ally',
      'Manusia', 'Kepolisian Metropolitan Tokyo (Unit G3)',
      'Jenius rekayasa robotika dan perancang utama sistem zirah tempur G3 dan G3-X.',
      'Ilmuwan kepolisian yang cerdas, lugas, dan percaya diri selaku pemimpin tim pengembang G3 System serta atasan langsung Makoto Hikawa.',
      'Episode 1', 'https://kamenrider.fandom.com/wiki/Sumiko_Ozawa'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Overlord of Darkness') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Overlord of Darkness', 'Rei Haneo', 'Villain',
      'Entitas Pencipta (Overlord)', 'Bangsa Unknown (Lords)',
      'Manipulasi kosmik atas kehidupan, penciptaan rasi bintang baru, serta komando mutlak atas seluruh makhluk Unknown.',
      'Entitas ilahi gelap pencipta umat manusia yang berusaha menghancurkan para penyandang Benih Agito karena takut evolusi manusia akan melampaui otoritasnya.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Agito'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Toshiki Kashu') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Toshiki Kashu', '賀集 利樹', 'Shouichi Tsugami / Kamen Rider Agito', 'MC', v_series_id, 'Aktor Jepang yang memulai debut peran utamanya di televisi lewat karakter Shouichi Tsugami dalam serial Kamen Rider dengan rating tertinggi era Heisei.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Jun Kaname') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Jun Kaname', '要 潤', 'Makoto Hikawa / Kamen Rider G3', 'Secondary Rider', v_series_id, 'Aktor populer Jepang yang memerankan perwira polisi Makoto Hikawa sebagai Kamen Rider G3.');
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER RYUKI (2002)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Ryuki', '仮面ライダー龍騎', 'Kamen Rider', 'Heisei', 2002, '2002-02-03', '2003-01-19',
      50, 'Toei Company', 'Cermin, Naga & Kartu Pertarungan',
      'Di dunia balik cermin bernama Mirror World, tiga belas Kamen Rider yang mengikat kontrak dengan monster dipaksa bertarung satu sama lain dalam Rider War demi satu permintaan yang dikabulkan. Wartawan muda Shinji Kido terjun sebagai Kamen Rider Ryuki bukan untuk membunuh sesama Rider, melainkan untuk menghentikan peperangan kejam tersebut.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー龍騎'),
      aired_from = COALESCE(aired_from, '2002-02-03'),
      aired_to   = COALESCE(aired_to, '2003-01-19'),
      episodes   = COALESCE(episodes, 50),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Cermin, Naga & Kartu Pertarungan'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki')
    WHERE id = v_series_id;
  END IF;

  IF EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ryuki') THEN
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Kamen Rider Ryuki'),
      civilian_name = COALESCE(civilian_name, 'Shinji Kido'),
      actor         = COALESCE(actor, 'Takamasa Suga'),
      role          = COALESCE(role, 'Main Rider'),
      species       = COALESCE(species, 'Manusia'),
      team          = COALESCE(team, 'ORE Journal'),
      power         = COALESCE(power, 'V-Buckle dan kartu Advent Deck milik naga merah Dragreder (Sword Vent, Strike Vent, Guard Vent, serta wujud Survive).'),
      bio           = COALESCE(bio, 'Reporter magang berhati tulus di ORE Journal yang tak sengaja menjalin kontrak dengan Dragreder. Ia bertekad melindungi warga dari monster Mirror World sekaligus menghentikan perang antar-Rider.'),
      debut_episode = COALESCE(debut_episode, 'Episode 1'),
      source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Shinji_Kido')
    WHERE series_id = v_series_id AND name = 'Kamen Rider Ryuki';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Knight') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Knight', 'Kamen Rider Knight', 'Ren Akiyama', 'Satoshi Matsuda', 'Secondary Rider',
      'Manusia', 'Kafe Atori / Sekutu Yui',
      'Kontrak kelelawar gelap Darkwing dengan senjata tombak Dark Visor serta kartu Trick Vent, Nasty Vent, dan bentuk Survive.',
      'Pemuda dingin dan penyendiri yang rela terjun dalam Rider War demi menyelamatkan kekasihnya, Eri Ogawa, dari koma panjang. Meskipun sikapnya sering bertolak belakang dengan Shinji, ia menjadi rekan bertarung terkuatnya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Zolda') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Zolda', 'Kamen Rider Zolda', 'Shuichi Kitaoka', 'Ryohei Odai', 'Secondary Rider',
      'Manusia', 'Kantor Hukum Kitaoka',
      'Kontrak banteng mekanik Magnugiga dengan artileri berat Shoot Vent serta daya hancur jarak jauh masif Final Vent End of World.',
      'Pengacara eksentrik dan materialistis yang ikut dalam Rider War karena mengidap penyakit mematikan demi meraih kehidupan abadi.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ohja') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Ohja', 'Kamen Rider Ohja', 'Takeshi Asakura', 'Takashi Hagino', 'Villain',
      'Manusia', 'Independen',
      'Kontrak tiga monster sekaligus (Venosnaker, Metalgelas, Evildiver) yang dapat menyatu menjadi Genocider.',
      'Kriminal kejam dan haus darah yang melarikan diri dari penjara lalu mengikuti Rider War semata-mata demi kepuasan bertarung dan menghancurkan Rider lain.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yui Kanzaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Yui Kanzaki', 'Yui Kanzaki', 'Ayano Sugiyama', 'Ally',
      'Manusia (terhubung Mirror World)', 'Kafe Atori',
      'Koneksi batin langsung dengan Mirror World dan gambar masa kecil yang menjadi asal kelahiran para Mirror Monster.',
      'Adik kandung Shiro Kanzaki yang bekerja sama dengan Ren Akiyama dan Shinji Kido untuk menghentikan Rider War sembari menyingkap rahasia masa lalunya sendiri.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Goro Yura') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Goro Yura', 'Goro Yura', 'Tomohisa Yuge', 'Ally',
      'Manusia', 'Kantor Hukum Kitaoka',
      'Keahlian memasak, pengelolaan rumah tangga hukum Kitaoka, serta loyalitas tanpa batas hingga sempat menggantikan peran Zolda.',
      'Asisten pribadi sekaligus pengawal setia Shuichi Kitaoka yang merawatnya sepenuh hati sepanjang pertarungan melawan penyakit dan para Rider lain.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shiro Kanzaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Shiro Kanzaki', 'Shiro Kanzaki', 'Kenzaburo Kikuchi', 'Villain',
      'Entitas Mirror World', 'Mirror World',
      'Kendali atas dimensi Mirror World, pembuatan Advent Deck, serta kemampuan memutar ulang waktu Time Vent lewat Kamen Rider Odin.',
      'Ilmuwan jenius yang menciptakan sistem Rider War dan memanipulasi ketiga belas petarung demi memperpanjang hidup adiknya, Yui Kanzaki.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ryuki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Satoshi Matsuda') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Satoshi Matsuda', 'Ren Akiyama / Kamen Rider Knight', 'Secondary Rider', v_series_id, 'Aktor Jepang yang dikenal luas lewat perannya sebagai Ren Akiyama, rival sekaligus rekan utama Shinji Kido.');
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER 555 (2003)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider 555', '仮面ライダー555（ファイズ）', 'Kamen Rider', 'Heisei', 2003, '2003-01-26', '2004-01-18',
      50, 'Toei Company', 'Teknologi Ponsel, Huruf Yunani & Hiu',
      'Korporasi raksasa Smart Brain diam-diam dipimpin oleh ras mutan hasil kematian manusia bernama Orphnoch yang mengembangkan tiga sabuk tempur canggih. Pemuda penyendiri bernama Takumi Inui terlibat dalam perseteruan antara Smart Brain, para penyintas Ryusei School, dan sesama Orphnoch setelah menggunakan Faiz Gear demi melindungi Mari Sonoda.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー555（ファイズ）'),
      aired_from = COALESCE(aired_from, '2003-01-26'),
      aired_to   = COALESCE(aired_to, '2004-01-18'),
      episodes   = COALESCE(episodes, 50),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Teknologi Ponsel, Huruf Yunani & Hiu'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_555')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Faiz') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Faiz', 'Kamen Rider Faiz', 'Takumi Inui', 'Kento Handa', 'Main Rider',
      'Orphnoch (Wolf Orphnoch)', 'Kikuchi Dry Cleaning',
      'Sabuk Faiz Gear bertenaga Photon Blood, Faiz Phone, pedang Faiz Edge, Axel Form berkecepatan super, dan Blaster Form.',
      'Pemuda sinis namun berhati lembut yang takut menjalin kedekatan agar tidak mengkhianati orang lain. Ia ternyata merupakan Wolf Orphnoch yang memilih berdiri di pihak manusia demi melindungi Mari dan teman-temannya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kaixa') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Kaixa', 'Kamen Rider Kaixa', 'Masato Kusaka', 'Kohei Murakami', 'Secondary Rider',
      'Manusia (disuntik DNA Orphnoch)', 'Ryusei School',
      'Sabuk Kaixa Gear dengan pedang laser Kaixa Blaygun, Kaixa Shot, dan jurus pamungkas Gold Smash.',
      'Mantan murid Ryusei School yang tampak ramah di luar tetapi manipulatif dan menyimpan kebencian mendalam terhadap seluruh Orphnoch. Ia berulang kali berkonflik dengan Takumi meski berada di kubu yang sama.',
      'Episode 10', 'https://kamenrider.fandom.com/wiki/Masato_Kusaka'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Delta') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Delta', 'Kamen Rider Delta', 'Shuji Mihara', 'Atsushi Harada', 'Secondary Rider',
      'Manusia (disuntik DNA Orphnoch)', 'Ryusei School',
      'Sabuk Delta Gear yang dikendalikan perintah suara (Standing By / Henshin), pistol Delta Mover, dan Lucifer''s Hammer.',
      'Alumni Ryusei School yang awalnya penakut dan ingin lari dari peperangan, namun akhirnya menerima tanggung jawab sebagai pengguna tetap sabuk Delta bersama Takumi dan Kusaka.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mari Sonoda') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mari Sonoda', 'Mari Sonoda', 'Yuria Haga', 'Ally',
      'Manusia', 'Ryusei School / Kikuchi Dry Cleaning',
      'Kepemilikan koper Faiz Gear dari ayah angkatnya dan keberanian mempertahankan rasa kemanusiaan di sekitar Takumi.',
      'Mantan siswi Ryusei School yang bercita-cita menjadi penata rambut dan membawa koper Faiz Gear berkeliling sebelum pertemuannya dengan Takumi Inui mengubah hidup mereka berdua.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yuji Kiba') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Yuji Kiba', 'Yuji Kiba', 'Masayuki Izumi', 'Ally',
      'Orphnoch (Horse Orphnoch)', 'Independen / Smart Brain',
      'Wujud kuat Horse Orphnoch bersenjatakan pedang sihir dan tameng ksatria, serta pernah mengenakan sabuk Faiz maupun Orga.',
      'Pemuda baik hati yang bangkit sebagai Horse Orphnoch setelah mengalami kecelakaan tragis dan pengkhianatan keluarga. Ia mendambakan koeksistensi damai antara Orphnoch dan manusia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kyoji Murakami') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kyoji Murakami', 'Kyoji Murakami', 'Katsuyuki Murai', 'Villain',
      'Orphnoch (Rose Orphnoch)', 'Smart Brain',
      'Pengendalian duri dan kelopak mawar mematikan dalam wujud Rose Orphnoch serta kekuasaan penuh atas aset korporasi Smart Brain.',
      'Direktur Smart Brain yang terobsesi membangkitkan Arch Orphnoch sang raja demi menyapu bersih umat manusia dari muka Bumi.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kitazaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kitazaki', 'Kitazaki', 'Rei Fujita', 'Villain',
      'Orphnoch (Dragon Orphnoch)', 'Lucky Clover (Smart Brain)',
      'Sentuhan maut yang mampu mengubah segala benda menjadi abu, kecepatan tempur Dragon Humanoid Form, serta pernah memakai Delta Gear.',
      'Anggota termuda sekaligus paling kejam dari kelompok elite Lucky Clover yang menganggap perburuan manusia sebagai permainan belaka.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_555'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kento Handa') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Kento Handa', '半田 健人', 'Takumi Inui / Kamen Rider Faiz', 'MC', v_series_id, 'Aktor sekaligus musisi Jepang yang memerankan karakter ikonik berkarakter tsundere-penyendiri Takumi Inui.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kohei Murakami') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Kohei Murakami', 'Masato Kusaka / Kamen Rider Kaixa', 'Secondary Rider', v_series_id, 'Aktor Jepang yang sangat dikenal penggemar tokusatsu melalui perannya sebagai Masato Kusaka.');
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER BLADE (2004)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Blade', '仮面ライダー剣（ブレイド）', 'Kamen Rider', 'Heisei', 2004, '2004-01-25', '2005-01-23',
      49, 'Toei Company', 'Kartu Remi & Serangga Kumbang',
      'Sepuluh ribu tahun setelah tersegel di dalam 52 kartu, ras makhluk abadi bernama Undead kembali bangkit ke dunia modern untuk melanjutkan Battle Fight yang menentukan spesies penguasa Bumi. Organisasi peneliti BOARD merekrut pemuda Kazuma Kenzaki dan seniornya Sakuya Tachibana sebagai Kamen Rider Blade serta Garren guna menyegel kembali para Undead.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー剣（ブレイド）'),
      aired_from = COALESCE(aired_from, '2004-01-25'),
      aired_to   = COALESCE(aired_to, '2005-01-23'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Kartu Remi & Serangga Kumbang'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Blade') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Blade', 'Kamen Rider Blade', 'Kazuma Kenzaki', 'Takayuki Tsubaki', 'Main Rider',
      'Manusia (kelak bermutasi menjadi Joker Undead)', 'BOARD',
      'Sabuk Blay Buckle dengan pedang Blay Rouzer, kartu Rouse kategori Sekop (Spade), Jack Form bersayap, dan King Form.',
      'Pekerja keras berhati murni di BOARD yang rela mengorbankan keselamatan dirinya demi menyelamatkan manusia dan sahabatnya. Pada akhirnya ia memilih berubah menjadi Joker kedua agar Hajime terbebas dari kutukan kehancuran dunia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Garren') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Garren', 'Kamen Rider Garren', 'Sakuya Tachibana', 'Kosei Amano', 'Secondary Rider',
      'Manusia', 'BOARD',
      'Sabuk Garren Buckle dengan pistol Garren Rouzer, kartu Rouse kategori Wajik (Diamond), dan Jack Form.',
      'Senior Kenzaki di BOARD yang menjadi pengguna pertama sistem Rider. Setelah sempat goyah akibat ketakutan dan manipulasi musuh, ia bangkit menjadi mentor tempur paling tangguh.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Chalice') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Chalice', 'Kamen Rider Chalice', 'Hajime Aikawa', 'Ryoji Morimoto', 'Secondary Rider',
      'Joker Undead', 'Kafe Jacaranda',
      'Sabuk Chalice Rouzer yang memanfaatkan kartu Rouse Hati (Heart) untuk berubah menjadi wujud Mantis Undead serta Wild Chalice.',
      'Fotografer pendiam yang hidup bersama keluarga Kurihara di Kafe Jacaranda. Jati dirinya sebenarnya adalah Joker Undead ke-53 yang belajar mencintai kehidupan manusia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Leangle') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Leangle', 'Kamen Rider Leangle', 'Mutsuki Kamijo', 'Takahiro Hojo', 'Secondary Rider',
      'Manusia', 'BOARD / Sekutu Blade',
      'Sabuk Leangle Buckle dengan tongkat bilah Leangle Rouzer dan kartu Rouse Keriting (Club).',
      'Siswa SMA biasa yang terpilih mengenakan sabuk kategori Club namun sempat dikendalikan oleh Spider Undead sebelum akhirnya mampu menaklukkan kegelapannya sendiri.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shiori Hirose') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Shiori Hirose', 'Shiori Hirose', 'Yumi Egawa', 'Ally',
      'Manusia', 'BOARD',
      'Pengoperasian radar pelacak Undead, sistem dukungan taktis BOARD, dan koordinasi logistik tim Rider.',
      'Analis sistem dan petugas lapangan BOARD yang mendampingi Kenzaki serta Tachibana menemukan lokasi Undead sekaligus menyelidiki rahasia ayahnya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hiroshi Tennoji') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Hiroshi Tennoji', 'Hiroshi Tennoji', 'Kohji Moritsugu', 'Villain',
      'Manusia', 'BOARD (Ketua Yayasan)',
      'Dalang penciptaan sistem Rider dan proyek makhluk buatan Kerberos demi memenangkan Battle Fight secara curang.',
      'Pendiri misterius yayasan BOARD yang diam-diam melepaskan para Undead dari segel agar ia dapat menguasai hadiah pemenang Battle Fight.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Blade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Takayuki Tsubaki') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Takayuki Tsubaki', '椿 隆之', 'Kazuma Kenzaki / Kamen Rider Blade', 'MC', v_series_id, 'Aktor Jepang yang membintangi tokoh utama Kazuma Kenzaki dan terus dikenang lewat frasa serta akhir pengorbanan serinya.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kosei Amano') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Kosei Amano', 'Sakuya Tachibana / Kamen Rider Garren', 'Secondary Rider', v_series_id, 'Aktor dan penyanyi Jepang pemeran Sakuya Tachibana yang kembali tampil di sejumlah proyek reuni Kamen Rider.');
  END IF;


  -- ===========================================================================
  -- 6. KAMEN RIDER HIBIKI (2005)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Hibiki', '仮面ライダー響鬼', 'Kamen Rider', 'Heisei', 2005, '2005-01-30', '2006-01-22',
      48, 'Toei Company', 'Oni Tradisional & Alat Musik',
      'Mengusung konsep unik pahlawan yang disebut Oni, organisasi rahasia Takeshi dan para ksatria pembasmi monster pemakan manusia bernama Makamou berjuang menggunakan kekuatan suara murni dari instrumen musik tradisional. Kisah ini dituturkan lewat sudut pandang siswa SMP Asumu Adachi yang tumbuh dewasa setelah dibimbing oleh Oni berpengalaman bernama Hibiki.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー響鬼'),
      aired_from = COALESCE(aired_from, '2005-01-30'),
      aired_to   = COALESCE(aired_to, '2006-01-22'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Oni Tradisional & Alat Musik'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Hibiki') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Hibiki', 'Kamen Rider Hibiki', 'Hitoshi Hidaka', 'Shigeki Hosokawa', 'Main Rider',
      'Manusia (Oni)', 'Takeshi',
      'Transformasi melalui garpu tala Onkaku, tongkat pemukul perkusi Ongekibo Rekka, drum Taiko raksasa, serta wujud Kurenai dan Armed Hibiki.',
      'Pria bersahaja yang telah melatih fisiknya menjadi Oni berpengalaman demi melindungi masyarakat dari ancaman Makamou. Ia menjadi sosok panutan dewasa yang membimbing kedewasaan Asumu Adachi.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ibuki') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Ibuki', 'Kamen Rider Ibuki', 'Iori Izumi', 'Joji Shibue', 'Secondary Rider',
      'Manusia (Oni)', 'Takeshi',
      'Terompet perang Ongekikan Reppuu yang merangkap senapan jarak jauh sekaligus alat transformasi Oni tiup.',
      'Oni muda keturunan keluarga utama Takeshi yang sopan dan cerdas. Ia turut mengasuh sekaligus melatih Akira Amami untuk meneruskan tradisi Oni.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Todoroki') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Todoroki', 'Kamen Rider Todoroki', 'Tomizo Todayama', 'Shingo Kawaguchi', 'Secondary Rider',
      'Manusia (Oni)', 'Takeshi',
      'Gitar listrik Ongekigen Retsurai yang menghasilkan gelombang petir serta teknik suara petikan dawai penghancur Makamou.',
      'Murid dari Zanki yang ceria dan penuh semangat, melangkah menggantikan sang guru sebagai Oni pengguna instrumen dawai.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Asumu Adachi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Asumu Adachi', 'Asumu Adachi', 'Rakuto Tochihara', 'Ally',
      'Manusia', 'Keluarga Adachi / Kedai Tachibana',
      'Ketekunan belajar, empati terhadap sesama, dan pengamatan keseharian dunia para Oni serta Takeshi.',
      'Remaja yang awalnya ragu menentukan arah masa depan sebelum bertemu Hibiki di Yakushima. Persahabatannya dengan Hibiki membentuk jalan hidupnya sebagai pemuda mandiri.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Akira Amami') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Akira Amami', 'Akira Amami', 'Nana Akiyama', 'Ally',
      'Manusia (Calon Oni)', 'Takeshi',
      'Latihan fisik keras ala Oni di bawah bimbingan Ibuki serta kemampuan memakai senjata musik sementara.',
      'Siswi sebaya Asumu yang berlatih keras di bawah pengawasan Ibuki karena menyimpan luka masa lalu akibat serangan Makamou terhadap keluarganya.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Douji') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Douji', 'Mitsu Murata', 'Villain',
      'Shikigami / Makhluk Pemelihara Makamou', 'Pembuat Makamou',
      'Pembiakan dan pembesaran Makamou di alam liar serta wujud tempur buas saat menghadapi Oni.',
      'Makhluk humanoid berpasangan dengan Hime yang berkeliling Jepang dalam wujud manusia untuk menumbuhkan para Makamou raksasa.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hime') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Hime', 'Sei Ashina', 'Villain',
      'Shikigami / Makhluk Pemelihara Makamou', 'Pembuat Makamou',
      'Sihir pengendali perkembangan Makamou dan wujud iblis wanita tangguh.',
      'Rekan wanita Douji yang memburu korban manusia sebagai makanan bagi pertumbuhan para Makamou di bawah perintah misterius dalang di balik layar.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Hibiki'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shigeki Hosokawa') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Shigeki Hosokawa', '細川 茂樹', 'Hitoshi Hidaka / Kamen Rider Hibiki', 'MC', v_series_id, 'Aktor senior Jepang yang memerankan sosok mentor dewasa Hitoshi Hidaka sekaligus membawakan warna tersendiri bagi serial Hibiki.');
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER KABUTO (2006)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Kabuto', '仮面ライダーカブト', 'Kamen Rider', 'Heisei', 2006, '2006-01-29', '2007-01-21',
      49, 'Toei Company', 'Serangga Kumbang & Kecepatan Super',
      'Tujuh tahun setelah meteor jatuh menghancurkan distrik Shibuya dan membawa ras alien penyamar bernama Worm, organisasi rahasia ZECT mengembangkan teknologi Masked Rider bertenaga partikel takion Clock Up. Pemuda penuh percaya diri Souji Tendou merebut Kabuto Zecter dan bertarung bersama agen muda Arata Kagami untuk menyingkap konspirasi besar di balik Worm.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーカブト'),
      aired_from = COALESCE(aired_from, '2006-01-29'),
      aired_to   = COALESCE(aired_to, '2007-01-21'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Serangga Kumbang & Kecepatan Super'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kabuto') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Kabuto', 'Kamen Rider Kabuto', 'Souji Tendou', 'Hiro Mizushima', 'Main Rider',
      'Manusia', 'Independen / Bekerja sama dengan ZECT',
      'Kabuto Zecter (Masked Form & Cast Off Rider Form), sistem kecepatan super Clock Up, Kabuto Kunai Gun, dan Hyper Form.',
      'Pria jenius serbabisa yang kerap mengutip ajaran neneknya dan menyatakan diri sebagai manusia yang berjalan di jalur surga. Di balik sikap arogannya, ia melindungi adiknya dan membasmi Worm tanpa kompromi.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gatack') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Gatack', 'Kamen Rider Gatack', 'Arata Kagami', 'Yuki Sato', 'Secondary Rider',
      'Manusia', 'ZECT',
      'Gatack Zecter (Masked & Rider Form), pedang kembar Gatack Double Calibur, serta kecepatan super Clock Up.',
      'Anggota lapangan ZECT yang jujur, emosional, namun berhati emas dan sempat mengenakan TheBee sebelum dipilih langsung oleh Gatack Zecter sebagai prajurit petarung sejati.',
      'Episode 21', 'https://kamenrider.fandom.com/wiki/Arata_Kagami'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Drake') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Drake', 'Kamen Rider Drake', 'Daisuke Kazama', 'Kazuki Kato', 'Secondary Rider',
      'Manusia', 'Independen',
      'Drake Zecter berwujud capung yang berfungsi sebagai pistol tempur berkecepatan tinggi dengan kemampuan Clock Up.',
      'Penata rias keliling berjiwa bebas yang berkelana bersama gadis cilik Gon dan bertarung sebagai Kamen Rider Drake tanpa terikat aturan ZECT.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Sasword') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Sasword', 'Kamen Rider Sasword', 'Tsurugi Kamishiro', 'Yusuke Yamamoto', 'Secondary Rider',
      'Worm (Scorpio Worm — meniru Tsurugi Kamishiro)', 'Keluarga Discabil / ZECT',
      'Sasword Zecter yang terpasang di pedang anggar Sasword Yaiver dengan kemampuan Clock Up dan serangan racun kalajengking.',
      'Pemuda bangsawan eksentrik dari keluarga Discabil yang bersumpah memusnahkan semua Worm tanpa menyadari bahwa dirinya sendiri adalah Scorpio Worm yang telah menyerap ingatan Tsurugi asli.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hiyori Kusakabe') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Hiyori Kusakabe', 'Hiyori Kusakabe', 'Yui Satonaka', 'Ally',
      'Native (Sisyphus / Adik Tendou dari garis waktu paralel)', 'Bistro la Salle',
      'Kemampuan melukis peri dan ikatan langsung dengan dimensi asal Native Worm akibat insiden meteor Shibuya.',
      'Pramusaji pendiam di Bistro la Salle yang berteman dekat dengan Arata Kagami dan menyimpan rahasia mendalam bersama Souji Tendou sejak tragedi Shibuya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shuichi Tadokoro') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Shuichi Tadokoro', 'Shuichi Tadokoro', 'Yoshiyuki Yamaguchi', 'Ally',
      'Manusia / Native', 'ZECT',
      'Komando lapangan ZECT serta ketenangan strategis dalam memimpin satuan penumpasan Worm.',
      'Komandan divisi lapangan ZECT sekaligus atasan langsung Arata Kagami yang selalu membela anggotanya meskipun menyimpan rahasia sebagai bangsa Native.',
      'Episode 1', 'https://kamenrider.fandom.com/wiki/Shuichi_Tadokoro'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Masato Mishima') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Masato Mishima', 'Masato Mishima', 'Tomohisa Yuge', 'Villain',
      'Manusia (kelak bermutasi menjadi Gryllus Worm)', 'ZECT',
      'Otoritas tinggi ZECT, manipulasi politik, serta kekuatan Gryllus Worm di babak akhir.',
      'Tangan kanan pimpinan ZECT yang dingin dan kejam tanpa rasa empati, diam-diam menjalankan rencana rahasia untuk menguasai umat manusia.',
      'Episode 1', 'https://kamenrider.fandom.com/wiki/Masato_Mishima'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Reiji Nogi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Reiji Nogi', 'Reiji Nogi', 'Taku Sakaguchi', 'Villain',
      'Worm (Cassis Worm)', 'Worm',
      'Kemampuan menghentikan waktu Freeze yang bahkan melampaui Clock Up milik para Rider.',
      'Salah satu komandan terkuat bangsa Worm dalam wujud Cassis Worm yang memiliki kekuatan menghentikan ruang waktu serta meregenerasi diri.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kabuto'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiro Mizushima') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hiro Mizushima', '水嶋 ヒロ', 'Souji Tendou / Kamen Rider Kabuto', 'MC', v_series_id, 'Aktor ternama Jepang yang melejit lewat perannya sebagai Souji Tendou dengan kalimat khasnya di serial Kabuto.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Yuki Sato') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Yuki Sato', 'Arata Kagami / Kamen Rider Gatack', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran Arata Kagami yang tampil dalam seluruh alur utama Kabuto hingga proyek spesial Zi-O.');
  END IF;


  -- ===========================================================================
  -- 8. KAMEN RIDER DEN-O (2007)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Den-O', '仮面ライダー電王', 'Kamen Rider', 'Heisei', 2007, '2007-01-28', '2008-01-20',
      49, 'Toei Company', 'Kereta Waktu & Makhluk Imagin',
      'Ryotaro Nogami, pemuda berhati lembut yang kerap ditimpa kesialan, menemukan tiket waktu Rider Pass dan terpilih sebagai Singularity Point yang mampu menampung makhluk masa depan bernama Imagin. Bersama empat Imagin nyentrik—Momotaros, Urataros, Kintaros, dan Ryutaros—ia menaiki kereta waktu DenLiner untuk menghentikan rencana Kai yang ingin memusnahkan sejarah.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー電王'),
      aired_from = COALESCE(aired_from, '2007-01-28'),
      aired_to   = COALESCE(aired_to, '2008-01-20'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Kereta Waktu & Makhluk Imagin'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O')
    WHERE id = v_series_id;
  END IF;

  IF EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Den-O') THEN
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Kamen Rider Den-O'),
      civilian_name = COALESCE(civilian_name, 'Ryotaro Nogami'),
      actor         = COALESCE(actor, 'Takeru Satoh'),
      role          = COALESCE(role, 'Main Rider'),
      species       = COALESCE(species, 'Manusia (Singularity Point)'),
      team          = COALESCE(team, 'Kru DenLiner & Imagin Taros'),
      power         = COALESCE(power, 'Sabuk Den-O Belt & Rider Pass, senjata serbaguna DenGasher, wujud Sword/Rod/Ax/Gun/Climax/Liner Form, serta kereta waktu DenLiner.'),
      bio           = COALESCE(bio, 'Pemuda yang sangat tidak beruntung namun berhati teguh dan kebal terhadap perubahan arus waktu. Bersama keempat Taros yang merasukinya, ia bertempur melindungi kenangan umat manusia.'),
      debut_episode = COALESCE(debut_episode, 'Episode 1'),
      source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Ryotaro_Nogami')
    WHERE series_id = v_series_id AND name = 'Kamen Rider Den-O';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Zeronos') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Zeronos', 'Kamen Rider Zeronos', 'Yuto Sakurai', 'Yuichi Nakamura', 'Secondary Rider',
      'Manusia (dari masa lalu)', 'Kru ZeroLiner',
      'Zeronos Belt & kartu pengubah yang membakar ingatan orang tentang dirinya, senjata ZeroGasher, serta kereta ZeroLiner.',
      'Pemuda misterius yang datang bersama Imagin Deneb untuk melindungi titik waktu krusial meski setiap transformasinya mengorbankan kenangan orang lain tentang dirinya.',
      'Episode 20', 'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Momotaros') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Momotaros', 'Toshihiko Seki', 'Ally',
      'Imagin', 'Kru DenLiner & Imagin Taros',
      'Merubah Ryotaro menjadi Den-O Sword Form dengan penguasaan pedang agresif dan pedang Momotarosword.',
      'Imagin merah pemarah yang terinspirasi kisah Momotaro. Meskipun ceroboh dan suka berkelahi, ia sangat setia terhadap Ryotaro maupun rekan-rekannya di DenLiner.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Urataros') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Urataros', 'Koji Yusa', 'Ally',
      'Imagin', 'Kru DenLiner & Imagin Taros',
      'Mengaktifkan Den-O Rod Form bertema penyu dengan keahlian taktis dan senjata tombak DenGasher Rod Mode.',
      'Imagin biru bertema Urashima Taro yang santun, cerdik, dan gemar merayu wanita. Ia kerap menyusun strategi tenang bagi tim DenLiner.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kintaros') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kintaros', 'Masaki Terasoma', 'Ally',
      'Imagin', 'Kru DenLiner & Imagin Taros',
      'Mengaktifkan Den-O Ax Form bertema beruang dengan kekuatan fisik raksasa dan senjata kapak.',
      'Imagin kuning berdialek Kansai yang bertubuh kekar dan menjunjung tinggi kehormatan, sering tertidur sebelum terbangun saat mendengar kata yang menyentuh perasaannya.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ryutaros') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Ryutaros', 'Kenichi Suzumura', 'Ally',
      'Imagin', 'Kru DenLiner & Imagin Taros',
      'Mengaktifkan Den-O Gun Form bertema naga dengan gerakan breakdance lincah dan tembakan beruntun.',
      'Imagin ungu yang kekanak-kanakan, suka menari dan menyayangi hewan, serta sangat protektif terhadap kakak Ryotaro, Airi Nogami.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hana') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Hana', 'Yuriko Shiratori', 'Ally',
      'Manusia (Singularity Point)', 'Kru DenLiner',
      'Penjaga ketertiban di dalam gerbong DenLiner dengan pukulan keras terhadap Imagin yang berulah.',
      'Gadis pemberani dari masa depan yang garis waktunya musnah akibat ulah Imagin, merekrut Ryotaro untuk menjadi Den-O sebelum kelak mengecil menjadi sosok Kohana.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kai') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kai', 'Hideo Ishiguro', 'Villain',
      'Manusia (dari masa depan)', 'Komandan Pasukan Imagin',
      'Membuka portal waktu untuk mengirim Imagin secara langsung ke masa lalu demi menggantikan masa depan umat manusia.',
      'Pemuda misterius dari masa depan yang mengomandoi para Imagin jahat untuk mencari dan melenyapkan titik persimpangan garis waktu agar masa depan Imagin tetap terwujud.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Den-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Yuichi Nakamura') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Yuichi Nakamura', 'Yuto Sakurai / Kamen Rider Zeronos', 'Secondary Rider', v_series_id, 'Aktor Jepang yang sebelumnya tampil di Hibiki dan kemudian melejit sebagai pemeran Yuto Sakurai di Kamen Rider Den-O.');
  END IF;


  -- ===========================================================================
  -- 9. KAMEN RIDER KIVA (2008)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Kiva', '仮面ライダーキバ', 'Kamen Rider', 'Heisei', 2008, '2008-01-27', '2009-01-18',
      48, 'Toei Company', 'Vampir, Kelelawar & Musik Klasik',
      'Berjalan dalam dua alur waktu paralel antara tahun 1986 dan 2008, serial ini mengisahkan pengrajin biola pemalu Wataru Kurenai yang bertarung sebagai Kamen Rider Kiva menghadapi monster pemakan energi bernama Fangire. Masa lalunya terikat erat dengan petualangan sang ayah yang karismatik, Otoya Kurenai, bersama para pemburu Fangire dari organisasi Wonderful Blue Sky.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーキバ'),
      aired_from = COALESCE(aired_from, '2008-01-27'),
      aired_to   = COALESCE(aired_to, '2009-01-18'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Vampir, Kelelawar & Musik Klasik'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kiva') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Kiva', 'Kamen Rider Kiva', 'Wataru Kurenai', 'Koji Seto', 'Main Rider',
      'Hibrida Manusia - Fangire', 'Keluarga Kurenai',
      'Gigitan Kivat-bat the 3rd, wujud Garulu/Basshaa/Dogga dengan Castle Doran, pedang Zanvat Sword, serta Emperor Form.',
      'Pemuda pemalu yang gemar membuat biola memakai resep rahasia dan awalnya merasa alergi terhadap dunia luar. Ia mewarisi darah separuh Fangire sekaligus kebaikan hati ayahnya untuk mendamaikan dua ras.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider IXA') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider IXA', 'Kamen Rider IXA', 'Keisuke Nago', 'Keisuke Kato', 'Secondary Rider',
      'Manusia', 'Wonderful Blue Sky Organization',
      'Sistem zirah anti-Fangire Ixa Knuckle & Ixa Calibur dengan Burst Mode serta Rising IXA.',
      'Pemburu bayaran fanatik pembela keadilan dari Wonderful Blue Sky yang awalnya memusuhi Kiva sebelum menjadi rekan sekaligus kakak senior bagi Wataru di garis depan 2008.',
      'Episode 13', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Saga') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Saga', 'Kamen Rider Saga', 'Taiga Nobori', 'Shoma Yamamoto', 'Secondary Rider',
      'Fangire (King 2008)', 'Checkmate Four (Fangire)',
      'Sabuk Sagarc, pedang-cambuk Jacorder, dan kemudian mewarisi kekuatan Kamen Rider Dark Kiva.',
      'Putra mahkota Fangire sekaligus sahabat masa kecil Wataru tanpa mengetahui bahwa mereka berdua adalah saudara tiri seibu.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Otoya Kurenai') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Otoya Kurenai', 'Kamen Rider Dark Kiva', 'Otoya Kurenai', 'Kohei Takeda', 'Ally',
      'Manusia', 'Wonderful Blue Sky Organization (1986)',
      'Pemain biola jenius yang nekat mengenakan Ixa System prototipe maupun sabuk mematikan Dark Kiva demi cinta.',
      'Ayah kandung Wataru pada alur waktu 1986 yang ceria, pemberani, dan genit. Kisah cintanya dengan Ratu Fangire Maya menjadi akar seluruh konflik di tahun 2008.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Megumi Aso') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Megumi Aso', 'Megumi Aso', 'Nana Yanagisawa', 'Ally',
      'Manusia', 'Wonderful Blue Sky Organization',
      'Ahli pertarungan tangan kosong pemburu Fangire mewarisi kemampuan ibunya Yuri Aso serta pernah mengenakan IXA.',
      'Model muda berbakat yang juga bekerja sebagai pemburu Fangire handal dan menjadi teman dekat sekaligus pelindung Wataru di masa kini.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kivat-bat the 3rd') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kivat-bat the 3rd', 'Tomokazu Sugita', 'Ally',
      'Ras Kivat', 'Keluarga Kurenai',
      'Gigitan aktifasi kekuatan Kiva serta Fuestle peluit pembangkit wujud Garulu, Basshaa, Dogga, hingga Emperor.',
      'Kelelawar mekanik cerdas yang berbicara cepat dan menjadi mitra transformasi setia Wataru Kurenai dalam memerangi para Fangire.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'King (1986)') THEN
    INSERT INTO characters (series_id, name, rider_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'King (1986)', 'Kamen Rider Dark Kiva', 'Shinya Niiro', 'Villain',
      'Fangire (Bat Fangire)', 'Checkmate Four (Fangire)',
      'Pemilik asli zirah terlarang Dark Kiva dengan daya penghancur absolut dan wujud Bat Fangire.',
      'Raja kejam ras Fangire pada tahun 1986 dan ayah kandung Taiga Nobori yang menghukum mati pengkhianat bangsanya tanpa belas kasihan.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Bishop') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Bishop', 'Mitsu Murata', 'Villain',
      'Fangire (Swallowtail Fangire)', 'Checkmate Four (Fangire)',
      'Sihir pengawasan atas hukum murni ras Fangire serta kekuatan tempur Swallowtail Fangire.',
      'Anggota Checkmate Four yang paling fanatik mempertahankan kemurnian ras Fangire dan berusaha menyingkirkan Wataru Kurenai maupun persatuan dengan manusia.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Kiva'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Koji Seto') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Koji Seto', '瀬戸 康史', 'Wataru Kurenai / Kamen Rider Kiva', 'MC', v_series_id, 'Aktor Jepang yang membintangi Wataru Kurenai sekaligus ikut membawakan lagu tema serial Kiva bersama grup Tetra-Fang.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Keisuke Kato') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Keisuke Kato', 'Keisuke Nago / Kamen Rider IXA', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran Keisuke Nago yang dikenal lewat ketegasan karakter dan slogan khasnya di Kiva.');
  END IF;

END $$;
