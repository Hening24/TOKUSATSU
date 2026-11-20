import { Link, useLocation } from 'react-router-dom';
import { Tv, Users, Clapperboard, Heart, Info, Download } from 'lucide-react';
import { usePwaInstall } from '../context/PwaInstallContext.jsx';

const NAV_ITEMS = [
  { to: '/',           label: 'Series',         icon: Tv,           match: (p) => p === '/' || p.startsWith('/series') },
  { to: '/characters', label: 'Karakter',       icon: Users,        match: (p) => p.startsWith('/characters') },
  { to: '/actors',     label: 'Pemeran Utama',  icon: Clapperboard, match: (p) => p.startsWith('/actors') },
  { to: '/favorites',  label: 'Favorit',        icon: Heart,        match: (p) => p.startsWith('/favorites') },
  { to: '/about',      label: 'Tentang',        icon: Info,         match: (p) => p.startsWith('/about') },
];

export default function Navbar() {
  const { pathname } = useLocation();
  const { canPrompt, isInstalled, promptInstall } = usePwaInstall();

  return (
    <header className="top-nav">
      <div className="top-nav__inner">
        <Link to="/" className="top-nav__brand" aria-label="Beranda Tokusatsu Zukan">
          <span className="top-nav__logo">TOKUSATSU ZUKAN</span>
        </Link>

        {/* Desktop Navigation 5 Tabs */}
        <nav className="top-nav__links" aria-label="Navigasi Desktop">
          {NAV_ITEMS.map(({ to, label, icon: Icon, match }) => {
            const active = match(pathname);
            return (
              <Link
                key={to}
                to={to}
                className={`top-nav__link ${active ? 'top-nav__link--active' : ''}`}
                aria-current={active ? 'page' : undefined}
              >
                <Icon size={17} aria-hidden="true" strokeWidth={active ? 2.4 : 1.8} />
                <span>{label}</span>
              </Link>
            );
          })}

          {canPrompt && !isInstalled && (
            <button
              type="button"
              className="top-nav__install-btn glass-card glass-card--interactive"
              onClick={promptInstall}
              aria-label="Pasang Aplikasi"
            >
              <Download size={16} aria-hidden="true" />
              <span>Pasang Aplikasi</span>
            </button>
          )}
        </nav>
      </div>
    </header>
  );
}
