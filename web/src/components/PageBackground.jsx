import { createContext, useCallback, useContext, useEffect, useId, useRef, useState } from 'react';
import defaultBgImg from '../assets/site-bg.jpg';
import { normalizePosValue } from '../utils/imagePosition';

const DEFAULT_BG = {
  src: defaultBgImg,
  posX: 55,
  posY: 50,
  isDynamic: false,
};

const BackgroundContext = createContext(null);

export function BackgroundProvider({ children }) {
  const [state, setState] = useState({
    activeSlot: 'A',
    slotA: DEFAULT_BG,
    slotB: DEFAULT_BG,
  });

  const activeOwnerRef = useRef(null);
  const resetTimerRef = useRef(null);
  const currentTargetRef = useRef(DEFAULT_BG);

  const applyBackground = useCallback((nextBg) => {
    const curr = currentTargetRef.current;
    if (
      curr.src === nextBg.src &&
      curr.posX === nextBg.posX &&
      curr.posY === nextBg.posY &&
      curr.isDynamic === nextBg.isDynamic
    ) {
      return;
    }
    currentTargetRef.current = nextBg;
    setState((prev) => {
      if (prev.activeSlot === 'A') {
        return { activeSlot: 'B', slotA: prev.slotA, slotB: nextBg };
      }
      return { activeSlot: 'A', slotA: nextBg, slotB: prev.slotB };
    });
  }, []);

  const requestBackground = useCallback(
    (ownerId, imageUrl, posX = 50, posY = 50, { loading = false } = {}) => {
      if (resetTimerRef.current) {
        clearTimeout(resetTimerRef.current);
        resetTimerRef.current = null;
      }
      activeOwnerRef.current = ownerId;

      if (loading) {
        return undefined;
      }

      const trimmedUrl = typeof imageUrl === 'string' ? imageUrl.trim() : '';
      if (!trimmedUrl) {
        applyBackground(DEFAULT_BG);
        return undefined;
      }

      const nextPosX = normalizePosValue(posX, 50);
      const nextPosY = normalizePosValue(posY, 50);

      let cancelled = false;
      const img = new window.Image();

      img.onload = () => {
        if (cancelled || activeOwnerRef.current !== ownerId) return;
        applyBackground({
          src: trimmedUrl,
          posX: nextPosX,
          posY: nextPosY,
          isDynamic: true,
        });
      };

      img.onerror = () => {
        if (cancelled || activeOwnerRef.current !== ownerId) return;
        applyBackground(DEFAULT_BG);
      };

      img.src = trimmedUrl;

      return () => {
        cancelled = true;
      };
    },
    [applyBackground]
  );

  const releaseOwner = useCallback(
    (ownerId) => {
      if (resetTimerRef.current) clearTimeout(resetTimerRef.current);
      resetTimerRef.current = setTimeout(() => {
        if (activeOwnerRef.current === ownerId) {
          activeOwnerRef.current = null;
          applyBackground(DEFAULT_BG);
        }
        resetTimerRef.current = null;
      }, 24);
    },
    [applyBackground]
  );

  useEffect(() => () => {
    if (resetTimerRef.current) clearTimeout(resetTimerRef.current);
  }, []);

  const activeLayer = state.activeSlot === 'A' ? state.slotA : state.slotB;

  return (
    <BackgroundContext.Provider value={{ requestBackground, releaseOwner, state, activeLayer }}>
      {children}
    </BackgroundContext.Provider>
  );
}

/**
 * Mengatur gambar latar global secara dinamis untuk halaman detail.
 * Otomatis preload dengan new Image() dan kembali ke latar bawaan saat unmount.
 */
export function usePageBackground(imageUrl, posX = 50, posY = 50, options = {}) {
  const ctx = useContext(BackgroundContext);
  const ownerId = useId();
  const loading = Boolean(options?.loading);

  useEffect(() => {
    if (!ctx) return undefined;
    const cancelLoad = ctx.requestBackground(ownerId, imageUrl, posX, posY, { loading });
    return () => {
      if (cancelLoad) cancelLoad();
    };
  }, [ctx, ownerId, imageUrl, posX, posY, loading]);

  useEffect(() => {
    if (!ctx) return undefined;
    return () => {
      ctx.releaseOwner(ownerId);
    };
  }, [ctx, ownerId]);
}

export default function PageBackground() {
  const ctx = useContext(BackgroundContext);
  const activeSlot = ctx?.state?.activeSlot || 'A';
  const slotA = ctx?.state?.slotA || DEFAULT_BG;
  const slotB = ctx?.state?.slotB || DEFAULT_BG;
  const isDynamic = ctx?.activeLayer?.isDynamic || false;

  return (
    <div className="page-bg" aria-hidden="true">
      <div
        className={`page-bg__layer${activeSlot === 'A' ? ' page-bg__layer--active' : ''}`}
        style={{
          backgroundImage: `url("${slotA.src}")`,
          backgroundPosition: `${slotA.posX}% ${slotA.posY}%`,
          transformOrigin: `${slotA.posX}% ${slotA.posY}%`,
        }}
      />
      <div
        className={`page-bg__layer${activeSlot === 'B' ? ' page-bg__layer--active' : ''}`}
        style={{
          backgroundImage: `url("${slotB.src}")`,
          backgroundPosition: `${slotB.posX}% ${slotB.posY}%`,
          transformOrigin: `${slotB.posX}% ${slotB.posY}%`,
        }}
      />
      <div className={`page-bg__overlay${isDynamic ? ' page-bg__overlay--dynamic' : ''}`} />
    </div>
  );
}
