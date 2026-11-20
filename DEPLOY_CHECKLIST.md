# Checklist Deploy Tokusatsu Zukan

Daftar periksa sebelum dan sesudah deploy ke produksi (Render + Vercel/Netlify + Neon).

---

## Sebelum Deploy
- [ ] Pastikan `.env`, `.env.local`, dan berkas kredensial lain tidak masuk repositori (`.gitignore` aktif di akar proyek, `api/`, dan `web/`).
- [ ] Jalankan migrasi SQL di Neon SQL Editor hingga selesai tanpa error:
  - [ ] `002_kronologi_dan_statistik.sql`
  - [ ] `003_extra_stats.sql`
  - [ ] `004_profile_stats.sql`
  - [ ] `005_image_position.sql`
- [ ] Pastikan `web/src/config.js` sudah diisi identitas pembuat (`name`, `nim`, `course`).
- [ ] Jalankan pemeriksaan lokal sebelum push:
  - [ ] `node --check` pada seluruh berkas API lolos tanpa error.
  - [ ] `npm run build` di `web/` berhasil menghasilkan `dist/`, `dist/manifest.webmanifest`, dan `dist/sw.js`.
  - [ ] Tidak ada rahasia (`DATABASE_URL`, password, token) di `README.md`, `DEPLOY_CHECKLIST.md`, maupun kode `web/` dan `api/`.

---

## Konfigurasi Variabel Lingkungan Produksi
### API (Render)
- [ ] `NODE_ENV=production`
- [ ] `DATABASE_URL` terisi connection string Neon dengan `sslmode=require`
- [ ] `CORS_ORIGIN` terisi URL frontend Vercel/Netlify (tanpa garis miring di akhir)
- [ ] `ALLOW_WRITE=false` (mode publik hanya-baca aktif)

### Web (Vercel / Netlify)
- [ ] `VITE_API_URL` terisi URL publik API Render (tanpa garis miring di akhir)
- [ ] `VITE_ENABLE_EDIT=false` (tombol tambah/edit/hapus disembunyikan)

---

## Sesudah Deploy
- [ ] **Health Check API**: Buka `GET https://<URL_API>/health` → mengembalikan HTTP `200` dengan `{"status":"ok"}`.
- [ ] **Mode Publik API**: Uji request `POST /series` atau `PUT /series/1` → harus mengembalikan HTTP `403` saat `ALLOW_WRITE=false`.
- [ ] **Mode Publik UI**: Buka beranda dan halaman detail → pastikan tombol *Tambah*, *Edit*, dan *Hapus* tidak tampil saat `VITE_ENABLE_EDIT=false`.
- [ ] **SPA Fallback**: Buka langsung URL dalam (mis. `https://<URL_WEB>/series/6` atau `https://<URL_WEB>/characters`) lewat address bar / refresh browser → tidak muncul error `404`.
- [ ] **PWA & Manifest**: Cek di Chrome DevTools → Application → Manifest terbaca (`Tokusatsu Zukan`, `display: standalone`, ikon `192x192`, `512x512`, `maskable 512x512`) dan Service Worker berstatus *activated and running*.
- [ ] **Uji Pasang (Install)**: Klik **Pasang Aplikasi** di Chrome/Android atau *Tambah ke Layar Utama* di iPhone → aplikasi terbuka dalam jendela standalone tanpa address bar, dan tombol **Pasang Aplikasi** otomatis tersembunyi setelah terpasang.
- [ ] **Uji Offline**: Buka beberapa halaman saat online, lalu aktifkan mode Offline di DevTools → halaman utama dan data API dari cache tetap tampil.
- [ ] **CORS**: Pastikan tidak ada error CORS di Console browser antara frontend dan backend produksi.
