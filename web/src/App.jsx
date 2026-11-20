import { useEffect, useRef } from 'react';
import { Route, Routes, useLocation, useNavigationType } from 'react-router-dom';
import Navbar from './components/Navbar.jsx';
import BottomNav from './components/BottomNav.jsx';
import GlassPanel from './components/GlassPanel.jsx';
import PageBackground, { BackgroundProvider } from './components/PageBackground.jsx';
import PwaUpdateBanner from './components/PwaUpdateBanner.jsx';
import { ToastProvider } from './context/ToastContext.jsx';
import { PwaInstallProvider } from './context/PwaInstallContext.jsx';
import SeriesList from './pages/SeriesList.jsx';
import SeriesDetail from './pages/SeriesDetail.jsx';
import CharacterList from './pages/CharacterList.jsx';
import CharacterDetail from './pages/CharacterDetail.jsx';
import Favorites from './pages/Favorites.jsx';
import About from './pages/About.jsx';
import Actors from './pages/Actors.jsx';
import ActorDetail from './pages/ActorDetail.jsx';

const scrollPositions = new Map();

function ScrollManager() {
  const location = useLocation();
  const navigationType = useNavigationType();
  const activeKeyRef = useRef(location.key);
  const restoringRef = useRef(false);

  useEffect(() => {
    if ('scrollRestoration' in window.history) {
      window.history.scrollRestoration = 'manual';
    }
  }, []);

  useEffect(() => {
    activeKeyRef.current = location.key;
    const onScroll = () => {
      if (!restoringRef.current) {
        scrollPositions.set(activeKeyRef.current, window.scrollY);
      }
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => {
      window.removeEventListener('scroll', onScroll);
    };
  }, [location.key]);

  useEffect(() => {
    if (navigationType !== 'POP') {
      restoringRef.current = false;
      window.scrollTo(0, 0);
      return undefined;
    }

    const savedY = scrollPositions.get(location.key) ?? 0;
    if (savedY <= 0) {
      restoringRef.current = false;
      window.scrollTo(0, 0);
      return undefined;
    }

    restoringRef.current = true;
    let done = false;
    const tryRestore = () => {
      if (done) return;
      const maxReachable = document.documentElement.scrollHeight - window.innerHeight;
      window.scrollTo(0, savedY);
      if (maxReachable >= savedY - 2 && Math.abs(window.scrollY - savedY) <= 4) {
        done = true;
        restoringRef.current = false;
      }
    };

    const rafId = requestAnimationFrame(tryRestore);
    const observer = new ResizeObserver(() => {
      tryRestore();
    });
    const mainEl = document.querySelector('main');
    if (mainEl) observer.observe(mainEl);
    observer.observe(document.body);
    observer.observe(document.documentElement);

    const timeoutId = setTimeout(() => {
      done = true;
      restoringRef.current = false;
      observer.disconnect();
    }, 5000);

    return () => {
      done = true;
      restoringRef.current = false;
      cancelAnimationFrame(rafId);
      clearTimeout(timeoutId);
      observer.disconnect();
    };
  }, [location.pathname, location.key, navigationType]);

  return null;
}

export default function App() {
  return (
    <BackgroundProvider>
      <PwaInstallProvider>
        <ToastProvider>
          <div className="app">
            <PageBackground />
            <ScrollManager />
            <Navbar />
            <PwaUpdateBanner />
            <main>
          <Routes>
            <Route path="/" element={<SeriesList />} />
            <Route path="/series/:id" element={<SeriesDetail />} />
            <Route path="/characters" element={<CharacterList />} />
            <Route path="/characters/:id" element={<CharacterDetail />} />
            <Route path="/actors" element={<Actors />} />
            <Route path="/actors/:id" element={<ActorDetail />} />
            <Route path="/favorites" element={<Favorites />} />
            <Route path="/about" element={<About />} />
            <Route
              path="*"
              element={
                <GlassPanel>
                  <div className="state">
                    <h2>Halaman tidak ditemukan</h2>
                    <p>Alamat yang kamu buka tidak ada di aplikasi ini.</p>
                  </div>
                </GlassPanel>
              }
            />
          </Routes>
            </main>
            <BottomNav />
          </div>
        </ToastProvider>
      </PwaInstallProvider>
    </BackgroundProvider>
  );
}
