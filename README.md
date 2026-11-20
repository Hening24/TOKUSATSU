# TOKUSATSU — Tokusatsu Zukan

Aplikasi ensiklopedia & katalog tokusatsu (Kamen Rider, Super Sentai, Ultraman, dan Metal Hero) berbasis web yang dapat dipasang sebagai **Progressive Web App (PWA)**, dibuat untuk kebutuhan tugas kuliah.

---

## Arsitektur Sistem

Aplikasi menggunakan arsitektur **3-tier decoupled** antara antarmuka PWA statis, REST API Express, dan database PostgreSQL terkelola di Neon:

```mermaid
flowchart LR
  User["Browser / PWA (Desktop & HP)"]
  SW["Workbox Service Worker\n(Precache Statis + NetworkFirst API)"]
  Web["Frontend Statis\nReact + Vite (Vercel / Netlify)"]
  API["REST API Node.js\nExpress + Security + Rate Limit (Render)"]
  DB["PostgreSQL Neon\n(Koneksi SSL + Parameterized Query)"]

  User -->|Akses UI & Offline Cache| SW
  SW <-->|Aset Statis| Web
  User <-->|JSON HTTPS (VITE_API_URL)| API
  SW -.->|Cache Cadangan API| API
  API <-->|pg Pool SSL| DB
```

---

## Sub-Bagian & Tanggung Jawab Modul

### 1. Frontend PWA (`web/`)
Aplikasi Single Page Application (SPA) dibangun dengan React 18 dan Vite 5, mengusung antarmuka *glassmorphism* gelap berlapis:
- **Halaman (`web/src/pages/`)**:
  - `SeriesList`: Beranda utama berisi **Hero Carousel** unggulan, pencarian instan, filter franchise & era, dan kelompok kategori (maksimal 5 kartu per kelompok dengan *Lihat semua*).
  - `SeriesDetail`: Halaman detail series lengkap dengan **latar dinamis**, poster terpusat, fakta produksi, sinopsis, kronologi arc, daftar karakter, dan grid kartu pemeran.
  - `CharacterList` & `CharacterDetail`: Katalog karakter dikelompokkan berdasarkan peran serta profil karakter lengkap (statistik kekuatan, tinggi/berat, riwayat, tautan series & pemeran).
  - `Actors` & `ActorDetail`: Daftar dan profil pemeran utama beserta keterkaitan peran & series.
  - `Favorites`: Daftar bookmark lokal yang disimpan di `localStorage` tanpa perlu login.
  - `About`: Informasi aplikasi, tombol/panduan **Pasang Aplikasi**, daftar teknologi, serta bagian **Sumber dan Kredit**.
- **Komponen Inti (`web/src/components/`)**:
  - `PageBackground`: Mengelola dua lapisan latar fixed global dengan `400ms` crossfade, preload `new Image()`, fallback senyap saat gagal muat, dan blur latar terisolasi (`--bg-image-blur`).
  - `Hero`: Carousel slide otomatis yang memetakan `image_pos_x` & `image_pos_y` lewat helper bersama dan melaporkan dimensi hero via `ResizeObserver`.
  - `ImagePositioner` & `ImageUrlField`: Pengatur letak gambar interaktif berbasis seret (mouse & tombol *Mode geser* untuk sentuh), keyboard panah, bingkai *Hero beranda*, *Layar lebar*, *HP (9:19)*, *Kartu poster (2:3)*, penanda *Area teks* / *Tertutup panel*, serta pratinjau hidup *Seperti di halaman*.
  - `Modal` & Form Modals (`SeriesModal`, `CharacterModal`, `ActorModal`, `ArcModal`, `ConfirmModal`): Struktur modal 3 bagian dengan pengunci scroll halaman (`position: fixed`), area scroll mandiri, dan konfirmasi hapus aman.
  - `Navbar`, `BottomNav`, `GlassPanel`, `PwaUpdateBanner`, `Toast`.
- **State, Cache & Util (`web/src/api/`, `context/`, `hooks/`, `utils/`)**:
  - `api/client.js`: Pembungkus `fetch` dengan cache GET dalam memori (`getCache`) yang otomatis dibersihkan bersama cache Workbox `zukan-api` saat `POST`/`PUT`/`DELETE`.
  - `context/PwaInstallContext.jsx`: Menangkap `beforeinstallprompt` & `appinstalled` untuk tombol *Pasang Aplikasi*.
  - `utils/imagePosition.js`: Satu sumber perhitungan `object-position` / `background-position`, dimensi hero, dan notifikasi peringatan bila migrasi DB belum dijalankan.

### 2. Backend REST API (`api/`)
REST API stateless berbasis Node.js & Express 4:
- **`api/server.js`**: Titik masuk aplikasi Express; mengatur `GET /health` (`{"status":"ok"}` tanpa menyentuh DB), CORS berbasis daftar asal `CORS_ORIGIN`, batas body JSON (`1mb`), dan handler error aman tanpa membocorkan kredensial.
- **`api/middleware/security.js`**:
  - `securityHeaders`: Mengatur header keamanan (`X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Permissions-Policy`, `HSTS` di produksi) dan menonaktifkan `X-Powered-By`.
  - `createRateLimiter`: Pembatasan laju *sliding-window* per IP (`120 req/menit`, status `429`).
  - `writeGuard`: Memblokir `POST`, `PUT`, `PATCH`, dan `DELETE` dengan HTTP `403` saat `ALLOW_WRITE=false`.
- **`api/db.js`**: Menginisialisasi `pg.Pool` dari `DATABASE_URL` dengan SSL aktif (`sslmode=require`) dan sanitasi log galat koneksi.
- **`api/routes/` & `api/utils/validate.js`**: Endpoint berparameter (`$1, $2, ...`) untuk `series`, `characters`, `actors`, dan `seriesArcs`, validasi tipe/rentang input sisi server, serta deteksi dinamis kolom `image_pos_x` & `image_pos_y` via `information_schema.columns` (mengembalikan `image_pos_supported: false` bila migrasi belum dijalankan di Neon).

### 3. Database PostgreSQL Neon (`api/sql/`)
Skema relasional terdiri dari:
- `series`: Data utama seri tokusatsu, poster, titik fokus gambar (`image_pos_x`, `image_pos_y`), sinopsis, dan plot.
- `characters`: Karakter terhubung ke `series(id)` (`ON DELETE CASCADE`), foto, statistik pertarungan/tubuh, dan titik fokus gambar.
- `actors`: Pemeran utama terhubung ke `series(id)` (`ON DELETE SET NULL`), biodata, foto, dan titik fokus gambar.
- `series_arcs` & `arc_characters` *(migrasi `002`)*: Bab kronologi terstruktur per series beserta relasi kemunculan karakter.

### 4. Lapisan PWA & Offline (`vite-plugin-pwa`)
- **Manifest**: Didefinisikan di `web/vite.config.js` (`name: "Tokusatsu Zukan"`, `short_name: "Zukan"`, `display: "standalone"`, tema gelap `#080B14`, ikon `192×192`, `512×512`, dan `maskable 512×512` di `web/public/icons/`).
- **Service Worker (`registerType: 'prompt'`)**:
  - Mem-precache aset statis (`js`, `css`, `html`, gambar latar, ikon, dan `/offline.html`).
  - Memakai strategi `NetworkFirst` (`networkTimeoutSeconds: 4`, cache `zukan-api`) pada `/series`, `/characters`, dan `/actors`.
  - Menampilkan banner *"Versi baru tersedia, muat ulang"* saat build baru terdeteksi.

---

## Fitur Utama
- **Beranda & Hero Carousel**: Sorotan 5 series unggulan, pencarian instan, filter franchise & era, dan kelompok kategori (maksimal 5 per kelompok dengan *Lihat semua*).
- **Detail Kaya Informasi & Latar Dinamis**: Latar belakang halaman detail menyesuaikan foto item secara halus lengkap dengan pengaturan titik fokus interaktif di editor.
- **Favorit Lokal**: Bookmark series, karakter, dan pemeran tersimpan di perangkat.
- **Mode Publik Aman**: Opsi menonaktifkan fitur tulis sekaligus di backend (`ALLOW_WRITE=false`) dan UI (`VITE_ENABLE_EDIT=false`).

---

## Struktur Folder
```text
tokusatsu-zukan/
├── api/
│   ├── middleware/
│   │   └── security.js          # Security headers, rate limiter, writeGuard (ALLOW_WRITE)
│   ├── routes/                  # series.js, characters.js, actors.js, seriesArcs.js
│   ├── scripts/seed.js
│   ├── sql/
│   │   ├── migrations/          # 002 s.d. 005_image_position.sql
│   │   ├── schema.sql
│   │   └── seed.sql
│   ├── utils/validate.js
│   ├── .env.example
│   ├── db.js
│   ├── package.json
│   └── server.js
├── web/
│   ├── public/
│   │   ├── icons/               # icon-192.png, icon-512.png, icon-maskable-512.png, apple-touch-icon.png
│   │   ├── _redirects           # SPA fallback Netlify
│   │   ├── favicon.svg
│   │   └── offline.html         # Cadangan halaman offline
│   ├── src/
│   │   ├── api/                 # client.js
│   │   ├── components/          # Hero, PageBackground, ImagePositioner, Modal, GlassPanel, dll.
│   │   ├── context/             # ToastContext, PwaInstallContext
│   │   ├── hooks/               # useFetch, useFavorites, useDebounce
│   │   ├── pages/               # SeriesList, SeriesDetail, CharacterList, CharacterDetail, Actors, ActorDetail, Favorites, About
│   │   ├── styles/              # index.css
│   │   ├── utils/               # imagePosition.js, franchise.js, matching.js, preloadImage.js
│   │   ├── config.js
│   │   ├── main.jsx
│   │   └── App.jsx
│   ├── .env.example
│   ├── index.html
│   ├── package.json
│   ├── vercel.json              # SPA rewrite Vercel
│   └── vite.config.js           # Konfigurasi Vite & PWA
├── DEPLOY_CHECKLIST.md
├── README.md
└── render.yaml                  # Blueprint deploy API untuk Render
```

---

## Menjalankan di Lokal

### 1. API (`api/`)
```bash
cd api
npm install
cp .env.example .env
```
Isi `api/.env` *(jangan pernah commit `.env`)*:
- `DATABASE_URL`: connection string Neon Anda (dengan `?sslmode=require`)
- `PORT`: `3000`
- `CORS_ORIGIN`: `http://localhost:5173`
- `ALLOW_WRITE`: `true` *(untuk uji edit lokal)*

Jalankan API:
```bash
npm run dev
# atau: npm start
```
Cek `http://localhost:3000/health` → mengembalikan `{"status":"ok"}`.

### 2. Frontend (`web/`)
```bash
cd web
npm install
cp .env.example .env
```
Isi `web/.env`:
- `VITE_API_URL`: `http://localhost:3000`
- `VITE_ENABLE_EDIT`: `true` *(untuk uji edit lokal)*

Jalankan Vite dev server:
```bash
npm run dev
```
Buka `http://localhost:5173`.

---

## Migrasi Database (Neon)
> **Catatan:** Jalankan SQL secara manual melalui **SQL Editor** di dashboard Neon.

1. Untuk database baru, jalankan `api/sql/schema.sql` lalu `api/sql/seed.sql` (atau `npm run seed` di lokal).
2. Jalankan berkas migrasi di `api/sql/migrations/` secara berurutan:
   1. `api/sql/migrations/002_kronologi_dan_statistik.sql`
   2. `api/sql/migrations/003_extra_stats.sql`
   3. `api/sql/migrations/004_profile_stats.sql`
   4. `api/sql/migrations/005_image_position.sql` *(menambahkan `image_pos_x` & `image_pos_y` dengan constraint `0..100`)*

---

## Panduan Deploy Langkah demi Langkah

> **Urutan Wajib:** Deploy **API terlebih dahulu (Render)** → **Web (Vercel / Netlify)** → **Perbarui `CORS_ORIGIN` di Render** dengan domain web yang sudah aktif.

### Langkah 1: Deploy API di Render
1. Push repositori ke GitHub (`https://github.com/Hening24/TOKUSATSU`).
2. Di dashboard Render, pilih **New + → Web Service** (atau gunakan `render.yaml` di akar proyek):
   - **Root Directory**: `api`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Health Check Path**: `/health`
3. Isi **Environment Variables** di Render:
   - `NODE_ENV` = `production`
   - `DATABASE_URL` = *(connection string Neon Anda dengan `sslmode=require`)*
   - `ALLOW_WRITE` = `false` *(wajib untuk deploy publik)*
   - `CORS_ORIGIN` = *(isi setelah Langkah 2 selesai)*
4. Catat URL API Render Anda (contoh: `https://tokusatsu-zukan-api.onrender.com`), lalu pastikan `GET /health` mengembalikan `{"status":"ok"}`.

### Langkah 2: Deploy Web di Vercel (atau Netlify)
1. Di Vercel (**Add New → Project**), hubungkan repositori GitHub Anda:
   - **Root Directory**: `web`
   - **Framework Preset**: `Vite`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
   *(SPA fallback sudah tersedia via `web/vercel.json` dan `web/public/_redirects` untuk Netlify.)*
2. Isi **Environment Variables**:
   - `VITE_API_URL` = `https://<URL_API_RENDER_ANDA>` *(tanpa garis miring di akhir)*
   - `VITE_ENABLE_EDIT` = `false` *(wajib untuk deploy publik)*
3. Catat domain web yang aktif (contoh: `https://tokusatsu-zukan.vercel.app`).

### Langkah 3: Perbarui `CORS_ORIGIN` di Render
1. Buka dashboard Render → **Environment** → isi `CORS_ORIGIN` dengan domain web Anda (`https://tokusatsu-zukan.vercel.app`; pisahkan koma jika lebih dari satu origin).
2. Tunggu redeploy singkat selesai dan pastikan web dapat memuat data dari API.

---

## Mode Publik (Read-Only)
Untuk deploy publik:
- Di API (`Render`): atur `ALLOW_WRITE=false` → seluruh `POST`, `PUT`, `PATCH`, dan `DELETE` mengembalikan `403`.
- Di Web (`Vercel` / `Netlify`): atur `VITE_ENABLE_EDIT=false` → seluruh tombol tambah, edit, hapus, dan modal form tidak dirender di UI.

---

## Cara Memasang sebagai Aplikasi (PWA)
- **Chrome Desktop & Android**: Klik **Pasang Aplikasi** di navbar atau di halaman **Tentang**, atau lewat menu browser (`⋮`) → **Pasang aplikasi / Install app**.
- **iPhone / iPad (Safari)**: Buka di Safari → ketuk tombol **Bagikan (Share)** → pilih **Tambah ke Layar Utama (Add to Home Screen)**.
