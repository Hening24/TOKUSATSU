-- =============================================================================
-- SEED DATA: SERIES ARCS & ARC CHARACTERS (IDEMPOTEN)
-- Memindahkan kronologi & sejarah ke tabel relasional series_arcs dan arc_characters
-- Menggunakan ON CONFLICT (series_id, arc_order) DO UPDATE
-- Prioritas 8 Series: Kamen Rider (1971), Kuuga, Ryuki, Den-O, Build, Zero-One, Geats, Gavv
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
  v_arc_id INT;
  v_char_main INT;
  v_char_sec INT;
  v_char_extra INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER (1971) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider' AND year = 1971 LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 1' LIMIT 1;
    SELECT id INTO v_char_sec FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider 2' LIMIT 1;
    SELECT id INTO v_char_extra FROM characters WHERE series_id = v_series_id AND name = 'Shocker Rider No. 1' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kelahiran Cyborg Belalang',
      'Episode 01–13',
      E'Takeshi Hongo, seorang mahasiswa biokimia sekaligus pembalap motor berprestasi, diculik oleh sindikat teroris rahasia Shocker untuk direkonstruksi menjadi prajurit cyborg. Sebelum operasi pencucian otak tahap akhir berhasil dijalankan, Profesor Midorikawa membantunya meloloskan diri dari markas bawah tanah Shocker.\n\nDengan mengandalkan sabuk pengubah Typhoon bertenaga angin serta sepeda motor Cyclone, Hongo bersumpah mendedikasikan tubuh barunya untuk menumpas para monster mutan ciptaan Shocker demi kebebasan umat manusia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Debut Takeshi Hongo sebagai Kamen Rider pertama.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Sang Penyelamat Kedua: Hayato Ichimonji',
      'Episode 14–52',
      E'Ketika Takeshi Hongo harus bertolak ke luar negeri untuk membongkar jaringan cabang Shocker di Eropa, organisasi tersebut menculik seorang fotografer lepas bernama Hayato Ichimonji untuk menjadikannya Kamen Rider pengganti. Namun Hongo berhasil menggagalkan proses cuci otak tersebut tepat waktu.\n\nHayato pun mengambil alih tugas mempertahankan Jepang sebagai Kamen Rider 2. Ia memperkenalkan pose transformasi khas serta bertarung menghadapi komandan kejam Shocker seperti Kolonel Zol dan Dr. Shinigami.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_sec IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_sec, 'Hayato Ichimonji mengambil peran pelindung utama di Jepang.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Kembali membantu di beberapa pertempuran penting.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kembalinya Double Riders Melawan Shocker',
      'Episode 53–79',
      E'Takeshi Hongo kembali ke Jepang dengan wujud pembaruan yang lebih tangguh untuk mengambil alih garis depan pertarungan melawan komandan baru Shocker, Ambassador Hell. Kehadirannya membuka era kerja sama erat bersama Hayato Ichimonji sebagai Double Riders.\n\nSerangkaian pertempuran sengit berlangsung melawan monster-monster tangguh Shocker yang mengincar fasilitas penting negara, sebelum akhirnya markas cabang Shocker di Jepang mulai terdesak.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Kembali menjadi protagonis utama dengan wujud New 1.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
    IF v_char_sec IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_sec, 'Bertarung bersama Hongo sebagai Double Riders.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Gel-Shocker & Enam Shocker Riders',
      'Episode 80–98',
      E'Sisa kekuatan Shocker bergabung dengan organisasi rahasia Geldam membentuk sindikat baru bernama Gel-Shocker yang dipimpin oleh Jenderal Black. Mereka menciptakan enam prajurit tiruan identik bernama Shocker Riders dengan syal warna-warni untuk menjebak dan memfitnah Kamen Rider.\n\nHongo dan Ichimonji kembali bersatu menghadapi kepungan enam Shocker Riders dalam duel dramatis. Setelah berhasil mengalahkan pasukan tiruan tersebut, Double Riders menyerbu markas besar Gel-Shocker dan mengakhiri teror Pemimpin Besar.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Memimpin serangan terakhir menumpas Gel-Shocker.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
    IF v_char_sec IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_sec, 'Membantu menumbangkan enam Shocker Riders dan Jenderal Black.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
    IF v_char_extra IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_extra, 'Pemimpin regu enam cyborg tiruan buatan Gel-Shocker (Ep. 91–94).')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER KUUGA (2000) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kuuga' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kuuga' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kebangkitan Gurongi & Lahirnya Kuuga',
      'Episode 01–16',
      E'Penggalian situs kuno di Pegunungan Kurogatake melepaskan suku misterius Gurongi yang kembali melakukan pembantaian manusia sebagai bagian dari permainan ritual bernama Gegeru. Pemuda berjiwa bebas bernama Yusuke Godai mengenakan sabuk batu kuno Arcle dan berubah menjadi prajurit legendaris Kuuga.\n\nDengan dukungan inspektur polisi Kaoru Ichijo serta peneliti Sakurako Sawatari, Yusuke mempelajari empat wujud dasar Kuuga (Mighty, Dragon, Pegasus, dan Titan) untuk beradaptasi menghadapi kekuatan unik setiap anggota Gurongi.',
      'Lihatlah perubahanku!',
      'Yusuke Godai',
      NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menguasai empat wujud dasar dan menjalin kerja sama dengan kepolisian.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Evolusi Kekuatan Emas (Rising Form)',
      'Episode 17–26',
      E'Yusuke sempat mengalami kondisi kritis ketika menghadapi Gurongi kelas tinggi hingga nyaris kehilangan nyawanya. Berkat penanganan medis berisiko dan respons batu Amadam di dalam tubuhnya, ia bangkit kembali dengan potensi kekuatan baru beraksen emas yang dikenal sebagai Rising Form.\n\nPada tahap ini, pihak kepolisian mulai mengembangkan persenjataan khusus dan kendaraan pendukung Gouram guna mengimbangi daya hancur Gurongi yang kian meningkat.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Membangkitkan wujud Rising dengan daya serang berlipat ganda.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Eskalasi Gegeru & Kemunculan Go-Group',
      'Episode 27–38',
      E'Gurongi tingkat elite dari kelompok Go mulai turun ke arena permainan Gegeru dengan target korban ratusan jiwa dan metode pembunuhan yang terencana. Yusuke harus mengorbankan keseimbangan emosinya demi memaksa tubuhnya mengeluarkan kekuatan yang jauh lebih buas, termasuk wujud Amazing Mighty.\n\nSementara itu, polisi mulai berhasil menganalisis pola bahasa dan kode permainan Gurongi berkat kerja keras Sakurako dan tim forensik.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menghadapi kebrutalan kelompok Go dan beban psikologis pertempuran.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kegelapan Ultimate & Duel Melawan Daguva',
      'Episode 39–49',
      E'Pemimpin tertinggi Gurongi, Unidentified Lifeform #0 (N·Daguva·Zeba), muncul membawa kehancuran luar biasa dan membantai anggota Gurongi lainnya yang dianggap lemah. Untuk menghentikannya, Yusuke terpaksa mengakses wujud terlarang Ultimate Form yang berisiko menghilangkan kendali dirinya.\n\nBerbekal tekad melindungi senyuman orang-orang di sekitarnya, Yusuke mempertahankan kesadarannya dan bertarung habis-habisan melawan Daguva di tengah badai salju Kurogatake hingga pertarungan berakhir.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengakses wujud Ultimate demi menumbangkan N·Daguva·Zeba.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER RYUKI (2002) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Ryuki' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ryuki' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Dunia Cermin & Awal Perang Rider',
      'Episode 01–14',
      E'Jurnalis muda Shinji Kido menemukan kartu Advent Deck yang membawanya masuk ke dimensi cermin berbahaya bernama Mirror World. Setelah membuat kontrak dengan naga cermin Dragredder, ia berubah menjadi Kamen Rider Ryuki.\n\nShinji segera mengetahui dari Ren Akiyama (Kamen Rider Knight) bahwa ia terjebak dalam Rider War yang dirancang Shiro Kanzaki: tiga belas Rider dipaksa saling membunuh agar satu pemenang terakhir dapat mengabulkan satu keinginannya.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Shinji menjadi Ryuki dengan tujuan menghentikan pertarungan antar Rider.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Munculnya Rider Kejam & Kekacauan Ouja',
      'Episode 15–28',
      E'Semakin banyak pemegang Deck bermunculan dengan motif egois masing-masing, mulai dari pengacara sakit parah Shuichi Kitaoka (Zolda) hingga penjahat keji Takeshi Asakura (Ouja) yang haus pertumpahan darah. Kehadiran Ouja memicu bentrokan brutal yang merenggut nyawa beberapa Rider.\n\nDi tengah ketegangan, wujud kuat Kamen Rider Odin tampil sebagai perpanjangan tangan Kanzaki, memaksa Shinji dan Ren menghadapi kenyataan bahwa aturan permainan ini tidak mudah dihentikan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Berjuang melindungi warga dan Rider lain dari serangan brutal Ouja.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Dilema Survive & Rahasia Masa Lalu Yui',
      'Episode 29–40',
      E'Kanzaki menyerahkan kartu Survive untuk mempercepat tersingkirnya para Rider, membuat Shinji dan Ren memperoleh wujud terkuat mereka yakni Ryuki Survive dan Knight Survive. Meski sempat terguncang, prinsip Shinji yang menolak membunuh sesama manusia perlahan memengaruhi beberapa Rider di sekitarnya.\n\nDi sisi lain, Yui Kanzaki mulai mengingat kembali hubungan masa kecilnya dengan sang kakak dan asal mula terciptanya Mirror World yang ternyata terhubung dengan hidup dan matinya sendiri.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Memperoleh kartu Survive Mugen dan mengungkap rahasia Mirror World.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Pengorbanan Terakhir & Akhir Perang Rider',
      'Episode 41–50',
      E'Ketika batas waktu ulang tahun ke-20 Yui semakin dekat, monster Mirror World mulai membanjiri dunia nyata untuk menyerang warga sipil. Dalam sebuah upaya melindungi seorang anak kecil dari serangan monster, Shinji mengalami luka fatal setelah bertarung dalam wujud Survive.\n\nRen melanjutkan pertarungan pamungkas hingga berhadapan dengan Odin demi menyelamatkan kekasihnya. Mengetahui tekad adiknya Yui yang memilih menolak perpanjangan nyawa berdarah tersebut, Kanzaki akhirnya membatalkan perang dan memulihkan garis waktu agar para peserta kembali hidup di dunia damai tanpa Rider War.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Berjuang hingga napas terakhir demi menyelamatkan warga sipil.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER DEN-O (2007) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Den-O' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Den-O' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kereta Waktu Den-Liner & Para Taros',
      'Episode 01–18',
      E'Ryotaro Nogami, pemuda yang kerap mengalami nasib sial, tidak sengaja menemukan Rider Pass yang memberinya akses ke kereta penjelajah waktu Den-Liner. Karena memiliki daya tahan unik sebagai Singularity Point, ia mampu mempertahankan kesadaran saat dirasuki makhluk masa depan bernama Imagin.\n\nBersama Momotaros yang bersemangat, Urataros yang cerdas, Kintaros yang kuat, dan Ryutaros yang lincah, Ryotaro berubah menjadi Kamen Rider Den-O dalam berbagai wujud untuk menghentikan Imagin jahat yang mengubah masa lalu.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengumpulkan keempat Taros Imagin untuk menjaga aliran waktu.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Kehadiran Zeronos & Beban Ingatan',
      'Episode 19–28',
      E'Seorang penjelajah waktu lain bernama Yuto Sakurai muncul bersama rekan Imagin-nya yang setia, Deneb, dan bertarung sebagai Kamen Rider Zeronos. Berbeda dengan Ryotaro, setiap kartu transformasi yang dipakai Yuto membayar harga mahal berupa hilangnya ingatan orang-orang tentang keberadaannya.\n\nRyotaro perlahan menyadari bahwa Yuto memiliki keterkaitan masa lalu yang erat dengan kakaknya, Airi Nogami, dan misteri hilangnya titik waktu tertentu.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Bekerja sama dengan Yuto Sakurai dan mengungkap rahasia sang kakak.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kemunculan Kai & Krisis Singularity Point',
      'Episode 29–39',
      E'Sosok pemimpin Imagin bernama Kai muncul di garis waktu sekarang dengan kemampuan membuka gerbang ke masa lalu untuk meruntuhkan sejarah manusia. Ketika hubungan antara tahun masa lalu dan sekarang terganggu, ikatan para Taros terhadap tubuh Ryotaro sempat terputus di masa lampau.\n\nDengan memadukan kesadaran para Taros ke dalam pedang DenKamen Sword, Ryotaro bangkit mengakses wujud mandiri Liner Form guna melawan pasukan Imagin tanpa bergantung penuh pada pengambilalihan tubuh.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Membangkitkan wujud terkuat Liner Form untuk menghadapi rencana Kai.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Pertempuran Akhir Menjaga Masa Depan',
      'Episode 40–49',
      E'Rahasia di balik Junction Point terungkap ketika Airi dan Hana menjadi kunci tersambungnya kembali masa depan yang sempat terhapus. Kai mengerahkan seluruh armada Imagin dan Death Imagin untuk memusnahkan Ryotaro dan Yuto secara bersamaan.\n\nBerbekal kepercayaan kuat antara manusia dan Imagin, Den-O bersama para Taros serta Zeronos berhasil mengalahkan Kai dan memulihkan garis waktu masa depan, membuktikan bahwa ikatan kenangan sanggup menembus batas waktu.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengalahkan Kai dan mengembalikan keutuhan garis waktu.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER BUILD (2017) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Build' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Build' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Organisasi Rahasia Faust & Kotak Pandora',
      'Episode 01–14',
      E'Sepuluh tahun setelah bencana Skywall memecah Jepang menjadi wilayah Touto, Hokuto, dan Seito, fisikawan eksentrik bernama Sento Kiryu yang kehilangan ingatannya berjuang sebagai Kamen Rider Build melawan monster Smash. Ia bekerja sama dengan mantan petarung Ryuga Banjo yang dijebak atas kasus pembunuhan.\n\nKeduanya menyelidiki sindikat rahasia Faust yang dipimpin oleh Night Rogue (Gentoku Himuro) serta sosok licik Blood Stalk demi mengungkap misteri di balik hilangnya ingatan Sento dan kekuatan Kotak Pandora.',
      'Sekarang, ayo kita mulai eksperimennya!',
      'Sento Kiryu',
      NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menyelidiki Faust dan mengembangkan Fullbottle bersama Ryuga Banjo.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Invasi Hokuto & Pemicu Hazard',
      'Episode 15–22',
      E'Konflik bergeser dari operasi bayangan menjadi perang terbuka ketika pemerintah Hokuto melancarkan serangan militer ke Touto demi merebut panel Kotak Pandora. Hokuto mengerahkan prajurit cyborg Kamen Rider Grease (Kazumi Sawatari) bersama Trio Hokuto.\n\nUntuk menghadapi ancaman tersebut, Sento menggunakan perangkat berbahaya Hazard Trigger yang sempat merampas kesadarannya saat bertarung hingga mengakibatkan tragedi tewasnya Aoba. Ia kemudian merancang wujud RabbitRabbit dan TankTank untuk mengendalikan kekuatan itu dengan aman.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menghadapi beban moral perang wilayah dan mengendalikan Hazard Trigger.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Invasi Seito & Identitas Asli Blood Stalk',
      'Episode 23–33',
      E'Wilayah Seito menggantikan Hokuto dengan mengerahkan serangan besar-besaran atas dorongan Namba Heavy Industries, termasuk Kamen Rider Rogue serta kloning saudara bersenjata Engine Bros dan Remocon Bros. Pertempuran berlanjut menuju menara Kotak Pandora yang bangkit.\n\nPuncak dari konflik ini membongkar rahasia paling mengejutkan bahwa sosok Blood Stalk sebenarnya adalah Soichi Isurugi yang dirasuki entitas makhluk luar angkasa bernama Evolto.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengetahui jati diri sejati Sento sebagai Takumi Katsuragi dan mengungkap Evolto.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kebangkitan Kamen Rider Evol & Genius Form',
      'Episode 34–41',
      E'Evolto menanggalkan penyamarannya dan memperoleh kembali Evol-Driver untuk bertransformasi menjadi Kamen Rider Evol. Dengan kekuatan luar biasa dan manipulasi genetik terhadap Ryuga Banjo, ia perlahan mencapai wujud sempurna sambil mengincar sepuluh Lost Fullbottle.\n\nSento menyatukan ingatan masa lalunya sebagai Takumi Katsuragi dengan keyakinannya sebagai Sento Kiryu, lalu menciptakan Genius Fullbottle untuk menandingi kekuatan kosmik Evolto.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menciptakan wujud pamungkas Build Genius Form.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Perang Penentuan & Penciptaan Dunia Baru',
      'Episode 42–49',
      E'Demi menghentikan rencana Evolto melahap seluruh Bumi melalui panel hitam Kotak Pandora, Sento bersama Cross-Z, Grease, dan Rogue berjuang mati-matian dalam pertempuran terakhir. Grease dan Rogue gugur dengan terhormat setelah menumbangkan para kloning elit musuh.\n\nDalam klimaks di dalam portal energi Kotak Pandora, Sento dan Ryuga menggunakan kekuatan gabungan mereka untuk menggabungkan dua dunia paralel dan menciptakan Dunia Baru yang damai tanpa keberadaan Skywall.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menumbangkan Evolto dan melahirkan Dunia Baru tanpa Skywall.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 6. KAMEN RIDER ZERO-ONE (2019) — 4 ARC (Migrasi dari data lama)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Zero-One' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Zero-One' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Presiden Muda & Lahirnya Zero-One',
      'Episode 01–08',
      E'Aruto Hiden, seorang komedian tunggal yang kerap gagal menghibur penonton, mendadak ditunjuk melalui surat wasiat kakeknya untuk menjabat sebagai CEO baru perusahaan teknologi AI Hiden Intelligence. Di sampingnya bertugas asisten robot Humagear setia bernama Izu.\n\nKetika kelompok teroris siber MetsubouJinrai.net meretas Humagear agar mengamuk sebagai Magia, Aruto mengenakan sabuk Zero-One Driver dan Progrisekey Rising Hopper untuk bertarung sebagai Kamen Rider Zero-One demi melindungi impian antara manusia dan AI.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Aruto mewarisi Zero-One Driver dan memulai tugas ganda sebagai CEO dan Rider.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Teror Siber MetsubouJinrai.net',
      'Episode 09–16',
      E'Horobi dan Jin meningkatkan serangan teror dari reruntuhan Daybreak Town dengan memanfaatkan data pertarungan untuk membangkitkan kembali satelit kecerdasan buatan Ark yang tenggelam 12 tahun lalu. Situasi ini mempertemukan Aruto dengan pasukan khusus A.I.M.S. yang dipimpin Isamu Fuwa (Vulcan) dan Yua Yaiba (Valkyrie).\n\nKonflik tiga arah pun tak terhindarkan hingga munculnya wujud Shining Hopper dan Assault Hopper yang berhasil memukul mundur kebangkitan awal MetsubouJinrai.net.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Membuktikan bahwa Humagear juga dapat memiliki hati dan mimpi.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Konflik ZAIA Enterprise & Kebangkitan Ark',
      'Episode 17–35',
      E'Gai Amatsu, presiden ZAIA Enterprise Japan yang mampu berubah menjadi Kamen Rider Thouser, menantang Hiden Intelligence dalam kompetisi lima babak untuk membuktikan keunggulan manusia dibanding Humagear. Kemenangan licik ZAIA berujung pada akuisisi perusahaan keluarga Aruto.\n\nTidak menyerah, Aruto mendirikan perusahaan rintisan Hiden Manufacturing. Namun kejahatan yang menumpuk dalam sistem satelit akhirnya membangunkan wujud sejati Ark sebagai Kamen Rider Ark-Zero yang mengancam seluruh jaringan teknologi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mendirikan Hiden Manufacturing dan membuka wujud MetalCluster Hopper.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Keputusasaan Ark-One & Harapan Masa Depan',
      'Episode 36–45',
      E'Meski Aruto sempat mendapatkan wujud terkuat Kamen Rider Zero-Two bersama Izu, tragedi hancurnya Izu di tangan Horobi membuatnya diliputi kebencian dan keputusasaan hingga menjadi inang bagi Kamen Rider Ark-One.\n\nPada pertarungan terakhir melawan Horobi, Aruto akhirnya menyadari bahwa dendam tidak akan menyelesaikan lingkaran penderitaan. Dengan bangkitnya kembali wujud Realizing Hopper, mereka berdamai dan membangun masa depan di mana manusia serta Humagear dapat hidup berdampingan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO UPDATE SET
      chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
      summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
      image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
    RETURNING id INTO v_arc_id;

    IF v_char_main IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Bangkit dari keputusasaan Ark-One menuju masa depan bersama.')
      ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;
    END IF;
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER GEATS (2022) — Pastikan Series/Karakter Ada + 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Geats' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Geats',
      '仮面ライダーギーツ',
      'Kamen Rider',
      'Reiwa',
      2022,
      '2022-09-04',
      '2023-08-27',
      49,
      'Toei Company',
      'Rubah Ekor Sembilan (Kitsune)',
      'Desire Grand Prix (DGP) adalah permainan bertahan hidup misterius di mana para peserta terpilih berubah menjadi Kamen Rider untuk melindungi kota dari monster Jyamato. Pemenang utama turnamen berhak menulis ulang realitas demi mewujudkan keinginan terdalamnya. Pemuda misterius Ace Ukiyo yang berjuluk Kamen Rider Geats terus mendominasi permainan sambil mencari kebenaran tentang dirinya.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Geats'
    )
    RETURNING id INTO v_series_id;
  END IF;

  SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Geats' LIMIT 1;
  IF v_char_main IS NULL THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Geats', 'Kamen Rider Geats', 'Ace Ukiyo', 'Hideyoshi Kan', 'Main Rider',
      'Desire Driver dengan berbagai Raise Buckle (Magnum, Boost, Mark II, Mark IX), keahlian menembak presisi tinggi.',
      'Ace Ukiyo adalah juara bertahan tak terkalahkan dalam Desire Grand Prix yang menyimpan rahasia reinkarnasi selama ribuan tahun demi menemukan ibunya. Cerdas, tenang, dan penuh perhitungan, ia bertarung sebagai Kamen Rider Geats untuk membentuk dunia tempat semua orang bisa meraih kebahagiaan.',
      'Episode 1: Daybreak F: Invitation to the Rider',
      NULL,
      'https://kamenrider.fandom.com/wiki/Ace_Ukiyo'
    )
    RETURNING id INTO v_char_main;
  END IF;

  -- ARC 01 Geats
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 1, 'ARC 01',
    'Pembukaan Desire Grand Prix',
    'Episode 01–09',
    E'Keiwa Sakurai, Neon Kurama, dan Michinaga Azuma terpilih bersama Ace Ukiyo untuk berpartisipasi dalam turnamen bertahan hidup Desire Grand Prix melawan ancaman monster Jyamato. Mereka belajar bahwa kegagalan di dalam permainan berarti tersingkirnya peserta beserta lenyapnya ingatan mengenai DGP.\n\nAce menunjukkan kepiawaian luar biasa sebagai juara bertahan dengan mengandalkan Magnum dan Boost Buckle hingga berhasil memenangkan musim turnamen tersebut dan membentuk ulang dunia baru.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Memenangkan DGP putaran awal.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 02 Geats
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 2, 'ARC 02',
    'Konspirasi di Balik Turnamen',
    'Episode 10–16',
    E'Pada musim permainan berikutnya, Game Master Girori mulai merasa terancam oleh keinginan Ace yang berusaha mengungkap rahasia petinggi DGP dan ibunya. Girori diam-diam memanipulasi aturan serta memanfaatkan Kamen Rider Glare untuk menyingkirkan Ace dari arena.\n\nSementara itu, para Jyamato mulai berkembang dengan kecerdasan tinggi dan menyusup ke tengah kota, memaksa para peserta bersatu menghadapi sabotase internal yang terjadi di dalam manajemen turnamen.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengungkap sabotase Game Master Girori.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 03 Geats
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 3, 'ARC 03',
    'Pergolakan Game Master & Desastar',
    'Episode 17–24',
    E'Manajemen DGP menghadirkan Game Master baru bernama Chirami dan memperkenalkan aturan Desastar di mana salah satu peserta berperan sebagai pengkhianat tersembunyi. Kecurigaan antar sesama Rider memuncak di tengah meningkatnya serangan Jyamato.\n\nDalam arc ini, para penonton dari masa depan ikut menampakkan diri secara langsung, sementara kebenaran pahit tentang identitas para Rider yang ternyata menjadi tontonan hiburan elit masa depan mulai terkuak.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menghadapi intrik Desastar dan sponsor masa depan.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 04 Geats
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 4, 'ARC 04',
    'Jyamato Grand Prix & Rahasia Dewi Penciptaan',
    'Episode 25–38',
    E'Sponsor Beroba merebut kendali permainan dan meluncurkan Jyamato Grand Prix dengan menggandeng Michinaga (Buffa) untuk memburu para Rider. Di tengah kekacauan tersebut, rahasia besar terungkap: ibu Ace, Mitsume, dijadikan Dewi Penciptaan yang mengabulkan seluruh permintaan pemenang DGP dengan mengorbankan kebahagiaan orang lain.\n\nAce membangkitkan ingatan lintas kehidupannya dan memperoleh kekuatan Boost Mark II hingga mengalahkan skema Desire Royale yang digerakkan oleh otoritas tertinggi DGP.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menemukan kebenaran tentang ibunya sebagai Dewi Penciptaan.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 05 Geats
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 5, 'ARC 05',
    'Kelahiran Geats IX & Dunia Baru',
    'Episode 39–49',
    E'Pendiri DGP bernama Suel berniat me-reset realitas Bumi menggunakan kekuatan Penciptaan setelah merasa hiburan tersebut mulai kehilangan kendali. Di sisi lain, Keiwa sempat terjerumus ke jalur gelap akibat duka mendalam sebelum kembali disadarkan oleh sahabat-sahabatnya.\n\nAce mewarisi kekuatan penuh Penciptaan sebagai Kamen Rider Geats IX dan bertarung bahu-membahu bersama Tycoon, Na-Go, dan Buffa untuk mengalahkan Suel. Ace kemudian membentuk dunia baru di mana kebahagiaan dapat diraih oleh semua orang dengan kehendak bebas masing-masing.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Menjadi Geats IX, mengalahkan Suel, dan membebaskan manusia dari DGP.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;


  -- ===========================================================================
  -- 8. KAMEN RIDER GAVV (2024) — Pastikan Series/Karakter Ada + 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Gavv' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NULL THEN
    INSERT INTO series (
      title, title_jp, franchise, era, year, aired_from, aired_to,
      episodes, studio, motif, synopsis, poster, source_url
    ) VALUES (
      'Kamen Rider Gavv',
      '仮面ライダーガヴ',
      'Kamen Rider',
      'Reiwa',
      2024,
      '2024-09-01',
      '2025-08-31',
      50,
      'Toei Company',
      'Camilan / Permen Gummy (Snacks)',
      'Shoma adalah pemuda keturunan setengah manusia dan setengah Granute yang melarikan diri ke Bumi setelah diburu oleh keluarganya sendiri. Di dunia manusia, ia menemukan bahwa kelezatan camilan memunculkan makhluk mungil Gochizo dari sabuk di perutnya. Menggunakan kekuatan tersebut, ia berubah menjadi Kamen Rider Gavv untuk melindungi manusia dari sindikat Stomach Inc. yang memproduksi narkotika gelap Dark Treats.',
      NULL,
      'https://en.wikipedia.org/wiki/Kamen_Rider_Gavv'
    )
    RETURNING id INTO v_series_id;
  END IF;

  SELECT id INTO v_char_main FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gavv' LIMIT 1;
  IF v_char_main IS NULL THEN
    INSERT INTO characters (
      series_id, name, rider_name, civilian_name, actor, role, power, bio,
      debut_episode, image, source_url
    ) VALUES (
      v_series_id, 'Kamen Rider Gavv', 'Kamen Rider Gavv', 'Shoma', 'Hidekazu Chinen', 'Main Rider',
      'Organ Gavv merah di pinggang yang melahirkan berbagai Gochizo camilan (Poppingummy, Zakuzakuchips, Fuwamallow, Over Gavv).',
      'Shoma tumbuh terisolasi di dunia Granute sebelum kabur ke Bumi, tempat asal mendiang ibunya. Dengan sifat polos namun bertekad kuat menjaga senyuman orang lain, ia bertarung menggunakan kekuatan camilan sebagai Kamen Rider Gavv melawan operasi gelap keluarga Stomach.',
      'Episode 1: A Snack Kamen Rider!?',
      NULL,
      'https://kamenrider.fandom.com/wiki/Shoma'
    )
    RETURNING id INTO v_char_main;
  END IF;

  -- ARC 01 Gavv
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 1, 'ARC 01',
    'Pelarian ke Bumi & Lahirnya Gochizo',
    'Episode 01–16',
    E'Setelah kabur ke Bumi, Shoma bertemu Sachika Amane yang membantunya memulai hidup baru melalui usaha jasa serba ada Hapipare. Shoma segera menemukan bahwa setiap kali ia menikmati camilan Bumi, tubuhnya menghasilkan makhluk Gochizo yang memungkinkannya bertarung sebagai Kamen Rider Gavv.\n\nBersamaan dengan munculnya jurnalis lepas Hanto Karakida yang memperoleh kekuatan Kamen Rider Valen, Shoma berusaha menggagalkan penculikan manusia oleh agen paruh waktu Stomach Inc. serta menghadapi saudara-saudara tirinya.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Debut Shoma di Bumi dan pertemuannya dengan Sachika dan Hanto.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 02 Gavv
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 2, 'ARC 02',
    'Ujian Kepercayaan & Munculnya Vram',
    'Episode 17–28',
    E'Hubungan Shoma dan Hanto sempat diuji berat ketika jati diri Shoma sebagai keturunan keluarga Stomach terbongkar di tengah konflik melawan tiruan misterius Bitter Gavv. Di saat bersamaan, muncul Kamen Rider ketiga bernama Vram (Lakia Amarga) yang awalnya bekerja sebagai agen Stomach Inc. demi menyelidiki nasib adiknya.\n\nPerlahan kebenaran mulai menyatukan kembali Shoma, Hanto, dan Lakia untuk melawan petinggi Stomach Inc. dan menggagalkan produksi massal Dark Treats.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengatasi keretakan kepercayaan dengan Hanto dan menghadapi Bitter Gavv.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 03 Gavv
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 3, 'ARC 03',
    'Perebutan Kekuasaan & Keluarga Jaldak',
    'Episode 29–40',
    E'Persaingan internal keluarga Stomach semakin memanas ketika presiden dunia Granute bernama Bocca Jaldak bersama putrinya melakukan pengambilalihan kendali atas bisnis Dark Treats. Untuk mengimbangi musuh yang semakin tangguh, Shoma mengumpulkan energi dari seratus Gochizo melalui perangkat Gochipod demi mengakses wujud Over Gavv.\n\nDengan kekuatan tersebut, Gavv bekerja sama dengan Valen dan Vram untuk menumbangkan eksekutif senior Stomach serta membongkar rencana keji pemerintah Granute terhadap populasi manusia.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Memperoleh kekuatan Gochipod untuk melawan intervensi keluarga Jaldak.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

  -- ARC 04 Gavv
  INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
  VALUES (
    v_series_id, 4, 'ARC 04',
    'Runtuhnya Stomach Inc. & Akhir Konflik',
    'Episode 41–50',
    E'Pertarungan memasuki babak penentuan ketika Lango Stomach mengambil kembali kendali sisa organisasi dan ancaman skala besar mengincar Bumi secara langsung. Shoma harus menghadapi kakak-kakak tirinya untuk mengakhiri perdagangan manusia selamanya.\n\nMelalui kerja sama solid antara Gavv, Valen, dan Vram serta dukungan sahabat-sahabat manusia mereka di Hapipare, sindikat Stomach Inc. akhirnya berhasil diruntuhkan dan hubungan antara dua dunia memasuki babak baru yang lebih damai.',
    NULL, NULL, NULL, NULL
  )
  ON CONFLICT (series_id, arc_order) DO UPDATE SET
    chapter_label = EXCLUDED.chapter_label, title = EXCLUDED.title, episode_range = EXCLUDED.episode_range,
    summary = EXCLUDED.summary, quote_text = EXCLUDED.quote_text, quote_by = EXCLUDED.quote_by,
    image_url = EXCLUDED.image_url, image_caption = EXCLUDED.image_caption
  RETURNING id INTO v_arc_id;
  INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_char_main, 'Mengakhiri dominasi Stomach Inc. bersama Valen dan Vram.') ON CONFLICT (arc_id, character_id) DO UPDATE SET note = EXCLUDED.note;

END $$;

-- Sinkronkan ulang sequence ID
SELECT setval(pg_get_serial_sequence('series', 'id'), COALESCE((SELECT MAX(id) FROM series), 1));
SELECT setval(pg_get_serial_sequence('characters', 'id'), COALESCE((SELECT MAX(id) FROM characters), 1));
SELECT setval(pg_get_serial_sequence('series_arcs', 'id'), COALESCE((SELECT MAX(id) FROM series_arcs), 1));
