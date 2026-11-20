-- =============================================================================
-- SEED DATA: SERIES ARCS & ARC CHARACTERS — ULTRAMAN BATCH 1 (ERA SHOWA)
-- Idempoten: ON CONFLICT (series_id, arc_order) DO NOTHING
-- Tidak menimpa arc yang sudah ada atau yang sudah diedit manual.
-- Mencari series_id lewat subquery berdasarkan title.
-- Cakupan: Ultra Q, Ultraman, Ultraseven, The Return of Ultraman,
--          Ultraman Ace, Ultraman Taro, Ultraman Leo, Ultraman 80
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
  -- 1. ULTRA Q (1966) — 4 ARC (pengelompokan antologi misteri)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultra Q' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Jun Manjome' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Yuriko Edogawa' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Ippei Togawa' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Gomess' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Garamon' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Kanegon' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Keseimbangan Alam yang Retak',
      'Episode 01–07',
      E'Tanpa adanya pahlawan raksasa pelindung Bumi, rangkaian peristiwa ganjil mulai mengguncang Jepang modern. Pilot muda Jun Manjome, asistennya Ippei Togawa, serta jurnalis foto Yuriko Edogawa kerap berada di garis depan penyelidikan ketika kaiju purba Gomess terbangun dari bawah terowongan kereta.\n\nPada fase pembuka ini, mereka menghadapi anomali alam dan makhluk prasejarah seperti Gomess hingga Peguila yang menguji batas ilmu pengetahuan manusia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Penyelidik utama fenomena ganjil') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Reporter yang meliput insiden awal') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Kaiju pertama di era Ultra Series') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Serangan Meteor Garadama & Teror Antariksa',
      'Episode 08–14',
      E'Misteri mulai melebar ke luar batas ekologi Bumi ketika benda-benda asing dari ruang angkasa jatuh menghantam Jepang. Puncak ketegangan fase ini hadir saat meteor misterius Garadama mendarat di sebuah bendungan dan mengaktifkan robot penyerbu bernama Garamon.\n\nJun, Yuriko, dan Ippei harus memecahkan keterkaitan sinyal radio asing tersebut sebelum kehancuran meluas ke wilayah permukiman.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Membantu melacak sumber meteor Garadama') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Rekan setia dalam misi penyelidikan') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Robot invasi dari meteor Garadama') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kisah Satire, Dimensi Lain, dan Tantangan 2020',
      'Episode 15–21',
      E'Bagian tengah seri menyajikan kisah yang memadukan tragedi komedi manusia dengan ancaman fiksi ilmiah kelam. Mulai dari kisah anak serakah yang berubah menjadi monster koin Kanegon hingga kembalinya ancaman pasukan Garamon dalam skala lebih besar.\n\nSalah satu babak paling dikenang muncul lewat kedatangan Kemur Man dari masa depan yang menculik manusia demi kelangsungan bangsanya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Terlibat dalam kasus-kasus anomali perkotaan') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Kembali menyerang dalam episode 16') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Monster ikonik dari kepompong keserakahan') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Ambang Dunia Tak Terjelaskan',
      'Episode 22–28',
      E'Menjelang penutup seri, kasus-kasus yang dihadapi trio Hoshikawa Air Service dan Daily News semakin bersifat surealis dan eksistensial. Mulai dari kota bawah tanah rahasia hingga fenomena dimensi paralel yang membuat batas realitas menjadi kabur.\n\nSeri ini ditutup dengan pengingat bahwa manusia hidup berdampingan dengan misteri semesta yang belum seluruhnya dapat dipahami.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menyelesaikan rangkaian kasus misteri terakhir') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengabadikan peristiwa-peristiwa ganjil terakhir') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Mendampingi Jun hingga episode penutup') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 2. ULTRAMAN (1966) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Shin Hayata' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Toshio Muramatsu' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Akiko Fuji' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Daisuke Arashi' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Mitsuhiro Ide' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Alien Baltan' LIMIT 1;
    SELECT id INTO v_c8 FROM characters WHERE series_id = v_series_id AND name = 'Zetton' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kedatangan Raksasa Perak & Invasi Baltan',
      'Episode 01–10',
      E'Ketika sedang berpatroli di Danau Ryugamori, petugas SSSP Shin Hayata bertabrakan dengan bola cahaya merah dari Nebula M78 yang sedang mengejar monster Bemular. Merasa bersalah, sang makhluk cahaya membagi nyawanya dengan Hayata dan menyerahkan Beta Capsule.\n\nTak lama kemudian, Bumi menghadapi ancaman cerdas pertama dari luar angkasa: Alien Baltan yang mengincar Bumi sebagai koloni baru, memaksa Ultraman dan tim SSSP pimpinan Kapten Muramatsu bersinergi sejak awal.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Debut pahlawan raksasa dari Nebula M78') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menyatukan nyawa dengan Ultraman') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Memimpin SSSP dalam operasi awal') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Musuh alien ikonik di Episode 2') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Kebangkitan Monster Raksasa & Kembalinya Baltan',
      'Episode 11–21',
      E'Ancaman kaiju dan alien berevolusi semakin beragam dan sulit diprediksi. Alien Baltan kembali dengan taktik yang lebih terorganisasi untuk mengelabui tim SSSP dan menyerang di berbagai titik sekaligus.\n\nSementara itu, anggota SSSP seperti Ide, Arashi, dan Fuji terus menguji senjata baru dan pesawat Jet VTOL guna meminimalkan ketergantungan penuh terhadap Ultraman.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menghadapi serangan balas dendam Baltan') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Operator komunikasi & dukungan lapangan SSSP') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Penembak andalan SSSP') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Penemu persenjataan penunjang SSSP') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Melancarkan serangan balik di Episode 16') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Pertempuran Melawan Pangeran Kaiju Gomora',
      'Episode 22–32',
      E'Ekspedisi penangkapan dinosaurus purba di Pulau Johnson berujung bencana ketika makhluk bernama Gomora terbangun di tengah kota Osaka dan menghancurkan Kastil Osaka. Kekuatan fisiknya memaksa Ultraman mengalami salah satu duel terberatnya dalam dua babak.\n\nPada periode ini juga muncul berbagai ancaman alien penyamar seperti Alien Zarab serta invasi dimensi keempat oleh Bullton.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menghadapi Gomora & trik Alien Zarab') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Terjebak dalam konspirasi alien penyamar') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Mengarahkan evakuasi & taktik dua babak') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Pertarungan Terakhir Melawan Zetton',
      'Episode 33–39',
      E'Pasukan invasi Alien Zetton melancarkan serangan besar-besaran langsung ke markas besar SSSP menggunakan kaiju terkuat mereka, Zetton. Dalam duel klimaks yang menegangkan, seluruh teknik andalan Ultraman dipatahkan hingga Color Timer-nya hancur.\n\nUmat manusia akhirnya membuktikan ketangguhannya saat SSSP berhasil menghancurkan Zetton memakai peluru antigravitasi buatan Profesor Iwamoto, sementara Zoffy datang membawa pulang Ultraman dan memulihkan nyawa Hayata.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Tumbang melawan Zetton & diselamatkan Zoffy') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Berpisah dengan Ultraman di episode terakhir') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Ikut menuntaskan ancaman tanpa bergantung pada Ultraman') ON CONFLICT DO NOTHING; END IF;
    IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c8, 'Kaiju terkuat yang menumbangkan Ultraman') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 3. ULTRASEVEN (1967) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraseven' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraseven' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Dan Moroboshi' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kaoru Kiriyama' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Anne Yuri' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Shigeru Furuhashi' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Alien Metron' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'King Joe' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Pengamat 340 & Penetrasi Ultra Guard',
      'Episode 01–13',
      E'Agen Pengamat 340 dari Nebula M78 memutuskan menetap di Bumi dengan menyamar sebagai pemuda misterius bernama Dan Moroboshi setelah terpikat oleh keberanian manusia. Ia direkrut ke dalam unit elite Ultra Guard pimpinan Kapten Kiriyama.\n\nBerbeda dengan ancaman kaiju murni, musuh di fase ini mayoritas merupakan alien cerdas seperti Alien Cool, Alien Pitt bersama Eleking, hingga Alien Metron yang menyusup ke kehidupan warga biasa.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Beraksi membela Bumi dengan kode Ultraseven') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bergabung ke Ultra Guard') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Merekrut Dan ke dalam tim') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Dalang konflik psikologis di Episode 8') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Invasi Robot King Joe di Kobe',
      'Episode 14–25',
      E'Perselisihan diplomatik antarbangsa luar angkasa menyeret Bumi ke ambang perang terbuka ketika Alien Pedan mengirim robot tempur nyaris tak terkalahkan, King Joe, untuk menggagalkan konferensi pertahanan di Kobe.\n\nSerangan fisik biasa maupun Eye Slugger milik Ultraseven gagal menembus pelindungnya hingga tim Ultra Guard harus memproduksi senjata khusus berbahan mineral langka Wrightonium R30.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menghadapi kebuntuan tempur melawan King Joe') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Mendukung operasi penyelamatan diplomat') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Berjibaku di garis depan pertahanan Kobe') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Super-robot Alien Pedan di Episode 14–15') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Dilema Moral & Konflik Penjajah Bumi',
      'Episode 26–39',
      E'Bagian pertengahan hingga paruh akhir seri menyoroti sisi kelam perlombaan senjata dan dilema etika antara mempertahankan Bumi atau berempati pada penduduk asli maupun korban eksperimen antariksa.\n\nUltra Guard juga menghadapi ancaman canggih seperti Alien Guts yang mampu menyalin teknik Ultraseven dan hampir mengeksekusinya di muka umum.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Terjebak dalam perangkap Alien Guts') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menghadapi pertentangan batin sebagai pembela Bumi') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Memimpin tim pembebasan Ultraseven') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Invasi Terbesar Sepanjang Sejarah',
      'Episode 40–49',
      E'Setelah terus bertempur tanpa jeda, tubuh Dan Moroboshi mengalami kelelahan ekstrem hingga atasannya dari M78 memperingatkannya untuk pulang sebelum nyawanya terenggut. Namun Alien Ghose melancarkan invasi terakhir dengan melepaskan kaiju berkepala dua, Pandon.\n\nMengabaikan larangan medisnya, Dan mengungkap jati dirinya kepada Anne Yuri sebelum berubah untuk terakhir kalinya, menumpas Pandon bersama Ultra Guard lalu terbang kembali menuju Nebula M78.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Berjuang melampaui batas fisik di duel final') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengungkap identitas asli kepada Anne Yuri') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Memimpin serangan pamungkas Ultra Guard') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Menyaksikan perpisahan Dan di fajar akhir') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 4. THE RETURN OF ULTRAMAN (1971) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'The Return of Ultraman' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Jack' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Hideki Go' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Katsuichiro Kato' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Ryu Ibuki' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Aki Sakata' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Twin Tail' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Alien Nackle' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kembalinya Sang Pejuang & Lahirnya Tekad Hideki Go',
      'Episode 01–10',
      E'Pembalap muda berbakat Hideki Go mengorbankan nyawanya demi menyelamatkan anak kecil saat kaiju Arstron muncul. Terharu oleh keberanian tersebut, Ultraman baru (kemudian dikenal sebagai Ultraman Jack) menyatu dengannya dan mengembalikannya hidup.\n\nHideki bergabung dengan unit pertahanan MAT di bawah Kapten Kato dan berlatih mengatasi kesombongan pribadinya saat menghadapi ancaman awal termasuk kemunculan duo kaiju bawah tanah Twin Tail dan Gudon.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menyatu dengan Hideki tanpa alat transformasi') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Meniti hari-hari awal sebagai anggota MAT') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Membimbing kedisiplinan Hideki di MAT') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Monster purba yang bertarung melawan Gudon') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Anugerah Ultra Bracelet & Pergantian Komando MAT',
      'Episode 11–22',
      E'Ketika kaiju luar angkasa pemakan energi matahari Bemstar mengalahkan Ultraman Jack hingga ia terpaksa mundur mencari energi di Matahari, Ultraseven hadir membantu dengan menyerahkan senjata serbaguna Ultra Bracelet.\n\nTak lama berselang, Kapten Kato dipromosikan ke markas pusat antariksa dan kepemimpinan MAT beralih kepada Kapten Ryu Ibuki yang keras tetapi penuh dedikasi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memperoleh senjata Ultra Bracelet dari Ultraseven') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyerahkan komando unit MAT') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Debut sebagai kapten baru MAT di Episode 22') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Ujian Batin dan Ancaman Alien Licik',
      'Episode 23–36',
      E'Di bawah komando Kapten Ibuki, ketegangan internal di tubuh MAT serta sisi kelam masyarakat manusia semakin disorot lewat episode-episode dramatis seperti kisah Alien Mates.\n\nHideki tidak hanya berjuang membasmi monster raksasa, melainkan juga berusaha mempertahankan sisi kemanusiaannya dan hubungannya dengan keluarga Sakata.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menghadapi tragedi prasangka terhadap alien') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memimpin operasi MAT di masa krisis moral') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Menjadi penopang emosional Hideki') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Tragedi Matahari Terbenam Melawan Alien Nackle',
      'Episode 37–38',
      E'Untuk menghancurkan mental Hideki Go sebelum bertarung, Alien Nackle secara keji membunuh sahabat sekaligus kekasihnya, Ken dan Aki Sakata. Dalam kondisi berduka dan kehilangan konsentrasi, Ultraman Jack tak berdaya menghadapi pengawal terkuat Nackle, Black King.\n\nJack ditawan ke luar angkasa untuk dieksekusi, namun Ultraman pertama dan Ultraseven datang menyelamatkannya tepat waktu. Dengan tekad yang pulih, Jack bangkit menumpas Black King dan Alien Nackle.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Ditawan lalu diselamatkan dua kakak Ultranya') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Bangkit dari duka mendalam kehilangan sahabat') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Gugur sebagai korban kekejaman Alien Nackle') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Otak tragedi di balik pengerahan Black King') ON CONFLICT DO NOTHING; END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Lima Sumpah Ultra & Pertempuran Terakhir',
      'Episode 39–51',
      E'Pasca tragedi tersebut, Hideki memilih tetap melindungi adik Aki, Jiro Sakata, sambil menghadapi sisa ancaman alien besar. Pada episode final, Alien Bat menyusun rencana pemusnahan dengan membawa Zetton II setelah mengancam Tanah Cahaya.\n\nBersama rekan-rekan MAT yang mengetahui identitasnya, Jack mengalahkan Alien Bat dan Zetton II, lalu menitipkan lima sumpah Ultra kepada Jiro sebelum pulang membantu pertahanan Nebula M78.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menumbangkan Zetton II dan kembali ke M78') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mewariskan lima sumpah Ultra sebelum berpisah') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Mendukung serangan akhir MAT menghadapi Alien Bat') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 5. ULTRAMAN ACE (1972) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Ace' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Ace' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Seiji Hokuto' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Yuko Minami' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Goro Ryu' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Kozo Yoshimura' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Yapool' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Ace-Killer' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Ultra Touch & Lahirnya Choju Yapool',
      'Episode 01–12',
      E'Entitas antar dimensi Yapool mulai menyerang Bumi memakai Choju (Terrible-Monsters), senjata biologis yang lebih buas daripada kaiju biasa. Pengantar roti Seiji Hokuto dan perawat Yuko Minami gugur saat mengevakuasi warga dalam serangan Verokron.\n\nEmpat Ultra Brothers mengutus pejuang kelima, Ultraman Ace, untuk membangkitkan kembali keduanya dengan memberikan Cincin Ultra. Melalui penyatuan dua cincin bernama Ultra Touch, keduanya bergabung menjadi Ultraman Ace sekaligus masuk tim TAC pimpinan Kapten Goro Ryu.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Pejuang kelima Ultra Brothers') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Inang pria yang bergabung ke tim TAC') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Inang wanita yang melengkapi Ultra Touch') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Komandan tim TAC menghadapi ancaman Choju') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Dalang penciptaan pasukan Choju') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Tragedi Planet Golgotha & Ace-Killer',
      'Episode 13–25',
      E'Yapool memancing Zoffy, Ultraman, Ultraseven, dan Ultraman Jack ke dimensi Planet Golgotha lalu menyalib mereka untuk menyedot energinya ke dalam mesin pembunuh Ace-Killer.\n\nMenghadapi Ace-Killer yang mampu menembakkan jurus andalan para kakaknya sekaligus, Ultraman Ace menerima energi gabungan keempat Ultra Brothers untuk melancarkan Space Q dan menghancurkan robot mematikan tersebut.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Melepaskan jurus pamungkas Space Q') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Mendukung analisis TAC atas krisis antariksa') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Merancang perangkap Planet Golgotha') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Debut di Episode 14 sebagai pembunuh Ultra') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Krisis Patung Perunggu & Kepergian Gadis Bulan',
      'Episode 26–28',
      E'Alien Hipporit berhasil membatukan seluruh Ultra Brothers menjadi patung perunggu di hadapan penduduk Bumi, memaksa Father of Ultra turun langsung ke Bumi dan mengorbankan energinya demi memulihkan Ace untuk membalas kekalahan tersebut.\n\nDi Episode 28, identitas sejati Yuko Minami sebagai keturunan penghuni Bulan terungkap setelah menuntaskan ancaman Lunaticks. Ia menyerahkan cincinnya kepada Seiji Hokuto sebelum berpulang menuju dunianya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Diselamatkan Father of Ultra saat krisis Hipporit') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menerima tanggung jawab tunggal sebagai inang Ace') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Berpamitan meninggalkan Bumi di Episode 28') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Perjuangan Tunggal Seiji Hokuto',
      'Episode 29–43',
      E'Sejak kepergian Yuko, Seiji Hokuto berubah menjadi pejuang tunggal yang dapat memanggil Ultraman Ace sendiri. Ia pun harus menanggung beban tempur yang lebih berat sambil membina kedekatan dengan Dan Umezu.\n\nMeski Yapool sempat tampak melemah setelah serangan balasan Ace ke markas dimensinya, sisa kebencian Yapool terus membangkitkan Choju-Choju ganas baru.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Bertarung dengan satu inang manusia') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Tumbuh lebih matang sebagai prajurit TAC') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memimpin tim TAC mempertahankan pertahanan') ON CONFLICT DO NOTHING; END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Serangan Terakhir Yapool & Pesan Harapan Ace',
      'Episode 44–52',
      E'Di ambang kejatuhannya, sisa kesadaran Yapool mengerahkan Choju terkuatnya, Jumbo King, yang memaksa Seiji mengungkap identitasnya demi menyelamatkan anak-anak dari penyamaran licik musuh.\n\nSetelah menghancurkan Jumbo King di Episode 52, Ultraman Ace menyampaikan pesan penting kepada anak-anak agar tidak kehilangan kebaikan hati dan keadilan, sebelum ia berpisah meninggalkan Bumi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengalahkan Jumbo King & berpesan kepada generasi muda') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Mengungkap jati diri demi melindungi warga') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Melancarkan serangan pamungkas lewat Jumbo King') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 6. ULTRAMAN TARO (1973) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Taro' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Taro' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kotaro Higashi' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Yutaro Asahina' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Tadao Nanbara' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Birdon' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Alien Temperor' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Tyrant' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kelahiran Putra Tanah Cahaya',
      'Episode 01–16',
      E'Petinju pengembara Kotaro Higashi terluka parah saat melawan kaiju tumbuhan Astromons. Lima Ultra Brothers bersama Mother of Ultra membawa tubuhnya dan menyatukannya dengan pejuang muda Tanah Cahaya, Ultraman Taro.\n\nDibekali Ultra Badge di lengan kiri serta semangat membara, Kotaro bergabung dengan unit pertahanan udara eksentrik ZAT pimpinan Kapten Asahina.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Debut pejuang keenam Ultra Brothers') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menerima Ultra Badge dan masuk tim ZAT') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Komandan tim ZAT yang penuh karisma') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Teror Birdon & Kebangkitan Zoffy',
      'Episode 17–24',
      E'Salah satu krisis paling brutal era Showa datang saat kaiju burung purba raksasa Birdon terbangun. Dengan paruh mematikan dan racun ganas, Birdon berhasil membunuh Ultraman Taro, lalu mengalahkan Zoffy yang turun menggantikannya.\n\nMother of Ultra memulihkan Taro sekaligus menganugerahkan King Bracelet. Dengan strategi baru bersama ZAT, Taro memancing Birdon jatuh ke dalam kawah gunung berapi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Dibangkitkan Mother of Ultra & mendapat King Bracelet') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Terlibat dalam operasi taktis ZAT melawan Birdon') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Kaiju burung ganas di Episode 17–19') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Reuni Ultra Brothers Menghadapi Alien Temperor',
      'Episode 25–39',
      E'Ketika Alien Temperor turun ke Bumi dengan misi membasmi seluruh Ultra Brothers, kelima kakak Taro memilih turun dalam wujud manusia mereka demi menguji kemandirian sang adik bungsu.\n\nNamun kerja sama keluarga Ultra tetap tak terelakkan saat ancaman Temperor kian licik, memperlihatkan kekompakan keenam Ultra Brothers menumpas invasi tersebut bersama tim ZAT.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Bertarung berdampingan dengan seluruh kakaknya') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menyambut para senior Ultra dalam wujud manusia') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Penjajah licik di Episode 33–34') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Menembus Batas Ultra: Kaiju Gabungan Tyrant',
      'Episode 40–47',
      E'Dari serpihan dendam tujuh monster dan alien terdahulu lahirlah kaiju gabungan Tyrant. Dalam perjalanannya menuju Bumi, Tyrant berturut-turut melumpuhkan Zoffy, Ultraman, Ultraseven, Jack, dan Ace di berbagai planet tata surya.\n\nSetibanya di Bumi dalam kondisi kelelahan tempur sekaligus penuh kepercayaan diri, Tyrant berhadapan dengan Ultraman Taro yang berhasil menjatuhkannya dan membuktikan kesiapannya sebagai pejuang tangguh.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengalahkan monster yang melumpuhkan lima kakaknya') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membantu pertahanan darat ZAT') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Kaiju gabungan di Episode 40') ON CONFLICT DO NOTHING; END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Perpisahan Ultra Badge & Keberanian Manusia',
      'Episode 48–53',
      E'Pada klimaks Episode 53, Alien Valky bersama kaiju Samekujira membunuh kapten kapal sahabat Kotaro. Menyadari bahwa manusia harus berdiri di atas kaki sendiri tanpa terus bergantung pada kekuatan Ultra, Kotaro mengambil keputusan besar.\n\nIa melepaskan Ultra Badge dan menyerahkannya kembali kepada Mother of Ultra, lalu menuntaskan pertarungan terakhir melawan Alien Valky sepenuhnya sebagai manusia biasa.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Berpisah secara terhormat dengan Kotaro') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menyerahkan Ultra Badge & mengalahkan musuh sebagai manusia') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyaksikan kedewasaan penuh Kotaro') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 7. ULTRAMAN LEO (1974) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman Leo' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman Leo' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Gen Otori' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Astra' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman King' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Momoko Yamaguchi' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Alien Magma' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Commander Black' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kehancuran Nebula L77 & Pelatihan Keras Kapten Dan',
      'Episode 01–13',
      E'Planet asal Ultraman Leo di Nebula L77 hancur oleh kekejaman Alien Magma beserta kaiju Red Giras dan Black Giras. Melarikan diri ke Bumi dalam wujud Gen Otori, Leo menyelamatkan Dan Moroboshi meski kaki Dan terluka permanen dan Ultra Eye-nya rusak.\n\nSebagai komandan tim MAC, Dan melatih Gen secara keras tanpa ampun baik fisik maupun mental, sementara Gen berjuang menjaga kedamaian kota dan orang-orang terdekatnya seperti Momoko Yamaguchi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengemban tugas menggantikan Ultraseven') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menjalani latihan keras dari Dan Moroboshi') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Sosok terdekat Gen di Jonan Sports Center') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Penghancur planet asal Leo di Episode 1–2') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Kembalinya Sang Adik Astra & Anugerah Ultra Mantle',
      'Episode 14–29',
      E'Di tengah pertarungan berat menghadapi serbuan monster dan alien baru, Gen dikejutkan oleh kehadiran adik kembarnya yang disangka telah gugur, Astra, yang datang membantu di saat genting.\n\nPada fase ini pula penguasa legendaris Ultraman King turun tangan menganugerahkan Ultra Mantle kepada Leo sebagai pengakuan atas ketekunan dan pengorbanannya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menerima Ultra Mantle dari Ultraman King') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Muncul membantu sang kakak di Episode 22') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Debut di Episode 26 membantu Leo') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Konflik Kunci Ultra: Leo Brothers vs Ultra Brothers',
      'Episode 30–39',
      E'Alien Babarue menyamar menjadi Astra lalu mencuri Ultra Key dari Tanah Cahaya, memicu perselisihan besar karena para Ultra Brothers menyangka Astra berkhianat. Leo terpaksa menghadapi saudara-saudara Ultra demi melindungi adiknya.\n\nKrisis yang hampir menabrakkan Tanah Cahaya ke Bumi itu akhirnya diselesaikan berkat campur tangan Ultraman King yang membongkar penyamaran Alien Babarue.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Membela Astra di tengah konflik antar-Ultra') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Dikhianati oleh penyamaran Alien Babarue') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membongkar dalang pencurian Ultra Key') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kehancuran MAC & Teror Saucer Creature',
      'Episode 40–45',
      E'Tragedi paling mengguncang terjadi di Episode 40 ketika makhluk piring terbang raksasa Silverbloome yang dikirim Commander Black menghancurkan markas antariksa tim MAC beserta hampir seluruh anggotanya.\n\nSelain kehilangan tim MAC, Gen juga kehilangan sahabat-sahabatnya di Jonan Sports Center termasuk Momoko dan harus berhadapan sendirian melawan teror Saucer Creature.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Bertarung sendirian usai kehancuran MAC') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menanggung duka kehilangan hampir seluruh kenalannya') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Gugur dalam serangan Silverbloome') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Memulai invasi Saucer Creature dari Black Star') ON CONFLICT DO NOTHING; END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Kehancuran Black Star & Pelayaran Leo',
      'Episode 46–51',
      E'Bertekad menuntaskan teror Commander Black tanpa bantuan pasukan pertahanan, Gen menempuh serangkaian duel hidup-mati termasuk saat Ultraman King kembali membantunya bangkit dari ambang kematian.\n\nDi episode penutup, Leo bersama bantuan Toru menghancurkan Commander Black sekaligus memusnahkan planet Black Star. Kini Bumi sudah aman, Gen pun berlayar mengarungi dunia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Memusnahkan Black Star di pertarungan final') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Memulai perjalanan keliling dunia di akhir seri') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Membantu pemulihan Leo di paruh akhir') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Tumbang bersama hancurnya Black Star') ON CONFLICT DO NOTHING; END IF;
  END IF;


  -- ===========================================================================
  -- 8. ULTRAMAN 80 (1980) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Ultraman 80' AND franchise = 'Ultraman' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Ultraman 80' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Takeshi Yamato' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Yullian' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Kazuki Oyama' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Emi Jono' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Hoe' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Margodon' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Guru Sekolah Menengah & Fenomena Energi Minus',
      'Episode 01–13',
      E'Ultraman 80 turun ke Bumi dengan menyamar sebagai guru IPA muda bernama Takeshi Yamato di SMP Sakuragaoka, karena meyakini bahwa kemunculan kaiju modern dipicu oleh Energi Minus dari emosi negatif manusia.\n\nSelain membimbing murid-muridnya keluar dari masalah keseharian seperti kasus kemunculan kaiju Hoe, ia juga direkrut Kapten Oyama menjadi anggota paruh waktu tim UGM.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Debut pahlawan Ultra dengan catatan tanpa kekalahan') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menjalani peran ganda sebagai guru dan agen UGM') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Merekrut Takeshi ke unit pertahanan UGM') ON CONFLICT DO NOTHING; END IF;
    IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c6, 'Monster Energi Minus dari Episode 3') ON CONFLICT DO NOTHING; END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Operasi Penuh Waktu Bersama Tim UGM',
      'Episode 14–29',
      E'Seiring meningkatnya frekuensi invasi alien dan kaiju berskala besar, kisah Takeshi berfokus penuh pada operasi militer ilmiah bersama tim UGM dan mengakhiri rutinitasnya mengajar di kelas.\n\nHubungan kerja sama Takeshi dengan Emi Jono dan anggota UGM lainnya semakin solid menghadapi berbagai ancaman antariksa maupun kaiju yang bangkit akibat kelalaian manusia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Menjaga rekor tak terkalahkan di garis depan') ON CONFLICT DO NOTHING; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Beralih penuh ke tugas lapangan UGM') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Rekan setim UGM yang mendukung operasi udara') ON CONFLICT DO NOTHING; END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kedatangan Sang Putri Yullian',
      'Episode 30–48',
      E'Memasuki paruh akhir seri, Putri Tanah Cahaya bernama Yullian turun ke Bumi untuk memperingatkan ancaman Raja Galtan dan sempat mengalami hilang ingatan sebelum menyamar menjadi Ryoko Hoshi.\n\nSetelah Emi Jono gugur secara heroik melindungi timnya di Episode 43, Ryoko resmi menggantikan posisi Emi sebagai anggota UGM dan berjuang bersama Takeshi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3; END IF;
    IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c2, 'Menerima kehadiran sahabat masa kecilnya') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Menyamar sebagai Ryoko Hoshi & masuk tim UGM') ON CONFLICT DO NOTHING; END IF;
    IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c5, 'Gugur secara heroik membela tim di Episode 43') ON CONFLICT DO NOTHING; END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kemerdekaan Pertahanan Manusia & Akhir Era Showa',
      'Episode 49–50',
      E'Yullian mengungkap wujud Ultra-nya di Episode 49 guna membantu Ultraman 80 menumpas monster kembar Energi Minus, Plazma dan Minazma. Memasuki Episode 50, Kapten Oyama mengungkap bahwa dirinya telah mengetahui identitas asli Takeshi dan Ryoko.\n\nKetika kaiju es Margodon menyerang, Oyama melarang mereka berubah demi membuktikan bahwa umat manusia mampu melindungi Bumi sendiri. UGM berhasil menghancurkan Margodon, menandai perpisahan hangat 80 dan Yullian sekaligus penutup era TV Showa.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING RETURNING id INTO v_arc_id;
    IF v_arc_id IS NULL THEN SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4; END IF;
    IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c1, 'Mengakhiri misi di Bumi dengan catatan tanpa kalah') ON CONFLICT DO NOTHING; END IF;
    IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c3, 'Bertransformasi di Episode 49 & pulang bersama 80') ON CONFLICT DO NOTHING; END IF;
    IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c4, 'Memimpin kemenangan mandiri umat manusia') ON CONFLICT DO NOTHING; END IF;
    IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters VALUES (v_arc_id, v_c7, 'Kaiju terakhir yang dihadapi langsung oleh UGM') ON CONFLICT DO NOTHING; END IF;
  END IF;

END $$;
