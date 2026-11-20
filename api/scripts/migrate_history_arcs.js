// Migrasi dan seeding history_arcs untuk Series dan Characters
const pool = require('../db');

(async () => {
  try {
    console.log('Menjalankan migrasi kolom history_arcs...');

    // 1. Tambah kolom history_arcs ke tabel series
    await pool.query(`
      ALTER TABLE series ADD COLUMN IF NOT EXISTS history_arcs JSONB DEFAULT '[]'::jsonb;
    `);
    console.log('✓ Kolom history_arcs pada tabel series siap.');

    // 2. Tambah kolom history_arcs ke tabel characters
    await pool.query(`
      ALTER TABLE characters ADD COLUMN IF NOT EXISTS history_arcs JSONB DEFAULT '[]'::jsonb;
    `);
    console.log('✓ Kolom history_arcs pada tabel characters siap.');

    // 3. Pastikan Shocker Rider No. 1 ada di characters
    const shockerCheck = await pool.query("SELECT id FROM characters WHERE name ILIKE '%Shocker Rider%'");
    let shockerId;
    if (shockerCheck.rows.length === 0) {
      const ins = await pool.query(`
        INSERT INTO characters (series_id, name, actor, power, image, bio)
        VALUES (1, 'Shocker Rider No. 1', 'Eiji Okada (Suara)', 'Kekuatan cyborg identik dengan Kamen Rider 1, semburan api dari ujung jari, peluru beracun', 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=600&q=80', 'Prajurit cyborg tiruan ciptaan Gel-Shocker dengan syal kuning yang bertugas merusak nama baik Kamen Rider.')
        RETURNING id
      `);
      shockerId = ins.rows[0].id;
      console.log('✓ Karakter Shocker Rider No. 1 berhasil ditambahkan dengan id:', shockerId);
    } else {
      shockerId = shockerCheck.rows[0].id;
      console.log('✓ Karakter Shocker Rider No. 1 sudah ada dengan id:', shockerId);
    }

    // 4. Update data history_arcs untuk Kamen Rider Zero-One (Series ID 6)
    const zeroOneArcs = [
      {
        id: 'arc-zo-1',
        sub_title: 'I Am the President and a Kamen Rider',
        quote_text: "There's only one person who can stop you, and that's me!",
        quote_speaker: 'Aruto Hiden',
        story_paragraphs: "Kisah berawal saat Aruto Hiden, seorang pelawak tunggal yang sering gagal membuat penonton tertawa, tiba-tiba dihubungi oleh asisten AI humanoid bernama Izu. Kakeknya, Korenosuke Hiden yang merupakan pendiri sekaligus CEO Hiden Intelligence, telah wafat dan meninggalkan surat wasiat tunggal: Aruto ditunjuk sebagai CEO generasi kedua sekaligus satu-satunya orang yang berhak mengoperasikan Hiden Zero-One Driver.\n\nDi saat bersamaan, robot Humagear pengelola taman hiburan diretas oleh organisasi teroris siber MetsubouJinrai.net menggunakan Zetsumeriser, mengubahnya menjadi monster Berotha Magia. Menyaksikan ancaman bagi senyuman pengunjung, Aruto mengambil keputusan berani untuk mengenakan sabuk Zero-One Driver dan mengaktifkan Progrisekey Rising Hopper. Melalui loncatan tinggi dan tendangan pamungkas Rising Impact, Kamen Rider Zero-One lahir untuk melindungi masa depan manusia dan kecerdasan buatan.",
        scene_image_url: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Aruto Hiden memegang Zero-One Driver dan bersiap melakukan transformasi pertama ke dalam wujud Rising Hopper.',
        episode_reference: 'Episode 01: I am the President and a Kamen Rider'
      },
      {
        id: 'arc-zo-2',
        sub_title: 'Dawn of MetsubouJinrai.net & Three-Way Conflict',
        quote_text: "Humagear are not tools of destruction. They are humanity's dreams!",
        quote_speaker: 'Aruto Hiden',
        story_paragraphs: "Horobi dan Jin mulai menyebarkan teror siber secara terbuka dari markas mereka di Daybreak Town. Operasi mereka bertujuan mengorbankan Humagear demi membangkitkan satelit kecerdasan buatan 'Ark' yang tenggelam 12 tahun lalu.\n\nPemerintah mengerahkan unit militer A.I.M.S. yang dipimpin oleh Isamu Fuwa (Kamen Rider Vulcan) dan penasihat teknis Yua Yaiba (Kamen Rider Valkyrie). Fuwa, yang memendam kebencian mendalam kepada Humagear akibat tragedi Daybreak, kerap berselisih ideologi dengan Aruto. Namun melalui pertempuran berulang, Aruto membuktikan bahwa Humagear memiliki potensi untuk bermimpi dan memiliki hati nurani sendiri jika dibimbing dengan kasih sayang.",
        scene_image_url: 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Kekacauan di pusat kota akibat sinyal peretasan satelit Ark oleh MetsubouJinrai.net.',
        episode_reference: 'Episode 04-16: MetsubouJinrai Arc'
      },
      {
        id: 'arc-zo-3',
        sub_title: 'ZAIA Enterprise Takeover & The Ark Awakens',
        quote_text: '1000% is my definitive calculation of human superiority.',
        quote_speaker: 'Gai Amatsu',
        story_paragraphs: "Ketenangan kota kembali terusik dengan kehadiran Gai Amatsu, presiden ZAIA Enterprise Japan sekaligus pemilik wujud emas Kamen Rider Thouser. Gai menantang Hiden Intelligence dalam kompetisi lima babak 'Workplace Competition' untuk membuktikan keunggulan alat pemikir manusia ZAIASpec dibandingkan Humagear.\n\nPersaingan ini memuncak pada akuisisi paksa Hiden Intelligence oleh ZAIA. Namun tanpa disadari Gai, rasa kebencian yang ditanamkan dalam sistem AI memicu kebangkitan satelit Ark seutuhnya. Ark mengambil alih tubuh Horobi dan memanifestasikan dirinya sebagai entitas teror mengerikan: Kamen Rider Ark-Zero.",
        scene_image_url: 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Ark mulai memanifestasikan kehendak kebenciannya melalui terminal satelit Daybreak.',
        episode_reference: 'Episode 17-35: ZAIA Enterprise Conflict'
      },
      {
        id: 'arc-zo-4',
        sub_title: 'Despair, Ark-One, and The Final Smile',
        quote_text: 'No matter how deep the grief, humanity and Humagear will walk together towards the future.',
        quote_speaker: 'Aruto Hiden',
        story_paragraphs: "Tragedi terbesar melanda ketika Horobi menghancurkan Izu hingga tak bersisa. Kehilangan sosok pendamping yang paling dicintainya membuat Aruto tenggelam dalam keputusasaan dan dendam yang tak terkendali. Ark memanfaatkan celah kegelapan ini untuk merasuki Aruto, melahirkan wujud terlarang: Kamen Rider Ark-One.\n\nDalam duel klimaks antara Aruto dan Horobi, kedua belah pihak menyadari bahwa membalas dendam hanya akan melipatgandakan kepedihan. Melalui pengorbanan dan percakapan batin yang tulus, Aruto melepaskan kebenciannya dan bertransformasi menjadi Kamen Rider Zero-One Realizing Hopper. Kemenangan ini bukan diraih melalui penghancuran musuh, melainkan membuka jalan baru di mana manusia dan Humagear saling berdampingan menuju masa depan yang penuh senyuman.",
        scene_image_url: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Pertarungan penentuan antara Aruto Hiden dan Horobi di bawah puing-puing kota.',
        episode_reference: 'Episode 41-45: Finale Arc - Towards the Future'
      }
    ];

    await pool.query(
      `UPDATE series SET history_arcs = $1 WHERE id = 6`,
      [JSON.stringify(zeroOneArcs)]
    );
    console.log('✓ history_arcs untuk Kamen Rider Zero-One (Series ID 6) diperbarui.');

    // 5. Update data history_arcs untuk Kamen Rider 1 (Series ID 1)
    const rider1Arcs = [
      {
        id: 'arc-kr1-1',
        sub_title: 'Kidnapping and Cybernetic Rebirth',
        quote_text: 'Shocker will not claim my soul. As long as the wind blows, Kamen Rider fights for human freedom!',
        quote_speaker: 'Takeshi Hongo',
        story_paragraphs: "Takeshi Hongo, seorang mahasiswa sains berprestasi dan pembalap motor berbakat, diculik oleh sindikat kriminal global Shocker. Di laboratorium rahasia bawah tanah, tubuhnya dibedah dan direkonstruksi menjadi prajurit cyborg berkekuatan setara belalang dengan biomekanik canggih.\n\nTepat sebelum operasi otak tahap akhir yang bertujuan mencuci pikirannya, mentornya Profesor Midorikawa berhasil meloloskan Hongo. Mengendarai sepeda motor Cyclone dan memanfaatkan turbin angin Typhoon di sabuknya, Hongo bersumpah mendedikasikan sisa hidupnya sebagai Kamen Rider untuk menghancurkan rencana keji Shocker.",
        scene_image_url: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Laboratorium bawah tanah Shocker tempat Takeshi Hongo mengalami rekonstruksi biomekanik.',
        episode_reference: 'Episode 01: The Mysterious Spider Man'
      },
      {
        id: 'arc-kr1-2',
        sub_title: 'Double Riders & Anti-Shocker Alliance',
        quote_text: 'Two hearts beating with the same wind of justice!',
        quote_speaker: 'Takeshi Hongo & Hayato Ichimonji',
        story_paragraphs: "Saat Hongo harus bertolak ke Eropa untuk mengejar cabang Shocker di luar negeri, Shocker menculik jurnalis foto Hayato Ichimonji untuk dijadikan Kamen Rider kedua. Beruntung, Hongo kembali tepat waktu untuk membebaskan Ichimonji sebelum pencucian otak selesai.\n\nKelahiran Kamen Rider 2 (Hayato Ichimonji) melahirkan duo legendaris 'Double Riders'. Bersama kelompok perlawanan rahasia Anti-Shocker Alliance, mereka membongkar konspirasi Shocker di seluruh penjuru Jepang.",
        scene_image_url: 'https://images.unsplash.com/photo-1508739773434-c26b3d09e071?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Pertemuan kembali Takeshi Hongo dan Hayato Ichimonji sebagai Double Riders.',
        episode_reference: 'Episode 14-52: Hayato Ichimonji Arc'
      },
      {
        id: 'arc-kr1-3',
        sub_title: 'Rise of the Six Shocker Riders',
        quote_text: 'They wear our face, but their souls reek of evil. Let our Double Kick show them the true power of justice!',
        quote_speaker: 'Takeshi Hongo',
        story_paragraphs: "Menyadari kekuatan Double Riders yang sulit ditandingi, Gel-Shocker menciptakan 6 prajurit tiruan identik yang disebut Shocker Riders. Mereka dipersenjatai kemampuan menyamar sempurna dengan syal kuning terang, semburan api mematikan, dan peluru beracun.\n\nPara Shocker Rider melakukan serangkaian sabotase untuk memfitnah nama baik pahlawan bertopeng. Puncaknya, keenam Shocker Rider mengepung Double Riders di atas tebing pegunungan. Melalui koordinasi batin yang sempurna, Hongo dan Ichimonji meluncurkan Rider Double Kick di udara yang meruntuhkan formasi keenam duplikat tersebut sekaligus.",
        scene_image_url: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Double Riders menghadapi formasi kepungan keenam Shocker Riders di perbukitan.',
        episode_reference: 'Episode 91-94: The Six Shocker Riders Arc'
      }
    ];

    await pool.query(
      `UPDATE series SET history_arcs = $1 WHERE id = 1`,
      [JSON.stringify(rider1Arcs)]
    );
    console.log('✓ history_arcs untuk Kamen Rider 1 (Series ID 1) diperbarui.');

    // 6. Update data history_arcs untuk Shocker Rider No. 1 (Character)
    const shocker1Arcs = [
      {
        id: 'arc-sr1-1',
        sub_title: 'Deployment',
        quote_text: 'We are the supreme creation of Gel-Shocker. The false hero shall be replaced.',
        quote_speaker: 'Shocker Rider No. 1',
        story_paragraphs: "Diciptakan langsung di markas rahasia Gel-Shocker di bawah komando Jenderal Black, Shocker Rider No. 1 diterjunkan dengan spesifikasi mekanik yang menyerupai wujud Shin Kamen Rider 1. Perbedaan mencolok terletak pada syal sutra berwarna kuning cerah, sarung tangan berlapis perak, dan sol sepatu beraksen metalik.\n\nTugas utamanya adalah mengecoh masyarakat sipil dan aparat keamanan dengan melancarkan sabotase fasilitas energi sambil berpura-pura menjadi Kamen Rider asli, menciptakan kepanikan massal dan meruntuhkan reputasi sang pahlawan bertopeng.",
        scene_image_url: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Penyusupan pertama Shocker Rider No. 1 ke fasilitas radar sipil di pinggiran kota.',
        episode_reference: 'Episode 91: Gel-Shocker Appears! Kamen Rider Assassination Plan!!'
      },
      {
        id: 'arc-sr1-2',
        sub_title: 'Anti-Shocker Alliance Ambush',
        quote_text: 'Eliminate the witnesses! The alliance ends here!',
        quote_speaker: 'Shocker Rider No. 1',
        story_paragraphs: "Saat ilmuwan dari Anti-Shocker Alliance berhasil mengamankan sebuah rekaman pita komputer berisi data struktur rahasia pimpinan Gel-Shocker, Shocker Rider No. 1 ditugaskan untuk mencegat konvoi tersebut di jalan pegunungan terpencil.\n\nDalam penyergapan itu, Shocker Rider No. 1 memperlihatkan persenjataan tersembunyi yang tidak dimiliki Kamen Rider sejati: semburan gas api bertekanan tinggi dari ujung jari sarung tangannya dan proyektil racun biokimia. Para agen aliansi tak berdaya sebelum Takeshi Hongo tiba di lokasi untuk menghentikan pembantaian.",
        scene_image_url: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Shocker Rider No. 1 menghadang konvoi pengangkut data Anti-Shocker Alliance.',
        episode_reference: 'Episode 92: The Fake Kamen Rider, A Terrible Trap'
      },
      {
        id: 'arc-sr1-3',
        sub_title: 'Rise of the Shocker Riders & The Aerial Downfall',
        quote_text: 'Six blades against two! You cannot outrun your own reflection!',
        quote_speaker: 'Shocker Rider No. 1',
        story_paragraphs: "Merasa kewalahan menghadapi duel satu lawan satu melawan Hongo, Gel-Shocker mengaktifkan lima unit tambahan: Shocker Rider No. 2 hingga No. 6, masing-masing dengan variasi warna syal yang berbeda (putih, hijau, biru, ungu, dan pink). Shocker Rider No. 1 memegang komando regu enam prajurit ini.\n\nMereka mengepung Takeshi Hongo dan Hayato Ichimonji di kawasan tebing terbuka. Keunggulan jumlah sempat membuat Double Riders terdesak parah. Namun, dengan memanfaatkan koordinasi teknik Rider Double Kick di udara bebas, Hongo dan Ichimonji berhasil menghancurkan Shocker Rider No. 1 beserta kelima saudaranya dalam satu ledakan dahsyat beruntun.",
        scene_image_url: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Barisan enam Shocker Riders saat memojokkan Double Riders di puncak tebing berbatu.',
        episode_reference: 'Episode 93-94: The Fall of the Six Shocker Riders'
      }
    ];

    await pool.query(
      `UPDATE characters SET history_arcs = $1 WHERE id = $2`,
      [JSON.stringify(shocker1Arcs), shockerId]
    );
    console.log('✓ history_arcs untuk Shocker Rider No. 1 (Character ID ' + shockerId + ') diperbarui.');

    // 7. Update data history_arcs untuk Kamen Rider Zero-One (Character ID 6)
    const arutoArcs = [
      {
        id: 'arc-aruto-1',
        sub_title: 'Inheriting the Zero-One Driver',
        quote_text: 'A president\'s job is to protect the dreams of everyone working at Hiden Intelligence!',
        quote_speaker: 'Aruto Hiden',
        story_paragraphs: "Aruto Hiden yang bermimpi menjadi komedian legendaris mendapati takdirnya berubah drastis setelah mewarisi posisi kakeknya sebagai pemimpin Hiden Intelligence. Memegang Progrisekey Rising Hopper, Aruto membuktikan integritasnya dengan bertarung di garis depan setiap kali Humagear dimanipulasi oleh virus kejahatan.",
        scene_image_url: 'https://images.unsplash.com/photo-1578632767115-351597cf2477?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Transformasi ikonik Aruto Hiden menggunakan Zero-One Driver.',
        episode_reference: 'Episode 01-03: The New CEO Arc'
      },
      {
        id: 'arc-aruto-2',
        sub_title: 'Rising Beyond Despair: Ark-One to Realizing Hopper',
        quote_text: 'Hatred will never build a future. Our power exists to bring back smiles!',
        quote_speaker: 'Aruto Hiden',
        story_paragraphs: "Kematian Izu sempat menjatuhkan Aruto ke dalam jurang kebencian terdalam, membuatnya berubah menjadi avatar keputusasaan Ark-One. Namun lewat kenangan akan impian sang kakek dan ikatan batin dengan para sahabatnya, Aruto bangkit kembali dan menciptakan wujud pamungkas Realizing Hopper demi membebaskan Horobi dan seluruh Humagear dari kutukan Ark.",
        scene_image_url: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?auto=format&fit=crop&w=1000&q=80',
        scene_caption: 'Aruto Hiden bangkit kembali dengan keyakinan baru untuk masa depan.',
        episode_reference: 'Episode 42-45: Realizing the Dream'
      }
    ];

    await pool.query(
      `UPDATE characters SET history_arcs = $1 WHERE id = 6`,
      [JSON.stringify(arutoArcs)]
    );
    console.log('✓ history_arcs untuk Aruto Hiden / Kamen Rider Zero-One (Character ID 6) diperbarui.');

    console.log('Semua migrasi dan seeding history_arcs berhasil diselesaikan!');
  } catch (err) {
    console.error('Migrasi gagal:', err.message);
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
})();
