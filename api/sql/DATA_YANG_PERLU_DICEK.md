# Data yang Perlu Dicek (Seed Kamen Rider)

Dokumen ini mencatat kolom-kolom yang memiliki perbedaan antar buku panduan resmi (guidebook/wiki) atau sengaja diisi `NULL` karena tidak ditemukan data resmi yang konsisten atau URL gambar berlisensi terbuka di Wikimedia Commons.

---

## ERA SHOWA (1971 – 1989)

### 1. Catatan Umum & Cakupan
- **Media Non-TV Series**: `Kamen Rider ZX` (TV Special 1984) serta film layar lebar/V-Cinema *Shin*, *ZO*, dan *J* (1992–1994) tidak dimasukkan ke seed ini karena cakupan tahap ini berfokus pada 9 **serial televisi (TV series)** resmi era Showa.
- **Kolom `poster` (Series) & `image` (Characters)**: Semua diisi `NULL` karena sebagian besar gambar kostum dan logo Kamen Rider di internet berstatus hak cipta/fair use (Toei/Ishimori) dan belum ditemukan URL langsung berlisensi terbuka di Wikimedia Commons untuk poster resmi tiap series/rider.

---

### 2. Kolom yang Diisi tetapi Memiliki Variasi Antar Sumber (Perlu Konfirmasi)

| Series / Karakter | Kolom | Nilai Diisi | Catatan / Variasi Sumber |
|---|---|---|---|
| **Kamen Rider 1** | `punch_power_t`, `kick_power_t`, `run_100m_s` | `15`, `22.5`, `12` | Buku panduan Showa memiliki angka berbeda antara wujud awal (*Old 1*) dan wujud pembaruan (*New 1*, misal lari 100m `12` detik vs `1.5` detik di New 1, tendangan berkisar `11.3t`–`22.5t`). |
| **Kamen Rider 2** | `punch_power_t`, `kick_power_t`, `run_100m_s` | `25`, `30`, `2` | Statistik mengacu pada data profil *Kamen Rider 2 / New 2* di Kamen Rider Wiki. |
| **Kamen Rider V3** | `height_cm`, `punch_power_t`, `kick_power_t`, `max_jump_m` | `180`, `90`, `100`, `60` | Terdapat dua versi statistik populer: profil resmi/modern (`180 cm`, `90t` pukul, `100t` tendang, `60m` lompat) dan profil alternatif/crossover (`190 cm`, `4t`, `12t`, `30m`). |
| **Kamen Rider X** | `max_jump_m`, `run_100m_s` | `28.3`, `2` | Angka mengacu pada profil utama X di Kamen Rider Wiki; beberapa buku panduan lain mencatat lompatan `35m`–`85m`. |
| **Skyrider** | `title_jp` (Series), `kick_power_t` | `仮面ライダー（新）`, `10` | Saat tayang resmi tahun 1979 berjudul *Kamen Rider (Shin)* sebelum nama *Skyrider* populer. Kekuatan tendang `10t` merujuk pada data setelah latihan peningkatan kekuatan (*Sky Kick*). |
| **Shadow Moon** | `actor` | `Takahito Horiuchi / Masaki Terasoma (Suara)` | Diperankan secara fisik (wujud manusia Nobuhiko) oleh Takahito Horiuchi dan diisi suara dalam wujud Shadow Moon oleh Masaki Terasoma. |
| **Kamen Rider Black RX** | `height_cm` | `198.8` | Beberapa referensi mencatat `198 cm` hingga `198.8 cm`. |

---

### 3. Daftar Kolom yang Diisi `NULL` (Tidak Ada Angka Resmi di Sumber)

| Series / Karakter | Kolom `NULL` | Alasan |
|---|---|---|
| **Semua Series & Karakter Showa** | `poster`, `image` | Menunggu URL gambar berlisensi terbuka dari Wikimedia Commons atau aset lokal yang diverifikasi. |
| **Riderman** | `run_100m_s` | Tidak tercantum kecepatan lari 100m resmi pada lembar data Showa utamanya. |
| **Kamen Rider X** | `height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t` | Statistik `178 cm / 70 kg / 75t / 90t` yang beredar di Wiki berasal dari versi *A.R. World (Kamen Rider Decade)*, bukan seri 1974 asli, sehingga dikosongkan (`NULL`) agar tidak rancu. |
| **Kamen Rider Amazon** | `height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t`, `run_100m_s` | Data spesifikasi metrik standar tidak dirilis secara resmi dalam seri Showa 1974 (hanya kemampuan lompat `80m` dengan gelang GiGi yang tercantum). |
| **Kamen Rider Stronger** | `height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t`, `max_jump_m`, `run_100m_s` | Lembar data resmi 1975 lebih menekankan kapasitas voltase listrik daripada angka metrik standar. |
| **Electro-Wave Human Tackle** | `height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t`, `max_jump_m`, `run_100m_s` | Tidak ada angka statistik metrik resmi di arsip Wiki/Toei. |
| **Skyrider** | `punch_power_t` | Sumber hanya mencantumkan daya cengkeram (*grip strength* `0.5t`) dan tidak merilis angka daya pukul resmi. |
| **Kamen Rider Super-1** | `kick_power_t` | Dideskripsikan secara konseptual sebagai *"Infinite / Tak Terbatas"* (berkat mekanisme anti-gravitasi) sehingga tidak dapat diisi angka `NUMERIC`. |
| **Kamen Rider Black** | `punch_power_t`, `kick_power_t`, `run_100m_s` | Data profil resmi seri 1987 tidak menyantumkan nilai tonase pukul/tendang atau waktu lari 100m secara numerik. |
| **Shadow Moon** | `max_jump_m`, `run_100m_s` | Tidak tercatat angka resmi tinggi lompatan dan waktu lari 100m pada profil utamanya. |

---

## TAHAP 3: Kronologi & Sejarah (`series_arcs` & `arc_characters`)

### 1. Catatan Umum
- **Gambar Arc (`image_url`, `image_caption`)**: Seluruh 34 arc diisi `NULL` karena tangkapan layar (*screenshot*) episode merupakan materi berhak cipta Toei Company dan tidak tersedia di Wikimedia Commons dengan lisensi terbuka. Tampilan UI otomatis merender teks secara penuh dan rapi tanpa blok gambar kosong.
- **Kutipan Dialog (`quote_text`, `quote_by`)**: Sebagian besar arc diisi `NULL` sesuai aturan ketat agar tidak mengarang dialog; blok kutipan di UI otomatis disembunyikan saat `NULL`. Hanya 2 kutipan ikonik yang sangat dikenal dan singkat yang disertakan (`Kuuga ARC 01` & `Build ARC 01`) dan tetap dapat diverifikasi.

### 2. Daftar Arc yang Ringkasan / Pembagian Episodenya Perlu Diverifikasi

| Series | Arc | Pembagian Episode | Bagian yang Perlu Dicek |
|---|---|---|---|
| **Kamen Rider (1971)** | `ARC 01` – `ARC 04` | Ep. 01–13, 14–52, 53–79, 80–98 | Pembagian episode *Old 1*, *Ichimonji*, *New 1*, dan *Gel-Shocker* disusun berdasarkan pergantian era komandan (Zol/Shinigami/Hell/Black) dan kembalinya Hiroshi Fujioka pada Episode 53. |
| **Kamen Rider Kuuga** | `ARC 01` – `ARC 04` | Ep. 01–16, 17–26, 27–38, 39–49 | Di Wiki resmi terbagi 3 arc utama (*Rebirth* 1–16, *Evolution* 17–35, *End* 36–49); di database dipecah menjadi 4 bab agar alur *Rising*, *Go-Group*, dan *Daguva* terbaca lebih jelas. Periksa juga kutipan `"Lihatlah perubahanku!"` (*Ore no henshin o miteite kudasai*). |
| **Kamen Rider Ryuki** | `ARC 01` – `ARC 04` | Ep. 01–14, 15–28, 29–40, 41–50 | Di Wiki resmi terbagi 2 arc besar (*Rider Battle* 1–28 dan *Between Battle and Wish* 29–50); di database dipecah menjadi 4 bab (awal, Ouja/Odin, Survive, penutup). |
| **Kamen Rider Den-O** | `ARC 01` – `ARC 04` | Ep. 01–18, 19–28, 29–39, 40–49 | Serial *Den-O* aslinya berbentuk mini-arc per kontrak Imagin; pembagian di database disusun berdasarkan masuknya *Zeronos* (Ep. 19–20), *Kai*, serta *Liner Form*. |
| **Kamen Rider Build** | `ARC 01` – `ARC 05` | Ep. 01–14, 15–22, 23–33, 34–41, 42–49 | Mengikuti pembagian 5 arc resmi di Kamen Rider Wiki (*Faust*, *Invasion of Hokuto*, *Invasion of Seito*, *Evolt*, *New World Creation*). Periksa apakah ringkasan tewasnya Aoba dan pengorbanan Grease/Rogue sudah sesuai keinginan tanpa terlalu banyak spoiler. |
| **Kamen Rider Zero-One** | `ARC 01` – `ARC 04` | Ep. 01–08, 09–16, 17–35, 36–45 | Menggabungkan sub-arc *Workplace Competition* & *ZAIA* ke `ARC 03` serta *Zero-Two / Ark-One* ke `ARC 04`. |
| **Kamen Rider Geats** | `ARC 01` – `ARC 05` | Ep. 01–09, 10–16, 17–24, 25–38, 39–49 | *Geats* di Wiki memiliki 7 bagian (termasuk *Daybreak* sebagai pembuka/penutup). Di sini disatukan menjadi 5 arc kronologis agar linier dari awal hingga Ep. 49. |
| **Kamen Rider Gavv** | `ARC 01` – `ARC 04` | Ep. 01–16, 17–28, 29–40, 41–50 | Di Wiki terbagi 3 arc utama (1–16, 17–28, 29–50); Arc 3 (29–50) dipecah menjadi `ARC 03` (intervensi keluarga Jaldak/Gochipod) dan `ARC 04` (babak akhir melawan Lango/Stomach Inc.). Mohon periksa detail babak akhir (Ep. 29–50) karena serial ini baru rampung Agustus 2025. |

---

## SEED DATA SHOWA — BAGIAN 1: KAMEN RIDER ERA SHOWA (`seed_showa_ultra_sentai.sql`)

### 1. Daftar Field yang Diisi dengan Catatan Khusus (Perlu Konfirmasi)
- **Kamen Rider ZX (1984)**: Format aslinya adalah 1 episode TV Special (*Birth of the 10th! Kamen Riders All Together!!*, 3 Januari 1984) sehingga `episodes = 1` dan `aired_from = aired_to = 1984-01-03`.
- **Shocker Rider No. 1**: Kolom `civilian_name` dibiarkan `NULL` karena identitas manusianya tidak dijelaskan secara individual dalam serial 1971.
- **Kamen Rider ZX (Statistik)**: Wiki resmi mencatat *Lifting Power: 1 t*, bukan daya pukul (*punch_power_t*) atau tendangan (*kick_power_t*), sehingga kedua kolom tersebut dikosongkan (`NULL`).
- **Pengisi Suara / Multi-Pemeran**:
  - `Ten-Faced Demon Gorgos`: Diisi suara oleh `Ritsuo Sawa / Ryuji Saikachi (Suara)`.
  - `General Jark`: Diisi suara oleh `Seizo Kato` (Ep. 1–44) lalu digantikan `Hidekatsu Shibata` (Ep. 45–46).

### 2. Daftar Kolom yang Sengaja Diisi `NULL`
- **`birth_date` & `agency` (Tabel `actors`)**: Dikosongkan (`NULL`) untuk pemeran yang tanggal lahir pastinya atau agensinya belum terverifikasi (seperti *Takeshi Sasaki*, *Takehisa Yamaguchi*, *Kyoko Okada*). Hanya *Hiroshi Fujioka*, *Hiroshi Miyauchi*, *Ryo Hayami*, *Toru Okazaki*, *Shigeru Araki*, *Hiroaki Murakami*, *Shunsuke Takasugi*, *Shun Sugata*, dan *Tetsuo Kurata* yang tanggal lahirnya sudah diverifikasi dari Wikipedia.
- **Statistik Tempur (`height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t`, `max_jump_m`, `run_100m_s`)**:
  - Diisi `NULL` untuk seluruh karakter non-Rider (*Ally* dan *Villain* seperti Tobei Tachibana, Colonel Zol, Apollo Geist, Gorgos, General Shadow, High Priest Darom, dll.) karena tidak ada metrik tempur standar.
  - Diisi `NULL` untuk statistik spesifik Rider Showa yang tidak tercantum di sumber tepercaya (`X`, `Amazon`, `Stronger`, `Skyrider` punch, `Super-1` kick, `Black`, `ZX` punch/kick).

### 3. Daftar Series & Karakter yang Masih Tanpa Gambar (`poster`, `image`, `photo` = `NULL`)
Semua gambar di bawah ini dibiarkan `NULL` karena belum ditemukan aset gambar berlisensi terbuka di Wikimedia Commons (siap di-upload manual via mode Admin):
- **Series (`poster = NULL`)**: Semua 10 series Kamen Rider Showa (*Kamen Rider 1971, V3, X, Amazon, Stronger, Skyrider, Super-1, ZX, Black, Black RX*).
- **Characters (`image = NULL`)**: Semua 56 karakter di 10 series Kamen Rider Showa (kecuali `Shocker Rider No. 1` jika sebelumnya sudah memiliki URL dari migrasi lama).
- **Actors (`photo = NULL`)**: Seluruh 12 entri pemeran utama baru di era Showa.

---

## KRONOLOGI ARCS — BATCH 1: KAMEN RIDER ERA SHOWA (`seed_arcs_batch1_showa.sql`)

### 1. Catatan Umum
- **Seluruh `quote_text`, `quote_by`, `image_url`, dan `image_caption`** pada Batch 1 disetel `NULL` agar tidak mengarang kutipan maupun menggunakan URL gambar non-terbuka (UI otomatis menyembunyikan kotak kutipan dan melebarkan teks dengan rapi).
- **Kamen Rider (1971)**: Menggunakan `ON CONFLICT DO NOTHING`, sehingga 4 arc yang sudah ada dari Tahap 3 tidak ditimpa, dan karakter tambahan (`Tobei Tachibana`, `Colonel Zol`, `Dr. Shinigami`, `Ambassador Hell`, `General Black`) dihubungkan ke tabel `arc_characters`.

### 2. Daftar Arc Batch 1 yang Pembagian Fase / Ringkasannya Perlu Dicek

| Series | Arc & Episode Range | Catatan untuk Verifikasi |
|---|---|---|
| **Kamen Rider V3** | `ARC 01`–`05` (Ep. 01–12, 13–30, 31–35, 36–40, 41–52) | Pembagian mengikuti pergantian 4 komandan Destron (*Doctor G*, *Baron Kiba*, *Archbishop Tsubasa*, *Marshal Armor*). Perlu dicek bahwa *Archbishop Tsubasa* aktif pada Ep. 36–40 sebelum digantikan *Marshal Armor*. |
| **Kamen Rider X** | `ARC 01`–`04` (Ep. 01–09, 10–21, 22–28, 29–35) | Pembagian fase *RS Device* antara Ep. 22–28 dan Ep. 29–35 dibuat untuk memecah paruh kedua menjadi 2 arc kronologis agar tetap terstruktur 4 arc. |
| **Kamen Rider Amazon** | `ARC 01`–`04` (Ep. 01–07, 08–13, 14–19, 20–24) | *Amazon* hanya memiliki 24 episode (2 faksi: Geddon Ep. 1–13 dan Garanda Ep. 14–24). Masing-masing faksi dibagi dua sub-fase kronologis (awal kedatangan / kejatuhan Gorgos, dan kedatangan Zero / akhir Garanda). |
| **Kamen Rider Stronger** | `ARC 01`–`04` (Ep. 01–13, 14–26, 27–33, 34–39) | Mohon periksa pembagian antara masuknya *Delzer Army* (Ep. 27), wafatnya *Tackle* (Ep. 30), *Charge Up* (Ep. 31), dan bersatunya 7 Rider (Ep. 34–39). |
| **Skyrider** | `ARC 01`–`04` (Ep. 01–17, 18–27, 28–39, 40–54) | Nomor pasti episode mulainya latihan 7 Rider dan perubahan warna kostum *Skyrider* (sekitar Ep. 28–35) perlu dicek kembali jika ingin rentang yang lebih spesifik. |
| **Kamen Rider Super-1** | `ARC 01`–`04` (Ep. 01–12, 13–23, 24–36, 37–48) | Faksi *Dogma Kingdom* berakhir di Ep. 23 dan *Jin Dogma* mulai Ep. 24; pembagian pertengahan (*12/13* dan *36/37*) adalah pembagian fase awal dan akhir masing-masing faksi. |
| **Kamen Rider ZX** | `ARC 01`–`04` (`TV Special (1984) — Fase 1..4`) | Karena *ZX* hanya berdurasi 1 episode TV Special, alurnya dibagi menjadi 4 fase kronologis berurutan (*Tragedi Amazon*, *Pertemuan Rumi & Kaido*, *Pengakuan 9 Rider*, *Penghancuran Badan*). |
| **Kamen Rider Black** | `ARC 01`–`04` (Ep. 01–17, 18–34, 35–45, 46–51) | Pembagian mengikuti debut *Bilgenia* (Ep. 18), kebangkitan penuh *Shadow Moon* (Ep. 35), dan pertempuran klimaks (Ep. 46–51). |
| **Kamen Rider Black RX** | `ARC 01`–`04` (Ep. 01–14, 15–20, 21–37, 38–47) | Pembagian mengikuti kelahiran *Roborider* (Ep. 15) & *Biorider* (Ep. 17), kembalinya *Shadow Moon* (Ep. 21–22), serta klimaks invasi Crisis (Ep. 38–47). |

### 3. Series di Database yang Belum Memiliki Arc (`arc_count = 0`)
Series berikut sengaja **belum diisi** pada Batch 1 karena masuk ke batch selanjutnya (di UI kini otomatis menampilkan blok netral *"Kronologi untuk series ini belum tersedia."*):
- **Ultraman (1966)** — Menunggu Batch 4 (Ultraman Era Showa).
- **Ultraseven (1967)** — Menunggu Batch 4 (Ultraman Era Showa).
- **Himitsu Sentai Goranger (1975)** — Menunggu Batch 4 (Super Sentai Era Showa).
- **Kyoryu Sentai Zyuranger (1992)** — Luar cakupan Era Showa & Batch 1–3.
- **Space Sheriff Gavan (1982)** — Franchise Metal Hero (belum masuk cakupan Batch 1–4).

---

## ULTRAMAN — BATCH 1: ERA SHOWA (`seed_ultraman_showa.sql` & `seed_ultraman_arcs_showa.sql`)

### 1. Ringkasan Data & Media Kosong (`NULL`)
- **Series (`poster = NULL`)**: Semua 6 series baru (*Ultra Q, The Return of Ultraman, Ultraman Ace, Ultraman Taro, Ultraman Leo, Ultraman 80*) disetel `poster = NULL`, sedangkan 2 series lama (*Ultraman* 1966 dan *Ultraseven*) mempertahankan poster eksisting lewat `COALESCE`.
- **Characters (`image = NULL`)**: Semua karakter baru di era Showa disetel `image = NULL` sampai gambar lokal ditambahkan ke `web/public/images/`.
- **`actor = NULL` (Karakter Kaiju / Robot / Alien Non-Manusia)**: Untuk kaiju dan robot (*Gomess, Garamon, Kanegon, Alien Baltan, Zetton, Alien Metron, King Joe, Twin Tail, Alien Nackle, Ace-Killer, Birdon, Alien Temperor, Tyrant, Alien Magma, Hoe, Margodon*), kolom `actor` dibiarkan `NULL` alih-alih mengarang pengisi suara/suit actor tunggal.
- **`extra_stats = NULL` (Karakter Manusia & Inang Manusia)**: Anggota tim pertahanan manusia dan *human host* (*Jun Manjome, Shin Hayata, Hideki Go, Seiji Hokuto, Yuko Minami, Kotaro Higashi*, dll.) serta *Yapool* / *Commander Black* disetel `extra_stats = NULL` agar UI menampilkan pesan ringkas tanpa angka nol palsu.
- **Arc Media & Kutipan (`NULL`)**: Seluruh `quote_text`, `quote_by`, `image_url`, dan `image_caption` pada 36 arc Showa disetel `NULL` agar tidak ada kutipan atau URL eksternal yang dikarang.

### 2. Data Statistik & Pengelompokan Arc yang Perlu Diverifikasi
| Item / Series | Field / Rentang | Catatan untuk Verifikasi |
|---|---|---|
| **Ultra Q** (Ep. 01–28) | `ARC 01`–`04` (Ep. 01–07, 08–14, 15–21, 22–28) | Karena *Ultra Q* berformat antologi misteri lepas, 4 arc dikelompokkan berdasarkan fase tematik dan debut monster ikonik (*Gomess, Garamon, Kanegon, Kemur Man*). |
| **Ultraman (1966)** (Ep. 01–39) | `ARC 01`–`04` (Ep. 01–10, 11–21, 22–32, 33–39) | Pengelompokan kronologis berbasis episode tonggak (*Baltan Ep. 2 & 16, Gomora Ep. 26–27, Zetton Ep. 39*). |
| **Ultraseven** (Ep. 01–49) | `ARC 01`–`04` (Ep. 01–13, 14–25, 26–39, 40–49) | Pengelompokan kronologis berbasis tonggak (*Alien Metron Ep. 8, King Joe Ep. 14–15, Alien Guts, Pandon Ep. 48–49*). |
| **The Return of Ultraman** | *Aki Sakata* (`debut_episode`), *Twin Tail* & *Alien Nackle* (`extra_stats`) | `extra_stats` kaiju hanya diisi tinggi & berat standar (*50 m / 45.000 ton*, dll.) apabila tersedia konsisten di referensi wiki. |
| **Ultraman Ace** | `ARC 01`–`05` (Ep. 01–12, 13–25, 26–28, 29–43, 44–52) | Pembagian memisahkan *Planet Golgotha / Ace-Killer* (Ep. 13–14), *Alien Hipporit & Kepergian Yuko Minami* (Ep. 26–28), dan perjuangan tunggal *Hokuto*. |
| **Ultraman Taro** | `ARC 01`–`05` (Ep. 01–16, 17–24, 25–39, 40–47, 48–53) | Memisahkan *Teror Birdon* (Ep. 17–19), *Alien Temperor* (Ep. 33–34), *Tyrant* (Ep. 40), dan *Alien Valky* (Ep. 53). |
| **Ultraman Leo** | `ARC 01`–`05` (Ep. 01–13, 14–29, 30–39, 40–45, 46–51) | Memisahkan debut *Astra* (Ep. 22) & *Ultraman King* (Ep. 26), konflik *Ultra Key* (Ep. 38–39), dan kehancuran *MAC* / *Commander Black* (Ep. 40–51). |
| **Ultraman 80** | *Yullian* (`extra_stats`), `ARC 01`–`04` | Perubahan fokus cerita dari latar guru SMP Sakuragaoka ke operasi penuh waktu UGM diletakkan pada batas Ep. 13/14; mohon cek kembali jika ada preferensi pemisahan episode lain. |

---

## METAL HERO — BATCH 1: ERA SHOWA (`seed_metalhero_sentai_batch1.sql` & `seed_metalhero_sentai_arcs_batch1.sql`)

### 1. Ringkasan Data & Field `NULL`
- **Series (`poster = NULL`)**: Ketujuh series Metal Hero Showa (*Space Sheriff Gavan, Space Sheriff Sharivan, Space Sheriff Shaider, Kyojuu Tokusou Juspion, Jikuu Senshi Spielban, Choujinki Metalder, Sekai Ninja Sen Jiraiya*) belum memiliki poster (`NULL`) untuk diisi foto lokal di `web/public/images/`.
- **Space Sheriff Gavan (`synopsis`)**: Karena kolom `synopsis` eksisting tidak bernilai `NULL` (berisi kalimat singkat bawaan awal), `COALESCE` dipertahankan agar tidak menimpa data yang berpotensi sudah diedit manual.
- **Characters (`image = NULL`) & Actors (`photo = NULL`)**: Seluruh karakter baru serta 6 entri baru di tabel `actors` (melengkapi `Kenji Ohba` yang sudah ada) disetel tanpa URL gambar (`NULL`).
- **`actor = NULL` (*Springer*)**: Pengisi suara *Springer* di *Choujinki Metalder* disetel `NULL` karena belum terverifikasi lintas sumber resmi.
- **`debut_episode = NULL` (Karakter Pertengahan Seri)**: *San Doruba*, *Queen Kiba*, *Boomerang*, *Mad Gallant*, *Helen Lady*, *Doctor Bio*, *Top Gunder*, *Kinin Reiha*, dan *Space Ninja Demost* dibiarkan `NULL` agar tidak mengarang nomor episode debutnya.
- **`extra_stats = NULL` (Karakter Pendukung / Penjahat)**: Statistik teknis (`Tinggi`, `Berat`, dll.) hanya diisi untuk karakter utama dengan spesifikasi terverifikasi; karakter pendukung & antagonis disetel `NULL`.
- **Arc Media & Kutipan (`NULL`)**: Seluruh `quote_text`, `quote_by`, `image_url`, dan `image_caption` pada 28 arc Showa Metal Hero disetel `NULL`.

### 2. Data & Pembagian Fase Arc yang Perlu Diverifikasi
| Series | Field / Rentang Arc | Catatan untuk Verifikasi |
|---|---|---|
| **Space Sheriff Gavan** (Ep. 01–44) | `ARC 01`–`04` (Ep. 01–14, 15–29, 30–39, 40–44) | Nomor episode persis pergantian *Hunter Killer* oleh *San Doruba & Queen Kiba* (sekitar Ep. 30) serta episode penebusan *Hunter Killer* (menjelang Ep. 40–44) perlu dicek kembali. |
| **Space Sheriff Sharivan** (Ep. 01–51) | `ARC 01`–`04` (Ep. 01–15, 16–30, 31–44, 45–51) | Pengelompokan fase berdasar transisi awal *Madou*, pengungkapan *Planet Iga / Kristal Iga*, intrik *Gyrer–Polter*, dan serbuan akhir ke *Istana Genmu*. |
| **Space Sheriff Shaider** (Ep. 01–49) | `ARC 01`–`04` (Ep. 01–13, 14–28, 29–42, 43–49) | Pembagian mengikuti fase perkenalan *Fuuma*, riset *Kekaisaran Mu*, operasi *Priest Poe*, dan klimaks *Kublai* + reuni 3 Space Sheriff (Ep. 48–49). |
| **Kyojuu Tokusou Juspion** (Ep. 01–46) | `ARC 01`–`04` (Ep. 01–12, 13–28, 29–39, 40–46) | Memisahkan pengembaraan awal + *Boomerang*, pencarian 5 anak *Burung Emas*, wujud sejati *Satan Gorth*, hingga duel akhir *Mad Gallant* (Ep. 45) & *Satan Gorth* (Ep. 46). |
| **Jikuu Senshi Spielban** (Ep. 01–44) | `ARC 01`–`04` (Ep. 01–12, 13–23, 24–36, 37–44) | Mengikuti titik belok kedatangan *Emperor Guillotine* (Ep. 24), konflik *Helen/Doctor Bio*, dan serbuan final ke *Kastel Waller* (Ep. 43–44). |
| **Choujinki Metalder** (Ep. 01–39) | `ARC 01`–`04` (Ep. 01–10, 11–22, 23–33, 34–39) | Memisahkan kebangkitan *Metalder* & wafatnya Dr. Koga, gempuran 4 divisi *Neros*, pembelotan *Top Gunder*, hingga kejatuhan *Ghost Bank* (Ep. 38–39). |
| **Sekai Ninja Sen Jiraiya** (Ep. 01–50) | `ARC 01`–`04` (Ep. 01–14, 15–28, 29–41, 42–50) | Nomor pasti episode debut *Kinin Reiha*, *Jiraishin*, dan *Space Ninja Demost* pada fase tengah seri dapat disesuaikan kembali bila ada referensi episode lebih rinci. |

---

## STATISTIK FISIK & PROFIL — KAMEN RIDER BATCH 1: ERA SHOWA (`seed_profile_stats_kamenrider_batch1_showa.sql`)

### 1. Ringkasan Cakupan Batch 1 (56 Karakter Era Showa)
- **Di-`UPDATE` (33 baris karakter Showa)**:
  - **10 Rider lama** yang sudah memiliki `height_cm`/`weight_kg` (`Kamen Rider 1, 2, V3, Riderman, Skyrider, Super-1, ZX, Black, Shadow Moon, Black RX`) dilengkapi kolom profil `NULL` (`age_text`, `origin`, `occupation`, `species`, `team`, `stats_note`, plus pukulan/tendangan/lari 100 m milik `Black`).
  - **5 Rider / Heroine / Evil Rider** yang sebelumnya `height_cm = NULL` (`Kamen Rider X, Kamen Rider Amazon, Kamen Rider Stronger, Electro-Wave Human Tackle, Shocker Rider No. 1`) kini terisi spesifikasi bentuk dasar & profil lengkap.
  - **18 baris Sekutu (`Ally`)** (13 tokoh unik: `Tobei Tachibana` di 5 series, `Genjiro Tani` di 2 series, `Junko Tama`, `Keitaro Jin`, `Mogura Beastman`, `Dr. Keitaro Shido`, `Master Genkai`, `Rumi Ichijo`, `Dr. Hajime Kaido`, `Kyoko Akizuki`, `Katsumi Kida`, `Reiko Shiratori`, `Joe the Haze`) diisi profil kanon (`origin`, `occupation`, `species`, `team`, `age_text` jika ada, `stats_note`) **tanpa** mengisi `height_cm`/`weight_kg` agar tidak memakai ukuran aktor.
- **Dilewati (23 baris `Villain` Showa)**: Seluruh jenderal dan tokoh antagonis era Showa tanpa statistik fisik baku resmi (*Colonel Zol, Dr. Shinigami, Ambassador Hell, General Black, Doctor G, Marshal Armor, Apollo Geist, King Dark, Ten-Faced Demon Gorgos, Zero Great Emperor, Hitotsume Titan, General Shadow, General Monster, Admiral Majin, Emperor Terror Macro, General Megarl, Ambassador Darkness, Generalissimo of Badan, High Priest Darom, High Priest Baraom, Sword Saint Bilgenia, General Jark, Commander Bosgun*) dibiarkan `NULL` sesuai aturan prioritas.
- **Menunggu Batch Berikutnya**: Era Heisei (*Kuuga, Ryuki, Den-O, Build*) masuk ke **Batch 2**, dan Era Reiwa (*Zero-One, Geats, Gavv*) masuk ke **Batch 3**.

### 2. Data Era Showa yang Memiliki Variasi / Perlu Dicek
| Karakter | Field / Nilai Terisi | Alasan / Catatan Verifikasi |
|---|---|---|
| **Kamen Rider X** | `punch_power_t = 75`, `kick_power_t = 90`, `max_jump_m = 85`, `run_100m_s = 2` | Angka pukulan/tendangan *X* di databook era modern/crossover (75 t / 90 t) jauh lebih tinggi dibanding era Showa awal; loncatan juga berkisar 28,3 m (awal) hingga 85 m (pasca *Mercury Circuit*). |
| **Kamen Rider Amazon** | `punch_power_t = 25`, `kick_power_t = 30`, `max_jump_m = 80`, `run_100m_s = 0.9` | Angka diambil dari ringkasan Kamen Rider Wiki / NamuWiki (loncatan vertikal 80 m vs horizontal 50 m); mohon verifikasi ulang bila menginginkan edisi buku data Showa lama. |
| **Kamen Rider Stronger** | `height_cm = 183`, `weight_kg = 78`, kemampuan tempur `NULL` | Tinggi & berat diambil dari *Kamen Rider Zukan* resmi Toei (`kamen-rider-official.com`). Halaman wiki tidak mencantumkan angka ton pukulan/tendangan resmi sehingga dibiarkan `NULL`. |
| **`blood_type` = `NULL`** | Seluruh 56 karakter era Showa | Tidak ada karakter Showa yang mencantumkan golongan darah resmi di profil kanonnya, sehingga dibiarkan `NULL`. |
| **Sekutu (`Ally`, 18 baris)** | `height_cm` & `weight_kg` = `NULL` | Karakter pendukung non-tempur tidak memiliki spesifikasi tinggi/berat kanon fiksi yang terpisah dari pemeran aslinya, sehingga sengaja dibiarkan `NULL`. |

---

## STATISTIK FISIK & PROFIL — KAMEN RIDER ERA HEISEI AWAL (`seed_profile_stats_kamenrider_heisei_awal.sql`)

### 1. Ringkasan Cakupan (Heisei Awal: Kuuga–Decade)
- **Kondisi Database**: Pada database saat ini hanya terdapat **3 series** dan **3 karakter** era Heisei awal (`Kamen Rider Kuuga`, `Kamen Rider Ryuki`, `Kamen Rider Den-O`). Series Heisei awal lainnya (*Agito, Faiz, Blade, Hibiki, Kabuto, Kiva, Decade*) belum terdaftar di database sehingga tidak ada baris untuk di-`UPDATE`.
- **Di-`UPDATE` (3 karakter)**: Ketiganya sebelumnya memiliki `height_cm = NULL` serta kolom profil `NULL`, dan seluruhnya berhasil diisi menggunakan `UPDATE` + `COALESCE`.
- **Dilewati (`0` karakter di DB)**: Tidak ada karakter *Heisei Awal* lain yang tersisa di tabel `characters`.

### 2. Data Era Heisei Awal yang Memiliki Catatan Khusus
| Karakter | Field / Nilai Terisi | Catatan untuk Verifikasi |
|---|---|---|
| **Kamen Rider Kuuga** | `Mighty Form` (200 cm, 99 kg, 3 t / 10 t, 15 m, 5.2 dtk), `blood_type = 'O'` | Memakai bentuk dasar utama **Mighty Form** (tendangan biasa 10 ton; jurus pamungkas *Mighty Kick* 30 ton dicatat di `stats_note`). |
| **Kamen Rider Ryuki** | `Base Form` (190 cm, 90 kg, 10 t / 20 t, 35 m, 5 dtk), `blood_type = 'B'` | Angka ton dikonversi sesuai keterangan Kamen Rider Wiki (`200 AP = 10 ton`, `400 AP = 20 ton`). Golongan darah `B` merujuk materi panduan/crossover di wiki dan mohon diverifikasi ulang bila dirasa kurang konklusif. |
| **Kamen Rider Den-O** | `Sword Form` (190 cm, 87 kg, 5 t / 7 t, 35 m, 5.2 dtk), `blood_type = NULL` | Memakai bentuk utama **Sword Form** (bukan *Plat Form* 180 cm / 80 kg yang dicantumkan sebagai pembanding di `stats_note`). Golongan darah Ryotaro Nogami tidak tercantum resmi di sumber sehingga dibiarkan `NULL`. |

---

## STATISTIK FISIK & PROFIL — KAMEN RIDER ERA HEISEI AKHIR (`seed_profile_stats_kamenrider_heisei_akhir.sql`)

### 1. Ringkasan Cakupan (Heisei Akhir: W–Zi-O)
- **Kondisi Database**: Pada database saat ini hanya terdapat **1 series** dan **1 karakter** era Heisei akhir (`Kamen Rider Build`, 2017). Series Heisei akhir lainnya (*W, OOO, Fourze, Wizard, Gaim, Drive, Ghost, Ex-Aid, Zi-O*) belum terdaftar di tabel `series` sehingga tidak ada baris untuk di-`UPDATE`.
- **Di-`UPDATE` (1 karakter)**: `Kamen Rider Build` (sebelumnya `height_cm = NULL` serta seluruh kolom profil `NULL`).
- **Dilewati (`0` karakter di DB)**: Tidak ada karakter *Heisei Akhir* lain yang tersisa di tabel `characters`.

### 2. Data Era Heisei Akhir yang Memiliki Catatan Khusus
| Karakter | Field / Nilai Terisi | Catatan untuk Verifikasi |
|---|---|---|
| **Kamen Rider Build** | `RabbitTank Form` (196 cm, 99 kg, pukulan `17` t, tendangan `23.7` t, lompatan `55` m, 100 m `2.9` dtk), `blood_type = 'AB'` | Spesifikasi TV Asahi resmi untuk *RabbitTank Form* bersifat asimetris: lengan kanan **9,9 t** / lengan kiri **17,0 t** dan kaki kanan **23,7 t** / kaki kiri **17,8 t**. Kolom numerik diisi nilai puncak per sisi dan perbedaan kiri/kanannya dijelaskan di `stats_note`. Usia diisi `"Awal 20-an tahun"` mengikuti usia biologis tubuh Takumi Katsuragi/Sento Kiryu tanpa mengarang angka eksak pasca-amnesia. |

---

## STATISTIK FISIK & PROFIL — KAMEN RIDER ERA REIWA (`seed_profile_stats_kamenrider_reiwa.sql`)

### 1. Ringkasan Cakupan (Reiwa: Zero-One–Terbaru di DB)
- **Kondisi Database**: Pada database saat ini terdapat **3 series** dan **3 karakter** era Reiwa (`Kamen Rider Zero-One`, `Kamen Rider Geats`, `Kamen Rider Gavv`), seluruhnya dengan `height_cm = NULL` dan kolom profil `NULL`. Series Reiwa lain (*Saber, Revice, Gotchard*, dll.) belum terdaftar di tabel `series` sehingga tidak ada baris untuk di-`UPDATE`.
- **Di-`UPDATE` (3 karakter)**: `Kamen Rider Zero-One`, `Kamen Rider Geats`, `Kamen Rider Gavv`.
- **Dilewati (`0` karakter di DB)**: Tidak ada karakter era Reiwa lain yang tersisa di tabel `characters`.

### 2. Data Era Reiwa yang Memiliki Catatan Khusus
| Karakter | Field / Nilai Terisi | Catatan untuk Verifikasi |
|---|---|---|
| **Kamen Rider Zero-One** | `Rising Hopper Form` (196.5 cm, 87 kg, 8.4 t / 49 t, 60.1 m, 4.1 dtk), `blood_type = NULL` | Seluruh spesifikasi fisik *Rising Hopper* terverifikasi identik antara TV Asahi resmi dan Kamen Rider Wiki. Golongan darah Aruto Hiden tidak tercantum resmi sehingga dibiarkan `NULL`. |
| **Kamen Rider Geats** | `MagnumBoost Form` (205.2 cm, 88.7 kg, `2.4` t / 58.5 t, 78 m, 2.7 dtk), `blood_type = NULL` | Halaman resmi TV Asahi mencantumkan daya pukulan **2,4 t** (kontribusi bagian atas *Magnum*, sementara beberapa ringkasan wiki menyebut angka varian `23,4 t`); nilai resmi TV Asahi `2.4` digunakan di sini. Detail *Entry Form* (78 kg, 1,8 t / 4,5 t) tercantum di `stats_note`. |
| **Kamen Rider Gavv** | `Poppingummy Form` (192.9 cm, 72.3 kg, 1 t / 2 t, 4.2 m, 7.6 dtk), `blood_type = NULL` | Spesifikasi dasar *Poppingummy Form* terverifikasi identik di TV Asahi dan Kamen Rider Wiki. Usia Shoma diisi perkiraan umum dari sumber (`Awal 20-an tahun`) dan golongan darah dibiarkan `NULL`. |

---

## KAMEN RIDER HEISEI — TAHAP 1: 2000–2008 (`seed_heisei_1.sql`)

### 1. Ringkasan Field `NULL` & Media
- **Media (`poster`, `image`, `photo` = `NULL`)**: Seluruh 6 series baru (*Agito, 555, Blade, Hibiki, Kabuto, Kiva*), 60 karakter baru, serta 13 pemeran baru di tabel `actors` disetel tanpa URL gambar (`NULL`), sedangkan data lama (*Kuuga, Ryuki, Den-O*) mempertahankan medianya lewat `COALESCE`.
- **Statistik Fisik (`height_cm`, `weight_kg`, dll. = `NULL`)**: Sengaja belum diisi pada karakter baru di Tahap 1 sesuai instruksi (pengisian statistik fisik dilakukan terpisah).
- **`debut_episode = NULL`**: Karakter yang debut episode pastinya belum terkonfirmasi eksplisit dari kutipan sumber (*N-Daguva-Zeba, Overlord of Darkness, Zolda, Ohja, Goro Yura, Shiro Kanzaki, Delta, Kyoji Murakami, Kitazaki, Leangle, Hiroshi Tennoji, Ibuki, Todoroki, Akira Amami, Drake, Sasword, Reiji Nogi, Urataros, Kintaros, Ryutaros, Kai, Saga, King (1986), Bishop*) dibiarkan `NULL` alih-alih mengarang nomor episode.
- **Kanji Pemeran (`actors.kanji = NULL`)**: Enam aktor pemeran pendukung (*Satoshi Matsuda, Kohei Murakami, Kosei Amano, Yuki Sato, Yuichi Nakamura, Keisuke Kato*) dibiarkan `kanji = NULL` karena belum diambil langsung dari sumber bertulisan kanji.

### 2. Data yang Perlu Dicek Kembali
| Item / Series | Field | Catatan untuk Verifikasi |
|---|---|---|
| **Kamen Rider IXA** (*Kiva*) | `debut_episode = 'Episode 13'` | Merujuk debut kronologis prototipe Ixa System di lini waktu 1986; bila yang dimaksud adalah debut Keisuke Nago sebagai IXA modern (2008), perlu dicek episode awal kemunculannya. |
| **Yuji Kiba** (*Kamen Rider 555*) | `role = 'Ally'` | *Yuji Kiba* adalah karakter kompleks (*Horse Orphnoch* yang berjuang membela koeksistensi namun sempat berseberangan dengan Takumi); dikategorikan `Ally` untuk mencerminkan peran utamanya sebagai rekan sekaligus tokoh sentral kedua. |
| **Kamen Rider Ohja & Shiro Kanzaki** (*Ryuki*) | `role = 'Villain'` | Dalam *Rider War*, tokoh antagonis sentral berupa Rider saingan (*Ohja*) dan kreator perang (*Shiro Kanzaki*) dimasukkan sebagai `Villain`. |
| **Tahap 2 (2009–2019)** | Series *Decade*–*Zi-O* | Telah dikerjakan di `seed_heisei_2.sql` (lihat bagian di bawah). |

---

## KAMEN RIDER HEISEI — TAHAP 2: 2009–2019 (`seed_heisei_2.sql`)

Ringkasan isi SQL: **11 series baru** (*Decade*, *W*, *OOO*, *Fourze*, *Wizard*, *Gaim*, *Drive*, *Ghost*, *Amazons*, *Ex-Aid*, *Zi-O*) + **1 series yang sudah ada diperkaya** (*Kamen Rider Build* via `COALESCE`), **70 karakter baru** + **1 karakter yang sudah ada diperkaya** (*Kamen Rider Build*), serta **24 entri pemeran (`actors`) baru** (+ `Atsuhiro Inukai` yang sudah ada).

| Item / Entitas | Kolom `NULL` / Catatan | Keterangan |
|---|---|---|
| **Media seluruh entri Tahap 2** (11 series baru, 70 karakter baru, 24 aktor baru) | `poster`, `image`, `photo` = `NULL` | Sesuai aturan untuk tidak menebak URL gambar; data *Kamen Rider Build* yang sudah ada tetap dipertahankan via `COALESCE`. |
| **Statistik fisik & profil seluruh karakter Tahap 2** | `height_cm`, `weight_kg`, `punch_power_t`, `kick_power_t`, `max_jump_m`, `run_100m_s`, `age_text`, `origin`, `occupation`, `blood_type`, `stats_note` = `NULL` | Sengaja tidak diisi pada skrip `seed_heisei_2.sql` sesuai instruksi tahap ini. |
| **Kamen Rider Amazons** (2016) | `aired_to` = `NULL` | Ditayangkan lewat streaming dalam 2 musim (total 26 episode, mulai 2016-04-01); tanggal tayang akhir Season 2 belum terkonfirmasi langsung pada hasil pencarian sehingga `aired_to` dibiarkan `NULL`. |
| **Kamen Rider G** (2009) | Tidak dimasukkan ke `series` | Merupakan parodi spesial TV 1 episode (*SmaSTATION*, 31 Januari 2009), bukan series utama Kamen Rider. |
| **16 karakter dengan `debut_episode = NULL`** | `debut_episode` = `NULL` | Terdiri dari: *Kamen Rider Diend*, *Apollo Geist*, *Kiyoto Maki*, *Sagittarius Zodiarts*, *Rosyuo*, *Kamen Rider Specter*, *Kamen Rider Necrom*, *Adel*, *Kamen Rider Brave*, *Kamen Rider Snipe*, *Kamen Rider Lazer*, *Kamen Rider Cronus*, *Kamen Rider Cross-Z*, *Kamen Rider Grease*, *Kamen Rider Rogue*, dan *Evolto*. Perlu verifikasi nomor episode debut masing-masing bila ingin dilengkapi. |
| **11 aktor dengan `kanji = NULL`** | `actors.kanji` = `NULL` | Terdiri dari: *Kimito Totani*, *Hiroaki Iwanaga*, *Ryo Yoshizawa*, *Tasuku Nagase*, *Yutaka Kobayashi*, *Ryosuke Yamamoto*, *Tom Fujita*, *Masashi Taniguchi*, *Toshiki Seto*, *Eiji Akaso*, dan *Gaku Oshida*. (13 aktor baru lainnya terisi kanji terverifikasi: *Masahiro Inoue*, *Renn Kiriyama*, *Masaki Suda*, *Minehiro Kinomoto*, *Shu Watanabe*, *Sota Fukushi*, *Shunya Shiraishi*, *Gaku Sano*, *Ryoma Takeuchi*, *Yu Inaba*, *Shun Nishime*, *Hiroki Iijima*, *So Okuno*). |
| **Philip** (*Kamen Rider W*) | `role = 'Main Rider'` | Ditempatkan bersama *Shotaro Hidari* (`Kamen Rider W`) sebagai `Main Rider` karena keduanya bergabung membentuk satu sosok Kamen Rider W. |
| **Phoenix** (*Kamen Rider Wizard*) | `actors` = `Atsumi` | Dikreditkan di Wikipedia sebagai *Atsumi*. |

---

## KRONOLOGI ARCS KAMEN RIDER HEISEI — TAHAP 1: 2000–2008 (`seed_arcs_heisei_1.sql`)

Ringkasan isi SQL: **27 arc baru** untuk **6 series** era Heisei 2000–2008 yang memiliki `0` arc (*Agito*: 5 arc, *555*: 5 arc, *Blade*: 4 arc, *Hibiki*: 4 arc, *Kabuto*: 4 arc, *Kiva*: 5 arc). Series *Kuuga* (4 arc), *Ryuki* (4 arc), dan *Den-O* (4 arc) dilewati karena sudah terisi, sedangkan Tahap 2 (2009–2019: *Decade*–*Zi-O* kecuali *Build*) menunggu konfirmasi pengguna.

| Item / Series | Kolom / Bagian | Keterangan |
|---|---|---|
| **Kutipan & Gambar seluruh 27 arc** | `quote_text`, `quote_by`, `image_url`, `image_caption` = `NULL` | Sengaja diisi `NULL` karena belum ada kutipan pendek terverifikasi verbatim per arc maupun URL Wikimedia Commons berlisensi terbuka yang diverifikasi. |
| **Kamen Rider Agito** (51 ep, 5 arc) | `episode_range` sub-arc (`01–13`, `14–25`, `26–36`, `37–43`, `44–51`) | Wikipedia tidak memiliki artikel daftar episode mandiri untuk *Agito*; batas arc disusun berdasarkan titik balik terverifikasi dari Kamen Rider Wiki (`G3-X` Ep. 14, `Trinity Form` Ep. 26, `Burning Form` Ep. 34, `Another Agito` Ep. 35, `Shining Form` TV Ep. 37, `Akatsuki` Ep. 42, kekalahan `El of Water` Ep. 42–43). Perlu pengecekan bila ingin menyelaraskan batas episode penutup. |
| **Kamen Rider Hibiki** (48 ep, 4 arc) | `episode_range` sub-arc (`01–14`, `15–29`, `30–39`, `40–48`) | Sumber Kamen Rider Wiki membagi *Hibiki* menjadi 2 arc besar (`01–29` dan `30–48`); agar menjadi 4 arc, masing-masing paruh dibagi di titik debut/peristiwa terverifikasi (`Ibuki` Ep. 07, `Zanki`/`Todoroki` Ep. 15–16, `Kurenai` Ep. 24, `Kyosuke` Ep. 30, `Armed Hibiki` Ep. 33, `Orochi` Ep. 40, `Zanki` gugur Ep. 45). |
| **Kamen Rider Kabuto** (49 ep, 4 arc) | `episode_range` sub-arc (`01–14`, `15–24`, `25–38`, `39–49`) | Sumber Kamen Rider Wiki membagi *Kabuto* menjadi 2 arc besar (`01–24` dan `25–49`); dipecah menjadi 4 arc berdasarkan debut/titik balik terverifikasi (`TheBee` Ep. 06, `Drake` Ep. 11–12, `Sasword` Ep. 19, `Gatack` Ep. 21, `Hyper Form` Ep. 28/34, `Hell Brothers` Ep. 35, `Red Shoes` Ep. 36, `Dark Kabuto` Ep. 39, `Reiji Nogi` Ep. 41). |
| **Kamen Rider Kiva** (48 ep, 5 arc) | `episode_range` sub-arc (`01–14`, `15–24`, `25–33`, `34–43`, `44–48`) | Sumber membagi *Kiva* menjadi 3 arc besar (`01–24`, `25–43`, `44–48`); dua arc besar pertama dibagi di titik `Checkmate Four` (Ep. 15) dan debut `Kamen Rider Saga` (Ep. 33) agar menjadi 5 arc. |
| **Keterkaitan `arc_characters` terbatas pada karakter yang ada di DB** | Tokoh pendukung di luar daftar `characters` saat ini | Tokoh yang disebut dalam alur seperti *Kaoru Kino / Another Agito* (*Agito*), *Zanki* & *Kyosuke Kiriya* (*Hibiki*), *TheBee*, *KickHopper*, *PunchHopper*, *Dark Kabuto* (*Kabuto*), serta *Maya* (*Kiva*) belum memiliki baris di `characters` sehingga tidak ditautkan ke `arc_characters`. |

---

## STATISTIK FISIK & PROFIL KAMEN RIDER HEISEI — TAHAP 1: 2000–2008 (`seed_profile_stats_kamenrider_heisei_1.sql`)

Ringkasan isi SQL: **60 perintah `UPDATE`** berbasis `COALESCE` untuk seluruh karakter Heisei `2000–2008` yang kolom `height_cm`-nya masih `NULL` (sedangkan `Kamen Rider Kuuga`, `Kamen Rider Ryuki`, dan `Kamen Rider Den-O` sudah terisi dan dilewati; Tahap 2 `2009–2019` menunggu konfirmasi pengguna).

| Karakter / Kelompok | Kolom / Angka | Catatan / Hal yang Perlu Dicek |
|---|---|---|
| **Kamen Rider Hibiki** | `height_cm = 222` | Sedikit di atas rentang wajar kostum Rider (`170–220 cm`), tetapi sesuai dengan statistik resmi wujud dasar Oni di Kamen Rider Wiki. |
| **Reiji Nogi** (*Kabuto*) | `height_cm = 228` | Di atas `220 cm` karena memakai spesifikasi kostum monster *Cassis Worm Dimidius* (`139 kg`; mode *Gladius* `147 kg`, *Clipeus* `154 kg`). |
| **Bishop** (*Kiva*) | `height_cm = 245` | Di atas `220 cm` karena memakai spesifikasi wujud monster *Swallowtail Fangire* (`95 kg`). |
| **King (1986) & Otoya Kurenai** (*Kiva*) | `max_jump_m = 250`, `run_100m_s = 1.2` | Nilai lompatan (`250 m`) dan kecepatan lari (`1.2 dtk`) sangat ekstrem dibanding Rider lain, namun merupakan spesifikasi resmi *Kamen Rider Dark Kiva*. Untuk *King (1986)*, wujud monster *Bat Fangire* tercatat `232 cm / 127 kg`; untuk *Otoya*, sistem *Ixa 1986 Save Mode* tercatat `218 cm / 160 kg`. |
| **Kamen Rider Todoroki** (*Hibiki*) | `height_cm = 212.1`, `weight_kg = 157.5`, `max_jump_m = 69.1` | Menggunakan konversi metrik resmi dari satuan tradisional Jepang (*7 shaku*, *42 kan*, *38 ken*) pada profil Kamen Rider Wiki. |
| **Kamen Rider Zolda** (*Ryuki*) | `height_cm = 192` | Sebagian rujukan kontinuitas menulis `187 cm`, sedangkan ringkasan profil Kamen Rider Wiki mencantumkan `192 cm / 110 kg`. |
| **Momotaros, Urataros, Kintaros, Ryutaros** (*Den-O*) | `height_cm` & `weight_kg` wujud asli Imagin (`185/102`, `182/110`, `187/107`, `171/80`) | Angka yang dimasukkan adalah tubuh asli Imagin (bukan wujud Den-O Sword/Rod/Ax/Gun Form yang tercantum terpisah di `stats_note`); khusus *Kintaros*, sebagian sumber mencantumkan statistik Den-O Ax Form (`185 cm / 93 kg`) dibanding `187 cm / 107 kg`. |
| **Kamen Rider Saga** (*Kiva*) | `max_jump_m = 90`, `run_100m_s = 2` | Angka kelincahan tinggi namun sesuai kotak info resmi Kamen Rider Saga. |
| **25 karakter pendukung & antagonis tanpa angka kostum resmi** | `height_cm`, `weight_kg` = `NULL` | Terdiri dari tokoh manusia pendukung & antagonis tanpa angka resmi (*Kaoru Ichijo*, *Sakurako Sawatari*, *Minori Godai*, *N-Daguva-Zeba*, *Ra-Baruba-De*, *Mana Kazaya*, *Sumiko Ozawa*, *Overlord of Darkness*, *Yui Kanzaki*, *Goro Yura*, *Shiro Kanzaki*, *Mari Sonoda*, *Shiori Hirose*, *Hiroshi Tennoji*, *Asumu Adachi*, *Akira Amami*, *Douji*, *Hime*, *Hiyori Kusakabe*, *Shuichi Tadokoro*, *Masato Mishima*, *Hana*, *Kai*, *Megumi Aso*, *Kivat-bat the 3rd*), sementara `35` karakter lainnya memiliki `height_cm` terisi dari wujud Rider/Imagin/Orphnoch/Worm/Fangire. Untuk *Goro Yura*, *Hiyori Kusakabe*, dan *Masato Mishima*, angka wujud sampingan dicatat di `stats_note` agar tidak tertukar dengan wujud utama/manusia mereka. |
| **`blood_type` & `origin` yang tidak tercantum di kotak info** | `NULL` (tidak diisi) | Tidak dicantumkan pada kotak info Kamen Rider Wiki untuk mayoritas karakter Heisei 2000–2008 sehingga sengaja dibiarkan `NULL`. |
| **`Wataru Kurenai` (`Kamen Rider Kiva`)** | `age_text = NULL` | Hasil penelusuran untuk usia kanon Wataru masih rancu pada sumber ringkasan sehingga dibiarkan `NULL` untuk dicek ulang. |

---

## GAP STATISTIK KAMEN RIDER — BATCH 1: TINGGI & SEDANG (`seed_profile_stats_gap_kamenrider.sql`)

Ringkasan isi SQL: **107 perintah `UPDATE`** berbasis `COALESCE` yang mencakup **112 karakter** Kamen Rider (`59` prioritas `TINGGI` + `53` prioritas `SEDANG`; seluruh `59` prioritas `RENDAH` dilewati sesuai aturan). Rincian: **`64` karakter** terisi `height_cm` & `weight_kg` dari wujud Rider/Imagin/Orphnoch/Oni, sedangkan **`48` karakter** sekutu sipil/non-Rider dibiarkan `height_cm = NULL` & `weight_kg = NULL` dan dilengkapi kolom profilnya (`age_text`, `origin`, `occupation`, `stats_note`, `source_url`).

| Karakter / Kelompok | Kolom / Angka | Catatan / Hal yang Perlu Dicek |
|---|---|---|
| **Kamen Rider Lazer** (*Ex-Aid*) | `height_cm = 222` (Lazer Turbo Bike Gamer Level 0) | Wujud *Level 2* adalah sepeda motor (`139 kg`) tanpa tinggi humanoid resmi, sehingga memakai wujud humanoid *Bike Gamer Level 0* (`222.0 cm / 144.0 kg`, sedikit di atas `220 cm`); parameter ton/m/dtk Level 0 dibiarkan `NULL` karena tidak tercantum di ringkasan sumber. |
| **Kamen Rider OOO** | `max_jump_m = 190` | Daya lompatan sangat tinggi (`190 m`) sesuai kotak info resmi wujud dasar *Tatoba Combo* (efek *Batta Legs*). |
| **Kamen Rider Poppy** (*Ex-Aid*) | `punch_power_t = 60.3`, `kick_power_t = 70.1`, `run_100m_s = 1.7` | Angka tempur jauh lebih tinggi dari Rider awal seri lain karena bentuk dasarnya adalah *Toki Meki Crisis Gamer Level X*. |
| **Kamen Rider Tsukuyomi** (*Zi-O*) | `kick_power_t = 61.3`, `max_jump_m = 72.2`, `run_100m_s = 2` | Angka akhir serial *Zi-O* tergolong tinggi namun sesuai kotak info Kamen Rider Wiki. |
| **Kamen Rider Amazon Omega & Amazon Alpha** | `punch_power_t`, `kick_power_t`, `max_jump_m`, `run_100m_s` = `NULL` | Sumber profil *Kamen Rider Amazons* mencantumkan tinggi & berat (`188 / 92.7` & `186.5 / 91.4`) tanpa statistik ton/m/detik standar seri TV. |
| **Kamen Rider Ryugen** (*Gaim*) | `max_jump_m = 28`, `run_100m_s = 5.9` | Mengikuti kerangka standar Armored Rider *Budou Arms* yang merujuk pada metrik dasar Gaim (`206 cm / 105 kg / 6.7 t / 10.2 t`). |
| **Philip** (*Kamen Rider W*) | `195 cm / 85 kg / 2.5 t / 6 t / 60 m / 5.2 s` | Menggunakan statistik tubuh gabungan *Kamen Rider W CycloneJoker* yang dibentuk bersama Shotaro Hidari. |
| **Kiriko Shijima** (*Drive*) | `height_cm = NULL` | Halaman wiki mencantumkan `166 cm` yang merupakan tinggi fisik sipil/pemeran, bukan spesifikasi kostum Rider, sehingga sengaja dibiarkan `NULL`. |
| **48 sekutu sipil/non-Rider** (`18` Showa + `16` Heisei Awal + `14` Heisei Akhir) | `height_cm`, `weight_kg` = `NULL` | Meliputi 18 sekutu Showa (*Tobei Tachibana* x5, *Junko Tama*, *Mogura Beastman*, *Keitaro Jin*, *Dr. Keitaro Shido*, *Genjiro Tani* x2, *Master Genkai*, *Rumi Ichijo*, *Dr. Hajime Kaido*, *Kyoko Akizuki*, *Katsumi Kida*, *Reiko Shiratori*, *Joe the Haze*), 16 sekutu Heisei 2000–2008, dan 14 sekutu Heisei 2009–2019 (*Natsumi Hikari*, *Akiko Narumi*, *Ankh*, *Hina Izumi*, *Yuki Jojima*, *Kengo Utahoshi*, *Koyomi*, *Mai Takatsukasa*, *Kiriko Shijima*, *Akari Tsukimura*, *Mizuki Mizusawa*, *Mamoru*, *Nanaha Izumi*, *Misora Isurugi*). *(Catatan: untuk *Ankh*, statistik wujud *Ankh (Lost)* `214 cm / 117 kg` dicatat di `stats_note` karena entri DB merujuk inang tubuh manusia Shingo Izumi.)* |
| **Catatan Heisei 2000–2008 (`Hibiki`, `Zolda`, `Todoroki`, `Otoya Kurenai`, `Den-O Taros`)** | Lihat tabel di atas | Sebagian karakter Heisei 2000–2008 (*Hibiki* `222 cm`, *Todoroki* satuan tradisional, *Zolda* `192` vs `187 cm`, *Otoya* `Dark Kiva` `250 m / 1.2 s`, Imagin *Den-O*) juga tercantum di bagian *Tahap 1: 2000–2008* di atas agar *Batch 1* berdiri utuh dan idempoten. |








