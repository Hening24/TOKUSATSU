-- =============================================================================
-- SEED DATA: KAMEN RIDER ERA HEISEI TAHAP 2 (2009–2019: DECADE–ZI-O)
-- IDEMPOTEN: Cek berdasarkan title (series) dan (series_id, name) (characters/actors).
-- HANYA mengisi kolom NULL pada data yang sudah ada (COALESCE), tidak menimpa editan manual.
-- TIDAK mengisi statistik fisik (height_cm, weight_kg, dll.) pada tahap ini.
-- Mencari series_id lewat subquery berdasarkan title.
-- Cakupan (12 Series):
--   1. Kamen Rider Decade (2009)    [baru]
--   2. Kamen Rider W (2009)         [baru]
--   3. Kamen Rider OOO (2010)       [baru]
--   4. Kamen Rider Fourze (2011)    [baru]
--   5. Kamen Rider Wizard (2012)    [baru]
--   6. Kamen Rider Gaim (2013)      [baru]
--   7. Kamen Rider Drive (2014)     [baru]
--   8. Kamen Rider Ghost (2015)     [baru]
--   9. Kamen Rider Amazons (2016)   [baru — seri web era Heisei]
--  10. Kamen Rider Ex-Aid (2016)    [baru]
--  11. Kamen Rider Build (2017)     [sudah ada — diperkaya]
--  12. Kamen Rider Zi-O (2018)      [baru]
-- Sumber verifikasi: Wikipedia ("List of Kamen Rider series") & Kamen Rider Wiki.
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER DECADE (2009)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Decade' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Decade', '仮面ライダーディケイド', 'Kamen Rider', 'Heisei', 2009, '2009-01-25', '2009-08-30',
      31, 'Toei Company', 'Barcode, Kamera & Kartu Lintas Dimensi',
      'Serial perayaan sepuluh tahun era Heisei yang mengikuti Tsukasa Kadoya, pemuda amnesia yang tinggal di Studio Foto Hikari bersama Natsumi Hikari. Ketika sembilan dunia Kamen Rider sebelumnya mulai bertabrakan dan menuju kehancuran, Tsukasa berubah menjadi Kamen Rider Decade untuk menjelajahi dunia paralel dan menyatukan kembali takdir para Rider.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーディケイド'),
      aired_from = COALESCE(aired_from, '2009-01-25'),
      aired_to   = COALESCE(aired_to, '2009-08-30'),
      episodes   = COALESCE(episodes, 31),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Barcode, Kamera & Kartu Lintas Dimensi'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Decade')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Decade') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Decade', 'Kamen Rider Decade', 'Tsukasa Kadoya', 'Masahiro Inoue', 'Main Rider',
      'Manusia', 'Studio Foto Hikari',
      'Decadriver & Rider Cards yang memungkinkannya berubah wujud serta meniru kekuatan seluruh sembilan Kamen Rider Heisei pendahulunya, senjata Ride Booker, dan Complete Form.',
      'Pemuda percaya diri yang kehilangan ingatan masa lalunya dan sering memotret dunia yang ia kunjungi dengan hasil foto kabur. Ia mengemban peran berat sebagai penghancur sekaligus penyelamat sembilan dunia Rider.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Diend') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Diend', 'Kamen Rider Diend', 'Daiki Kaito', 'Kimito Totani', 'Secondary Rider',
      'Manusia', 'Independen (Pencuri Harta Lintas Dunia)',
      'Senapan pengubah Diendriver yang mampu memanggil Rider lain sebagai sekutu tempur menggunakan Rider Cards.',
      'Pencuri harta karun lintas dimensi yang mengenal masa lalu Tsukasa dan kerap muncul di berbagai dunia untuk memburu benda berharga.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Natsumi Hikari') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Natsumi Hikari', 'Natsumi Hikari', 'Kanna Mori', 'Ally',
      'Manusia', 'Studio Foto Hikari',
      'Teknik penekan titik saraf Warai no Tsubo untuk mendisiplinkan Tsukasa dan dukungan perjalanan antardunia.',
      'Cucu pemilik Studio Foto Hikari yang mengawasi Tsukasa selama berkelana melintasi dunia paralel agar ramalan mimpi buruk tentang Decade tidak terwujud.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Narutaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Narutaki', 'Narutaki', 'Renji Ishibashi', 'Villain',
      'Manusia Misterius', 'Independen',
      'Kemampuan membuka tirai dimensi Aurora Curtain untuk memanggil monster maupun Rider dari dunia lain melawan Decade.',
      'Pria misterius berjaket abu-abu yang terus mengutuk keberadaan Decade sebagai iblis perusak dunia dan memprovokasi Rider lain untuk menghancurkannya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Apollo Geist') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Apollo Geist', 'Kazuhisa Kawahara', 'Villain',
      'Cyborg Dai-Shocker', 'Dai-Shocker',
      'Tameng Gaia Shield, pedang ganda, dan kemampuan menyedot energi kehidupan demi memperpanjang nyawanya.',
      'Perwira kejam dari sindikat lintas dimensi Dai-Shocker yang menargetkan dunia paralel serta berduel langsung melawan Decade dan sekutunya.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Decade'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Masahiro Inoue') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Masahiro Inoue', '井上 正大', 'Tsukasa Kadoya / Kamen Rider Decade', 'MC', v_series_id, 'Aktor Jepang pemeran Tsukasa Kadoya yang terus tampil memerankan tokoh ikonik Decade dalam berbagai film dan serial lintas generasi.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Kimito Totani') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Kimito Totani', 'Daiki Kaito / Kamen Rider Diend', 'Secondary Rider', v_series_id, 'Aktor dan pengisi suara Jepang yang memerankan pencuri antardimensi Daiki Kaito.');
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER W (2009)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider W' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider W', '仮面ライダーＷ（ダブル）', 'Kamen Rider', 'Heisei', 2009, '2009-09-06', '2010-08-29',
      49, 'Toei Company', 'Detektif, Memori USB & Dua Jiwa Satu Tubuh',
      'Di kota berangin Futo, sindikat bawah tanah Museum mendistribusikan perangkat memori terlarang bernama Gaia Memory yang mengubah penggunanya menjadi monster Dopant. Detektif swasta Shotaro Hidari dan rekannya yang memiliki akses perpustakaan pengetahuan bumi, Philip, menggabungkan kesadaran mereka melalui Double Driver untuk bertransformasi menjadi Kamen Rider W.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーＷ（ダブル）'),
      aired_from = COALESCE(aired_from, '2009-09-06'),
      aired_to   = COALESCE(aired_to, '2010-08-29'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Detektif, Memori USB & Dua Jiwa Satu Tubuh'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_W')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider W') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider W', 'Kamen Rider W', 'Shotaro Hidari', 'Renn Kiriyama', 'Main Rider',
      'Manusia', 'Kantor Detektif Narumi',
      'Double Driver dengan kombinasi Gaia Memory seperti CycloneJoker, HeatMetal, LunaTrigger, hingga FangJoker dan CycloneJoker Xtreme.',
      'Detektif swasta bergaya hard-boiled di Kantor Detektif Narumi yang sangat mencintai kota Futo. Ia bertindak sebagai tubuh fisik sekaligus pengendali utama saat bergabung dengan kesadaran Philip menjadi Kamen Rider W.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Philip') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Philip', 'Kamen Rider W', 'Raito Sonozaki', 'Masaki Suda', 'Main Rider',
      'Manusia Data (Avatar Planet Bumi)', 'Kantor Detektif Narumi',
      'Akses penuh ke Earth Library (Perpustakaan Bumi) serta mentransfer kesadarannya ke sisi kanan tubuh Kamen Rider W lewat Gaia Memory Cyclone, Heat, atau Luna.',
      'Pemuda jenius tanpa ingatan masa lalu yang bekerja bersama Shotaro memecahkan kasus Dopant lewat riset instan Earth Library sebelum mengungkap keterkaitannya dengan keluarga Sonozaki.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Accel') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Accel', 'Kamen Rider Accel', 'Ryu Terui', 'Minehiro Kinomoto', 'Secondary Rider',
      'Manusia', 'Kepolisian Futo (Divisi Kejahatan Supranatural)',
      'Accel Driver berbentuk stang motor dengan pedang Engine Blade, kemampuan berubah jadi sepeda motor Bike Form, serta Accel Trial super cepat.',
      'Inspektur polisi dingin yang bergabung menyelidiki kejahatan Dopant demi membalaskan kematian keluarganya. Seiring waktu ia menjadi sekutu tangguh Shotaro serta menikahi Akiko Narumi.',
      'Episode 19', 'https://kamenrider.fandom.com/wiki/Ryu_Terui'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Akiko Narumi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Akiko Narumi', 'Akiko Narumi', 'Hikaru Yamamoto', 'Ally',
      'Manusia', 'Kantor Detektif Narumi',
      'Kepemimpinan operasional kantor detektif serta pukulan sandal hijau khas terhadap tingkah laku konyol rekan-rekannya.',
      'Putri dari pendiri Kantor Detektif Narumi, Sokichi Narumi, yang datang dari Osaka mengambil alih kepemilikan kantor sekaligus menjadi penyemangat bagi Shotaro dan Philip.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ryubee Sonozaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Ryubee Sonozaki', 'Ryubee Sonozaki', 'Minori Terada', 'Villain',
      'Manusia (Pengguna Gaia Memory)', 'Museum / Keluarga Sonozaki',
      'Gaia Memory Terror yang mampu melumpuhkan lawan lewat rasa takut mendalam serta memanggil Terror Dragon raksasa.',
      'Kepala keluarga Sonozaki yang terpandang sekaligus pemimpin tertinggi organisasi sindikat gelap Museum di kota Futo.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Saeko Sonozaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Saeko Sonozaki', 'Saeko Sonozaki', 'Ami Namai', 'Villain',
      'Manusia (Pengguna Gaia Memory)', 'Museum / Keluarga Sonozaki',
      'Gaia Memory Taboo yang memberinya kemampuan terbang dan menembakkan bola energi penghancur.',
      'Putri sulung keluarga Sonozaki yang ambisius dan bertekad merebut kendali penuh atas organisasi Museum bahkan dengan mengkhianati keluarganya sendiri.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Wakana Sonozaki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Wakana Sonozaki', 'Wakana Sonozaki', 'Rin Asuka', 'Villain',
      'Manusia (Pengguna Gaia Memory)', 'Museum / Keluarga Sonozaki',
      'Gaia Memory Clay Doll dengan daya regenerasi tubuh tanah liat dan meriam energi lengan.',
      'Putri bungsu keluarga Sonozaki sekaligus penyiar radio populer di Futo yang diam-diam terlibat dalam perdagangan Gaia Memory sebelum mengetahui keterhubungannya dengan Philip.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_W'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Renn Kiriyama') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Renn Kiriyama', '桐山 漣', 'Shotaro Hidari / Kamen Rider W', 'MC', v_series_id, 'Aktor Jepang yang memerankan separuh protagonis utama Shotaro Hidari dalam serial detektif Kamen Rider W.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Masaki Suda') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Masaki Suda', '菅田 将暉', 'Philip / Kamen Rider W', 'MC', v_series_id, 'Aktor papan atas Jepang yang melambung namanya sejak memerankan tokoh Philip pada usia remaja di Kamen Rider W.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Minehiro Kinomoto') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Minehiro Kinomoto', '木ノ本 嶺浩', 'Ryu Terui / Kamen Rider Accel', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran inspektur polisi Ryu Terui sebagai Kamen Rider Accel.');
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER OOO (2010)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider OOO' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider OOO', '仮面ライダーOOO（オーズ）', 'Kamen Rider', 'Heisei', 2010, '2010-09-05', '2011-08-28',
      48, 'Toei Company', 'Koin Medali, Hewan & Keinginan Manusia',
      'Monster kuno bernama Greeed bangkit setelah 800 tahun tersegel akibat keserakahan manusia dan menciptakan monster Yummy memakai koin Cell Medal. Pengembara tanpa harta bernama Eiji Hino bekerja sama secara tak terduga dengan Greeed berwujud lengan bernama Ankh untuk bertarung sebagai Kamen Rider OOO menggunakan kekuatan tiga Core Medal.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーOOO（オーズ）'),
      aired_from = COALESCE(aired_from, '2010-09-05'),
      aired_to   = COALESCE(aired_to, '2011-08-28'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Koin Medali, Hewan & Keinginan Manusia'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider OOO') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider OOO', 'Kamen Rider OOO', 'Eiji Hino', 'Shu Watanabe', 'Main Rider',
      'Manusia', 'Restoran Cous Coussier',
      'OOO Driver & O Scanner yang memadukan tiga Core Medal berbeda untuk membentuk TaToBa, GataKiriBa, Latorartar, SaGoZo, TaJaDor, ShaUTa, hingga PuToTyra Combo.',
      'Pengelana berhati mulia yang tidak memiliki ambisi pribadi selain sepotong pakaian dalam dan uang secukupnya untuk esok hari, sehingga dipilih Ankh untuk menggunakan sabuk OOO demi menyelamatkan orang lain.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Birth') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Birth', 'Kamen Rider Birth', 'Akira Date', 'Hiroaki Iwanaga', 'Secondary Rider',
      'Manusia', 'Kougami Foundation',
      'Birth Driver & Birth Buster yang memakai koin Cell Medal untuk memanggil unit senjata modular Birth CLAWS.',
      'Mantan dokter tempur tangguh yang direkrut Kougami Foundation untuk mengumpulkan 100 juta yen menggunakan sabuk Birth sebelum meneruskannya kepada asisten setianya Shintaro Goto.',
      'Episode 16', 'https://kamenrider.fandom.com/wiki/Akira_Date'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ankh') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Ankh', 'Shingo Izumi (inang tubuh)', 'Ryosuke Miura', 'Ally',
      'Greeed (Burung)', 'Restoran Cous Coussier',
      'Kendali Core Medal bertema burung (Taka, Kujaku, Condor), sayap api Ankh, serta kemampuan merasuki tubuh detektif Shingo Izumi yang koma.',
      'Greeed bermotif burung yang kehilangan sebagian besar Core Medal miliknya sehingga hanya berwujud lengan kanan dan meminjam tubuh kakak Hina sambil membentuk persahabatan unik dengan Eiji.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hina Izumi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Hina Izumi', 'Hina Izumi', 'Riho Takada', 'Ally',
      'Manusia', 'Restoran Cous Coussier',
      'Kekuatan fisik alami super kuat yang sanggup mengangkat benda berat dan menahan Ankh agar tidak kabur.',
      'Mahasiswi mode sekaligus adik Shingo Izumi yang bekerja di restoran Cous Coussier dan selalu mengawasi kerja sama antara Eiji Hino serta Ankh.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kiyoto Maki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kiyoto Maki', 'Kiyoto Maki', 'Yu Kamio', 'Villain',
      'Greeed (Dinosaurus)', 'Kougami Foundation / Sekutu Greeed',
      'Kendali atas Purple Core Medal dinosaurus yang mengubahnya menjadi Kyoryu Greeed dengan energi pembeku dan penghancur.',
      'Ilmuwan eksentrik yang terobsesi pada konsep akhir zaman agar segala hal tetap indah selamanya, menciptakan sistem Birth sebelum akhirnya bersekutu dengan para Greeed.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Uva') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Uva', 'Yusuke Yamada', 'Villain',
      'Greeed (Serangga)', 'Greeed',
      'Serangan petir dari Core Medal serangga (Kuwagata, Kamakiri, Batta) serta penciptaan Yummy bertema serangga.',
      'Greeed berwatak pemarah dari ras serangga yang paling gigih memburu kembali Core Medal miliknya serta berseteru langsung dengan Ankh maupun OOO.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_OOO'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shu Watanabe') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Shu Watanabe', '渡部 秀', 'Eiji Hino / Kamen Rider OOO', 'MC', v_series_id, 'Aktor Jepang yang membintangi pengembara Eiji Hino dan berduet dengan Ryosuke Miura membawakan salah satu pasangan protagonis terpopuler di Heisei.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroaki Iwanaga') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Hiroaki Iwanaga', 'Akira Date / Kamen Rider Birth', 'Secondary Rider', v_series_id, 'Aktor sekaligus pengisi suara Jepang yang dikenal lewat peran Akira Date dan berbagai serial aksi.');
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER FOURZE (2011)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Fourze' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Fourze', '仮面ライダーフォーゼ', 'Kamen Rider', 'Heisei', 2011, '2011-09-04', '2012-08-26',
      48, 'Toei Company', 'Astronaut, Roket Antariksa & Kehidupan SMA',
      'Di SMA Amanogawa yang prestisius, siswa pindahan berambut jambul bergaya berandalan namun sangat ramah bernama Gentaro Kisaragi bertekad berteman dengan seluruh murid di sekolahnya. Ketika monster rasi bintang bernama Zodiarts muncul dari penyalahgunaan perangkat kosmik, Gentaro membentuk Kamen Rider Club dan bertarung sebagai Kamen Rider Fourze memakai Astroswitch.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーフォーゼ'),
      aired_from = COALESCE(aired_from, '2011-09-04'),
      aired_to   = COALESCE(aired_to, '2012-08-26'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Astronaut, Roket Antariksa & Kehidupan SMA'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Fourze') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Fourze', 'Kamen Rider Fourze', 'Gentaro Kisaragi', 'Sota Fukushi', 'Main Rider',
      'Manusia', 'Kamen Rider Club (SMA Amanogawa)',
      'Fourze Driver & 40 Astroswitch yang memasangkan modul roket, bor, radar, maupun perubahan Fire, Elek, Magnet, hingga Cosmic States.',
      'Siswa pindahan energik berhati hangat yang bersumpah menjadikan setiap murid di SMA Amanogawa sebagai sahabatnya, termasuk para pengguna Zodiarts Switch yang tersesat.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Meteor') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Meteor', 'Kamen Rider Meteor', 'Ryusei Sakuta', 'Ryo Yoshizawa', 'Secondary Rider',
      'Manusia', 'Anti-Zodiarts Union / Kamen Rider Club',
      'Meteor Driver bertema planet dan bola langit, seni bela diri Jeet Kune Do, serta Meteor Storm.',
      'Siswa pertukaran yang awalnya menyembunyikan identitas aslinya demi menyelamatkan sahabatnya yang koma akibat Aries Switch sebelum akhirnya luluh oleh persahabatan tulus Gentaro.',
      'Episode 17', 'https://kamenrider.fandom.com/wiki/Ryusei_Sakuta'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yuki Jojima') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Yuki Jojima', 'Yuki Jojima', 'Fumika Shimizu', 'Ally',
      'Manusia', 'Kamen Rider Club (SMA Amanogawa)',
      'Ketua sekaligus penggerak utama Kamen Rider Club serta pengetahuan antariksa yang mendalam.',
      'Teman masa kecil Gentaro yang terobsesi menjadi astronaut dan memicu berdirinya Kamen Rider Club di markas pangkalan bulan Rabbit Hutch.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kengo Utahoshi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kengo Utahoshi', 'Kengo Utahoshi', 'Ryuki Takahashi', 'Ally',
      'Core Child (Entitas Kosmik berwujud manusia)', 'Kamen Rider Club (SMA Amanogawa)',
      'Jenius pembuat dan analis teknologi Astroswitch yang diwariskan oleh ayahnya.',
      'Pemuda cerdas bertubuh lemah yang menjadi mitra otak bagi Gentaro di Kamen Rider Club sekaligus menyimpan rahasia asal-usul Core Switch.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Sagittarius Zodiarts') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Sagittarius Zodiarts', 'Mitsuaki Gamou', 'Shingo Tsurumi', 'Villain',
      'Horoscopes (Zodiarts)', 'Horoscopes (SMA Amanogawa)',
      'Wujud Horoscopes Sagittarius Zodiarts dengan panah kosmik dan evolusi Sagittarius Nova.',
      'Kepala Yayasan SMA Amanogawa sekaligus pemimpin kelompok rahasia Horoscopes yang menyebar Zodiarts Switch demi mencapai The Presenter di luar angkasa.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Fourze'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Sota Fukushi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Sota Fukushi', '福士 蒼汰', 'Gentaro Kisaragi / Kamen Rider Fourze', 'MC', v_series_id, 'Aktor ternama Jepang yang meraih popularitas besar usai memerankan murid ramah berambut unik Gentaro Kisaragi.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Ryo Yoshizawa') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Ryo Yoshizawa', 'Ryusei Sakuta / Kamen Rider Meteor', 'Secondary Rider', v_series_id, 'Aktor Jepang berprestasi yang memulai pengenalan luasnya melalui karakter Ryusei Sakuta di Kamen Rider Fourze.');
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER WIZARD (2012)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Wizard' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Wizard', '仮面ライダーウィザード', 'Kamen Rider', 'Heisei', 2012, '2012-09-02', '2013-09-29',
      53, 'Toei Company', 'Sihir, Cincin Permata & Naga Elemen',
      'Saat gerhana matahari memicu ritual kejam Sabbat yang melahirkan monster pemakan keputusasaan bernama Phantom, seorang pemuda bernama Haruto Soma berhasil menekan Phantom di dalam dirinya dan bertahan hidup berbekal harapan. Dianugerahi Wizardriver dan cincin sihir oleh Penyihir Putih misterius, Haruto bertarung sebagai Kamen Rider Wizard menjadi harapan terakhir bagi para calon korban baru.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーウィザード'),
      aired_from = COALESCE(aired_from, '2012-09-02'),
      aired_to   = COALESCE(aired_to, '2013-09-29'),
      episodes   = COALESCE(episodes, 53),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Sihir, Cincin Permata & Naga Elemen'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Wizard') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Wizard', 'Kamen Rider Wizard', 'Haruto Soma', 'Shunya Shiraishi', 'Main Rider',
      'Manusia (Penyintas Sabbat / Inang WizarDragon)', 'Toko Barang Antik Omokagedo',
      'Wizardriver & Wizard Rings elemen Flame, Water, Hurricane, Land, WizarSwordGun, serta wujud Dragon dan Infinity Style.',
      'Mantan calon pesepak bola yang mengabdikan hidupnya melindungi harapan manusia dari keputusasaan Phantom sambil menjaga kelangsungan hidup gadis misterius bernama Koyomi.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Beast') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Beast', 'Kamen Rider Beast', 'Kosuke Nitoh', 'Tasuku Nagase', 'Secondary Rider',
      'Manusia (Inang Beast Chimera)', 'Sekutu Haruto Soma',
      'Beast Driver kuno dengan kekuatan roh Beast Chimera (Falco, Buffa, Chameleo, Dolphi), Dice Saber, serta Beast Hyper.',
      'Mahasiswa arkeologi penggemar mayones yang menemukan sabuk Beast Chimera dan harus melahap energi sihir Phantom agar Chimera tidak memangsanya sendiri.',
      'Episode 17', 'https://kamenrider.fandom.com/wiki/Kosuke_Nitoh'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Koyomi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Koyomi', 'Koyomi', 'Makoto Okunaka', 'Ally',
      'Boneka Sihir (bertahan lewat Batu Filosofis)', 'Toko Barang Antik Omokagedo',
      'Kemampuan mendeteksi penyamaran Phantom di tengah masyarakat dan kepekaan terhadap aliran mana.',
      'Gadis pendiam yang diselamatkan Haruto pasca-Sabbat dan bergantung pada pasokan mana dari Haruto untuk bertahan hidup sementara menyimpan inti rahasia Wiseman.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Wiseman') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Wiseman', 'Kamen Rider Wiseman (White Wizard)', 'Sou Fueki', 'Narushi Ikeda', 'Villain',
      'Penyihir / Manusia', 'Pemimpin Para Phantom',
      'Sabuk White Wizard, cincin sihir mutlak termasuk Explosion dan Teleport, serta kendali penuh atas Sabbat.',
      'Fisikawan sekaligus ayah kandung Koyomi yang rela menggelar ritual Sabbat demi mencari empat penyihir baru untuk membangkitkan kembali putrinya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Phoenix') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Phoenix', 'Yugo Fujita (inang asli)', 'Atsumi', 'Villain',
      'Phantom (Burung Api)', 'Phantom',
      'Pedang raksasa Catastrophe, manipulasi api neraka, dan keabadian bangkit kembali lebih kuat setiap kali dihancurkan.',
      'Panglima Phantom brutal yang haus pertarungan fisik dan menjadi lawan tangguh berulang bagi Kamen Rider Wizard sebelum akhirnya dilempar ke Matahari.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Medusa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Medusa', 'Misa Inamori (inang asli)', 'Erina Nakayama', 'Villain',
      'Phantom (Medusa)', 'Phantom',
      'Tongkat Arrogant, ular rambut yang mampu menyerap energi, serta kemampuan melacak calon Gate.',
      'Komandan wanita dingin yang sangat setia kepada Wiseman dan terus memburu calon korban Gate baru tanpa mengetahui bahwa Wiseman hanya memanfaatkannya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Wizard'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shunya Shiraishi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Shunya Shiraishi', '白石 隼也', 'Haruto Soma / Kamen Rider Wizard', 'MC', v_series_id, 'Aktor Jepang yang memerankan penyihir modern Haruto Soma yang penuh gaya akrobatik di sepanjang serial Wizard.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Tasuku Nagase') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Tasuku Nagase', 'Kosuke Nitoh / Kamen Rider Beast', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran arkeolog eksentrik Kosuke Nitoh.');
  END IF;


  -- ===========================================================================
  -- 6. KAMEN RIDER GAIM (2013)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Gaim' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Gaim', '仮面ライダー鎧武（ガイム）', 'Kamen Rider', 'Heisei', 2013, '2013-10-06', '2014-09-28',
      47, 'Toei Company', 'Samurai Sengoku & Buah-buahan',
      'Di Kota Zawame yang dikuasai korporasi Yggdrasill, kelompok penari jalanan bertarung memakai makhluk mini Inves menggunakan perangkat Lockseed. Pemuda baik hati Kota Kazuraba menemukan Sengoku Driver untuk menjadi Kamen Rider Gaim demi membantu teman-temannya, namun permainan tarian jalanan itu perlahan berubah menjadi perebutan Buah Terlarang yang menentukan nasib seluruh umat manusia.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダー鎧武（ガイム）'),
      aired_from = COALESCE(aired_from, '2013-10-06'),
      aired_to   = COALESCE(aired_to, '2014-09-28'),
      episodes   = COALESCE(episodes, 47),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Samurai Sengoku & Buah-buahan'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gaim') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Gaim', 'Kamen Rider Gaim', 'Kota Kazuraba', 'Gaku Sano', 'Main Rider',
      'Manusia (kelak Man of the Beginning / Overlord)', 'Team Gaim',
      'Sengoku Driver & Orange Lockseed dengan pedang Daidaimaru, wujud Jimber Lemon, Kachidoki Arms, hingga Kiwami Arms.',
      'Mantan anggota Team Gaim yang awalnya hanya mencari pekerjaan paruh waktu demi kakaknya sebelum menjadi pelindung utama kota Zawame hingga mencapai kekuatan tertinggi Buah Terlarang.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Baron') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Baron', 'Kamen Rider Baron', 'Kaito Kumon', 'Yutaka Kobayashi', 'Secondary Rider',
      'Manusia (kelak Overlord Lord Baron)', 'Team Baron',
      'Sengoku Driver & Banana Lockseed dengan tombak Bana Spear, Genesis Driver Lemon Energy Arms, serta evolusi Lord Baron.',
      'Pemimpin karismatik Team Baron yang membenci penindasan orang lemah oleh Yggdrasill dan berambisi meraih kekuatan mutlak untuk merombak tatanan dunia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ryugen') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Ryugen', 'Kamen Rider Ryugen', 'Mitsuzane Kureshima', 'Mahiro Takasugi', 'Secondary Rider',
      'Manusia', 'Team Gaim / Yggdrasill',
      'Sengoku Driver & Budou Lockseed dengan pistol naga Budou Ryuhou serta wujud gelap Yomi.',
      'Adik Takatora Kureshima dan teman dekat Kota di Team Gaim yang perlahan terjerumus ke dalam intrik gelap demi melindungi Mai dengan caranya sendiri.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Zangetsu') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Zangetsu', 'Kamen Rider Zangetsu', 'Takatora Kureshima', 'Yuki Kubota', 'Secondary Rider',
      'Manusia', 'Yggdrasill Corporation',
      'Sengoku Driver & Melon Lockseed dengan pedang dan tameng Melon Defender serta Zangetsu Shin bertenaga Genesis Driver.',
      'Eksekutif Yggdrasill yang serius dan rela memikul dosa berat demi menyelamatkan sebagian kecil umat manusia dari ancaman Hutan Helheim.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mai Takatsukasa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mai Takatsukasa', 'Mai Takatsukasa', 'Yuumi Shida', 'Ally',
      'Manusia (kelak Woman of the Beginning)', 'Team Gaim',
      'Kepemimpinan penari Team Gaim serta wadah kekuatan suci Buah Terlarang yang menghubungkan masa lalu dan masa depan.',
      'Gadis pemberani pemimpin tim tari Team Gaim sekaligus sosok yang menyatukan prinsip keadilan Kota dan tekad Kaito.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Rosyuo') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Rosyuo', 'Joji Nakata', 'Villain',
      'Overlord Inves (Raja Femushinmu)', 'Overlord',
      'Kendali mutlak atas tumbuhan Hutan Helheim, manipulasi telekinesis masif, serta kekuatan Buah Terlarang.',
      'Raja bijak sekaligus penguasa Overlord dari peradaban kuno Femushinmu yang menyaksikan kehancuran bangsanya akibat keserakahan dan meragukan kelayakan manusia.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Gaim'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Gaku Sano') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Gaku Sano', '佐野 岳', 'Kota Kazuraba / Kamen Rider Gaim', 'MC', v_series_id, 'Aktor akrobatik Jepang pemenang Junon Superboy Contest yang memukau penggemar lewat adegan aksi langsung sebagai Kota Kazuraba.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Yutaka Kobayashi') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Yutaka Kobayashi', 'Kaito Kumon / Kamen Rider Baron', 'Secondary Rider', v_series_id, 'Aktor sekaligus anggota grup BOYS AND MEN yang memerankan rival utama Kaito Kumon.');
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER DRIVE (2014)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Drive' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Drive', '仮面ライダードライブ', 'Kamen Rider', 'Heisei', 2014, '2014-10-05', '2015-09-27',
      48, 'Toei Company', 'Polisi Detektif & Mobil Sport',
      'Pasca peristiwa Global Freeze yang menghentikan waktu dan memicu kemunculan android pemberontak Roidmude, polisi eks-elit yang kehilangan semangat bernama Shinnosuke Tomari ditempatkan di Divisi Investigasi Khusus. Dipilih oleh sabuk cerdas Mr. Belt dan mengendarai mobil sport Tridoron, Shinnosuke berubah menjadi Kamen Rider Drive untuk memecahkan misteri kriminal Roidmude.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダードライブ'),
      aired_from = COALESCE(aired_from, '2014-10-05'),
      aired_to   = COALESCE(aired_to, '2015-09-27'),
      episodes   = COALESCE(episodes, 48),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Polisi Detektif & Mobil Sport'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Drive') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Drive', 'Kamen Rider Drive', 'Shinnosuke Tomari', 'Ryoma Takeuchi', 'Main Rider',
      'Manusia', 'Divisi Investigasi Khusus Kepolisian',
      'Drive Driver (Mr. Belt), gelang Shift Brace dengan berbagai Shift Cars (Type Speed, Wild, Technic, Deadheat, Formula, Tridoron), dan mobil sport Tridoron.',
      'Detektif polisi brilian yang awalnya malas namun kembali bersemangat saat menghadapi kasus Roidmude sembari menelusuri kebenaran kematian ayahnya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Mach') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Mach', 'Kamen Rider Mach', 'Go Shijima', 'Yu Inaba', 'Secondary Rider',
      'Manusia', 'Divisi Investigasi Khusus (Sekutu)',
      'Mach Driver Honoh dengan Signal Bikes, senapan pistol Zenrin Shooter, serta Mach Chaser.',
      'Fotografer lepas sekaligus adik kandung Kiriko yang ceria namun menyimpan kebencian mendalam terhadap para Roidmude akibat ciptaan ayahnya sendiri.',
      'Episode 12', 'https://kamenrider.fandom.com/wiki/Go_Shijima'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Chaser') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Chaser', 'Kamen Rider Chaser', 'Chase', 'Taiko Katono', 'Secondary Rider',
      'Roidmude (Proto Zero)', 'Divisi Investigasi Khusus (Sekutu)',
      'Break Gunner sebagai Mashin Chaser dan Mach Driver Honoh dengan kapak Signal Ax setelah beralih menjadi Kamen Rider Chaser.',
      'Roidmude prototipe yang sempat diprogram ulang menjadi pemburu kejam Mashin Chaser sebelum Kiriko membantunya mengingat janji sejatinya melindungi manusia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kiriko Shijima') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kiriko Shijima', 'Kiriko Shijima', 'Rio Uchida', 'Ally',
      'Manusia', 'Divisi Investigasi Khusus Kepolisian',
      'Seni bela diri disiplin kepolisian, sepatu pelompat khusus, serta pengawas utama sistem Shift Cars bersama Mr. Belt.',
      'Polisi wanita serius dan berdedikasi tinggi yang selalu menyeret Shinnosuke turun ke lokasi perkara dan menjadi pendamping paling diandalkannya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Heart') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Heart', 'Tomoya Warabino', 'Villain',
      'Roidmude (Nomor 002)', 'Roidmude',
      'Wujud Heart Roidmude dengan peningkatan kekuatan lewat emosi gairah bertarung (Dead Zone & Super Evolution).',
      'Pemimpin mulia bangsa Roidmude yang sangat mencintai rekan-rekannya serta menganggap Shinnosuke Tomari sebagai rival terhormat sekaligus teman sejati.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Brain') THEN
    INSERT INTO characters (series_id, name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Brain', 'Shota Matsushima', 'Villain',
      'Roidmude (Nomor 003)', 'Roidmude',
      'Kecerdasan taktis tinggi, kendali racun serta medan psikis dalam wujud Brain Roidmude.',
      'Tangan kanan Heart yang perfeksionis, cemburu kepada Medic, namun tetap setia hingga berkorban demi melindungi sesama pemimpin Roidmude.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Drive'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Ryoma Takeuchi') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Ryoma Takeuchi', '竹内 涼真', 'Shinnosuke Tomari / Kamen Rider Drive', 'MC', v_series_id, 'Aktor papan atas Jepang yang membintangi serial detektif Kamen Rider Drive sebelum sukses membintangi berbagai drama prime-time.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Yu Inaba') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Yu Inaba', '稲葉 友', 'Go Shijima / Kamen Rider Mach', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran fotografer bersemangat Go Shijima.');
  END IF;


  -- ===========================================================================
  -- 8. KAMEN RIDER GHOST (2015)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Ghost' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Ghost', '仮面ライダーゴースト', 'Kamen Rider', 'Heisei', 2015, '2015-10-04', '2016-09-25',
      50, 'Toei Company', 'Arwah, Bola Mata & Tokoh Sejarah Dunia',
      'Pada ulang tahunnya ke-18, pewaris muda Kuil Daitenku bernama Takeru Tenkuji tewas dibunuh monster dimensi Gamma saat berusaha melindungi sahabatnya. Diberi kesempatan hidup sementara selama 99 hari sebagai Kamen Rider Ghost, Takeru harus mengumpulkan lima belas Eyecon jiwa tokoh sejarah dunia sebelum batas waktunya habis selamanya.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーゴースト'),
      aired_from = COALESCE(aired_from, '2015-10-04'),
      aired_to   = COALESCE(aired_to, '2016-09-25'),
      episodes   = COALESCE(episodes, 50),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Arwah, Bola Mata & Tokoh Sejarah Dunia'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ghost') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Ghost', 'Kamen Rider Ghost', 'Takeru Tenkuji', 'Shun Nishime', 'Main Rider',
      'Manusia (Arwah Sementara / Ghost)', 'Kuil Daitenku',
      'Ghost Driver & Heroic Eyecon (Ore, Musashi, Edison, Newton, Grateful, Mugen Damashii) dengan senjata Gan Gun Saber.',
      'Pemuda baik hati dan gigih yang berpacu dengan batas 99 hari kehidupan sementaranya demi menyelamatkan orang lain serta menyatukan kembali jiwa para tokoh sejarah.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Specter') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Specter', 'Kamen Rider Specter', 'Makoto Fukami', 'Ryosuke Yamamoto', 'Secondary Rider',
      'Manusia Buatan Dunia Gamma', 'Kuil Daitenku',
      'Ghost Driver & Specter Eyecon dengan senjata Gan Gun Hand serta Deep Specter dan Sin Specter.',
      'Petarung dingin yang awalnya bersaing memperebutkan Eyecon demi menghidupkan kembali adik perempuannya Kanon sebelum menjadi sahabat terdekat Takeru.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Necrom') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Necrom', 'Kamen Rider Necrom', 'Alain', 'Hayato Isomura', 'Secondary Rider',
      'Penghuni Dunia Gamma (Pangeran)', 'Kuil Daitenku (kelak sekutu)',
      'Mega Ulorder & Necrom Eyecon yang memungkinkannya memanggil wujud Grimm dan Sanzo serta bertarung langsung.',
      'Pangeran kekaisaran dunia Gamma yang berhati halus dan berubah memihak Takeru setelah belajar arti kebahagiaan hidup bersama manusia di Bumi.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Akari Tsukimura') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Akari Tsukimura', 'Akari Tsukimura', 'Hikaru Ohsawa', 'Ally',
      'Manusia', 'Kuil Daitenku',
      'Kecerdasan sains fisika dan penemuan alat penyemprot Shiranui yang membuat Gamma tak kasatmata terlihat.',
      'Sahabat masa kecil Takeru sekaligus mahasiswi sains yang berpegang teguh pada rasionalitas namun mendukung penuh pencarian Eyecon di Kuil Daitenku.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Adel') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Adel', 'Adel', 'Akihiro Mayama', 'Villain',
      'Penghuni Dunia Gamma', 'Kekaisaran Gamma',
      'Kendali atas sistem Demia, Eyecon penguasa Perfect Gammaizer, serta kekuatan penuh Great Eye.',
      'Kakak kandung Alain yang membunuh ayahnya sendiri Kaisar Adonis demi merebut takhta Dunia Gamma dan berusaha menyeragamkan kesadaran manusia.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ghost'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Shun Nishime') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Shun Nishime', '西銘 駿', 'Takeru Tenkuji / Kamen Rider Ghost', 'MC', v_series_id, 'Aktor Jepang pemenang Junon Superboy Contest yang memerankan Takeru Tenkuji di serial Kamen Rider Ghost.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Ryosuke Yamamoto') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Ryosuke Yamamoto', 'Makoto Fukami / Kamen Rider Specter', 'Secondary Rider', v_series_id, 'Aktor dan model Jepang pemeran Makoto Fukami yang sering kembali tampil di film-film reuni Kamen Rider.');
  END IF;


  -- ===========================================================================
  -- 9. KAMEN RIDER AMAZONS (2016 — Seri Web Era Heisei)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Amazons' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Amazons', '仮面ライダーアマゾンズ', 'Kamen Rider', 'Heisei', 2016, '2016-04-01', NULL,
      26, 'Toei Company', 'Mutasi Sel Biopunk & Predator Buas',
      'Menjadi seri web berorientasi dewasa yang menafsirkan ulang Kamen Rider Amazon secara kelam di dunia di mana ribuan makhluk eksperimen bernama Amazon terlepas di masyarakat. Haruka Mizusawa berjuang menjaga kemanusiaannya sebagai Kamen Rider Amazon Omega, bertolak belakang dengan pemburu kejam Jin Takayama alias Amazon Alpha yang bertekad memusnahkan seluruh Amazon.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーアマゾンズ'),
      aired_from = COALESCE(aired_from, '2016-04-01'),
      episodes   = COALESCE(episodes, 26),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Mutasi Sel Biopunk & Predator Buas'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon Omega') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Amazon Omega', 'Kamen Rider Amazon Omega', 'Haruka Mizusawa', 'Tom Fujita', 'Main Rider',
      'Amazon Buatan (Sel Manusia & Amazon)', 'Tim Pembasmi Nozama Peston Service',
      'Amazons Driver penekan nafsu kanibal dengan cakar Violent Punish dan senjata tombak dari pegangan sabuk.',
      'Pemuda pendiam yang awalnya hidup terkurung dan terkejut mendapati dirinya memiliki sel Amazon. Ia memilih berjuang menentukan siapa yang layak ia lindungi tanpa tunduk pada insting pemangsa.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon Alpha') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Amazon Alpha', 'Kamen Rider Amazon Alpha', 'Jin Takayama', 'Masashi Taniguchi', 'Secondary Rider',
      'Manusia (menyuntikkan sendiri sel Amazon)', 'Independen',
      'Amazons Driver tanpa penahan insting buas yang mengandalkan cakar Violent Slash serta gaya bertarung brutal.',
      'Mantan peneliti Nozama Pharmacy yang menyuntikkan sel Amazon ke tubuhnya sendiri demi memburu dan membantai seluruh makhluk eksperimen ciptaannya tanpa ampun.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mizuki Mizusawa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mizuki Mizusawa', 'Mizuki Mizusawa', 'Rena Takeda', 'Ally',
      'Manusia', 'Organisasi 4C (Musim 2)',
      'Keteguhan melindungi kakaknya dan keberanian bertindak langsung di lapangan sebagai anggota 4C.',
      'Adik angkat Haruka Mizusawa yang terus mencari serta mengkhawatirkan kakaknya meskipun menghadapi kenyataan pahit tentang asal-usul Amazon.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mamoru') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Mamoru', 'Mamoru', 'Ryota Kobayashi', 'Ally',
      'Amazon (Mole Amazon)', 'Nozama Peston Service',
      'Cakar tajam Mole Amazon dengan kecepatan menggali dan kekuatan tempur fisik tinggi.',
      'Amazon ramah penggemar burger yang bekerja membantu tim pembasmi Nozama Peston Service sebelum tragedi membuatnya terpecah antara sahabat manusia dan sesama Amazon.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Nanaha Izumi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Nanaha Izumi', 'Nanaha Izumi', 'Ayu Higashi', 'Ally',
      'Manusia (kelak terinfeksi)', 'Independen',
      'Ketabahan batin mendampingi Jin Takayama serta ikatan biologis yang melahirkan Chihiro di musim kedua.',
      'Kekasih setia Jin Takayama yang merawatnya di masa sulit dan memegang peran sentral dalam tragedi yang memicu peristiwa musim kedua.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Amazons'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Tom Fujita') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Tom Fujita', 'Haruka Mizusawa / Kamen Rider Amazon Omega', 'MC', v_series_id, 'Aktor Jepang yang memerankan protagonis utama bernuansa gelap Haruka Mizusawa dalam dua musim Kamen Rider Amazons.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Masashi Taniguchi') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Masashi Taniguchi', 'Jin Takayama / Kamen Rider Amazon Alpha', 'Secondary Rider', v_series_id, 'Aktor veteran tokusatsu Jepang (sebelumnya GoBlue) yang menuai pujian luas lewat karakter keras Jin Takayama.');
  END IF;


  -- ===========================================================================
  -- 10. KAMEN RIDER EX-AID (2016)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Ex-Aid' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Ex-Aid', '仮面ライダーエグゼイド', 'Kamen Rider', 'Heisei', 2016, '2016-10-02', '2017-08-27',
      45, 'Toei Company', 'Dokter Medis & Video Game Retro',
      'Wabah virus komputer misterius bernama Bugster menginfeksi manusia dan memunculkan monster video game ke dunia nyata. Dokter magang anak sekaligus gamer jenius berjuluk M, Emu Hojo, bergabung dengan departemen rahasia CR sebagai Kamen Rider Ex-Aid untuk menyelamatkan nyawa pasien sembari membongkar ambisi pencipta game Genm Corp.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダーエグゼイド'),
      aired_from = COALESCE(aired_from, '2016-10-02'),
      aired_to   = COALESCE(aired_to, '2017-08-27'),
      episodes   = COALESCE(episodes, 45),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Dokter Medis & Video Game Retro'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ex-Aid') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Ex-Aid', 'Kamen Rider Ex-Aid', 'Emu Hojo', 'Hiroki Iijima', 'Main Rider',
      'Manusia (Pasien Zero Bugster)', 'Cyber Rescue (CR) / RS Universitas Seito',
      'Gamer Driver & Mighty Action X Gashat, Gashacon Breaker, Double Action XX, Maximum Mighty X, hingga Hyper Muteki tak terkalahkan.',
      'Dokter magang pediatri yang kikuk di kehidupan sehari-hari tetapi berubah menjadi gamer jenius berjuluk M saat memegang kontroler demi menyembuhkan pasiennya tanpa ada yang boleh tersakiti.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Brave') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Brave', 'Kamen Rider Brave', 'Hiiro Kagami', 'Toshiki Seto', 'Secondary Rider',
      'Manusia', 'Cyber Rescue (CR) / RS Universitas Seito',
      'Gamer Driver & Taddle Quest Gashat dengan pedang api-es Gashacon Sword serta Taddle Legacy.',
      'Dokter bedah jenius berkarakter dingin dan perfeksionis yang gemar menyantap kue manis sambil memikul luka kehilangan kekasihnya akibat virus Bugster.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Snipe') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Snipe', 'Kamen Rider Snipe', 'Taiga Hanaya', 'Ukyo Matsumoto', 'Secondary Rider',
      'Manusia', 'Independen / Eks-CR',
      'Gamer Driver & Bang Bang Shooting Gashat dengan senapan Gashacon Magnum dan Bang Bang Simulations.',
      'Mantan dokter radiologi tanpa izin praktik yang berambisi mengumpulkan seluruh Gashat demi menyelamatkan orang lain dari risiko operasi kecocokan Bugster.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Lazer') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Lazer', 'Kamen Rider Lazer', 'Kiriya Kujo', 'Hayato Onozuka', 'Ally',
      'Manusia (kelak direkonstruksi sebagai Bugster)', 'Cyber Rescue (Sekutu)',
      'Gamer Driver & Bakusou Bike Gashat (wujud motor balap Level 2 serta Lazer Turbo bertombak Gashacon Sparrow).',
      'Pemeriksa forensik eksentrik yang kerap berbohong namun berjuang mengungkap kebenaran di balik wabah Zero Day hingga mengorbankan nyawanya demi melindungi rahasia Emu.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Poppy') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Poppy', 'Kamen Rider Poppy', 'Asuna Karino / Poppy Pipopapo', 'Ruka Matsuda', 'Ally',
      'Bugster (DoReMiFa Beat)', 'Cyber Rescue (CR)',
      'Navigasi CR serta Buggle Driver II dengan Tokimeki Crisis Gashat sebagai Kamen Rider Poppy.',
      'Asisten ceria di CR yang bertingkah tegas saat menyamar sebagai perawat Asuna Karino dan menjadi teman pendukung terpercaya bagi Emu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Genm') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Genm', 'Kamen Rider Genm', 'Kuroto Dan', 'Tetsuya Iwanaga', 'Villain',
      'Manusia (kelak Bugster abadi dengan 99 nyawa)', 'Genm Corp',
      'Gamer Driver & Proto Mighty Action X, Zombie Gamer Level X-0 dengan puluhan nyawa cadangan, dan God Maximum Mighty X.',
      'CEO eksentrik sekaligus pengembang jenius game Kamen Rider Chronicle yang menganggap bakat desain gamenya setara dewa dan menjadi pencetus konflik dengan Emu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Cronus') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Cronus', 'Kamen Rider Cronus', 'Masamune Dan', 'Hiroyuki Takami', 'Villain',
      'Manusia (Pembawa antibodi sempurna Bugster)', 'Genm Corp',
      'Buggle Driver II & Kamen Rider Chronicle Gashat dengan kekuatan mutlak menghentikan waktu Pause dan Reset.',
      'Ayah kandung Kuroto Dan dan mantan CEO Genm Corp yang bebas dari penjara untuk mengambil alih kendali Kamen Rider Chronicle demi kepentingan bisnis mutlaknya.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Ex-Aid'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Hiroki Iijima') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('Hiroki Iijima', '飯島 寛騎', 'Emu Hojo / Kamen Rider Ex-Aid', 'MC', v_series_id, 'Aktor muda Jepang pemenang Junon Superboy Contest yang membintangi dokter sekaligus gamer Emu Hojo.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Toshiki Seto') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Toshiki Seto', 'Hiiro Kagami / Kamen Rider Brave', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran dokter bedah jenius Hiiro Kagami.');
  END IF;


  -- ===========================================================================
  -- 11. KAMEN RIDER BUILD (2017)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Build', '仮面ライダービルド', 'Kamen Rider', 'Heisei', 2017, '2017-09-03', '2018-08-26',
      49, 'Toei Company', 'Fisika, Botol Kimia & Dualitas Hewan-Benda',
      'Sepuluh tahun setelah artefak Kotak Pandora membelah Jepang menjadi tiga wilayah—Touto, Hokuto, dan Seito—oleh tembok raksasa Skywall, fisikawan jenius yang kehilangan ingatannya bernama Sento Kiryu bertarung menggunakan Build Driver dan Fullbottle sebagai Kamen Rider Build. Bersama mantan petinju buronan Ryuga Banjo, ia menghadapi serangan monster Smash serta menguak konspirasi besar alien Evolto.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダービルド'),
      aired_from = COALESCE(aired_from, '2017-09-03'),
      aired_to   = COALESCE(aired_to, '2018-08-26'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Fisika, Botol Kimia & Dualitas Hewan-Benda'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Build')
    WHERE id = v_series_id;
  END IF;

  IF EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Build') THEN
    UPDATE characters SET
      rider_name    = COALESCE(rider_name, 'Kamen Rider Build'),
      civilian_name = COALESCE(civilian_name, 'Sento Kiryu'),
      actor         = COALESCE(actor, 'Atsuhiro Inukai'),
      role          = COALESCE(role, 'Main Rider'),
      species       = COALESCE(species, 'Manusia'),
      team          = COALESCE(team, 'Team Build / Nascita'),
      power         = COALESCE(power, 'Build Driver dengan pasangan Fullbottle Best Match (RabbitTank), RabbitTank Sparkling, Hazard, RabbitRabbit/TankTank, hingga Genius Form.'),
      bio           = COALESCE(bio, 'Fisikawan jenius narsis yang tinggal di ruang bawah tanah kafe Nascita setelah kehilangan ingatan masa lalunya. Ia merancang sebagian besar teknologi Rider demi menjaga perdamaian tanpa korban jiwa.'),
      debut_episode = COALESCE(debut_episode, 'Episode 1'),
      source_url    = COALESCE(source_url, 'https://kamenrider.fandom.com/wiki/Sento_Kiryu')
    WHERE series_id = v_series_id AND name = 'Kamen Rider Build';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Cross-Z') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Cross-Z', 'Kamen Rider Cross-Z', 'Ryuga Banjo', 'Eiji Akaso', 'Secondary Rider',
      'Hibrida Manusia - DNA Evolto', 'Team Build / Nascita',
      'Build Driver & Cross-Z Dragon, Sclash Driver Cross-Z Charge, Cross-Z Magma, dan kekuatan naga api bertarung jarak dekat.',
      'Mantan petarung MMA berwatak panas namun setia kawan yang dijebak dalam kasus pembunuhan sebelum diselamatkan Sento dan berjuang bersamanya sebagai sahabat karib.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Grease') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Grease', 'Kamen Rider Grease', 'Kazumi Sawatari', 'Kouhei Takeda', 'Secondary Rider',
      'Manusia (terekspos Nebula Gas)', 'Team Build (eks-Hokuto)',
      'Sclash Driver & Robot Sclashjelly, senjata Twin Breaker, serta kekuatan puncak Grease Blizzard.',
      'Mantan komandan pasukan Hokuto yang awalnya bermusuhan dengan Sento demi menyelamatkan kampung halamannya dan rekan-rekan pertaniannya sebelum bergabung ke Team Build.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Rogue') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Rogue', 'Kamen Rider Rogue', 'Gentoku Himuro', 'Kensei Mikami', 'Secondary Rider',
      'Manusia (terekspos Nebula Gas)', 'Team Build (eks-Faust / Seito)',
      'Sclash Driver & Crocodile Crack Fullbottle sebagai Kamen Rider Rogue dan sebelumnya Night Rogue dengan Transteam Gun.',
      'Putra Perdana Menteri Touto yang sempat terseret pengaruh cahaya Kotak Pandora hingga mendirikan Faust sebelum bertobat berjuang di pihak Sento melawan Evolto.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Misora Isurugi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Misora Isurugi', 'Misora Isurugi', 'Kaho Takada', 'Ally',
      'Manusia (inang Ratu Vernage)', 'Team Build / Nascita',
      'Memurnikan energi Smash menjadi Fullbottle melalui gelang suci Mars serta dukungan idola internet Mii-tan.',
      'Gadis penghuni ruang rahasia kafe Nascita yang memiliki kemampuan memurnikan Fullbottle dan menjadi pengikat kehangatan emosional bagi Team Build.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Soichi Isurugi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Soichi Isurugi', 'Soichi Isurugi', 'Yasuyuki Maekawa', 'Villain',
      'Manusia (dirasuki Evolto)', 'Kafe Nascita / Faust',
      'Kopi khas Nascita dan akses Transteam Gun sebagai Blood Stalk saat tubuhnya dikendalikan Evolto.',
      'Pemilik ramah Kafe Nascita dan ayah Misora yang tubuhnya dirasuki entitas luar angkasa Evolto sejak ekspedisi misi Mars.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Evolto') THEN
    INSERT INTO characters (series_id, name, rider_name, actor, role, species, team, power, bio, source_url)
    VALUES (
      v_series_id, 'Evolto', 'Kamen Rider Evol', 'Tetsuo Kanao', 'Villain',
      'Alien (Suku Blood)', 'Independen / Faust',
      'Evol Driver dengan wujud Cobra, Dragon, Rabbit, Black Hole Form penghancur planet, serta manipulasi penuh perang sipil Jepang.',
      'Entitas alien pemusnah planet dari Suku Blood yang menghancurkan peradaban Mars dan mendalangi seluruh konspirasi Kotak Pandora serta ingatan Takumi Katsuragi.',
      'https://en.wikipedia.org/wiki/Kamen_Rider_Build'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Eiji Akaso') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Eiji Akaso', 'Ryuga Banjo / Kamen Rider Cross-Z', 'Secondary Rider', v_series_id, 'Aktor Jepang yang melejit popularitasnya setelah memerankan sahabat setia Sento, Ryuga Banjo.');
  END IF;


  -- ===========================================================================
  -- 12. KAMEN RIDER ZI-O (2018)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Zi-O' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Zi-O', '仮面ライダージオウ', 'Kamen Rider', 'Heisei', 2018, '2018-09-02', '2019-08-25',
      49, 'Toei Company', 'Jam Tangan, Perjalanan Waktu & Penghormatan Era Heisei',
      'Sebagai penutup besar era Heisei, siswa SMA biasa bermimpi menjadi raja bernama Sougo Tokiwa didatangi dua penjelajah waktu dari tahun 2068: Geiz Myokoin yang berniat membunuhnya sebelum menjadi raja iblis kejam Ohma Zi-O, dan Tsukuyomi yang ingin membimbingnya. Untuk memperbaiki garis waktu dari ancaman kelompok Time Jacker, Sougo berubah menjadi Kamen Rider Zi-O dan mewarisi Ridewatch seluruh Kamen Rider Heisei.',
      NULL, 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp   = COALESCE(title_jp, '仮面ライダージオウ'),
      aired_from = COALESCE(aired_from, '2018-09-02'),
      aired_to   = COALESCE(aired_to, '2019-08-25'),
      episodes   = COALESCE(episodes, 49),
      studio     = COALESCE(studio, 'Toei Company'),
      motif      = COALESCE(motif, 'Jam Tangan, Perjalanan Waktu & Penghormatan Era Heisei'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Zi-O') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Zi-O', 'Kamen Rider Zi-O', 'Sougo Tokiwa', 'So Okuno', 'Main Rider',
      'Manusia (Pemilik kekuatan Raja Waktu)', 'Kujigojido (Jam Kujigoji)',
      'Ziku-Driver & Ridewatch 20 Rider Heisei (Rider Armor, Zi-O II pengubah masa depan, Grand Zi-O, hingga Ohma Zi-O).',
      'Siswa SMA berwatak baik hati dan agak naif yang bercita-cita menjadi raja bijaksana demi membahagiakan rakyat, sekaligus berusaha mengubah takdir kelam masa depannya.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Geiz') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Geiz', 'Kamen Rider Geiz', 'Geiz Myokoin', 'Gaku Oshida', 'Secondary Rider',
      'Manusia (dari tahun 2068)', 'Kujigojido / Pasukan Perlawanan 2068',
      'Ziku-Driver & Geiz Ridewatch dengan senjata Zikan Zax, GeizRevive kecepatan-kekuatan tinggi, serta Rider Armor.',
      'Prajurit perlawanan dari tahun 2068 yang awalnya turun ke masa lalu untuk melenyapkan Sougo sebelum tergerak oleh ketulusan sahabat barunya tersebut.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Woz') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Woz', 'Kamen Rider Woz', 'Woz', 'Keisuke Watanabe', 'Secondary Rider',
      'Manusia (dari masa depan)', 'Pengikut Setia Sougo Tokiwa',
      'Kitab Kouma Korin, selendang penyerang, serta Beyondriver dengan Miridewatch masa depan (Woz, Shinobi, Quiz, Kikai, Ginga).',
      'Pengabdi setia yang kerap muncul melafalkan kata sambutan "Iwae!" untuk memuji kebangkitan Sougo sebagai Raja Waktu.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Tsukuyomi') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Kamen Rider Tsukuyomi', 'Kamen Rider Tsukuyomi', 'Tsukuyomi', 'Shieri Ohata', 'Ally',
      'Manusia (dari tahun 2068 / Garis keturunan waktu)', 'Kujigojido',
      'Kemampuan menghentikan waktu sementara, pistol Faiz Phone X, dan kelak berubah menjadi Kamen Rider Tsukuyomi di babak akhir.',
      'Rekan seperjuangan Geiz dari tahun 2068 yang meyakini Sougo masih bisa diarahkan menjadi raja yang baik sambil menyingkap jati dirinya yang terlupakan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Swartz') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Swartz', 'Swartz', 'Kentarou Kanesaki', 'Villain',
      'Penguasa Waktu', 'Time Jacker',
      'Kekuatan penghenti waktu Time Jacker, penciptaan Another Ridewatch, dan kelak Another Decade pemanggil dimensi.',
      'Pemimpin dingin kelompok Time Jacker sekaligus kakak kandung Tsukuyomi yang berusaha menggantikan Ohma Zi-O dan menguasai seluruh dunia.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ora') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (
      v_series_id, 'Ora', 'Ora', 'Ayaka Konno', 'Villain',
      'Time Jacker', 'Time Jacker',
      'Kemampuan menghentikan aliran waktu target serta menyuntikkan Another Watch untuk menciptakan Another Rider.',
      'Anggota wanita Time Jacker yang terampil memanipulasi waktu dan merekrut manusia terpilih untuk diubah menjadi raja baru versi tandingan.',
      'Episode 1', 'https://en.wikipedia.org/wiki/Kamen_Rider_Zi-O'
    );
  END IF;

  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'So Okuno') THEN
    INSERT INTO actors (name, kanji, character, role_type, series_id, bio)
    VALUES ('So Okuno', '奥野 壮', 'Sougo Tokiwa / Kamen Rider Zi-O', 'MC', v_series_id, 'Aktor muda Jepang yang membawakan peran Sougo Tokiwa pada seri perayaan penutup dua puluh tahun era Kamen Rider Heisei.');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM actors WHERE series_id = v_series_id AND name = 'Gaku Oshida') THEN
    INSERT INTO actors (name, character, role_type, series_id, bio)
    VALUES ('Gaku Oshida', 'Geiz Myokoin / Kamen Rider Geiz', 'Secondary Rider', v_series_id, 'Aktor Jepang pemeran Geiz Myokoin dalam serial utama maupun spin-off Kamen Rider Zi-O NEXT TIME: Geiz, Majesty.');
  END IF;

END $$;
