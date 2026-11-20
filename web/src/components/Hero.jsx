import { useState, useEffect, useRef, useCallback } from 'react';
import { Link } from 'react-router-dom';
import { Play, Heart, ChevronLeft, ChevronRight } from 'lucide-react';
import { getImageObjectPositionStyle, setMeasuredHeroSize } from '../utils/imagePosition';

function HeroSlide({ item, index, total, isActive, isFavorite, onToggleFav }) {
  const [imgFailed, setImgFailed] = useState(false);
  const hasPoster = Boolean(item.poster && !imgFailed);

  return (
    <div
      className={`hero-slide${isActive ? ' hero-slide--active' : ''}`}
      role="group"
      aria-roledescription="slide"
      aria-label={`${index + 1} dari ${total}`}
      aria-hidden={!isActive}
    >
      {hasPoster ? (
        <img
          className="hero__img"
          src={item.poster}
          alt={item.title}
          loading={index === 0 ? 'eager' : 'lazy'}
          style={getImageObjectPositionStyle(item)}
          onError={() => setImgFailed(true)}
        />
      ) : (
        <div className="hero__fallback" aria-hidden="true" />
      )}

      <div className="hero__overlay hero__overlay--centered" aria-hidden="true" />

      <div className="hero__content hero__content--centered">
        <h2 className="hero__title">{item.title}</h2>

        {item.synopsis && (
          <p className="hero__desc">{item.synopsis}</p>
        )}

        <div className="hero__actions">
          <Link
            to={`/series/${item.id}`}
            className="btn-primary"
            aria-label={`Lihat detail ${item.title}`}
            tabIndex={isActive ? 0 : -1}
          >
            <Play size={18} aria-hidden="true" />
            <span>Lihat Detail</span>
          </Link>
          <button
            type="button"
            className={`btn-outline${isFavorite ? ' btn-outline--active' : ''}`}
            onClick={() => onToggleFav(item.id)}
            aria-pressed={isFavorite}
            aria-label={isFavorite ? `Hapus ${item.title} dari favorit` : `Simpan ${item.title} ke favorit`}
            tabIndex={isActive ? 0 : -1}
          >
            <Heart size={18} aria-hidden="true" fill={isFavorite ? 'currentColor' : 'none'} />
            <span>{isFavorite ? 'Tersimpan di Favorit' : 'Simpan ke Favorit'}</span>
          </button>
        </div>
      </div>
    </div>
  );
}

/** Hero banner carousel — berputar otomatis tiap 6 detik antar series unggulan */
export default function Hero({ items, item, isFavorite, onToggleFav }) {
  const slides = Array.isArray(items) && items.length > 0 ? items : item ? [item] : [];
  const [activeIndex, setActiveIndex] = useState(0);
  const [isHovered, setIsHovered] = useState(false);
  const [isFocused, setIsFocused] = useState(false);
  const [isTouching, setIsTouching] = useState(false);
  const [prefersReducedMotion, setPrefersReducedMotion] = useState(() => {
    if (typeof window === 'undefined' || !window.matchMedia) return false;
    return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  });
  const touchStartRef = useRef(null);
  const heroSectionRef = useRef(null);

  useEffect(() => {
    const el = heroSectionRef.current;
    if (!el || typeof ResizeObserver === 'undefined') return undefined;
    const updateSize = () => {
      const rect = el.getBoundingClientRect();
      if (rect.width > 0 && rect.height > 0) {
        setMeasuredHeroSize(rect.width, rect.height);
      }
    };
    updateSize();
    const ro = new ResizeObserver(updateSize);
    ro.observe(el);
    return () => ro.disconnect();
  }, [slides.length]);

  useEffect(() => {
    if (typeof window === 'undefined' || !window.matchMedia) return undefined;
    const mq = window.matchMedia('(prefers-reduced-motion: reduce)');
    const onChange = (e) => setPrefersReducedMotion(e.matches);
    setPrefersReducedMotion(mq.matches);
    mq.addEventListener('change', onChange);
    return () => mq.removeEventListener('change', onChange);
  }, []);

  useEffect(() => {
    if (activeIndex >= slides.length && slides.length > 0) {
      setActiveIndex(0);
    }
  }, [activeIndex, slides.length]);

  const goPrev = useCallback(() => {
    if (slides.length <= 1) return;
    setActiveIndex((prev) => (prev - 1 + slides.length) % slides.length);
  }, [slides.length]);

  const goNext = useCallback(() => {
    if (slides.length <= 1) return;
    setActiveIndex((prev) => (prev + 1) % slides.length);
  }, [slides.length]);

  const isPaused = isHovered || isFocused || isTouching || prefersReducedMotion;

  useEffect(() => {
    if (slides.length <= 1 || isPaused) return undefined;
    const timer = setInterval(() => {
      setActiveIndex((prev) => (prev + 1) % slides.length);
    }, 6000);
    return () => clearInterval(timer);
  }, [slides.length, isPaused]);

  if (!slides.length) return null;

  const handleTouchStart = (e) => {
    setIsTouching(true);
    const t = e.touches[0];
    if (t) touchStartRef.current = { x: t.clientX, y: t.clientY };
  };

  const handleTouchEnd = (e) => {
    setIsTouching(false);
    const start = touchStartRef.current;
    touchStartRef.current = null;
    if (!start || slides.length <= 1) return;
    const t = e.changedTouches[0];
    if (!t) return;
    const dx = t.clientX - start.x;
    const dy = t.clientY - start.y;
    if (Math.abs(dx) > 40 && Math.abs(dx) > Math.abs(dy)) {
      if (dx < 0) goNext();
      else goPrev();
    }
  };

  const handleTouchCancel = () => {
    setIsTouching(false);
    touchStartRef.current = null;
  };

  const handleFocus = () => setIsFocused(true);
  const handleBlur = (e) => {
    if (!e.currentTarget.contains(e.relatedTarget)) {
      setIsFocused(false);
    }
  };

  const checkFavorite = (id) => (typeof isFavorite === 'function' ? isFavorite(id) : Boolean(isFavorite));

  return (
    <section
      ref={heroSectionRef}
      className="hero hero--centered hero-carousel"
      role="region"
      aria-roledescription="carousel"
      aria-label="Series unggulan"
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      onFocus={handleFocus}
      onBlur={handleBlur}
      onTouchStart={handleTouchStart}
      onTouchEnd={handleTouchEnd}
      onTouchCancel={handleTouchCancel}
    >
      <div className="hero-carousel__track">
        {slides.map((s, idx) => (
          <HeroSlide
            key={s.id}
            item={s}
            index={idx}
            total={slides.length}
            isActive={idx === activeIndex}
            isFavorite={checkFavorite(s.id)}
            onToggleFav={(id) => onToggleFav?.(id)}
          />
        ))}
      </div>

      {slides.length > 1 && (
        <div className="hero-carousel__controls">
          <button
            type="button"
            className="hero-carousel__arrow hero-carousel__arrow--prev"
            onClick={goPrev}
            aria-label="Slide sebelumnya"
          >
            <ChevronLeft size={22} aria-hidden="true" />
          </button>

          <div className="hero-carousel__dots" role="group" aria-label="Pilih slide">
            {slides.map((s, idx) => {
              const active = idx === activeIndex;
              return (
                <button
                  key={s.id}
                  type="button"
                  className={`hero-carousel__dot${active ? ' hero-carousel__dot--active' : ''}`}
                  onClick={() => setActiveIndex(idx)}
                  aria-label={`Pilih slide ${idx + 1} dari ${slides.length}: ${s.title}`}
                  aria-pressed={active}
                />
              );
            })}
          </div>

          <button
            type="button"
            className="hero-carousel__arrow hero-carousel__arrow--next"
            onClick={goNext}
            aria-label="Slide berikutnya"
          >
            <ChevronRight size={22} aria-hidden="true" />
          </button>
        </div>
      )}
    </section>
  );
}
