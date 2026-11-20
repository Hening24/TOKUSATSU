-- =============================================================================
-- SEED DATA: KRONOLOGI ARCS KAMEN RIDER ERA HEISEI — TAHAP 1 (2000–2008)
-- Mengisi tabel series_arcs dan arc_characters untuk series Heisei 2000–2008
-- yang masih memiliki 0 arc di database (Kuuga, Ryuki, Den-O sudah ada dan dilewati).
-- IDEMPOTENT: Menggunakan INSERT ... ON CONFLICT (series_id, arc_order) DO NOTHING
--             dan lookup series_id lewat subquery berdasarkan title.
-- JANGAN menimpa atau menghapus data yang sudah ada.
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
  -- 1. KAMEN RIDER AGITO (2001) — 5 ARC (51 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Agito' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Agito' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider G3' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gills' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Mana Kazaya' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Sumiko Ozawa' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Overlord of Darkness' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kebangkitan Agito & Misteri Unknown',
      'Episode 01–13',
      E'Shouichi Tsugami yang mengalami amnesia total tinggal menumpang bersama keluarga Misugi dan membantu pekerjaan rumah tangga sehari-hari. Tanpa mengetahui asal-usul dirinya, ia selalu terpanggil oleh naluri untuk berubah menjadi prajurit misterius Kamen Rider Agito setiap kali makhluk ilahi berjuluk Unknown (Lords) melakukan pembunuhan terhadap manusia berpotensi khusus.\n\nDi sisi lain, Kepolisian Metropolitan mengerahkan baju zirah tempur teknologi tinggi G3 yang dirancang Sumiko Ozawa dan dikemudikan perwira Makoto Hikawa. Sementara itu, mahasiswa bernama Ryo Ashihara mulai mengalami mutasi menyakitkan akibat keterlibatannya dalam insiden laut kapal Akatsuki hingga berubah menjadi Kamen Rider Gills yang buas.\n\nPada fase awal ini pula mulai tampak sosok anak misterius yang terhubung dengan Overlord of Darkness di balik serangan para Unknown, sementara Mana Kazaya menggunakan kemampuan psikisnya untuk mendampingi Shouichi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Shouichi mulai bertarung sebagai Agito dengan wujud Ground, Storm (Ep. 02), dan Flame (Ep. 08).') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Makoto Hikawa mengoperasikan unit G3 milik kepolisian menghadapi para Unknown.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Ryo Ashihara mengalami mutasi menjadi Kamen Rider Gills dan menyelidiki masa lalunya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Membantu Shouichi beradaptasi di rumah keluarga Misugi dengan kekuatan psikisnya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mengawasi operasional teknis unit tempur G3 di divisi SAUL.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Sosok mudanya mulai muncul mengawasi kemunculan benih Agito sejak episode awal.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Unit G3-X & Penyelidikan Insiden Akatsuki',
      'Episode 14–25',
      E'Melihat keterbatasan unit G3 menghadapi daya rusak para Unknown tingkat lanjut, Sumiko Ozawa merampungkan baju zirah peningkatan G3-X sejak Episode 14 lengkap dengan persenjataan berat serta chip kendali kecerdasan buatan. Makoto Hikawa sempat berjuang keras menaklukkan sistem AI yang terlalu agresif sebelum mampu menjinakkannya untuk melindungi warga.\n\nBersamaan dengan itu, jejak para penumpang kapal Akatsuki semakin sering bermunculan dan memperjelas adanya benang merah antara Ryo Ashihara, Shouichi Tsugami, serta identitas asli Tetsuya Sawaki. Interaksi antara Agito, G3-X, dan Gills terus diwarnai kesalahpahaman sekaligus kerja sama darurat di tengah ancaman baru.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menghadapi serangan Unknown yang memburu para penyintas kapal Akatsuki.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menggunakan sistem peningkatan G3-X mulai Episode 14.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Terus menyelidiki hubungannya sebagai mantan penumpang kapal Akatsuki.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Mendampingi Shouichi mencari petunjuk mengenai masa lalu yang hilang.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mengembangkan dan menyempurnakan sistem AI pada unit G3-X.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kembalinya Ingatan, Burning Form & Another Agito',
      'Episode 26–36',
      E'Potongan ingatan Shouichi mulai pulih di Episode 26 dan membangkitkan wujud gabungan Trinity Form, sebelum tekanan pertempuran yang semakin berat memicu lahirnya wujud super Burning Form pada Episode 34. Kekuatan bertarung Burning Form begitu liar dan panas hingga sempat mengancam kendali diri Shouichi di medan laga.\n\nDi tengah krisis tersebut, seorang dokter bedah penyintas Akatsuki bernama Kaoru Kino bangkit sebagai Another Agito mulai Episode 35 dengan jalur evolusi yang lebih gelap. Kemunculan sosok Agito tandingan ini memicu konflik mengenai makna sesungguhnya dari kekuatan evolusi manusia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengakses Trinity Form (Ep. 26) dan wujud buas Burning Form (Ep. 34).') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menghadapi eskalasi konflik antar pemilik kekuatan Agito bersama unit G3-X.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Menghadapi tantangan ideologis dari kemunculan Another Agito.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Mendukung kestabilan batin Shouichi ketika kekuatan Burning Form sulit dikendalikan.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Meningkatkan perburuan Unknown seiring bertambahnya manusia yang berevolusi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Shining Form & Kebenaran Kapal Akatsuki',
      'Episode 37–43',
      E'Setelah menembus batas kekuatannya di bawah sinar matahari, Shouichi memurnikan kekuatan Burning menjadi wujud puncak Shining Form yang tampil di serial televisi sejak Episode 37. Sementara itu, kekuatan Ryo Ashihara turut berevolusi menjadi Exceed Gills untuk menghadapi ancaman Lord kelas atas.\n\nSeluruh teka-teki tragedi kapal Akatsuki serta konflik purba antara Kekuatan Cahaya dan Kekuatan Kegelapan akhirnya terungkap sepenuhnya pada Episode 42–43. Dengan ingatan yang telah utuh, Agito Shining Form bekerja sama dengan Exceed Gills, G3-X, serta Another Agito untuk menumbangkan utusan kuat Overlord, El of Water.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menguasai Shining Form (Ep. 37) dan memulihkan ingatan insiden Akatsuki.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Bertarung bahu-membahu bersama para Agito menentang utusan Overlord.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Berevolusi menjadi Exceed Gills dan berperan menumbangkan El of Water.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menjadi saksi terungkapnya seluruh kebenaran mengenai masa lalu Shouichi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mendukung operasional polisi saat krisis Akatsuki mencapai puncaknya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mengirim utusan kuat El of Water untuk menghabisi para Agito.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Penghakiman Overlord of Darkness',
      'Episode 44–51',
      E'Merasa evolusi manusia menuju Agito tidak lagi dapat dibendung, sang pencipta Overlord of Darkness memutuskan menjatuhkan penghakiman dengan menurunkan dua pengawal tertingginya: El of the Wind dan El of the Ground. Berbagai serangan berskala besar mengancam kelangsungan hidup umat manusia dan mendesak kepolisian hingga titik terlemah.\n\nDalam pertempuran penentuan, Makoto Hikawa membuktikan nilai manusia biasa melalui keberaniannya memakai G3-X bersama Exceed Gills menumbangkan El of the Wind, sementara Shouichi memimpin serangan akhir melawan El of the Ground. Keteguhan hati para pahlawan akhirnya menggagalkan rencana penghancuran Overlord dan membuka jalan hidup damai bagi manusia.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengalahkan El of the Ground dan menghentikan penghakiman Overlord of Darkness.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Membuktikan tekad manusia dengan membantu menumbangkan El of the Wind.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Bertarung bersama G3-X menaklukkan El of the Wind di fase akhir.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menjadi bagian dari kedamaian baru keluarga Misugi usai konflik berakhir.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mempertahankan keberadaan unit G3-X demi menghadapi krisis terakhir.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Menurunkan para El Lords demi memusnahkan benih Agito sebelum akhirnya mengalah.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER 555 (2003) — 5 ARC (50 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider 555' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Faiz' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kaixa' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Delta' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Mari Sonoda' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Yuji Kiba' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Kyoji Murakami' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Kitazaki' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Sabuk Pelindung Impian (Faiz Gear)',
      'Episode 01–11',
      E'Pengelana sinis bernama Takumi Inui secara tidak sengaja terseret dalam pelarian Mari Sonoda yang membawa koper berisi perangkat tempur misterius Faiz Gear. Ketika diserang oleh monster evolusioner bernama Orphnoch yang diciptakan korporasi Smart Brain, Mari mempercayakan sabuk tersebut kepada Takumi sehingga ia berubah menjadi Kamen Rider Faiz.\n\nSecara paralel, pemuda tulus Yuji Kiba tewas dalam sebuah tragedi namun bangkit kembali sebagai Horse Orphnoch. Alih-alih menerima dorongan membunuh manusia demi supremasi Orphnoch, Yuji berjuang keras menjaga sisi kemanusiaannya dan melindungi orang-orang yang tidak bersalah.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Takumi terpaksa memakai Faiz Gear untuk menyelamatkan Mari dan melindungi impian orang lain.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Pewaris awal koper Faiz Gear yang terus diburu oleh agen Smart Brain.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Terlahir kembali sebagai Horse Orphnoch dan berusaha hidup berdampingan dengan manusia.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Sabuk Terkutuk & Kemunculan Kaixa',
      'Episode 12–25',
      E'Konflik melebar dengan hadirnya sabuk kedua, Kaixa Gear, yang mematikan bagi pengguna manusia biasa tanpa kecocokan genetik khusus. Masato Kusaka—mantan teman sekelas Mari di Ryusei School—mengambil alih peran sebagai Kamen Rider Kaixa sekaligus memendam kebencian mendalam terhadap seluruh Orphnoch dan kecurigaan terhadap Takumi.\n\nDi pihak lawan, direktur Smart Brain Kyoji Murakami menggerakkan regu elite Lucky Clover—termasuk pembunuh kejam Kitazaki—untuk memburu para Rider serta menghabisi Orphnoch pembelot seperti Yuji Kiba. Intrik antar kubu dan manipulasi Kusaka membuat hubungan Takumi, Mari, dan Yuji kerap berada di ambang perpecahan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Sering berkonflik dengan Kusaka akibat prasangka dan siasat manipulatif.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Masato Kusaka tampil sebagai Kamen Rider Kaixa dengan ambisi membasmi semua Orphnoch.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Berusaha menjaga persatuan di tengah ketegangan antara Takumi dan Kusaka.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menjadi incaran Smart Brain karena menolak memburu umat manusia.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Memimpin operasi Smart Brain dan memerintahkan Lucky Clover merebut Rider Gear.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Anggota muda Lucky Clover yang memburu para pengguna sabuk Rider dengan brutal.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Delta Gear & Kekuatan yang Membutakan',
      'Episode 26–34',
      E'Sabuk ketiga sekaligus yang paling bertenaga, Delta Gear, mulai diperebutkan oleh kubu Ryusei School, Smart Brain, hingga Orphnoch pemberontak. Efek samping adiktif dan kegilaan yang dipicu oleh Delta Gear sempat merusak kewarasan para pemakainya serta memecah belah sekutu terdekat Mari.\n\nSetelah melewati perebutan panjang, Shuji Mihara memberanikan diri mengatasi ketakutannya dan menerima tanggung jawab sebagai pengguna tetap Kamen Rider Delta. Kehadiran Delta membantu Faiz dan Kaixa menahan serangan Lucky Clover di tengah ancaman sel Orphnoch yang terus menekan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menghadapi ancaman perebutan Delta Gear dan peningkatan kekuatan Lucky Clover.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Terlibat dalam perebutan kekuasaan atas Delta Gear bersama alumni Ryusei School.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Shuji Mihara akhirnya mengambil alih kendali sebagai pengguna tetap Kamen Rider Delta.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menyaksikan kehancuran psikologis rekan-rekannya akibat pengaruh Delta Gear.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Berjuang mempertahankan keyakinannya saat konflik tiga arah semakin memanas.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mengerahkan agen Smart Brain untuk mengamankan perangkat Delta.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Menjadi ancaman besar di lapangan dengan kekuatan Dragon Orphnoch.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Rahasia Ryusei School & Jati Diri Takumi',
      'Episode 35–45',
      E'Misteri tragedi reuni siswa Ryusei School beserta alasan mengapa mereka dapat mengenakan sabuk Rider perlahan terkuak seluruhnya. Kebenaran mengejutkan terungkap ketika diketahui bahwa Takumi Inui sesungguhnya adalah Wolf Orphnoch yang selama ini berjuang melindungi manusia sebagai Kamen Rider Faiz.\n\nTerbukanya jati diri Takumi memicu keretakan kepercayaan dengan Mari dan mempertajam permusuhan Kusaka. Sementara itu, Yuji Kiba yang berkali-kali dikhianati manusia mulai berpaling ke sisi gelap, sedangkan Kyoji Murakami serta Kitazaki mempercepat agenda untuk mencari sosok wadah Orphnoch King.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Identitasnya sebagai Wolf Orphnoch terbongkar dan mengguncang hubungan dengan rekan-rekannya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Semakin membenci Takumi setelah rahasia Orphnoch-nya terungkap.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Berupaya menengahi konflik internal kelompok di tengah terkuaknya masa lalu Ryusei.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Mengingat kembali kebenaran tragis malam reuni sekolah Ryusei.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mengalami krisis kepercayaan terhadap manusia yang menggeser haluannya ke kubu Orphnoch.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Memburu sosok bocah wadah Orphnoch King demi menghentikan kepunahan ras Orphnoch.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Terus mengintai dan menjebak para Rider demi kepentingan Smart Brain.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Kebangkitan Raja & Akhir Pertempuran',
      'Episode 46–50',
      E'Untuk menghentikan proses degenerasi sel yang perlahan mengubah Orphnoch menjadi abu, Kyoji Murakami mengorbankan nyawanya pada Episode 47 demi membangkitkan Orphnoch King di dalam tubuh bocah bernama Teruo Suzuki. Dalam kekacauan klimaks tersebut, Masato Kusaka gugur secara tragis, sementara Yuji Kiba sempat dimanfaatkan sebagai pemimpin sementara Smart Brain.\n\nSetelah menyaksikan kebrutalan Orphnoch King yang menghancurkan sekutunya sendiri termasuk Kitazaki, Yuji berbalik mendukung Takumi dan Shuji Mihara dalam duel terakhir. Dengan menerima sepenuhnya jati dirinya sebagai manusia sekaligus Wolf Orphnoch, Takumi bertarung habis-habisan sebagai Kamen Rider Faiz menumbangkan sang Raja demi memberi harapan baru bagi masa depan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menerima takdirnya sebagai Wolf Orphnoch dan bertarung melawan Orphnoch King.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Masato Kusaka menemui akhir tragis di fase penutup konflik Rider Gear.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Mendampingi Takumi menghadapi pasukan Riotrooper dan Orphnoch King.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Tetap percaya pada Takumi hingga pertempuran terakhir melawan sang Raja.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Sempat memimpin Smart Brain sebelum berbalik mengorbankan diri melawan Orphnoch King.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mengorbankan nyawanya di Episode 47 demi membangkitkan Orphnoch King.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Dihancurkan oleh kebangkitan Orphnoch King setelah sempat menyergap para Rider.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER BLADE (2004) — 4 ARC (49 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Blade' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Blade' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Garren' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Chalice' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Leangle' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Shiori Hirose' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Hiroshi Tennoji' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Kebangkitan Undead & Kehancuran BOARD',
      'Episode 01–15',
      E'Sepuluh ribu tahun setelah kemenangan Human Undead dalam Battle Fight memberi hak hidup bagi umat manusia, lembaga riset BOARD tanpa sengaja membuka kembali segel 52 makhluk abadi bernama Undead. Segera setelah markas BOARD diserang, anggota pemula Kazuma Kenzaki berjuang sebagai Kamen Rider Blade untuk menyegel para Undead ke dalam Rouse Card bersama rekan penelitinya, Shiori Hirose.\n\nDi pihak lain, seniornya Sakuya Tachibana (Kamen Rider Garren) dilanda ketakutan serta konflik batin yang membuatnya sempat menjauh dari Kenzaki. Bersamaan dengan itu muncul sosok misterius Hajime Aikawa yang bertarung sebagai Kamen Rider Chalice dan menyimpan rahasia mendalam terkait aturan Battle Fight.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Kazuma Kenzaki bertekad melindungi manusia sebagai Blade setelah markas BOARD hancur.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Sakuya Tachibana bergulat dengan rasa takutnya hingga mampu kembali bertarung penuh.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Hajime Aikawa tampil sebagai Chalice yang misterius sejak Episode 02.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mengoperasikan sistem pelacak lokasi Undead untuk membantu Blade.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Sistem Rider Terkuat & Kutukan Leangle',
      'Episode 16–30',
      E'Dengan pulihnya kerja sama antara Blade dan Garren, teknologi penyegelan melahirkan sabuk Rider baru yang lebih kuat namun berbahaya. Pelajar SMA Mutsuki Kamijo terpilih mengenakan sabuk tersebut sebagai Kamen Rider Leangle sejak Episode 16, tetapi kesadarannya perlahan dikuasai oleh kehendak jahat Spider Undead.\n\nPerebutan kendali atas kekuatan Leangle sekaligus munculnya perangkat peningkatan evolusi membuat hubungan antar keempat Rider semakin tegang. Sambil berupaya membebaskan Mutsuki dari pengaruh kegelapan, Kenzaki terus menyelidiki masa lalu BOARD bersama Shiori serta semakin memahami sisi manusiawi Hajime.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Berusaha menyelamatkan Mutsuki sekaligus membuka akses Rouse Absorber.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menghadapi uji coba sistem Rider baru bersama rekan-rekan seperjuangannya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Ikatan kemanusiaannya diuji oleh kemunculan Leangle dan Undead kelas tinggi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Mutsuki Kamijo debut sebagai Kamen Rider Leangle di Episode 16 namun dikuasai Spider Undead.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Terus mendukung tim Rider dalam memantau kemunculan Undead baru.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Kebenaran Battle Fight & King Form',
      'Episode 31–47',
      E'Para Rider akhirnya membongkar kebenaran mengerikan tentang aturan Battle Fight: hanya spesies terakhir yang bertahan hidup berhak menentukan penguasa Bumi, dan kemenangan Joker Undead akan memicu kehancuran dunia. Ketika terungkap bahwa Hajime adalah Joker Undead, Kenzaki menolak melenyapkannya dan justru mengakses kekuatan puncak King Form mulai Episode 34, disusul kebangkitan Wild Chalice pada Episode 37.\n\nDalang sesungguhnya di balik pembukaan segel dan manipulasi BOARD muncul dalam diri Hiroshi Tennoji pada Episode 38. Bersama Shiori Hirose dan Sakuya serta Mutsuki yang berhasil menaklukkan kegelapan dalam dirinya, keempat Rider bersatu menumbangkan rencana Tennoji serta para Undead kategori King terakhir.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengakses wujud terkuat Blade King Form di serial TV mulai Episode 34.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Membantu menumbangkan para Undead kategori King serta konspirasi Tennoji.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Terungkap sebagai Joker Undead dan membangkitkan Wild Chalice pada Episode 37.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Berhasil memutus kendali Spider Undead dan bertarung di pihak manusia.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mengungkap keterkaitan riset ayahnya dengan kebangkitan Undead dan peran Tennoji.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Muncul sebagai dalang di balik BOARD dan Battle Fight modern sejak Episode 38.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kartu As Terakhir',
      'Episode 48–49',
      E'Dengan tersingkirnya seluruh Undead lain di akhir Battle Fight, Hajime Aikawa tinggal sebagai satu-satunya Joker yang tersisa—kondisi yang langsung mengaktifkan datangnya kawanan Darkroach untuk memusnahkan seluruh kehidupan di Bumi. Kenzaki menghadapi dilema terberat antara menyelamatkan umat manusia atau mengorbankan sahabatnya sendiri.\n\nSebagai kartu as terakhir, Kazuma Kenzaki terus memaksakan penggunaan King Form hingga tubuhnya menyatu dengan seluruh kartu Raja dan berubah menjadi Joker Undead kedua. Dengan adanya dua Joker, Battle Fight tidak dapat berakhir dan Bumi terhindar dari kehancuran, walau Kenzaki harus memilih mengasingkan diri demi selamanya menjaga kedamaian.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengubah dirinya menjadi Joker kedua demi menyelamatkan Hajime dan menghentikan kehancuran Bumi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menahan serangan kawanan Darkroach di saat-saat terakhir Battle Fight.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Menerima kesempatan hidup di antara manusia berkat pengorbanan Kenzaki.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Ikut bertarung melindungi kota dari serbuan Darkroach di dua episode penutup.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menyaksikan perpisahan mengharukan para Rider di akhir konflik.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER HIBIKI (2005) — 4 ARC (48 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Hibiki' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Hibiki' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Ibuki' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Todoroki' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Asumu Adachi' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Akira Amami' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Douji' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Hime' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Pertemuan Asumu & Jalan Para Oni',
      'Episode 01–14',
      E'Siswa SMP bernama Asumu Adachi yang diliputi keraguan menatap masa depannya bertemu dengan pria santai namun berdedikasi tinggi, Hitoshi Hidaka. Asumu terkejut mengetahui bahwa Hidaka adalah Kamen Rider Hibiki, anggota organisasi kuno Takeshi yang melatih tubuh dan jiwa sebagai Oni untuk memurnikan monster Makamou dengan gelombang suara murni.\n\nMelalui bimbingan Hibiki, Asumu mulai belajar tentang arti tanggung jawab dan kedewasaan. Dalam pertempuran awal melawan Makamou yang dibesarkan oleh pasangan misterius Douji dan Hime, Hibiki turut dibantu oleh Oni peniup instrumen tiup Kamen Rider Ibuki (mulai Episode 07) beserta murid mudanya, Akira Amami.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Hidaka membimbing Asumu sembari menumpas ancaman awal Makamou.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Iori Izumi debut penuh sebagai Kamen Rider Ibuki di Episode 07.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Siswa SMP yang mulai terinspirasi oleh ketekunan dan cara hidup Hibiki.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Murid muda Ibuki yang giat berlatih membantu operasi lapangan Takeshi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Bersama Hime menumbuhkan Makamou di berbagai wilayah pegunungan dan hutan.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Sosok pelayan misterius yang terus mengawal kelahiran Makamou bersama Douji.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Oni Petir Todoroki & Api Kurenai',
      'Episode 15–29',
      E'Ketika Oni senior Zanki mulai terhambat oleh cedera fisik lama sejak Episode 15, murid setianya Tomizo Todayama mengambil alih garis depan dan melakukan debut penuh sebagai Kamen Rider Todoroki di Episode 16. Todoroki berjuang membuktikan kelayakannya menguasai teknik petikan gitar petir di bawah pengawasan ketat gurunya.\n\nMemasuki musim panas, kemunculan Makamou yang lebih kuat dan kebal terhadap serangan suara biasa memaksa Hibiki menjalani latihan tempaan fisik ekstrem. Usaha keras itu berbuah lahirnya wujud merah menyala Kurenai pada Episode 24 yang memiliki daya ledak suara berlipat ganda guna menutup paruh pertama serial (*Training Oni*).',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menempa diri hingga membangkitkan wujud kuat Hibiki Kurenai pada Episode 24.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Terus mendukung pertempuran melawan Makamou musim panas bersama Akira.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Tomizo Todayama resmi tampil sebagai Kamen Rider Todoroki mulai Episode 16.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menyaksikan beratnya pengorbanan latihan para Oni di sekitar Hidaka.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Melanjutkan pendidikannya sebagai murid Ibuki di tengah tugas Takeshi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Membiakkan jenis Makamou yang menuntut kekuatan suara tingkat lanjut.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Terlibat aktif memicu kemunculan Makamou baru di berbagai daerah.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Pedang Zirah Armed Hibiki & Murid Baru',
      'Episode 30–39',
      E'Memasuki paruh kedua (*The Boy Who Moves Toward Tomorrow*), hadir sosok pelajar pindahan ambisius bernama Kyosuke Kiriya sejak Episode 30 yang juga bertekad menjadi murid Hibiki dan memicu persaingan pribadi dengan Asumu Adachi. Di sisi lain, Akira Amami pun menghadapi ujian berat terkait pilihannya menekuni jalur Oni.\n\nDi medan tempur, kemunculan Makamou kelas super sempat merebut senjata pamungkas Ongekizofukuken Armed Saber dari tangan para Oni. Setelah merebutnya kembali, Hibiki menggabungkan para Disk Animals ke tubuhnya dan membangkitkan wujud zirah puncak Armed Hibiki pada Episode 33 untuk menghadapi serangan Douji dan Hime yang semakin terkoordinasi.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengakses wujud puncak Armed Hibiki di serial TV mulai Episode 33 dan melatih Asumu serta Kyosuke.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menghadapi serangan Makamou kelas super serta dinamika muridnya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Berjuang menjaga garis pertahanan para Oni menghadapi ancaman baru.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Bersaing sehat dengan Kyosuke Kiriya sembari mencari arah masa depannya sendiri.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menghadapi keraguan batin dan konflik terkait masa lalunya sebagai calon Oni.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Memicu kemunculan Makamou kelas super yang mengincar Armed Saber.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Mengarahkan serangan Makamou yang lebih terencana terhadap anggota Takeshi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Bencana Orochi & Langkah Menuju Hari Esok',
      'Episode 40–48',
      E'Sejak Episode 40, fenomena alam gaib bernama Orochi mulai menyelimuti negeri dan melahirkan Makamou dalam jumlah besar tanpa henti. Dalam masa krisis tersebut, mentor senior Zanki memaksakan tubuhnya kembali bertarung demi melindungi Todoroki sebelum mengakhiri perjalanannya secara terhormat di Episode 45, meninggalkan tanggung jawab penuh kepada Todoroki.\n\nSementara Akira memutuskan jalannya sendiri di luar medan tempur Oni, Asumu akhirnya menyadari bahwa ia tidak harus menjadi Oni demi berharga bagi orang lain. Di babak final Episode 48, Hibiki, Ibuki, dan Todoroki bersatu memulihkan keseimbangan alam dari bencana Orochi, menutup perjalanan pertumbuhan Asumu menuju hari esok.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Memimpin para Oni memurnikan wabah Makamou dari fenomena Orochi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Menghadapi wabah Orochi dan menghormati keputusan hidup muridnya, Akira.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Mewarisi sepenuhnya semangat gurunya Zanki setelah tragedi di Episode 45.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menemukan jati diri dan impiannya sendiri di episode terakhir serial.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menemukan pilihannya untuk melangkah maju menjalani hidup biasa.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Terlibat dalam kemunculan massal Makamou selama terjadinya fenomena Orochi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Menghadapi akhir perannya seiring redanya bencana Orochi oleh para Oni.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER KABUTO (2006) — 4 ARC (49 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kabuto' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kabuto' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Gatack' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Drake' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Sasword' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Hiyori Kusakabe' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Shuichi Tadokoro' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'Masato Mishima' LIMIT 1;
    SELECT id INTO v_c8 FROM characters WHERE series_id = v_series_id AND name = 'Reiji Nogi' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Ancaman Worm & Para Pengguna Zecter',
      'Episode 01–14',
      E'Tujuh tahun sesudah meteorit raksasa menghantam distrik Shibuya, makhluk asing mirip serangga bernama Worm menyusup di tengah manusia dengan meniru wujud dan ingatan korbannya. Agen lapangan ZECT bernama Arata Kagami yang bertugas di bawah kepala tim Shuichi Tadokoro dibuat terkejut ketika Souji Tendou yang arogan mengklaim Kabuto Zecter dan berubah menjadi Kamen Rider Kabuto dengan kemampuan gerak supercepat Clock Up.\n\nDi tengah operasi ZECT, muncul berbagai pengguna Zecter lain seperti Kamen Rider TheBee (mulai Episode 06) serta penata rias pengelana Daisuke Kazama yang bertarung secara independen sebagai Kamen Rider Drake sejak Episode 11–12. Sementara itu, gadis pemalu Hiyori Kusakabe dan Tendou mulai mencium kejanggalan agenda petinggi ZECT, Masato Mishima.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Souji Tendou merebut Kabuto Zecter dan menguasai teknik Cast Off serta Clock Up.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Arata Kagami bertugas sebagai agen ZECT sekaligus sempat mencoba menggunakan TheBee Zecter.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Daisuke Kazama debut sebagai Kamen Rider Drake mulai Episode 11–12.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Rekan kerja Arata di bistro yang memiliki keterkaitan misterius dengan insiden Shibuya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Memimpin unit lapangan ZECT tempat Arata Kagami bernaung.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Tangan kanan pimpinan ZECT yang mengawasi pergerakan para pengguna Zecter secara dingin.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Kelahiran Kamen Rider Gatack & Bangsawan Sasword',
      'Episode 15–24',
      E'Barisan petarung ZECT bertambah ramai dengan hadirnya bangsawan eksentrik Tsurugi Kamishiro yang bertekad memusnahkan seluruh Worm sebagai Kamen Rider Sasword mulai Episode 19. Di sisi lain, Arata Kagami yang berkali-kali gagal dipercaya Zecter lain akhirnya diakui oleh Gatack Zecter yang paling sulit dikendalikan pada Episode 21.\n\nBertransformasi menjadi Kamen Rider Gatack, Arata membuktikan tekadnya untuk melindungi sesama dan berdiri sejajar bersama Souji Tendou. Kesatuan para Rider utama di penghujung paruh pertama ini menyiapkan mereka sebelum rahasia besar mengenai ZECT mulai terungkap.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengakui tekad Arata dan bertempur bersama saat Gatack akhirnya bangkit.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Arata Kagami resmi berubah menjadi Kamen Rider Gatack pada Episode 21.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Sesekali bersinggungan maupun membantu operasi ZECT melawan Worm kuat.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Tsurugi Kamishiro muncul sebagai Kamen Rider Sasword sejak Episode 19.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mulai terseret lebih jauh dalam misteri Worm dan hubungan keluarganya dengan Tendou.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mengkoordinasikan misi ZECT selama kemunculan Sasword dan Gatack.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Mengawasi operasional Gatack sembari menjalankan rencana tersembunyi di balik ZECT.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Hyper Form, Sistem Red Shoes & Hell Brothers',
      'Episode 25–38',
      E'Memasuki paruh kedua serial, Tendou mengakses wujud evolusi puncak Hyper Form menggunakan Hyper Zecter (tampil singkat pada Episode 28 sebelum penggunaan resmi masa kini di Episode 34) yang menghadirkan kekuatan Hyper Clock Up untuk melampaui batas ruang dan waktu. Bersamaan dengan itu, Episode 36 mengungkap rahasia sistem tersembunyi Red Shoes yang tertanam dalam Zecter untuk memaksa penggunanya menghancurkan Worm tanpa kendali.\n\nSituasi semakin pelik akibat kemunculan mantan pengguna TheBee, So Yaguruma dan Shun Kageyama, yang kembali sebagai duo suram Kamen Rider KickHopper dan PunchHopper mulai Episode 35. Di sisi lain, Hiyori Kusakabe terjebak dalam pusaran rahasia identitas Worm dan hubungannya dengan masa lalu Tendou.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menguasai Hyper Form (Ep. 34) dengan kemampuan Hyper Clock Up menembus waktu.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Mengetahui rahasia Red Shoes System pada Zecter miliknya serta Kabuto.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Tetap terlibat melindungi warga di tengah ancaman Worm dan konflik internal Rider.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Terlibat dalam berbagai pertarungan menghadapi Worm sembari memperjuangkan kehormatan keluarganya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menghadapi kenyataan rumit mengenai jati dirinya dan keterikatan dengan Tendou.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Tetap membimbing Arata dan unitnya di tengah perpecahan ZECT.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Memperketat kendalinya atas ZECT di balik munculnya Hyper Zecter.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Dark Kabuto, Reiji Nogi & Konspirasi Natives',
      'Episode 39–49',
      E'Ancaman pamungkas datang melalui kemunculan tiruan gelap Kamen Rider Dark Kabuto sejak Episode 39 serta hadirnya pemimpin tangguh Worm, Reiji Nogi (Cassis Worm), mulai Episode 41. Puncak pengungkapan terjadi saat terkuak bahwa ras alien Natives—yang selama 35 tahun membantu membentuk ZECT dan sistem Rider—bersekongkol dengan Masato Mishima untuk mengubah seluruh umat manusia menjadi Natives.\n\nSetelah menyingkirkan pimpinan lama ZECT dan merubah dirinya menjadi Gryllus Worm, Mishima sempat mendesak seluruh Rider termasuk Hyper Kabuto. Namun melalui serangan terkoordinasi penuh antara Gatack dan Hyper Kabuto pada Episode 49, Mishima tumbang dan rencana asimilasi global Natives berhasil digagalkan.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Sebagai Hyper Kabuto menyelamatkan Hiyori dan mengalahkan Gryllus Worm bersama Gatack.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Melumpuhkan titik lemah Gryllus Worm dalam pertarungan penentuan Episode 49.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Menemui nasib tragisnya setelah kebenaran tentang Scorpio Worm dan janji Tendou terungkap.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Kembali dari sisi gelap berkat tekad Tendou menjelang akhir serial.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Tetap berpihak pada umat manusia ketika konspirasi Natives terbongkar.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Merebut kendali ZECT dan bermutasi menjadi Gryllus Worm sebagai lawan terakhir.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c8, 'Reiji Nogi debut di Episode 41 sebagai Cassis Worm berkemampuan menghentikan waktu.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;


  -- ===========================================================================
  -- 6. KAMEN RIDER KIVA (2008) — 5 ARC (48 Episode)
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Kiva' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    SELECT id INTO v_c1 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Kiva' LIMIT 1;
    SELECT id INTO v_c2 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider IXA' LIMIT 1;
    SELECT id INTO v_c3 FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Saga' LIMIT 1;
    SELECT id INTO v_c4 FROM characters WHERE series_id = v_series_id AND name = 'Otoya Kurenai' LIMIT 1;
    SELECT id INTO v_c5 FROM characters WHERE series_id = v_series_id AND name = 'Megumi Aso' LIMIT 1;
    SELECT id INTO v_c6 FROM characters WHERE series_id = v_series_id AND name = 'Kivat-bat the 3rd' LIMIT 1;
    SELECT id INTO v_c7 FROM characters WHERE series_id = v_series_id AND name = 'King (1986)' LIMIT 1;
    SELECT id INTO v_c8 FROM characters WHERE series_id = v_series_id AND name = 'Bishop' LIMIT 1;

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01',
      'Dua Lini Masa: 1986 & Kebangkitan Kiva',
      'Episode 01–14',
      E'Alur cerita berjalan paralel di dua era yang saling terpaut: tahun 1986 dan tahun 2008. Pada 1986, musisi bebas Otoya Kurenai bersinggungan dengan pemburu monster serta para Arms Monsters penghuni Castle Doran saat purwarupa sistem Ixa mulai digunakan melawan ras penghisap energi manusia bernama Fangire.\n\nDua puluh dua tahun kemudian pada 2008, putra Otoya yang pemalu dan terasing, Wataru Kurenai, bertarung sebagai Kamen Rider Kiva ditemani kelelawar hidup Kivat-bat the 3rd. Perjuangannya bersinggungan dengan organisasi Aozora melalui Megumi Aso serta pemburu Fanatik pengguna Ixa System masa kini, Keisuke Nago.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Wataru mulai bertarung sebagai Kiva di tahun 2008 sembari mengejar impian membuat biola.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Keisuke Nago memburu Fangire sekaligus mencurigai Kiva dengan Ixa System 2008.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Otoya Kurenai terlibat perburuan Fangire dan penggunaan awal prototipe Ixa pada 1986.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Pemburu Fangire dari Aozora yang kerap membantu Wataru dan menjadi rekan Nago.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Rekan setia Wataru yang memungkinkan transformasinya menjadi Kamen Rider Kiva.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02',
      'Checkmate Four & Tahta Emperor Form',
      'Episode 15–24',
      E'Sejak Episode 15, ancaman ras Fangire meningkat drastis dengan terungkapnya jajaran penguasa tertinggi Checkmate Four yang terdiri atas Raja, Ratu, Rook, dan Bishop. Pada era 1986, Bishop secara ketat mengawasi hukum ras Fangire dan melapor kepada King (1986) mengenai kedekatan terlarang antara Ratu Maya dan Otoya Kurenai.\n\nDi masa kini 2008, kebangkitan Rook mendesak Kiva hingga titik kritis sebelum Kivat-bat the 3rd memanggil naga emas Tatsulot pada Episode 24. Kekuatan tersebut membuka wujud keemasan Kiva Emperor Form yang mengantarkan Wataru meraih kemenangan gemilang sekaligus membuka babak konflik keluarga kerajaan Fangire.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Membangkitkan wujud puncak Kiva Emperor Form pada Episode 24.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Mengimbangi kekuatan Fangire tingkat lanjut melalui mode Rising IXA.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Jatuh hati pada Ratu Maya di tengah ancaman hukuman dari Checkmate Four.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menghadapi serangan langsung para anggota Checkmate Four di tahun 2008.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Memanggil Tatsulot untuk membuka kekuatan penuh Emperor Form.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Penguasa kejam Fangire tahun 1986 yang menuntut ketaatan penuh terhadap hukum ras.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c8, 'Penegak hukum Checkmate Four yang mengintai hubungan Maya dan Otoya.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03',
      'Raja Fangire Baru & Hadirnya Kamen Rider Saga',
      'Episode 25–33',
      E'Memasuki paruh kedua, sahabat masa kecil Wataru yang sesungguhnya adalah putra Ratu Maya dan Raja 1986, yakni Taiga Nobori, tampil sebagai pemimpin baru ras Fangire di era 2008. Dengan pengawasan dan dorongan Bishop, Taiga mengemban zirah kerajaan dan melakukan debut penuhnya sebagai Kamen Rider Saga pada Episode 33.\n\nDi masa lalu tahun 1986, kekejaman King (1986) yang memakai bayi Taiga sebagai sandera untuk menekan Maya memicu perlawanan sengit dari Otoya. Sementara itu di masa kini, persahabatan Wataru dengan Megumi, Nago, serta Taiga mulai diuji oleh rahasia darah yang perlahan mendekat.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Menyambut kembali teman lamanya Taiga tanpa menyadari peran Taiga di kubu Fangire.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Nago terus bertempur sebagai IXA sembari perlahan mengubah sikapnya terhadap Wataru.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Taiga Nobori debut penuh sebagai Kamen Rider Saga pada Episode 33.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Berusaha melindungi Maya di tengah tekanan ekstrem dari King (1986).') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menyelidiki pergerakan baru di balik munculnya pimpinan Fangire modern.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mendampingi Wataru menghadapi tantangan baru dari Kamen Rider Saga.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Menjadikan bayi Taiga sebagai alat ancaman terhadap Maya di tahun 1986.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c8, 'Membimbing Taiga Nobori menjalankan peran barunya sebagai Raja Fangire 2008.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04',
      'Kebenaran Garis Darah & Perpecahan Dua Zaman',
      'Episode 34–43',
      E'Fakta bahwa Wataru merupakan manusia setengah Fangire sekaligus saudara tiri Taiga akhirnya terungkap dan mengguncang seluruh pihak yang terlibat. Keisuke Nago dan Megumi Aso harus menghadapi dilema besar antara tugas mereka sebagai pemburu monster dan kepercayaan mereka terhadap Wataru, sementara Taiga dan Bishop mulai berselisih paham mengenai masa depan Fangire.\n\nDi garis waktu 1986, kesewenang-wenangan sang Bat Fangire King membuat Kivat-bat the 2nd memutuskan meninggalkan tuannya. Kedua lini masa pun bergerak mendekat menuju puncak konflik keluarga Kurenai dan tahta Fangire.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Mengalami krisis identitas setelah kebenaran darah Fangire dan persaudaraan dengan Taiga terbongkar.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Memilih tetap memercayai Wataru walau jati diri setengah Fangire-nya terungkap.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Terpecah antara loyalitas terhadap Bishop dan ikatannya dengan Wataru.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Bersiap menghadapi konfrontasi terakhir melawan King (1986).') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Mendukung Wataru melewati guncangan kepercayaan dalam organisasi Aozora.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Tetap setia berdiri di sisi Wataru saat asal-usulnya dipertanyakan.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Ditinggalkan oleh Kivat-bat the 2nd akibat kekejamannya di lini masa 1986.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c8, 'Mulai menyiapkan rencana penggulingan jika Taiga menyimpang dari hukum Fangire.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05',
      'Dark Kiva & Akhir Takdir Dua Generasi',
      'Episode 44–48',
      E'Pada puncak kisah tahun 1986, Otoya Kurenai menjalin kontrak berisiko nyawa dengan Kivat-bat the 2nd untuk berubah menjadi Kamen Rider Dark Kiva sejak Episode 45 demi menyelamatkan Wataru, Taiga kecil, Maya, serta para penghuni Castle Doran. Bersama putranya, Otoya menjatuhkan King (1986) sebelum akhirnya mengembuskan napas terakhir akibat beban kekuatan Dark Kiva.\n\nDi masa kini tahun 2008, Bishop berusaha membangkitkan kembali sang Raja masa lalu dan menyingkirkan Taiga, sehingga Taiga mewarisi kekuatan Dark Kiva. Menepikan perseteruan mereka, Wataru dan Taiga bersatu bersama Keisuke Nago (IXA) menumbangkan Bishop beserta kebangkitan sang Raja, membuka era perdamaian antara manusia dan Fangire.',
      NULL, NULL, NULL, NULL
    )
    ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5;
    IF v_arc_id IS NOT NULL THEN
      IF v_c1 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c1, 'Bertemu ayahnya di masa lalu dan bersatu dengan Taiga mengakhiri konflik dua generasi.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c2 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c2, 'Bertarung bersama Kiva di pertempuran penutup melawan ancaman Bishop.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c3 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c3, 'Mewarisi kekuatan Dark Kiva dan berdamai dengan Wataru menumpas pemberontakan Bishop.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c4 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c4, 'Mengenakan Dark Kiva mulai Episode 45 dan berkorban menumbangkan King (1986).') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c5 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c5, 'Menyaksikan akhir pertempuran antara Aozora dan kelompok Bishop di tahun 2008.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c6 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c6, 'Mendukung Kiva Emperor Form hingga akhir pertempuran melawan pasukan Bishop.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c7 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c7, 'Dikalahkan oleh Otoya dan Wataru di 1986 sebelum sisa kekuatannya coba dibangkitkan Bishop.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
      IF v_c8 IS NOT NULL THEN INSERT INTO arc_characters (arc_id, character_id, note) VALUES (v_arc_id, v_c8, 'Menjadi dalang pertempuran penutup 2008 dengan membangkitkan kembali Raja 1986.') ON CONFLICT (arc_id, character_id) DO NOTHING; END IF;
    END IF;
  END IF;

END $$;
