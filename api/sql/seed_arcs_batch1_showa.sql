-- =============================================================================
-- SEED ARCS BATCH 1: KAMEN RIDER ERA SHOWA (1971 - 1989)
-- IDEMPOTEN: Menggunakan INSERT ... ON CONFLICT DO NOTHING agar TIDAK menimpa
-- data arc yang sudah ada atau yang sudah diedit manual.
-- Mencari series_id dan character_id secara dinamis berdasarkan title/name.
-- =============================================================================

DO $$
DECLARE
  v_series_id INT;
  v_arc_id    INT;
BEGIN

  -- ===========================================================================
  -- 1. KAMEN RIDER (1971) — Hubungkan karakter baru ke 4 arc yang sudah ada
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN
    -- Pastikan 4 arc ada (tidak menimpa bila sudah ada)
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Kelahiran Cyborg Belalang', 'Episode 01–13',
      E'Takeshi Hongo, mahasiswa cerdas sekaligus pembalap motor, diculik oleh sindikat rahasia Shocker untuk diubah menjadi prajurit cyborg. Berkat pertolongan Profesor Midorikawa, ia berhasil kabur sebelum pencucian otak dilakukan.\n\nDengan sabuk Typhoon dan motor Cyclone, Hongo bersumpah menumpas monster-monster Shocker demi melindungi keselamatan warga.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mentor dan pendukung mekanik Takeshi Hongo sejak awal.'
      FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana'
      ON CONFLICT (arc_id, character_id) DO NOTHING;
    END IF;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Komandan Shocker pertama yang dihadapi Hayato Ichimonji.'
      FROM characters WHERE series_id = v_series_id AND name = 'Colonel Zol'
      ON CONFLICT (arc_id, character_id) DO NOTHING;

      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Ilmuwan sekaligus komandan kedua Shocker.'
      FROM characters WHERE series_id = v_series_id AND name = 'Dr. Shinigami'
      ON CONFLICT (arc_id, character_id) DO NOTHING;
    END IF;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Panglima ketiga Shocker yang bertarung sengit melawan New 1.'
      FROM characters WHERE series_id = v_series_id AND name = 'Ambassador Hell'
      ON CONFLICT (arc_id, character_id) DO NOTHING;
    END IF;

    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Pemimpin operasional Gel-Shocker pada babak akhir serial.'
      FROM characters WHERE series_id = v_series_id AND name = 'General Black'
      ON CONFLICT (arc_id, character_id) DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 2. KAMEN RIDER V3 (1973) — 5 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider V3' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Kebangkitan V3 & Ancaman Awal Destron', 'Episode 01–12',
      E'Tidak lama setelah kehancuran Gel-Shocker, sindikat jahat baru bernama Destron muncul dan membantai keluarga mahasiswa Shiro Kazami. Ketika berusaha menyelamatkan Double Riders dan ikut terluka parah, Shiro memohon agar dirinya diubah menjadi cyborg demi membalas dendam.\n\nDengan menggabungkan teknik Rider 1 dan kekuatan Rider 2, Shiro terlahir kembali sebagai Kamen Rider V3. Ditemani Tobei Tachibana dan Junko Tama, ia memulai perburuan terhadap para monster mekanik awal milik Destron.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kelahiran Shiro Kazami sebagai Kamen Rider V3.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mendampingi Shiro Kazami sejak episode perdana.' FROM characters WHERE series_id = v_series_id AND name IN ('Tobei Tachibana', 'Junko Tama') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Serangan Pasukan Mekanik Doctor G', 'Episode 13–30',
      E'Destron menurunkan komandan lapangan pertamanya yang berzirah ksatria bernama Doctor G untuk memimpin divisi pasukan mekanik. Doctor G melancarkan serangan demi serangan terencana ke kota Tokyo guna menjebak V3.\n\nPertempuran keduanya berlangsung sengit selama puluhan episode hingga memuncak saat Doctor G menunjukkan wujud monster sejatinya sebagai Kani Laser sebelum akhirnya berhasil ditumbangkan oleh Shiro Kazami.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Berduel melawan pasukan mekanik Destron.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Komandan pertama Destron yang memimpin serangan langsung.' FROM characters WHERE series_id = v_series_id AND name = 'Doctor G' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Kemunculan Suku Taring Baron Kiba', 'Episode 31–35',
      E'Menyusul gugurnya Doctor G, Pemimpin Besar Destron menunjuk Baron Kiba dari Suku Taring untuk mengambil alih komando serangan. Baron Kiba menggunakan ilmu sihir hitam dan monster-monster buas bertaring untuk meneror warga.\n\nV3 harus mengandalkan kecerdikan serta kecepatan barunya untuk membongkar ritual musuh sebelum menaklukkan wujud monster mamut milik Baron Kiba.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghadapi serangan ilmu hitam dari Suku Taring Destron.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Pasukan Bersayap Uskup Agung Tsubasa', 'Episode 36–40',
      E'Komando Destron berpindah ke tangan Uskup Agung Tsubasa yang membawahi pasukan monster udara dan burung pemangsa. Serangan dari langit sempat menyulitkan pergerakan V3 di darat.\n\nUntuk mengatasi kelemahan tersebut, Shiro Kazami melatih teknik tendangan udara cepat baru bernama V3 Mach Kick yang menjadi penentu kemenangan atas Uskup Agung Tsubasa.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mengembangkan jurus udara baru V3 Mach Kick.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 05
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 5, 'ARC 05', 'Kelahiran Riderman & Jenderal Yoroi', 'Episode 41–52',
      E'Jenderal terakhir Destron, Jenderal Yoroi (Marshal Armor), naik ke tampuk kekuasaan dan menjebak mantan ilmuwan setia organisasi mereka sendiri, Joji Yuki. Kehilangan lengan kanannya akibat pengkhianatan itu, Joji memasang lengan bionik modular dan bangkit sebagai Riderman.\n\nMeski sempat bersitegang dengan Shiro, Riderman akhirnya bekerja sama dengan V3 untuk menghentikan proyek roket pemusnah dan mengalahkan Pemimpin Besar Destron.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 5 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bekerja sama dengan Riderman menumbangkan Destron.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider V3' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Debut Joji Yuki sebagai Riderman dan diakui sebagai Rider keempat.' FROM characters WHERE series_id = v_series_id AND name = 'Riderman' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Jenderal terakhir Destron dan lawan bebuyutan Riderman.' FROM characters WHERE series_id = v_series_id AND name = 'Marshal Armor' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 3. KAMEN RIDER X (1974) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider X' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Kelahiran Cyborg Laut Dalam Kaizorg', 'Episode 01–09',
      E'Organisasi rahasia GOD menyerang laboratorium Profesor Keitaro Jin demi merampas teknologi robotik laut dalam miliknya. Sebelum mengembuskan napas terakhir akibat serangan itu, Profesor Jin berhasil merombak tubuh putranya, Keisuke Jin, menjadi cyborg Kaizorg.\n\nKeisuke bangkit sebagai Kamen Rider X bersenjatakan tongkat Ridol dan kendaraan Cruiser. Didampingi Tobei Tachibana, ia memulai perlawanan terhadap para monster mitologi kiriman GOD.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Keisuke bertransformasi menjadi Kamen Rider X.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Pencipta teknologi Kaizorg dan ayah Keisuke Jin.' FROM characters WHERE series_id = v_series_id AND name = 'Keitaro Jin' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membimbing Keisuke di kedai kopi COL.' FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Duel Melawan Polisi Rahasia Apollo Geist', 'Episode 10–21',
      E'GOD mengirimkan kepala polisi rahasia mereka yang kejam dan terampil, Apollo Geist, untuk mengawasi operasi sekaligus melenyapkan Kamen Rider X secara langsung. Pertarungan antara X-Rider dan Apollo Geist berlangsung sengit karena keduanya seimbang.\n\nSetelah sempat kalah dan dihidupkan kembali oleh para ilmuwan GOD dengan batas waktu hidup singkat, Apollo Geist mengerahkan seluruh kekuatannya dalam serangan umum terakhir sebelum akhirnya gugur di tangan Keisuke.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Berduel berulang kali melawan rival utamanya.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kepala polisi rahasia GOD yang menjadi rival utama X-Rider.' FROM characters WHERE series_id = v_series_id AND name = 'Apollo Geist' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Kemunculan Raksasa King Dark & Cetak Biru RS', 'Episode 22–28',
      E'Menyusul tumbangnya Apollo Geist, pemimpin raksasa bernama King Dark muncul mengambil kendali penuh atas operasi GOD. Target utamanya adalah merampas sembilan bagian cetak biru mesin energi pemusnah bernama RS Device ciptaan Dr. Nanbara.\n\nGOD mengerahkan monster-monster yang terinspirasi dari tokoh sejarah serta penjahat terkenal dunia untuk memburu potongan cetak biru tersebut, memaksa Keisuke berpacu dengan waktu untuk mengamankannya.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mengamankan potongan cetak biru RS Device.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Muncul sebagai penguasa raksasa organisasi GOD.' FROM characters WHERE series_id = v_series_id AND name = 'King Dark' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Penentuan RS Device & Runtuhnya GOD', 'Episode 29–35',
      E'Pertarungan memburu potongan cetak biru terakhir semakin memanas hingga GOD hampir berhasil merakit RS Device di dalam tubuh raksasa King Dark. Keisuke memperoleh peningkatan kemampuan dari komponen pelengkap demi menghadapi ancaman kehancuran massal tersebut.\n\nPada klimaks serial, Kamen Rider X berhasil menerobos masuk ke dalam tubuh King Dark untuk menghadapi dalang sejatinya, Dr. Noroi, sekaligus menghancurkan markas dan mesin RS Device selamanya.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghancurkan King Dark dan menggagalkan RS Device.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider X' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menemui kehancuran pada pertempuran penutup.' FROM characters WHERE series_id = v_series_id AND name = 'King Dark' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 4. KAMEN RIDER AMAZON (1974) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Amazon' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Pejuang Rimba & Perburuan Gelang GiGi', 'Episode 01–07',
      E'Daisuke Yamamoto, anak yang tumbuh besar di pedalaman hutan Amazon, mewarisi gelang mistis GiGi Armlet dari tetua suku Inca Bago setelah desanya diserang organisasi jahat Geddon. Diburu oleh Sepuluh Wajah Gorgos hingga ke Jepang, Daisuke berjuang mempertahankan gelang itu.\n\nMeski awalnya asing dengan bahasa dan peradaban modern, Amazon mendapat bantuan dari Masahiko dan Tobei Tachibana serta berteman dengan tikus tanah pembelot bernama Mogura Beastman.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Daisuke beradaptasi di Jepang sebagai Kamen Rider Amazon.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membantu Amazon beradaptasi dan memberinya motor Jungler.' FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membelot dari Geddon dan menjadi sahabat setia Amazon.' FROM characters WHERE series_id = v_series_id AND name = 'Mogura Beastman' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Pemimpin Geddon yang memburu gelang GiGi.' FROM characters WHERE series_id = v_series_id AND name = 'Ten-Faced Demon Gorgos' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Akhir Organisasi Geddon & Sepuluh Wajah Gorgos', 'Episode 08–13',
      E'Ten-Faced Demon Gorgos semakin gencar mengirimkan monster-monster Beastman kuat demi merebut GiGi Armlet agar bisa digabungkan dengan gelang pasangannya, GaGa Armlet. Masyarakat Jepang sempat diliputi teror oleh operasi penculikan dan sabotase Geddon.\n\nSetelah mempelajari arti persahabatan serta melindungi keluarga Masahiko, Amazon berhasil menerobos rencana musuh dan menumbangkan Gorgos pada Episode 13.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menjatuhkan Sepuluh Wajah Gorgos dalam duel penentuan.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Gugur pada Episode 13 saat berhadapan dengan Amazon.' FROM characters WHERE series_id = v_series_id AND name = 'Ten-Faced Demon Gorgos' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Bangkitnya Kekaisaran Garanda & Kaisar Zero', 'Episode 14–19',
      E'Runtuhnya Geddon dimanfaatkan oleh organisasi baru yang jauh lebih terstruktur secara militer bernama Kekaisaran Garanda, dipimpin oleh sosok kejam Kaisar Zero. Mereka mengambil alih gelang GaGa Armlet dari sisa jasad Gorgos.\n\nGaranda mengerahkan unit pengikut berpakaian serba hitam dan Beastman baru yang menebar ancaman bom serta bencana buatan di Tokyo, memaksa Amazon dan Mogura bahu-membahu menghentikannya.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghadapi serangan terorganisir Kekaisaran Garanda.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membantu menyelidiki pergerakan bawah tanah Garanda.' FROM characters WHERE series_id = v_series_id AND name = 'Mogura Beastman' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Muncul memimpin Kekaisaran Garanda.' FROM characters WHERE series_id = v_series_id AND name = 'Zero Great Emperor' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Rahasia Penguasa Sejati & Akhir Garanda', 'Episode 20–24',
      E'Setelah melalui serangkaian pengorbanan berat termasuk gugurnya sahabat setianya Mogura Beastman, Amazon semakin dekat menuju markas inti Kekaisaran Garanda. Ia bertekad menghentikan rencana bom helium raksasa milik musuh.\n\nDi pertempuran puncak, terungkap bahwa Kaisar Zero yang selama ini tampil di depan hanyalah pemeran pengganti. Amazon akhirnya mengalahkan sang Penguasa Sejati Garanda dan menghancurkan markas mereka untuk selamanya.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menumbangkan Penguasa Sejati dan menghancurkan Garanda.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Amazon' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kalah dalam konfrontasi akhir di markas Garanda.' FROM characters WHERE series_id = v_series_id AND name = 'Zero Great Emperor' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 5. KAMEN RIDER STRONGER (1975) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Stronger' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Penyusupan Black Satan & Lahirnya Manusia Listrik', 'Episode 01–13',
      E'Demi menuntut keadilan atas kematian sahabatnya di tangan organisasi Black Satan, Shigeru Jo secara sukarela membiarkan dirinya ditangkap dan dimodifikasi menjadi cyborg bertenaga listrik. Sebelum otaknya dicuci, ia kabur dan bersumpah menjadi Kamen Rider Stronger.\n\nDalam pelariannya, ia menyelamatkan Yuriko Misaki yang turut menjadi korban eksperimen sebagai Electro-Wave Human Tackle. Keduanya menempuh perjalanan melawan eksekutif pertama Black Satan, Hitotsume Titan.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Shigeru memulai perlawanan terhadap Black Satan.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bertempur setia mendampingi Stronger.' FROM characters WHERE series_id = v_series_id AND name = 'Electro-Wave Human Tackle' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bergabung membantu Shigeru dan Yuriko sejak Episode 3.' FROM characters WHERE series_id = v_series_id AND name = 'Tobei Tachibana' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Eksekutif pertama Black Satan.' FROM characters WHERE series_id = v_series_id AND name = 'Hitotsume Titan' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Rivalitas Jenderal Shadow & Runtuhnya Black Satan', 'Episode 14–26',
      E'Black Satan menghadirkan ahli strategi misterius bernama Jenderal Shadow yang menggunakan kartu tarot sebagai senjatanya, memicu persaingan internal melawan Titan yang bangkit kembali. Shigeru dan Tackle terus menggagalkan rencana penguasaan Jepang oleh makhluk serangga Black Satan.\n\nPada Episode 26, Stronger berhasil membongkar jati diri pemimpin agung Black Satan dan menghancurkan organisasi tersebut, sementara Jenderal Shadow lolos untuk membentuk ancaman baru.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menumbangkan organisasi Black Satan.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Muncul sebagai eksekutif baru Black Satan pada Episode 14.' FROM characters WHERE series_id = v_series_id AND name = 'General Shadow' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Pasukan Delza, Pengorbanan Tackle & Charge Up', 'Episode 27–33',
      E'Jenderal Shadow memimpin faksi baru bernama Delzer Army yang berisi para jenderal monster cyborg berkekuatan jauh di atas pasukan lama. Ancaman tersebut memaksa Shigeru dan Yuriko bertarung melampaui batas fisik mereka.\n\nTragedi besar terjadi di Episode 30 saat Tackle mengorbankan nyawanya untuk menyelamatkan Shigeru dari racun mematikan Doctor Kate. Diliputi duka, Shigeru menerima modifikasi lanjutan untuk mengakses wujud Charge Up yang jauh lebih kuat.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memperoleh kekuatan upgrade Charge Up setelah kepergian Tackle.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Gugur dengan gagah berani pada Episode 30.' FROM characters WHERE series_id = v_series_id AND name = 'Electro-Wave Human Tackle' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin Delzer Army melawan Stronger.' FROM characters WHERE series_id = v_series_id AND name = 'General Shadow' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Bersatunya Tujuh Rider Legendaris', 'Episode 34–39',
      E'Menjelang akhir peperangan, para komandan baru Delzer Army yang lebih buas mulai menekan kekuatan Stronger di seluruh penjuru Jepang. Ketika situasi kian genting, satu per satu dari enam Kamen Rider senior terdahulu pulang dari tugas mereka di luar negeri.\n\nTujuh Kamen Rider legendaris pun bertempur bahu-membahu menghadapi kekuatan inti Delzer Army hingga berhasil menumbangkan Jenderal Shadow dan Pemimpin Besar.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin pertempuran penutup bersama enam seniornya.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Stronger' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Tumbang dalam duel terakhir menjelang akhir serial.' FROM characters WHERE series_id = v_series_id AND name = 'General Shadow' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 6. SKYRIDER (1979) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Skyrider' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Pelarian dari Neo-Shocker & Sayap Kebebasan', 'Episode 01–17',
      E'Mahasiswa pencinta layang gantung Hiroshi Tsukuba terluka parah saat menolong Dr. Keitaro Shido yang dikejar oleh organisasi Neo-Shocker. Agar nyawanya terselamatkan, Dr. Shido membujuk Neo-Shocker mengubah Hiroshi menjadi cyborg lalu melarikannya bersama-sama.\n\nDengan kekuatan anti-gravitasi Sailing Jump untuk terbang bebas di udara, Hiroshi bertarung sebagai Skyrider melawan pasukan awal Neo-Shocker hingga akhirnya berhasil mengalahkan komandan pertama, General Monster.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Hiroshi memulai perjuangannya sebagai Kamen Rider baru.' FROM characters WHERE series_id = v_series_id AND name = 'Skyrider' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membimbing Hiroshi dan merancang sistem terbang Skyrider.' FROM characters WHERE series_id = v_series_id AND name = 'Dr. Keitaro Shido' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bergabung pada Episode 14 membantu Hiroshi di kedai Blanca.' FROM characters WHERE series_id = v_series_id AND name = 'Genjiro Tani' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Komandan pertama Neo-Shocker hingga tumbang di Episode 17.' FROM characters WHERE series_id = v_series_id AND name = 'General Monster' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Komando Laksamana Majin & Bantuan Rider Senior', 'Episode 18–27',
      E'Neo-Shocker mengirim panglima baru yang sangat disiplin bernama Admiral Majin setelah kepergian Dr. Shido ke luar negeri. Sementara itu, Genjiro Tani mengambil alih peran pendukung utama di kedai kopi Blanca.\n\nPada periode ini, beberapa Kamen Rider senior dari era terdahulu mulai muncul kembali secara bergantian ke Jepang untuk membantu Hiroshi menghadapi taktik kejam Admiral Majin.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghadapi strategi keras Admiral Majin bersama para senior.' FROM characters WHERE series_id = v_series_id AND name = 'Skyrider' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mendukung penuh operasi lapangan Hiroshi.' FROM characters WHERE series_id = v_series_id AND name = 'Genjiro Tani' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Panglima kedua Neo-Shocker sejak Episode 18.' FROM characters WHERE series_id = v_series_id AND name = 'Admiral Majin' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Latihan Tujuh Rider & Peningkatan Kekuatan', 'Episode 28–39',
      E'Menyadari monster-monster baru Neo-Shocker terlalu tangguh untuk dihadapi dengan kekuatan dasarnya, Hiroshi menjalani latihan berat langsung di bawah bimbingan tujuh Kamen Rider senior legendaris.\n\nHasil latihan keras tersebut memicu peningkatan kekuatan besar-besaran bagi Skyrider yang ditandai dengan perubahan warna kostum menjadi lebih cerah serta penguasaan variasi jurus 99 teknik.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Meningkatkan kekuatan dan mendapat warna kostum baru.' FROM characters WHERE series_id = v_series_id AND name = 'Skyrider' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Terus melancarkan berbagai operasi melawan Skyrider.' FROM characters WHERE series_id = v_series_id AND name = 'Admiral Majin' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Kejatuhan Admiral Majin & Pemimpin Besar', 'Episode 40–54',
      E'Operasi Neo-Shocker mencapai puncaknya ketika Admiral Majin terbunuh oleh pengkhianatan dan Pemimpin Besar berwujud naga raksasa menampakkan wujud aslinya untuk memusnahkan seluruh Jepang dengan bom oksigen.\n\nSkyrider bersama tujuh Kamen Rider senior kembali bergabung menghadapi pertempuran penentuan yang berakhir pada kehancuran total Pemimpin Besar Neo-Shocker.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mengorbankan tenaga bersama tujuh Rider demi menumpas Neo-Shocker.' FROM characters WHERE series_id = v_series_id AND name = 'Skyrider' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menemui ajalnya pada Episode 53.' FROM characters WHERE series_id = v_series_id AND name = 'Admiral Majin' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 7. KAMEN RIDER SUPER-1 (1980) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Super-1' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Proyek Antariksa & Latihan Kung Fu', 'Episode 01–12',
      E'Kazuya Oki mengajukan diri menjadi cyborg untuk program penjelajahan antariksa tanpa perlengkapan luar, namun laboratorium penelitiannya diserang dan dihancurkan oleh Kerajaan Dogma. Satu-satunya yang selamat, Kazuya tidak bisa berubah wujud secara sadar.\n\nIa menemui Master Genkai untuk mempelajari ilmu kung fu Sekishin Shorinji Kenpo hingga mampu memicu sabuk Cyclode sendiri, lalu mulai melawan pasukan monster Dogma dengan lima sarung tangan tempur Five Hands.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kazuya belajar kung fu dan memulai aksinya sebagai Super-1.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Super-1' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Melatih pengendalian diri Kazuya melalui seni bela diri.' FROM characters WHERE series_id = v_series_id AND name = 'Master Genkai' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin Kerajaan Dogma dari balik bayang-bayang.' FROM characters WHERE series_id = v_series_id AND name IN ('Emperor Terror Macro', 'General Megarl') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Keruntuhan Kerajaan Dogma', 'Episode 13–23',
      E'Dibantu Genjiro Tani dan kelompok anak-anak Junior Rider Team, Kazuya terus menggagalkan rencana jahat Kerajaan Dogma yang menyasar warga sipil Jepang. Konfrontasi langsung dengan Jenderal Megarl pun semakin kerap terjadi.\n\nPuncaknya pada Episode 22–23, Super-1 berhasil mengalahkan Jenderal Megarl serta wujud naga sejati Kaisar Terror Macro, mengakhiri dominasi Kerajaan Dogma.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghancurkan Terror Macro dan General Megarl.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Super-1' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mendukung Super-1 bersama Junior Rider Team.' FROM characters WHERE series_id = v_series_id AND name = 'Genjiro Tani' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Tumbang bersama runtuhnya Kerajaan Dogma di Episode 23.' FROM characters WHERE series_id = v_series_id AND name IN ('Emperor Terror Macro', 'General Megarl') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Kemunculan Organisasi Baru Jin Dogma', 'Episode 24–36',
      E'Tidak lama setelah kehancuran Dogma, muncul faksi penerus yang lebih brutal dan aneh bernama Jin Dogma di bawah pimpinan Marshal Demon dan empat komandan eksentriknya. Mereka menggunakan monster-monster yang berwujud benda kehidupan sehari-hari.\n\nKazuya berhadapan dengan taktik licik para komandan Jin Dogma sembari melindungi warga dan teman-teman Junior Rider Team dari penyusupan.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Berjuang menghadapi komandan dan monster benda Jin Dogma.' FROM characters WHERE series_id = v_series_id AND name IN ('Kamen Rider Super-1', 'Genjiro Tani') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Pertempuran Akhir Melawan Marshal Demon', 'Episode 37–48',
      E'Satu per satu dari empat komandan Jin Dogma terjun langsung ke medan laga dengan wujud monster sejati mereka, menguji seluruh teknik kung fu dan kemampuan lima sarung tangan Super-1 hingga batas maksimal.\n\nPada penutup serial, Kazuya berhasil mengalahkan Marshal Demon dalam wujud raksasa Satan Snake serta membawa teknologi antariksa untuk melanjutkan impian awalnya menjelajah luar angkasa.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mengalahkan Marshal Demon dan berangkat ke luar angkasa.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Super-1' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 8. KAMEN RIDER ZX (1984 TV Special) — 4 Fase Kronologis
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider ZX' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Tragedi Amazon & Kelahiran Cyborg Ninja', 'TV Special (1984) — Fase 1',
      E'Saat meneliti daerah hutan Amazon bersama kakaknya Shizuka, Ryo Murasame diserang dan diculik oleh pasukan Kekaisaran Badan. Kakaknya tewas sementara tubuh Ryo dioperasi secara paksa menjadi prajurit cyborg ninja bernama ZX.\n\nMeski sempat mengalami hilang ingatan dan dikendalikan oleh Badan sebagai prajurit tanpa emosi, sebuah kecelakaan listrik melepaskan kendali pikiran tersebut dan menyadarkan Ryo.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Latar belakang penculikan dan modifikasi menjadi ZX.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider ZX' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Pertemuan dengan Rumi Ichijo & Pelarian', 'TV Special (1984) — Fase 2',
      E'Dalam pelariannya memburu pimpinan Badan demi membalas kematian kakaknya, Ryo bertemu dengan Rumi Ichijo yang ayahnya turut dibunuh karena menolak membantu Badan. Ia juga dibimbing oleh rekan ilmuwan ayah Rumi, Dr. Hajime Kaido.\n\nNamun kekuatan Badan di bawah komando Ambassador Darkness terus membayangi dan mencoba menjebak Ryo menggunakan pasukan robot tempur mereka.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mendapat dukungan Dr. Kaido dan berteman dengan Rumi.' FROM characters WHERE series_id = v_series_id AND name IN ('Kamen Rider ZX', 'Rumi Ichijo', 'Dr. Hajime Kaido') ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin pengejaran terhadap ZX.' FROM characters WHERE series_id = v_series_id AND name = 'Ambassador Darkness' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Pertemuan Dengan Sembilan Rider Senior', 'TV Special (1984) — Fase 3',
      E'Karena sempat terjadi kesalahpahaman, Ryo berhadapan dengan Kamen Rider V3, Riderman, Kamen Rider 2, dan Super-1 yang sedang menyelidiki proyek Badan. Berkat pertolongan para senior, Ryo mulai memahami bahwa perjuangan bukanlah sekadar balas dendam.\n\nSembilan Kamen Rider terdahulu kemudian bersatu mengakui Ryo secara resmi sebagai Kamen Rider ke-10.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Resmi bergabung sebagai Kamen Rider ke-10.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider ZX' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Kehancuran Space Break System Badan', 'TV Special (1984) — Fase 4',
      E'Kekaisaran Badan bersiap mengaktifkan senjata pamungkas Space Break System untuk menghancurkan kota-kota di dunia. Kesepuluh Kamen Rider menyerbu markas besar musuh secara serempak.\n\nDi akhir pertempuran, Kamen Rider ZX memimpin serangan penghancuran Space Break System bersama sembilan seniornya serta menumbangkan Ambassador Darkness.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menggagalkan senjata kiamat Kekaisaran Badan.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider ZX' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Pemimpin dan komandan Kekaisaran Badan pada babak klimaks.' FROM characters WHERE series_id = v_series_id AND name IN ('Ambassador Darkness', 'Generalissimo of Badan') ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 9. KAMEN RIDER BLACK (1987) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Malam Gerhana & Lahirnya Ksatria Hitam', 'Episode 01–17',
      E'Lahir pada saat gerhana matahari berlangsung, dua saudara angkat Kotaro Minami dan Nobuhiko Akizuki diculik sekte rahasia Gorgom pada ulang tahun ke-19 mereka. Tubuh keduanya ditanamkan batu suci Kingstone sebagai calon Raja Penciptaan abad berikutnya.\n\nKotaro berhasil meloloskan diri sebelum ingatannya dihapus dan bangkit berjuang sendirian sebagai Kamen Rider Black, menghadapi operasi monster utusan Tiga Pendeta Agung Gorgom demi melindungi Kyoko dan Katsumi.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kotaro memulai perlawanan terhadap Gorgom sendirian.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Keluarga dan rekan terdekat yang dilindungi Kotaro.' FROM characters WHERE series_id = v_series_id AND name IN ('Kyoko Akizuki', 'Katsumi Kida') ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Pendeta Agung Gorgom yang memimpin operasi teror awal.' FROM characters WHERE series_id = v_series_id AND name IN ('High Priest Darom', 'High Priest Baraom') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Kebangkitan Pendekar Pedang Bilgenia', 'Episode 18–34',
      E'Merasa kesulitan menghentikan Black, Tiga Pendeta Agung membangkitkan prajurit kuno dari peti mati bernama Sword Saint Bilgenia. Berbekal kemahiran pedang dan pedang Satan Saber, Bilgenia menjadi rival mematikan bagi Kotaro.\n\nKonfrontasi antara Black dan Bilgenia terus berlanjut hingga Tiga Pendeta Agung mengorbankan kekuatan mereka untuk membangkitkan sosok yang selama ini dinantikan: Raja Abad Kedua, Shadow Moon.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Berduel berulang kali melawan Sword Saint Bilgenia.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Prajurit kuno Gorgom yang bangkit sejak Episode 18.' FROM characters WHERE series_id = v_series_id AND name = 'Sword Saint Bilgenia' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membimbing kebangkitan Shadow Moon.' FROM characters WHERE series_id = v_series_id AND name IN ('High Priest Darom', 'High Priest Baraom') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Lahirnya Shadow Moon & Duel Dua Pangeran', 'Episode 35–45',
      E'Nobuhiko Akizuki akhirnya terbangun seutuhnya dalam kepribadian dingin dan kejam sebagai Shadow Moon setelah seluruh ingatan manusianya terhapus. Ia merebut pedang Satan Saber dan menantang Kotaro secara langsung untuk memperebutkan hak pewaris Raja Penciptaan.\n\nKotaro menghadapi dilema emosional yang sangat berat karena harus bertarung melawan saudara angkat yang sangat disayanginya demi melindungi Kyoko serta umat manusia.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Dihadapkan pada pertarungan batin melawan saudara angkatnya.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bangkit sepenuhnya sebagai Raja Abad Kedua sejak Episode 35.' FROM characters WHERE series_id = v_series_id AND name = 'Shadow Moon' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Berusaha menyadarkan kembali Nobuhiko.' FROM characters WHERE series_id = v_series_id AND name IN ('Kyoko Akizuki', 'Katsumi Kida') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Hari Terakhir Gorgom & Kehancuran Raja Penciptaan', 'Episode 46–51',
      E'Pertempuran mencapai klimaksnya ketika seluruh kekuatan Tiga Pendeta Agung telah musnah dan kota Tokyo berada di ambang kekacauan total oleh serangan akhir Gorgom. Kotaro menyerbu markas bawah tanah Gorgom untuk duel penentuan.\n\nMeski sempat gugur namun dihidupkan kembali oleh batu Kingstone serta pengorbanan motor Battle Hopper, Black mengalahkan Shadow Moon dan membinasakan Raja Penciptaan demi membawa kedamaian kembali ke Bumi.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mengalahkan Shadow Moon dan menghancurkan Raja Penciptaan.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Tumbang dalam duel terakhir melawan Kotaro di markas Gorgom.' FROM characters WHERE series_id = v_series_id AND name = 'Shadow Moon' ON CONFLICT DO NOTHING;
    END IF;
  END IF;


  -- ===========================================================================
  -- 10. KAMEN RIDER BLACK RX (1988) — 4 ARC
  -- ===========================================================================
  SELECT id INTO v_series_id FROM series WHERE title = 'Kamen Rider Black RX' AND franchise = 'Kamen Rider' LIMIT 1;
  IF v_series_id IS NOT NULL THEN

    -- ARC 01
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 1, 'ARC 01', 'Invasi Kekaisaran Crisis & Evolusi Pangeran Matahari', 'Episode 01–14',
      E'Enam bulan setelah mengalahkan Gorgom, Kotaro Minami menjalani hidup damai bersama keluarga Sahara sebagai pilot helikopter sebelum diculik oleh Kekaisaran Crisis. Karena menolak bergabung menjadi jenderal invasi, Kotaro dilempar ke ruang angkasa.\n\nRadiasi matahari memicu evolusi batu Kingstone dalam tubuhnya sehingga ia bangkit sebagai Kamen Rider Black RX. Bersenjatakan pedang cahaya Revolcane dan mobil Ridoron, ia mematahkan serangan awal Jenderal Jark serta para komandannya.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 1 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Kotaro berevolusi menjadi Black RX dan melawan Crisis.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black RX' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Mendampingi kehidupan baru Kotaro dan melawan agen Crisis.' FROM characters WHERE series_id = v_series_id AND name = 'Reiko Shiratori' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Komandan tertinggi Crisis dan panglima divisi tempurnya.' FROM characters WHERE series_id = v_series_id AND name IN ('General Jark', 'Commander Bosgun') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 02
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 2, 'ARC 02', 'Kelahiran Roborider dan Biorider', 'Episode 15–20',
      E'Dalam menghadapi situasi terdesak serta duka mendalam akibat tragedi yang menimpa orang-orang tak bersalah, energi Kingstone dalam diri Kotaro kembali mengalami mutasi wujud yang unik.\n\nIa memperoleh wujud lapis baja bersenjata api bernama Roborider serta wujud cair berkecepatan tinggi bernama Biorider, sekaligus memperoleh sekutu setia baru bernama Joe Kazama (Joe the Haze).',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 2 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Membuka akses wujud baru Roborider (Ep. 15) dan Biorider (Ep. 17).' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black RX' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bergabung sebagai rekan tempur dekat Kotaro sejak Episode 15.' FROM characters WHERE series_id = v_series_id AND name = 'Joe the Haze' ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 03
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 3, 'ARC 03', 'Kembalinya Shadow Moon & Pengejaran Crisis', 'Episode 21–37',
      E'Ancaman tak terduga datang saat rival lamanya, Shadow Moon, bangkit kembali dari reruntuhan dengan sepasang pedang baru untuk membalas kekalahannya. Sementara itu, komandan Crisis seperti Bosgun terus berupaya menyabotase Bumi dan menjebak keluarga Sahara.\n\nRX berhasil mengatasi bentrokan melawan Shadow Moon serta menahan laju pasukan monster Crisis bersama Reiko dan Joe.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 3 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Menghadapi kebangkitan singkat Shadow Moon dan komandan Crisis.' FROM characters WHERE series_id = v_series_id AND name IN ('Kamen Rider Black RX', 'Reiko Shiratori', 'Joe the Haze') ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin operasi pengejaran Crisis di pertengahan serial.' FROM characters WHERE series_id = v_series_id AND name IN ('General Jark', 'Commander Bosgun') ON CONFLICT DO NOTHING;
    END IF;

    -- ARC 04
    INSERT INTO series_arcs (series_id, arc_order, chapter_label, title, episode_range, summary, quote_text, quote_by, image_url, image_caption)
    VALUES (
      v_series_id, 4, 'ARC 04', 'Sepuluh Rider Bersatu & Keruntuhan Kekaisaran Crisis', 'Episode 38–47',
      E'Menjelang akhir perang, Kaisar Crisis mengirim pengawas tinggi Dasmader dan mengubah Jenderal Jark menjadi monster Jark Midla untuk menggempur RX habis-habisan. Ketika pasukan invasi besar Crisis mulai mengepung Jepang, sepuluh Kamen Rider senior dari seluruh dunia datang membantu.\n\nBersama sepuluh Rider terdahulu serta pengorbanan sahabatnya, Kotaro menembus jantung Kekaisaran Crisis dan menghancurkan Kaisar Crisis untuk menyelamatkan dua dunia.',
      NULL, NULL, NULL, NULL
    ) ON CONFLICT (series_id, arc_order) DO NOTHING;
    SELECT id INTO v_arc_id FROM series_arcs WHERE series_id = v_series_id AND arc_order = 4 LIMIT 1;
    IF v_arc_id IS NOT NULL THEN
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Memimpin pertempuran penutup bersama 10 Kamen Rider terdahulu.' FROM characters WHERE series_id = v_series_id AND name = 'Kamen Rider Black RX' ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Bertempur hingga titik akhir menghadapi invasi penuh Crisis.' FROM characters WHERE series_id = v_series_id AND name IN ('Reiko Shiratori', 'Joe the Haze') ON CONFLICT DO NOTHING;
      INSERT INTO arc_characters (arc_id, character_id, note)
      SELECT v_arc_id, id, 'Tumbang dalam duel terakhir sebagai Jark Midla (Ep. 46).' FROM characters WHERE series_id = v_series_id AND name = 'General Jark' ON CONFLICT DO NOTHING;
    END IF;
  END IF;

END $$;

SELECT setval(pg_get_serial_sequence('series_arcs', 'id'), COALESCE((SELECT MAX(id) FROM series_arcs), 1));
