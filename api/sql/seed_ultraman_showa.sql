-- =============================================================================
-- SEED ULTRAMAN BATCH 1: ERA SHOWA (1966 - 1981)
-- IDEMPOTEN: Cek berdasarkan title / (series_id, name) sebelum INSERT.
-- HANYA mengisi kolom NULL pada data yang sudah ada (COALESCE), tidak menimpa editan manual.
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
BEGIN

  -- ===========================================================================
  -- 1. ULTRA Q (1966)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultra Q' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Ultra Q', 'ウルトラQ', 'Ultraman', 'Showa', 1966, '1966-01-02', '1966-07-03',
      28, 'Tsuburaya Productions', 'Misteri / Kaiju / Fiksi Ilmiah',
      'Serial pembuka dari waralaba Ultra ini mengikuti petualangan pilot Jun Manjome, jurnalis foto Yuriko Edogawa, dan mekanik Ippei Togawa dalam menyelidiki berbagai fenomena aneh, gangguan ruang waktu, serta kemunculan monster raksasa di Jepang tanpa kehadiran pahlawan raksasa.',
      NULL, 'https://en.wikipedia.org/wiki/Ultra_Q'
    ) RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, 'ウルトラQ'), aired_from = COALESCE(aired_from, '1966-01-02'),
      aired_to = COALESCE(aired_to, '1966-07-03'), episodes = COALESCE(episodes, 28),
      studio = COALESCE(studio, 'Tsuburaya Productions'), motif = COALESCE(motif, 'Misteri / Kaiju / Fiksi Ilmiah'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Ultra_Q')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Jun Manjome') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Jun Manjome', 'Jun Manjome', 'Kenji Sahara', 'Team Member', 'Manusia', 'Hoshikawa Air Service', 'Keahlian menerbangkan pesawat ringan dan naluri investigasi di lapangan.', 'Pilot muda dari Hoshikawa Air Service sekaligus penulis amatir fiksi ilmiah yang kerap terseret ke tengah insiden monster misterius bersama Yuriko dan Ippei.', 'Episode 1: Defeat Gomess!', 'https://ultra.fandom.com/wiki/Jun_Manjome');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yuriko Edogawa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Yuriko Edogawa', 'Yuriko Edogawa', 'Hiroko Sakurai', 'Team Member', 'Manusia', 'Daily News', 'Ketajaman jurnalistik dan fotografi investigatif dalam menyingkap kasus supranatural.', 'Reporter dan fotografer pemberani di surat kabar Daily News yang selalu bersemangat mendokumentasikan fenomena tak masuk akal bersama Jun.', 'Episode 1: Defeat Gomess!', 'https://ultra.fandom.com/wiki/Yuriko_Edogawa');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ippei Togawa') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Ippei Togawa', 'Ippei Togawa', 'Yasuhiko Saijo', 'Team Member', 'Manusia', 'Hoshikawa Air Service', 'Kecakapan merawat pesawat dan dukungan teknis lapangan.', 'Asisten mekanik setia Jun Manjome yang ceria serta tidak ragu membantu menyelidiki jejak kaiju maupun kejadian ganjil di seluruh Jepang.', 'Episode 1: Defeat Gomess!', 'https://ultra.fandom.com/wiki/Ippei_Togawa');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Gomess') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Gomess', NULL, 'Villain', 'Kaiju Kuno', 'Kulit keras mirip armor, cakar tajam, dan kekuatan fisik penghancur terowongan.', 'Monster purba raksasa pertama yang muncul dalam sejarah Ultra Series saat terowongan kereta bawah tanah dibangun dan hanya bisa ditandingi oleh burung purba Litra.', 'Episode 1: Defeat Gomess!', 'https://ultra.fandom.com/wiki/Gomess');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Garamon') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Garamon', NULL, 'Villain', 'Robot Antariksa', 'Tubuh logam berduri tahan peluru dan dikendalikan melalui gelombang radio meteorit Garadama.', 'Robot monster luar angkasa yang jatuh ke Bumi di dalam meteorit Garadama dan menjadi salah satu makhluk paling ikonik dari Ultra Q.', 'Episode 13: Garadama', 'https://ultra.fandom.com/wiki/Garamon');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kanegon') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kanegon', NULL, 'Villain', 'Kaiju Koin', 'Menghitung dan memakan uang logam terus-menerus untuk bertahan hidup.', 'Bocah laki-laki serakah uang bernama Kaneda yang bermutasi menjadi monster pemakan koin setelah memungut kepompong misterius.', 'Episode 15: Kanegon''s Cocoon', 'https://ultra.fandom.com/wiki/Kanegon');
  END IF;


  -- ===========================================================================
  -- 2. ULTRAMAN (1966)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraman', 'ウルトラマン', 'Ultraman', 'Showa', 1966, '1966-07-17', '1967-04-09', 39, 'Tsuburaya Productions', 'Raksasa Cahaya / Nebula M78', 'Ketika mengejar monster luar angkasa Bemular di Bumi, raksasa cahaya dari Nebula M78 tak sengaja menabrak pesawat anggota SSSP Shin Hayata hingga tewas. Sebagai gantinya, Ultraman menyatukan nyawanya dengan Hayata untuk melindungi Bumi dari serangan kaiju dan alien.', NULL, 'https://en.wikipedia.org/wiki/Ultraman_(1966_TV_series)')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, 'ウルトラマン'), aired_from = COALESCE(aired_from, '1966-07-17'),
      aired_to = COALESCE(aired_to, '1967-04-09'), episodes = COALESCE(episodes, 39),
      studio = COALESCE(studio, 'Tsuburaya Productions'), motif = COALESCE(motif, 'Raksasa Cahaya / Nebula M78'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Ultraman_(1966_TV_series)')
    WHERE id = v_series_id;
  END IF;

  -- Enrich atau Insert Ultraman
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (
      v_series_id, 'Ultraman', 'Ultraman', 'Shin Hayata', 'Susumu Kurobe / Bin Furuya (Suit)', 'Main Ultra', 'Ultra (Nebula M78)', 'SSSP',
      'Sinar pamungkas Specium Ray, Ultra Slash, perisai Ultra Barrier, batas waktu bertarung 3 menit di atmosfer Bumi.',
      'Prajurit antariksa dari Negeri Cahaya yang menyatu dengan Shin Hayata demi menyelamatkan nyawanya setelah tabrakan tak sengaja. Ia menjadi pelindung ikonik Bumi yang mengawali seluruh seri pahlawan Ultra.',
      'Episode 1: Ultra Operation No.1',
      '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 5","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Usia","value":"20000","unit":"tahun"},{"label":"Durasi bertransformasi","value":"3","unit":"menit"}]'::jsonb,
      'https://ultra.fandom.com/wiki/Ultraman_(character)'
    );
  ELSE
    UPDATE characters SET
      rider_name = COALESCE(rider_name, 'Ultraman'),
      civilian_name = COALESCE(civilian_name, 'Shin Hayata'),
      role = COALESCE(role, 'Main Ultra'),
      species = COALESCE(species, 'Ultra (Nebula M78)'),
      team = COALESCE(team, 'SSSP'),
      debut_episode = COALESCE(debut_episode, 'Episode 1: Ultra Operation No.1'),
      extra_stats = COALESCE(extra_stats, '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 5","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Usia","value":"20000","unit":"tahun"},{"label":"Durasi bertransformasi","value":"3","unit":"menit"}]'::jsonb),
      source_url = COALESCE(source_url, 'https://ultra.fandom.com/wiki/Ultraman_(character)')
    WHERE series_id = v_series_id AND name = 'Ultraman';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shin Hayata') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Shin Hayata', 'Shin Hayata', 'Susumu Kurobe', 'Human Host', 'Manusia', 'SSSP', 'Menggunakan kapsul Beta Capsule untuk memanggil dan berubah menjadi Ultraman, serta pilot andal pesawat Jet VTOL.', 'Wakil kapten tim SSSP (Science Patrol) yang berwatak tenang dan pemberani. Setelah menyatu dengan Ultraman, ia menjaga rahasia identitas pahlawan raksasa tersebut dari rekan setimnya.', 'Episode 1: Ultra Operation No.1', 'https://ultra.fandom.com/wiki/Shin_Hayata');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Toshio Muramatsu') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Toshio Muramatsu', 'Toshio Muramatsu', 'Akiji Kobayashi', 'Team Member', 'Manusia', 'SSSP', 'Kepemimpinan taktis militer, keahlian menembak Super Gun, serta koordinasi misi SSSP.', 'Kapten cabang Jepang Science Special Search Party yang bijaksana, tegas, dan selalu mengambil keputusan tenang di tengah krisis kaiju.', 'Episode 1: Ultra Operation No.1', 'https://ultra.fandom.com/wiki/Toshio_Muramatsu');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Akiko Fuji') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Akiko Fuji', 'Akiko Fuji', 'Hiroko Sakurai', 'Team Member', 'Manusia', 'SSSP', 'Komunikasi taktis markas, analisis laporan lapangan, serta operasional tempur dasar.', 'Satu-satunya anggota wanita di tim SSSP cabang Jepang yang bertanggung jawab atas sistem komunikasi serta kerap turun langsung ke lapangan.', 'Episode 1: Ultra Operation No.1', 'https://ultra.fandom.com/wiki/Akiko_Fuji');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Daisuke Arashi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Daisuke Arashi', 'Daisuke Arashi', 'Sandayu Dokumamushi', 'Team Member', 'Manusia', 'SSSP', 'Penembak jitu terbaik SSSP menggunakan senjata berat seperti Spider Shot.', 'Anggota tim SSSP berbadan tegap yang menjadi ujung tombak serangan persenjataan berat di lapangan untuk mendukung aksi Ultraman.', 'Episode 1: Ultra Operation No.1', 'https://ultra.fandom.com/wiki/Daisuke_Arashi');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Mitsuhiro Ide') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Mitsuhiro Ide', 'Mitsuhiro Ide', 'Masanari Nihei', 'Team Member', 'Manusia', 'SSSP', 'Penemu genius beragam senjata baru SSSP, termasuk Mars 133.', 'Ilmuwan sekaligus penyedia humor di tim SSSP yang menciptakan senjata canggih demi membantu manusia menghadapi monster.', 'Episode 1: Ultra Operation No.1', 'https://ultra.fandom.com/wiki/Mitsuhiro_Ide');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Alien Baltan') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Alien Baltan', NULL, 'Villain', 'Alien Baltan', 'Kemampuan berlipat ganda (ilusi kloning), teleportasi, serta cakar penjepit berenergi.', 'Bangsa pengembara luar angkasa berkepala serangga dengan tawa khas yang berniat menginvasi dan mengambil alih Bumi setelah planet asalnya hancur.', 'Episode 2: Shoot the Invader', '[{"label":"Tinggi","value":"50","unit":"m"},{"label":"Berat","value":"15000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Alien_Baltan');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Zetton') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Zetton', NULL, 'Villain', 'Kaiju Luar Angkasa', 'Gelombang bola api satu triliun derajat, perisai penyerap Specium Ray, dan teleportasi.', 'Monster pamungkas ciptaan Alien Zetton yang mampu menangkis serangan andalan Ultraman sekaligus mengalahkannya dalam duel terakhir di markas SSSP.', 'Episode 39: Farewell, Ultraman', '[{"label":"Tinggi","value":"60","unit":"m"},{"label":"Berat","value":"30000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Zetton');
  END IF;


  -- ===========================================================================
  -- 3. ULTRASEVEN (1967)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraseven' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraseven', 'ウルトラセブン', 'Ultraman', 'Showa', 1967, '1967-10-01', '1968-09-08', 49, 'Tsuburaya Productions', 'Prajurit Penjaga Galaksi / Matahari', 'Pengamat bintang dari Nebula M78 terpesona oleh keberanian umat manusia dan memutuskan tinggal menyamar sebagai Dan Moroboshi sambil bergabung dengan tim Ultra Guard. Menggunakan kacamata Ultra Eye, ia berubah menjadi Ultraseven untuk melindungi Bumi dari berbagai invasi alien.', NULL, 'https://en.wikipedia.org/wiki/Ultraseven')
    RETURNING id INTO v_series_id;
  ELSE
    UPDATE series SET
      title_jp = COALESCE(title_jp, 'ウルトラセブン'), aired_from = COALESCE(aired_from, '1967-10-01'),
      aired_to = COALESCE(aired_to, '1968-09-08'), episodes = COALESCE(episodes, 49),
      studio = COALESCE(studio, 'Tsuburaya Productions'), motif = COALESCE(motif, 'Prajurit Penjaga Galaksi / Matahari'),
      source_url = COALESCE(source_url, 'https://en.wikipedia.org/wiki/Ultraseven')
    WHERE id = v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraseven') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (
      v_series_id, 'Ultraseven', 'Ultraseven', 'Dan Moroboshi', 'Koji Moritsugu', 'Main Ultra', 'Ultra (Nebula M78)', 'Ultra Guard',
      'Bumerang tajam Eye Slugger di kepala, sinar Emerium Beam dan Wide Shot, serta kapsul monster Windam, Miclas, dan Agira.',
      'Petugas pengamat bintang yang memilih menetap di Bumi setelah kagum akan keteguhan hati manusia. Tidak seperti Ultraman pertama, ia langsung mengambil wujud manusia sendiri tanpa menyatu dengan inang.',
      'Episode 1: The Invisible Challenger',
      '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 7","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Usia","value":"19000","unit":"tahun"}]'::jsonb,
      'https://ultra.fandom.com/wiki/Ultraseven_(character)'
    );
  ELSE
    UPDATE characters SET
      rider_name = COALESCE(rider_name, 'Ultraseven'),
      civilian_name = COALESCE(civilian_name, 'Dan Moroboshi'),
      role = COALESCE(role, 'Main Ultra'),
      species = COALESCE(species, 'Ultra (Nebula M78)'),
      team = COALESCE(team, 'Ultra Guard'),
      debut_episode = COALESCE(debut_episode, 'Episode 1: The Invisible Challenger'),
      extra_stats = COALESCE(extra_stats, '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 7","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Usia","value":"19000","unit":"tahun"}]'::jsonb),
      source_url = COALESCE(source_url, 'https://ultra.fandom.com/wiki/Ultraseven_(character)')
    WHERE series_id = v_series_id AND name = 'Ultraseven';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Dan Moroboshi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Dan Moroboshi', 'Dan Moroboshi', 'Koji Moritsugu', 'Human Host', 'Ultra (Wujud Manusia)', 'Ultra Guard', 'Mengaktifkan kacamata Ultra Eye untuk bertransformasi dan menggunakan Kapsul Monster saat tidak bisa berubah.', 'Wujud samaran Ultraseven yang direkrut menjadi anggota ketujuh tim elit Ultra Guard. Ia memiliki kemampuan pengamatan tajam dan berhati lembut terhadap nasib manusia.', 'Episode 1: The Invisible Challenger', 'https://ultra.fandom.com/wiki/Dan_Moroboshi');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kaoru Kiriyama') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kaoru Kiriyama', 'Kaoru Kiriyama', 'Shoji Nakayama', 'Team Member', 'Manusia', 'Ultra Guard', 'Kepemimpinan tegas TDF, komando kapal udara Ultra Hawk, dan strategi pertahanan bumi.', 'Kapten tim Ultra Guard yang berwibawa dan memiliki kepercayaan penuh kepada Dan Moroboshi meski latar belakang Dan penuh misteri.', 'Episode 1: The Invisible Challenger', 'https://ultra.fandom.com/wiki/Kaoru_Kiriyama');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Anne Yuri') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Anne Yuri', 'Anne Yuri', 'Yuriko Hishimi', 'Team Member', 'Manusia', 'Ultra Guard', 'Petugas medis, ahli komunikasi Ultra Guard, serta penggunaan senjata Ultra Gun.', 'Anggota wanita di tim Ultra Guard yang merangkap perawat di markas TDF sekaligus memiliki ikatan emosional yang erat dengan Dan Moroboshi.', 'Episode 1: The Invisible Challenger', 'https://ultra.fandom.com/wiki/Anne_Yuri');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Shigeru Furuhashi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Shigeru Furuhashi', 'Shigeru Furuhashi', 'Sandayu Dokumamushi', 'Team Member', 'Manusia', 'Ultra Guard', 'Kekuatan fisik tangguh dan keahlian persenjataan berat di lapangan.', 'Anggota bertubuh kekar dari tim Ultra Guard yang dikenal setia kawan dan selalu maju di garis depan saat menyelidiki serangan alien.', 'Episode 1: The Invisible Challenger', 'https://ultra.fandom.com/wiki/Shigeru_Furuhashi');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Alien Metron') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Alien Metron', NULL, 'Villain', 'Alien Metron', 'Manipulasi psikologis memakai kristal merah dan meracuni rokok untuk membuat manusia saling membenci.', 'Alien cerdas yang merancang invasi halus tanpa perang terbuka dengan membuat manusia hilang akal dan saling menghancurkan diri sendiri.', 'Episode 8: The Marked Town', '[{"label":"Tinggi","value":"50","unit":"m"},{"label":"Berat","value":"18000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Alien_Metron');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'King Joe') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'King Joe', NULL, 'Villain', 'Robot Antariksa (Alien Pedan)', 'Tubuh logam super kuat kebal sinar Emerium, dapat terpisah menjadi empat pesawat tempur.', 'Robot tempur canggih ciptaan Alien Pedan yang terbukti hampir tidak terkalahkan oleh serangan fisik maupun tembakan sinar Ultraseven.', 'Episode 14: The Ultra Guard Goes West (Part 1)', '[{"label":"Tinggi","value":"55","unit":"m"},{"label":"Berat","value":"48000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/King_Joe');
  END IF;


  -- ===========================================================================
  -- 4. THE RETURN OF ULTRAMAN (1971)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'The Return of Ultraman' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('The Return of Ultraman', '帰ってきたウルトラマン', 'Ultraman', 'Showa', 1971, '1971-04-02', '1972-03-31', 51, 'Tsuburaya Productions', 'Raksasa Cahaya / Gelang Ultra', 'Pembalap muda Hideki Go tewas saat menyelamatkan seorang anak dari serangan monster di awal kebangkitan kembali para kaiju. Tersentuh oleh keberaniannya, Ultraman Jack menyatu dengan Hideki dan membangkitkannya untuk membela Bumi bersama tim MAT.', NULL, 'https://en.wikipedia.org/wiki/Return_of_Ultraman')
    RETURNING id INTO v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Jack') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman Jack', 'Ultraman Jack', 'Hideki Go', 'Jiro Dan / Eiichi Kikuchi (Suit)', 'Main Ultra', 'Ultra (Nebula M78)', 'MAT', 'Sinar Specium Ray, Cinerama Shot, dan senjata serbaguna Ultra Bracelet pemberian Ultraseven.', 'Ksatria cahaya yang memilih Hideki Go sebagai inang manusianya tanpa memakai alat transformasi fisik melainkan melalui tekad batin. Ia berlatih keras hingga menjadi anggota penting Ultra Brothers.', 'Episode 1: All Monsters Attack', '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 5","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Durasi bertransformasi","value":"3","unit":"menit"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_Jack');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hideki Go') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Hideki Go', 'Hideki Go', 'Jiro Dan', 'Human Host', 'Manusia', 'MAT', 'Keahlian mengemudikan pesawat Mat Arrow serta kepekaan tinggi mendeteksi bahaya monster.', 'Pembalap mobil muda berhati lurus yang direkrut ke dalam tim MAT setelah bersatu dengan Ultraman Jack. Perjalanannya dipenuhi pendewasaan mental serta duka kehilangan orang tercinta.', 'Episode 1: All Monsters Attack', 'https://ultra.fandom.com/wiki/Hideki_Go');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Katsuichiro Kato') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Katsuichiro Kato', 'Katsuichiro Kato', 'Nobuo Tsukamoto', 'Team Member', 'Manusia', 'MAT', 'Komandan lapangan pertama tim MAT dan pelatih kedisiplinan tim.', 'Kapten pertama MAT yang merekrut Hideki Go dan membimbingnya pada paruh awal serial sebelum dipindahkan bertugas ke stasiun luar angkasa.', 'Episode 1: All Monsters Attack', 'https://ultra.fandom.com/wiki/Katsuichiro_Kato');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ryu Ibuki') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Ryu Ibuki', 'Ryu Ibuki', 'Jun Negami', 'Team Member', 'Manusia', 'MAT', 'Ahli taktik militer berdisiplin tinggi sebagai kapten kedua tim MAT.', 'Komandan baru MAT mulai Episode 22 yang tampak tegas namun sangat peduli terhadap keselamatan anggotanya dan menjadi pengarah utama Hideki Go hingga akhir.', 'Episode 22: I''ll Kill This Monster!', 'https://ultra.fandom.com/wiki/Ryu_Ibuki');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Aki Sakata') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Aki Sakata', 'Aki Sakata', 'Rumi Sakakibara', 'Team Member', 'Manusia', 'Keluarga Sakata', 'Pendukung emosional utama dan kekasih Hideki Go.', 'Adik dari mekanik Ken Sakata sekaligus kekasih Hideki Go yang menjadi sumber semangatnya sebelum gugur secara tragis akibat ulah Alien Nackle.', 'Episode 1: All Monsters Attack', 'https://ultra.fandom.com/wiki/Aki_Sakata');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Twin Tail') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Twin Tail', NULL, 'Villain', 'Kaiju Purba', 'Cambuk ekor kembar di atas kepala serta gigi taring berbisa.', 'Monster prasejarah berbentuk aneh berkepala terbalik yang muncul bersamaan dengan musuh alaminya Gudon di bawah kota Tokyo.', 'Episode 5: Two Giant Monsters Attack Tokyo', '[{"label":"Tinggi","value":"45","unit":"m"},{"label":"Berat","value":"15000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Twin_Tail');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Alien Nackle') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Alien Nackle', NULL, 'Villain', 'Alien Nackle', 'Keahlian merancang skenario pembunuhan berantai serta mengendalikan monster pengawal Black King.', 'Alien licik yang mempelajari kelemahan Ultraman Jack terlebih dahulu sebelum membunuh Aki serta Ken Sakata dan sempat menaklukkan Jack dengan bantuan Black King.', 'Episode 37: Ultraman Dies at Sunset', '[{"label":"Tinggi","value":"43","unit":"m"},{"label":"Berat","value":"20000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Alien_Nackle');
  END IF;


  -- ===========================================================================
  -- 5. ULTRAMAN ACE (1972)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Ace' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraman Ace', 'ウルトラマンA(エース)', 'Ultraman', 'Showa', 1972, '1972-04-07', '1973-03-30', 52, 'Tsuburaya Productions', 'Cincin Ultra / Pengendali Sinar', 'Monster interdimensi kejam bernama Choju dikirim oleh penyihir Yapool untuk meneror Bumi. Pemuda Seiji Hokuto dan perawat Yuko Minami yang gugur dalam serangan pertama dihidupkan kembali oleh Ultraman Ace agar dapat bergabung berubah memakai Cincin Ultra dan bertempur bersama tim TAC.', NULL, 'https://en.wikipedia.org/wiki/Ultraman_Ace')
    RETURNING id INTO v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Ace') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman Ace', 'Ultraman Ace', 'Seiji Hokuto & Yuko Minami', 'Keiji Takamine / Mitsuko Hoshi', 'Main Ultra', 'Ultra (Nebula M78)', 'TAC', 'Metallium Beam, Guillotine Shot, serta penguasaan variasi jurus pemotong sinar terbanyak di antara Ultra Brothers.', 'Anggota kelima Ultra Brothers yang awalnya dikendalikan melalui penyatuan unik dua manusia, Seiji dan Yuko, menggunakan teknik Ultra Touch sebelum akhirnya bertumpu pada Seiji seorang.', 'Episode 1: Shine! The Five Ultra Brothers', '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"45000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 20","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Durasi bertransformasi","value":"3","unit":"menit"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_Ace_(character)');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Seiji Hokuto') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Seiji Hokuto', 'Seiji Hokuto', 'Keiji Takamine', 'Human Host', 'Manusia', 'TAC', 'Cincin Ultra di jari, pilot pesawat tempur TAC Falcon.', 'Pemuda pengemudi roti berhati panas yang terpilih oleh Ace setelah mengorbankan diri melindungi warga, lalu bergabung menjadi pilot utama di tim TAC.', 'Episode 1: Shine! The Five Ultra Brothers', 'https://ultra.fandom.com/wiki/Seiji_Hokuto');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yuko Minami') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Yuko Minami', 'Yuko Minami', 'Mitsuko Hoshi', 'Human Host', 'Manusia (Keturunan Bulan)', 'TAC', 'Cincin Ultra dan koordinasi Ultra Touch bersama Seiji Hokuto.', 'Perawat berhati lembut yang menjadi separuh inang Ultraman Ace hingga Episode 28, sebelum kembali ke Bulan untuk menjaga kaumnya setelah identitas aslinya terungkap.', 'Episode 1: Shine! The Five Ultra Brothers', 'https://ultra.fandom.com/wiki/Yuko_Minami');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Goro Ryu') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Goro Ryu', 'Goro Ryu', 'Tetsuro Sagawa', 'Team Member', 'Manusia', 'TAC', 'Komando tertinggi tim TAC serta keahlian menembak TAC Gun.', 'Kapten tim TAC yang berdisiplin keras namun berjiwa melindungi seluruh bawahannya termasuk Seiji yang sering bertindak gegabah.', 'Episode 1: Shine! The Five Ultra Brothers', 'https://ultra.fandom.com/wiki/Goro_Ryu');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kozo Yoshimura') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kozo Yoshimura', 'Kozo Yoshimura', 'Mitsuhiro Sano', 'Team Member', 'Manusia', 'TAC', 'Analisis data biologi Choju serta pengoperasian sistem radar markas TAC.', 'Anggota tim TAC berotak analitis yang meneliti kelemahan serta asal mula setiap Choju ciptaan Yapool.', 'Episode 1: Shine! The Five Ultra Brothers', 'https://ultra.fandom.com/wiki/Kozo_Yoshimura');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yapool') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Yapool', 'Tatsuhiko Takada (Suara)', 'Villain', 'Entitas Antar Dimensi', 'Pencipta monster gabungan Choju yang kebal rasa sakit serta manipulasi antar dimensi.', 'Dalang utama dari dimensi lain yang membenci manusia dan Ultra Brothers serta terus-menerus melahirkan Choju untuk menaklukkan Bumi.', 'Episode 1: Shine! The Five Ultra Brothers', 'https://ultra.fandom.com/wiki/Yapool');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ace-Killer') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ace-Killer', NULL, 'Villain', 'Choju Mekanik (Yapool)', 'Mencuri dan menggunakan kekuatan empat Ultra Brothers senior termasuk Specium Ray dan M87 Beam.', 'Monster mekanik mematikan ciptaan Yapool di Planet Golgotha yang dirancang khusus untuk meniru jurus para Ultra Brothers dan menghancurkan Ace.', 'Episode 14: 5 Stars Scattered in the Galaxy', '[{"label":"Tinggi","value":"40","unit":"m"},{"label":"Berat","value":"43000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ace-Killer');
  END IF;


  -- ===========================================================================
  -- 6. ULTRAMAN TARO (1973)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Taro' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraman Taro', 'ウルトラマンT(タロウ)', 'Ultraman', 'Showa', 1973, '1973-04-06', '1974-04-05', 53, 'Tsuburaya Productions', 'Putra Mahkota Negeri Cahaya / Api', 'Petinju pengembara Kotaro Higashi tewas saat melindungi sebuah bunga dari monster raksasa sebelum diselamatkan oleh Mother of Ultra dan lima Ultra Brothers, melahirkannya kembali sebagai Ultraman Taro. Bersama tim ceria ZAT, Taro berjuang menumpas monster Bumi dan alien.', NULL, 'https://en.wikipedia.org/wiki/Ultraman_Taro')
    RETURNING id INTO v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Taro') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman Taro', 'Ultraman Taro', 'Kotaro Higashi', 'Saburo Shinoda', 'Main Ultra', 'Ultra (Nebula M78)', 'ZAT', 'Sinar terkuat Storium Beam, ledakan bunuh diri Ultra Dynamite dengan kemampuan regenerasi, dan King Bracelet.', 'Putra kandung Father dan Mother of Ultra sekaligus anggota termuda keenam di Ultra Brothers. Dikenal bertubuh paling kokoh di masanya dan sangat mahir bertarung jarak dekat serta jurus api.', 'Episode 1: Mother of Ultra Is Like the Sun', '[{"label":"Tinggi","value":"53","unit":"m"},{"label":"Berat","value":"55000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 20","unit":""},{"label":"Asal","value":"Nebula M78","unit":""},{"label":"Durasi bertransformasi","value":"3","unit":"menit"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_Taro_(character)');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kotaro Higashi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kotaro Higashi', 'Kotaro Higashi', 'Saburo Shinoda', 'Human Host', 'Manusia', 'ZAT', 'Keterampilan tinju profesional, keberanian tinggi, dan gelang Ultra Badge untuk berubah menjadi Taro.', 'Pemuda bersemangat dan penyayang anak-anak yang direkrut menjadi anggota baru ZAT. Pada akhir serial ia mengembalikan Ultra Badge demi mengandalkan kekuatan manusia seutuhnya.', 'Episode 1: Mother of Ultra Is Like the Sun', 'https://ultra.fandom.com/wiki/Kotaro_Higashi');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yutaro Asahina') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Yutaro Asahina', 'Yutaro Asahina', 'Akira Nagoya', 'Team Member', 'Manusia', 'ZAT', 'Kepemimpinan bijaksana dan strategi tim udara ZAT.', 'Kapten tim ZAT cabang Jepang yang hangat, penuh humor, sekaligus sangat mengayomi keberanian Kotaro Higashi.', 'Episode 1: Mother of Ultra Is Like the Sun', 'https://ultra.fandom.com/wiki/Yutaro_Asahina');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tadao Nanbara') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Tadao Nanbara', 'Tadao Nanbara', 'Toyoyuki Kimura', 'Team Member', 'Manusia', 'ZAT', 'Pilot pesawat tempur Sky Whale dan dukungan garis depan ZAT.', 'Anggota tim ZAT berhati tulus asal pedesaan yang menjadi teman akrab Kotaro dan kerap terlibat dalam misi penyelamatan.', 'Episode 1: Mother of Ultra Is Like the Sun', 'https://ultra.fandom.com/wiki/Tadao_Nanbara');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Birdon') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Birdon', NULL, 'Villain', 'Kaiju Burung Purba', 'Paruh mematikan beracun dan semburan api ganas dari mulutnya.', 'Burung monster prasejarah pemakan daging yang sempat mengalahkan Ultraman Taro sekaligus membunuh Zoffy sebelum akhirnya dilumpuhkan oleh Taro.', 'Episode 17: Two Giant Monsters Close in on Taro!', '[{"label":"Tinggi","value":"62","unit":"m"},{"label":"Berat","value":"33000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Birdon');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Alien Temperor') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Alien Temperor', NULL, 'Villain', 'Alien Temperor', 'Cambuk listrik, pancaran energi merah dari tangan, serta wujud raksasa.', 'Alien sombong yang berani menantang seluruh enam Ultra Brothers secara langsung saat mereka berkumpul di Bumi.', 'Episode 33: Five Seconds Before the Great Explosion of the Land of Ultra!', '[{"label":"Tinggi","value":"52","unit":"m"},{"label":"Berat","value":"35000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Alien_Temperor');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Tyrant') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Tyrant', NULL, 'Villain', 'Kaiju Gabungan', 'Menggabungkan kekuatan tubuh tujuh monster terkuat (Red King, Bemstar, Seagorath, dll.) dengan sabit raksasa.', 'Monster gabungan mengerikan yang mengalahkan lima Ultra Brothers berturut-turut di luar angkasa sebelum dihentikan oleh Taro dan tim ZAT di Bumi.', 'Episode 40: Surpass the Ultra Brothers!', '[{"label":"Tinggi","value":"62","unit":"m"},{"label":"Berat","value":"57000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Tyrant');
  END IF;


  -- ===========================================================================
  -- 7. ULTRAMAN LEO (1974)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Leo' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraman Leo', 'ウルトラマンレオ', 'Ultraman', 'Showa', 1974, '1974-04-12', '1975-03-28', 51, 'Tsuburaya Productions', 'Singa / Seni Bela Diri (L77)', 'Setelah planet asalnya Nebula L77 dihancurkan oleh Alien Magma, Pangeran Gen Otori mengungsi ke Bumi sebagai guru olahraga. Ketika Ultraseven cedera berat di tangan musuh yang sama, Gen mengemban tugas menjadi Ultraman Leo dan menjalani latihan keras di bawah asuhan Dan Moroboshi.', NULL, 'https://en.wikipedia.org/wiki/Ultraman_Leo')
    RETURNING id INTO v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Leo') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman Leo', 'Ultraman Leo', 'Gen Otori', 'Ryu Manatsu', 'Main Ultra', 'Ultra (Nebula L77)', 'MAC', 'Jurus bela diri fisik terbaik di antara para Ultra, tendangan api Leo Kick, dan sinar Timer Shot.', 'Ksatria asal Nebula L77 yang tidak berawal dari Negeri Cahaya M78. Kekuatannya tidak bertumpu pada tembakan sinar melainkan seni bela diri murni hasil tempaan latihan ekstrem.', 'Episode 1: The Day When Ultraseven Dies, is the Day when Tokyo Sinks!', '[{"label":"Tinggi","value":"52","unit":"m"},{"label":"Berat","value":"48000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 7","unit":""},{"label":"Asal","value":"Nebula L77","unit":""},{"label":"Usia","value":"10000","unit":"tahun"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_Leo_(character)');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Gen Otori') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Gen Otori', 'Gen Otori', 'Ryu Manatsu', 'Human Host', 'Ultra (Wujud Manusia)', 'MAC', 'Menggunakan cincin Lion Eye untuk bertransformasi dan ahli karate tingkat tinggi.', 'Pangeran L77 yang menyamar sebagai instruktur di Jonan Sports Center sebelum direkrut Dan Moroboshi ke tim MAC. Ia selalu bertahan melewati latihan berat serta tragedi demi melindungi bumi barunya.', 'Episode 1: The Day When Ultraseven Dies, is the Day when Tokyo Sinks!', 'https://ultra.fandom.com/wiki/Gen_Otori');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Astra') THEN
    INSERT INTO characters (series_id, name, rider_name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Astra', 'Astra', 'Junji Maruyama (Suara)', 'Team Member', 'Ultra (Nebula L77)', 'Jurus kombinasi Ultra Double Flasher bersama kakaknya Leo.', 'Adik kembar Ultraman Leo yang dianggap tewas saat L77 hancur namun berhasil diselamatkan oleh Ultraman King. Ia muncul secara berkala untuk membantu kakaknya menghadapi ancaman berat.', 'Episode 22: The Leo Brothers vs. the Monster Brothers', '[{"label":"Tinggi","value":"50","unit":"m"},{"label":"Berat","value":"49000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Astra');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman King') THEN
    INSERT INTO characters (series_id, name, rider_name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman King', 'Ultraman King', 'Motomu Kiyokawa (Suara)', 'Team Member', 'Ultra (Legenda)', 'Kekuatan kosmik nyaris tanpa batas termasuk King Hammer, memulihkan makhluk maupun menyegel ancaman besar.', 'Sosok tetua legendaris yang hidup menyendiri di Planet King dan mengawasi kedamaian seluruh semesta. Ia membekali Leo jubah Ultra Mantle untuk menghadapi musuh tangguh.', 'Episode 26: Japanese Folklore Series! - Ultraman King vs The Wizard', '[{"label":"Tinggi","value":"58","unit":"m"},{"label":"Berat","value":"56000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_King');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Momoko Yamaguchi') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Momoko Yamaguchi', 'Momoko Yamaguchi', 'Kaori Okano', 'Team Member', 'Manusia', 'Jonan Sports Center', 'Pendukung moral terdekat Gen Otori dan pengasuh adik-adik asuhnya.', 'Staf di Jonan Sports Center sekaligus kekasih Gen Otori yang setia mendampinginya melewati hari-hari tersulit hingga menjadi korban keganasan Saucer Creature di Episode 40.', 'Episode 1: The Day When Ultraseven Dies, is the Day when Tokyo Sinks!', 'https://ultra.fandom.com/wiki/Momoko_Yamaguchi');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Alien Magma') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Alien Magma', NULL, 'Villain', 'Alien Magma', 'Pedang tempur Saber serta pengendali monster kembar Red Giras dan Black Giras.', 'Pengkhianat kejam yang menghancurkan planet asal Leo, Nebula L77, dan bertanggung jawab melukai kaki Ultraseven pada Episode 1.', 'Episode 1: The Day When Ultraseven Dies, is the Day when Tokyo Sinks!', '[{"label":"Tinggi","value":"57","unit":"m"},{"label":"Berat","value":"22000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Alien_Magma');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Commander Black') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Commander Black', 'Black Directive', 'Takeshi Obayashi', 'Villain', 'Alien (Black Star)', 'Menggunakan bola kristal untuk memanggil makhluk piring terbang Saucer Creature yang sangat mematikan.', 'Antagonis utama paruh akhir serial yang memusnahkan seluruh markas tim MAC serta menewaskan orang-orang terdekat Gen Otori sebelum ditumbangkan di penghujung serial.', 'Episode 40: The Terrifying Saucer Creature Series! - MAC Annihilated!', 'https://ultra.fandom.com/wiki/Commander_Black');
  END IF;


  -- ===========================================================================
  -- 8. ULTRAMAN 80 (1980)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman 80' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (title, title_jp, franchise, era, year, aired_from, aired_to, episodes, studio, motif, synopsis, poster, source_url)
    VALUES ('Ultraman 80', 'ウルトラマン80', 'Ultraman', 'Showa', 1980, '1980-04-02', '1981-03-25', 50, 'Tsuburaya Productions', 'Guru & Pelindung / Energi Minus', 'Setelah jeda panjang tanpa kehadiran kaiju, energi negatif dari sifat buruk manusia mulai membangkitkan monster baru. Ultraman 80 datang ke Bumi dan bekerja sebagai guru SMP bernama Takeshi Yamato sekaligus anggota tim UGM demi menumpas monster serta membimbing muridnya.', NULL, 'https://en.wikipedia.org/wiki/Ultraman_80')
    RETURNING id INTO v_series_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman 80') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Ultraman 80', 'Ultraman 80', 'Takeshi Yamato', 'Hatsunori Hasegawa', 'Main Ultra', 'Ultra (Nebula M78)', 'UGM', 'Sinar Saxium Beam, teknik akrobatik cepat, serta jurus Buckle Beam dari perut.', 'Pahlawan cahaya terakhir era Showa di televisi Jepang yang menggabungkan tugas sebagai pelindung bumi bersama UGM dan guru yang peduli terhadap perkembangan hati manusia.', 'Episode 1: Ultraman Teacher', '[{"label":"Tinggi","value":"50","unit":"m"},{"label":"Berat","value":"44000","unit":"ton"},{"label":"Kecepatan terbang","value":"Mach 9","unit":""},{"label":"Asal","value":"Nebula M78","unit":""}]'::jsonb, 'https://ultra.fandom.com/wiki/Ultraman_80_(character)');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Takeshi Yamato') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Takeshi Yamato', 'Takeshi Yamato', 'Hatsunori Hasegawa', 'Human Host', 'Ultra (Wujud Manusia)', 'UGM', 'Menggunakan Bright Stick untuk bertransformasi dan pilot pesawat Silver Gull.', 'Guru sains penuh dedikasi di SMP Sakuragaoka yang direkrut langsung menjadi anggota UGM karena kejeliannya mendeteksi munculnya energi negatif di masyarakat.', 'Episode 1: Ultraman Teacher', 'https://ultra.fandom.com/wiki/Takeshi_Yamato');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Yullian') THEN
    INSERT INTO characters (series_id, name, rider_name, civilian_name, actor, role, species, team, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Yullian', 'Yullian', 'Ryoko Hoshi', 'Sayoko Hagiwara', 'Team Member', 'Ultra (Nebula M78)', 'UGM', 'Sinar penyembuh dan kekuatan pertahanan cahaya Princess Ray.', 'Putri dari Negeri Cahaya sekaligus teman masa kecil Ultraman 80 yang datang ke Bumi memperingatkan ancaman alien lalu menyamar sebagai anggota UGM bernama Ryoko Hoshi.', 'Episode 43: The Female Warrior from the Land of Light', '[{"label":"Tinggi","value":"47","unit":"m"},{"label":"Berat","value":"36000","unit":"ton"},{"label":"Asal","value":"Nebula M78","unit":""}]'::jsonb, 'https://ultra.fandom.com/wiki/Yullian');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Kazuki Oyama') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Kazuki Oyama', 'Kazuki Oyama', 'Jin Nakayama', 'Team Member', 'Manusia', 'UGM', 'Komando lapangan strategis dan pemimpin markas tim UGM Jepang.', 'Kapten tim UGM yang cerdas, berpengalaman, dan percaya bahwa masa depan kedamaian harus dipertahankan oleh kekuatan manusia sendiri.', 'Episode 1: Ultraman Teacher', 'https://ultra.fandom.com/wiki/Kazuki_Oyama');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Emi Jono') THEN
    INSERT INTO characters (series_id, name, civilian_name, actor, role, species, team, power, bio, debut_episode, source_url)
    VALUES (v_series_id, 'Emi Jono', 'Emi Jono', 'Eri Ishida', 'Team Member', 'Manusia', 'UGM', 'Keahlian teknologi komunikasi dan pilot tempur tim UGM.', 'Anggota wanita tangguh di tim UGM yang setia mendampingi Takeshi Yamato dalam berbagai misi penyelamatan hingga ia gugur pada Episode 43.', 'Episode 1: Ultraman Teacher', 'https://ultra.fandom.com/wiki/Emi_Jono');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Hoe') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Hoe', NULL, 'Villain', 'Kaiju Energi Minus', 'Semburan cairan asam energi negatif dan raungan yang memicu kepanikan.', 'Monster yang tercipta dari rasa patah hati dan keputusasaan mendalam seorang remaja, menjadi simbol monster Energi Minus awal serial.', 'Episode 3: Hot-Blooded! Teacher and Student', '[{"label":"Tinggi","value":"55","unit":"m"},{"label":"Berat","value":"23000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Hoe');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM characters WHERE series_id = v_series_id AND name = 'Margodon') THEN
    INSERT INTO characters (series_id, name, actor, role, species, power, bio, debut_episode, extra_stats, source_url)
    VALUES (v_series_id, 'Margodon', NULL, 'Villain', 'Kaiju Es Antariksa', 'Badai pembeku suhu mutlak yang sanggup membekukan kota sekaligus melumpuhkan monster lain.', 'Monster terakhir serial Ultraman 80 yang membekukan kota, namun akhirnya ditaklukkan oleh kerja sama murni tim manusia UGM tanpa campur tangan langsung Ultraman 80.', 'Episode 50: Ah! The Giraffes and Elephants All Turned to Ice!!', '[{"label":"Tinggi","value":"53","unit":"m"},{"label":"Berat","value":"39000","unit":"ton"}]'::jsonb, 'https://ultra.fandom.com/wiki/Margodon');
  END IF;

END $$;

SELECT setval(pg_get_serial_sequence('series', 'id'), COALESCE((SELECT MAX(id) FROM series), 1));
SELECT setval(pg_get_serial_sequence('characters', 'id'), COALESCE((SELECT MAX(id) FROM characters), 1));
