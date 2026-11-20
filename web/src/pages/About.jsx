import { Download, Smartphone, CheckCircle2 } from 'lucide-react';
import { PROFILE } from '../config';
import { API_BASE } from '../api/client';
import { usePwaInstall } from '../context/PwaInstallContext.jsx';
import GlassPanel from '../components/GlassPanel.jsx';

export default function About() {
  const { canPrompt, isInstalled, isIos, promptInstall } = usePwaInstall();

  return (
    <GlassPanel className="about-page">
      {/* Hero about */}
      <div className="about-hero">
        <h1>TENTANG</h1>
        <p>Tokusatsu Zukan — katalog tokusatsu dari era Showa sampai Reiwa</p>
      </div>

      <div className="about-grid">
        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Isi Aplikasi</h2>
          <p className="prose">
            Telusuri series Kamen Rider, Super Sentai, Ultraman, dan Metal Hero,
            lalu buka profil karakternya. Cari berdasarkan nama, filter berdasarkan
            franchise atau era, dan simpan yang kamu suka ke Favorit. Aplikasi bisa
            dipasang ke layar utama dan tetap menampilkan data saat offline.
          </p>
        </section>

        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Pasang Aplikasi</h2>
          <div className="pwa-install-card">
            {isInstalled ? (
              <p className="pwa-install-status">
                <CheckCircle2 size={18} aria-hidden="true" />
                <span>Aplikasi sudah terpasang di perangkat ini.</span>
              </p>
            ) : canPrompt ? (
              <button
                type="button"
                className="btn-primary pwa-install-btn"
                onClick={promptInstall}
              >
                <Download size={17} aria-hidden="true" />
                <span>Pasang Aplikasi</span>
              </button>
            ) : null}

            {isIos && !isInstalled && (
              <p className="prose pwa-install-guide">
                <Smartphone size={16} aria-hidden="true" style={{ display: 'inline', verticalAlign: '-3px', marginRight: 6 }} />
                Di iPhone: ketuk Bagikan, lalu Tambah ke Layar Utama.
              </p>
            )}

            <p className="muted" style={{ fontSize: '0.88rem', lineHeight: 1.55 }}>
              Untuk Chrome desktop dan Android: buka menu browser (⋮), lalu pilih <strong>Pasang aplikasi</strong>.
            </p>
          </div>
        </section>

        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Teknologi</h2>
          <dl className="facts">
            <div><dt>Aplikasi</dt><dd>React, Vite, React Router, PWA</dd></div>
            <div><dt>API</dt><dd>Node.js dan Express</dd></div>
            <div><dt>Database</dt><dd>Neon (PostgreSQL)</dd></div>
            <div><dt>Alamat API</dt><dd className="break">{API_BASE || 'Mode offline / belum dikonfigurasi'}</dd></div>
          </dl>
        </section>

        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Pembuat</h2>
          <dl className="facts">
            <div><dt>Nama</dt><dd>{PROFILE.name}</dd></div>
            <div><dt>NIM</dt><dd>{PROFILE.nim}</dd></div>
            <div><dt>Program studi</dt><dd>{PROFILE.program}</dd></div>
            <div><dt>Mata kuliah</dt><dd>{PROFILE.course}</dd></div>
            <div>
              <dt>Source code</dt>
              <dd>
                <a className="link break" href={PROFILE.repo} target="_blank" rel="noreferrer">
                  {PROFILE.repo}
                </a>
              </dd>
            </div>
          </dl>
        </section>

        {/* Sumber dan Kredit */}
        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Sumber dan Kredit</h2>
          <div className="prose" style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
            <p>
              Data karakter dan series bersumber dari wiki tokusatsu yang digunakan dalam basis data,
              dengan Wikipedia sebagai pembanding.
            </p>
            <p>
              Seluruh merek, karakter, dan gambar merupakan milik pemegang hak ciptanya masing-masing
              (Toei, Tsuburaya, dan lainnya). Proyek ini bersifat nirlaba untuk kebutuhan tugas kuliah.
            </p>
            <p>
              Gambar latar bawaan aplikasi dibuat menggunakan AI.
            </p>
            <p className="muted" style={{ fontSize: '0.88rem' }}>
              Pengembang: {PROFILE.name} ({PROFILE.nim}) — {PROFILE.course}.
            </p>
          </div>
        </section>

        {/* Franchise Legend */}
        <section className="card glass-card">
          <h2 className="section-title" style={{ margin: '12px 0 10px' }}>Franchise</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
            {[
              { name: 'Kamen Rider',  color: '#4ade80', desc: 'Pahlawan bersenjatakan sabuk transformasi' },
              { name: 'Super Sentai', color: '#facc15', desc: 'Tim pahlawan berwarna-warni' },
              { name: 'Ultraman',     color: '#60a5fa', desc: 'Raksasa cahaya dari luar angkasa' },
              { name: 'Metal Hero',   color: '#94a3b8', desc: 'Polisi angkasa berbaju baja' },
            ].map(({ name, color, desc }) => (
              <div key={name} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <div style={{
                  width: 4, height: 36, borderRadius: 2,
                  background: color, flexShrink: 0,
                }} />
                <div>
                  <p style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--text-primary)' }}>{name}</p>
                  <p className="muted" style={{ fontSize: '0.85rem' }}>{desc}</p>
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </GlassPanel>
  );
}
