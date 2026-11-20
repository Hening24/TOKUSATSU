// Migrasi tabel database Neon: Menambah full_plot di series dan membuat tabel actors
const pool = require('../db');

(async () => {
  try {
    console.log('Menjalankan migrasi database...');

    // 1. Tambah kolom full_plot ke series jika belum ada
    await pool.query(`
      ALTER TABLE series ADD COLUMN IF NOT EXISTS full_plot TEXT;
    `);
    console.log('✓ Kolom full_plot pada tabel series siap.');

    // 2. Buat tabel actors jika belum ada
    await pool.query(`
      CREATE TABLE IF NOT EXISTS actors (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        kanji TEXT,
        character TEXT NOT NULL,
        role_type TEXT DEFAULT 'MC',
        series_id INT REFERENCES series(id) ON DELETE SET NULL,
        birth_date TEXT,
        birth_place TEXT,
        agency TEXT,
        photo TEXT,
        bio TEXT
      );
      CREATE INDEX IF NOT EXISTS idx_actors_series ON actors(series_id);
    `);
    console.log('✓ Tabel actors siap.');

    // 3. Masukkan seed data awal untuk actors jika masih kosong
    const countRes = await pool.query('SELECT count(*) FROM actors');
    if (parseInt(countRes.rows[0].count, 10) === 0) {
      console.log('Mengisi data awal pemeran utama (actors)...');
      await pool.query(`
        INSERT INTO actors (name, kanji, character, role_type, series_id, birth_date, birth_place, agency, photo, bio) VALUES
        ('Fumiya Takahashi', '高橋 文哉', 'Aruto Hiden / Kamen Rider Zero-One', 'MC', 6, '12 Maret 2001', 'Saitama, Jepang', 'A-Plus Entertainment', '', 'Pemenang Boys Contest 2017. Menjadi Rider era Reiwa pertama yang memerankan presiden muda perusahaan kecerdasan buatan Hiden Intelligence.'),
        ('Atsuhiro Inukai', '犬飼 貴丈', 'Sento Kiryu / Kamen Rider Build', 'MC', 5, '13 Juni 1994', 'Tokushima, Jepang', 'Burning Production', '', 'Pemenang kontes Junon Super Boy ke-25. Memerankan fisikawan jenius ber-IQ tinggi yang memperjuangkan kedamaian dengan prinsip sains dan cinta.'),
        ('Takeru Satoh', '佐藤 健', 'Ryotaro Nogami / Kamen Rider Den-O', 'MC', 4, '21 Maret 1989', 'Saitama, Jepang', 'Co-LaVo Inc.', '', 'Aktor papan atas Jepang dan bintang film Rurouni Kenshin. Terkenal luar biasa saat memerankan Ryotaro dengan 8 kepribadian berbeda saat dirasuki para Imagin.'),
        ('Takamasa Suga', '須賀 貴匡', 'Shinji Kido / Kamen Rider Ryuki', 'MC', 3, '19 Oktober 1977', 'Tokyo, Jepang', 'La Sette', '', 'Jurnalis investigasi berhati tulus yang terseret ke dalam Mirror World demi menyelamatkan manusia dan menghentikan perang antar Kamen Rider.'),
        ('Joe Odagiri', 'オダギリジョー', 'Yusuke Godai / Kamen Rider Kuuga', 'MC', 2, '16 Februari 1976', 'Okayama, Jepang', 'Dongyu Club', '', 'Aktor kawakan dan pelopor kebangkitan Kamen Rider era modern (Heisei) dengan pose legendaris acungan jempol (thumbs up) yang selalu melindungi senyuman orang lain.'),
        ('Hiroshi Fujioka', '藤岡 弘、', 'Takeshi Hongo / Kamen Rider 1', 'MC', 1, '19 Februari 1946', 'Ehime, Jepang', 'Sanki Promotion', '', 'Legenda hidup perfilman aksi Jepang dan master seni bela diri sejati yang mengawali seluruh waralaba Kamen Rider sejak tahun 1971.'),
        ('Yuki Inoue', '井上 祐貴', 'Hiroyuki Kudo / Ultraman Taiga', 'MC', 11, '6 Juni 1996', 'Hiroshima, Jepang', 'Horipro', '', 'Aktor berbakat yang memenangkan peran utama di serial Ultra era Reiwa pertama, bertindak sebagai inang dari tiga Ultra bersaudara (Taiga, Titas, Fuma).'),
        ('Koji Moritsugu', '森次 晃嗣', 'Dan Moroboshi / Ultraseven', 'MC', 10, '15 Maret 1943', 'Hokkaido, Jepang', 'Moritsugu Entertainment', '', 'Pemeran ikonik Dan Moroboshi. Gerakan memasang kacamata Ultra Eye miliknya menjadi salah satu transformasi paling dikenang sepanjang masa.'),
        ('Susumu Kurobe', '黒部 進', 'Shin Hayata / Ultraman', 'MC', 9, '22 Oktober 1939', 'Toyama, Jepang', 'Art Promotion', '', 'Aktor legendaris yang mengawali waralaba Ultra. Memerankan anggota Science Patrol yang berubah menjadi Sang Raksasa Cahaya menggunakan Beta Capsule.'),
        ('Kenji Ohba', '大葉 健二', 'Retsu Ichijouji / Space Sheriff Gavan', 'MC', 12, '5 Februari 1955', 'Ehime, Jepang', 'Japan Action Enterprise', '', 'Stuntman legendaris binaan Sonny Chiba. Menjadi pahlawan pertama Metal Hero dengan aksi bela diri tanpa kabel dan teriakan transformasi "Jouchaku!".'),
        ('Yuta Mochizuki', '望月 祐多', 'Geki / Tyranno Ranger', 'MC', 8, '14 Maret 1967', 'Kanagawa, Jepang', 'Ex-JAE', '', 'Memerankan pangeran purba suku Yamato sekaligus pemimpin tim Zyuranger yang kemudian diadaptasi secara global menjadi Mighty Morphin Power Rangers.'),
        ('Naoya Makoto', '誠 直也', 'Tsuyoshi Kaijo / Aka Ranger', 'MC', 7, '25 Juni 1948', 'Saga, Jepang', 'Geiei Production', '', 'Ranger Merah pertama dalam sejarah Super Sentai. Ketegasannya yang berwibawa menetapkan standar pemimpin pahlawan berkostum hingga hari ini.');
      `);
      console.log('✓ 12 Data awal pemeran berhasil di-seed.');
    }

    console.log('Semua migrasi database berhasil diselesaikan!');
  } catch (err) {
    console.error('Migrasi gagal:', err.message);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
})();
