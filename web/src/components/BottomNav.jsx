import { Link, useLocation } from 'react-router-dom';
import { Tv, Users, Clapperboard, Heart, Info } from 'lucide-react';

const TABS = [
  { to: '/',           label: 'Series',   icon: Tv,           match: (p) => p === '/' || p.startsWith('/series') },
  { to: '/characters', label: 'Karakter', icon: Users,        match: (p) => p.startsWith('/characters') },
  { to: '/actors',     label: 'Pemeran',  icon: Clapperboard, match: (p) => p.startsWith('/actors') },
  { to: '/favorites',  label: 'Favorit',  icon: Heart,        match: (p) => p.startsWith('/favorites') },
  { to: '/about',      label: 'Tentang',  icon: Info,         match: (p) => p.startsWith('/about') },
];

export default function BottomNav() {
  const { pathname } = useLocation();

  return (
    <nav className="bottom-nav" aria-label="Navigasi utama">
      {TABS.map(({ to, label, icon: Icon, match }) => {
        const active = match(pathname);
        return (
          <Link
            key={to}
            to={to}
            className={active ? 'tab tab--active' : 'tab'}
            aria-current={active ? 'page' : undefined}
          >
            <Icon
              size={20}
              strokeWidth={active ? 2.5 : 1.8}
              aria-hidden="true"
            />
            <span>{label}</span>
          </Link>
        );
      })}
    </nav>
  );
}
