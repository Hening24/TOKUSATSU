import { useEffect, useRef, useState } from 'react';
import { Hand, Image as ImageIcon, Move, RotateCcw, Trash2 } from 'lucide-react';
import {
  getHeroAspectRatio,
  normalizePosValue,
  subscribeHeroSize,
} from '../utils/imagePosition';

const FRAMES = [
  { id: 'hero', label: 'Hero beranda', modifier: 'hero' },
  { id: 'viewport', label: 'Layar lebar', modifier: 'wide' },
  { id: '9:19', label: 'HP (9:19)', modifier: 'mobile' },
  { id: '2:3', label: 'Kartu poster (2:3)', modifier: 'poster' },
];

function getViewportMetrics() {
  if (typeof window === 'undefined') {
    return { width: 1280, height: 800 };
  }
  return {
    width: Math.max(1, window.innerWidth),
    height: Math.max(1, window.innerHeight),
  };
}

function detectTouchCapable() {
  if (typeof window === 'undefined') return false;
  return (
    window.matchMedia?.('(pointer: coarse)')?.matches ||
    window.matchMedia?.('(hover: none)')?.matches ||
    'ontouchstart' in window
  );
}

function computeCoverSlack(frameEl, natW, natH) {
  if (!frameEl || !natW || !natH) return { slackX: 0, slackY: 0 };
  const rect = frameEl.getBoundingClientRect();
  const cw = rect.width;
  const ch = rect.height;
  if (cw <= 0 || ch <= 0) return { slackX: 0, slackY: 0 };
  const scale = Math.max(cw / natW, ch / natH);
  return {
    slackX: Math.max(0, natW * scale - cw),
    slackY: Math.max(0, natH * scale - ch),
  };
}

/**
 * Pengatur letak gambar interaktif:
 * - Mendukung bingkai "Hero beranda", "Layar lebar", "HP (9:19)", dan "Kartu poster (2:3)"
 * - Memakai background-size: cover & background-position agar rumusnya identik dengan Hero & PageBackground
 * - Roda mouse tetap men-scroll .modal-body; sentuh memakai tombol "Mode geser"
 */
export default function ImagePositioner({
  src,
  alt = 'Pratinjau gambar',
  posX = 50,
  posY = 50,
  defaultFrame = 'viewport',
  onPositionChange,
  onClearImage,
}) {
  const trimmed = typeof src === 'string' ? src.trim() : '';
  const isCandidateUrl =
    /^https?:\/\/\S+$/i.test(trimmed) ||
    /^data:image\/\S+/i.test(trimmed) ||
    trimmed.startsWith('/');

  const [frameId, setFrameId] = useState(defaultFrame || 'viewport');
  const [imgLoaded, setImgLoaded] = useState(false);
  const [imgFailed, setImgFailed] = useState(false);
  const [naturalSize, setNaturalSize] = useState({ w: 0, h: 0 });
  const [dragging, setDragging] = useState(false);
  const [viewport, setViewport] = useState(getViewportMetrics);
  const [, setHeroVersion] = useState(0);
  const [isTouchDevice, setIsTouchDevice] = useState(detectTouchCapable);
  const [touchDragMode, setTouchDragMode] = useState(false);

  const frameRef = useRef(null);
  const dragRef = useRef(null);
  const lastEmittedRef = useRef({
    x: normalizePosValue(posX, 50),
    y: normalizePosValue(posY, 50),
  });

  useEffect(() => {
    setFrameId(defaultFrame || 'viewport');
  }, [defaultFrame]);

  useEffect(() => {
    setImgLoaded(false);
    setImgFailed(false);
    setNaturalSize({ w: 0, h: 0 });
    dragRef.current = null;
    setDragging(false);
  }, [trimmed]);

  useEffect(() => {
    if (typeof window === 'undefined') return undefined;
    const handleResize = () => {
      setViewport(getViewportMetrics());
      setIsTouchDevice(detectTouchCapable());
    };
    window.addEventListener('resize', handleResize);
    const mqCoarse = window.matchMedia?.('(pointer: coarse)');
    const mqNoHover = window.matchMedia?.('(hover: none)');
    mqCoarse?.addEventListener?.('change', handleResize);
    mqNoHover?.addEventListener?.('change', handleResize);
    const unsubHero = subscribeHeroSize(() => setHeroVersion((v) => v + 1));
    return () => {
      window.removeEventListener('resize', handleResize);
      mqCoarse?.removeEventListener?.('change', handleResize);
      mqNoHover?.removeEventListener?.('change', handleResize);
      unsubHero();
    };
  }, []);

  const curX = normalizePosValue(posX, 50);
  const curY = normalizePosValue(posY, 50);
  lastEmittedRef.current = { x: curX, y: curY };

  if (!trimmed) {
    return (
      <div className="image-pos-empty" aria-disabled="true">
        <ImageIcon size={18} aria-hidden="true" />
        <span>Gambar belum bisa dimuat</span>
      </div>
    );
  }

  const canDrag = isCandidateUrl && imgLoaded && !imgFailed;
  const activeFrame = FRAMES.find((f) => f.id === frameId) || FRAMES[0];
  const viewportRatio = viewport.width / viewport.height;
  const heroRatio = getHeroAspectRatio(viewport.width);
  const frameRatio =
    activeFrame.id === 'hero'
      ? heroRatio
      : activeFrame.id === 'viewport'
        ? viewportRatio
        : activeFrame.id === '9:19'
          ? 9 / 19
          : 2 / 3;

  const panelPx =
    viewport.width >= 640
      ? Math.min(1200, viewport.width - 32)
      : Math.max(0, viewport.width - 16);
  const panelWidthPct = Math.max(0, Math.min(100, (panelPx / viewport.width) * 100));
  const sideWidthPct = Math.max(0, (100 - panelWidthPct) / 2);

  const emitPosition = (nextX, nextY) => {
    if (typeof onPositionChange !== 'function') return;
    if (nextX === lastEmittedRef.current.x && nextY === lastEmittedRef.current.y) return;
    lastEmittedRef.current = { x: nextX, y: nextY };
    onPositionChange(nextX, nextY);
  };

  const handlePointerDown = (e) => {
    if (!canDrag) return;
    if (e.pointerType !== 'mouse') {
      if (!isTouchDevice) setIsTouchDevice(true);
      if (!touchDragMode) {
        return;
      }
    } else if (e.button !== 0) {
      return;
    }

    e.preventDefault();
    e.stopPropagation();

    try {
      e.currentTarget.focus({ preventScroll: true });
    } catch {
      e.currentTarget.focus();
    }

    const { slackX, slackY } = computeCoverSlack(frameRef.current, naturalSize.w, naturalSize.h);
    dragRef.current = {
      pointerId: e.pointerId,
      startX: e.clientX,
      startY: e.clientY,
      originPosX: curX,
      originPosY: curY,
      slackX,
      slackY,
    };

    try {
      e.currentTarget.setPointerCapture(e.pointerId);
    } catch {
      /* abaikan bila event sintetis tanpa pointer aktif */
    }
    setDragging(true);
  };

  const handlePointerMove = (e) => {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== e.pointerId) return;
    e.preventDefault();
    e.stopPropagation();

    const dx = e.clientX - drag.startX;
    const dy = e.clientY - drag.startY;

    const nextX =
      drag.slackX > 0.5
        ? normalizePosValue(Math.round(drag.originPosX - (dx / drag.slackX) * 100), curX)
        : drag.originPosX;
    const nextY =
      drag.slackY > 0.5
        ? normalizePosValue(Math.round(drag.originPosY - (dy / drag.slackY) * 100), curY)
        : drag.originPosY;

    emitPosition(nextX, nextY);
  };

  const handlePointerEnd = (e) => {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== e.pointerId) return;
    e.stopPropagation();
    try {
      e.currentTarget.releasePointerCapture(e.pointerId);
    } catch {
      /* abaikan */
    }
    dragRef.current = null;
    setDragging(false);
  };

  const handleKeyDown = (e) => {
    if (!canDrag) return;
    const step = e.shiftKey ? 10 : 2;
    const { slackX, slackY } = computeCoverSlack(frameRef.current, naturalSize.w, naturalSize.h);

    if (e.key === 'ArrowLeft') {
      e.preventDefault();
      if (slackX > 0.5) emitPosition(normalizePosValue(curX - step, curX), curY);
    } else if (e.key === 'ArrowRight') {
      e.preventDefault();
      if (slackX > 0.5) emitPosition(normalizePosValue(curX + step, curX), curY);
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      if (slackY > 0.5) emitPosition(curX, normalizePosValue(curY - step, curY));
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (slackY > 0.5) emitPosition(curX, normalizePosValue(curY + step, curY));
    }
  };

  return (
    <div className="image-pos">
      <div className="image-pos__top-bar">
        <div className="image-pos__hint">
          <Move size={16} aria-hidden="true" />
          <span>Geser gambar untuk mengatur bagian yang terlihat</span>
        </div>

        {(isTouchDevice || viewport.width < 768) && (
          <button
            type="button"
            className={`image-pos__mode-btn${touchDragMode ? ' is-active' : ''}`}
            aria-pressed={touchDragMode}
            disabled={!canDrag}
            onClick={() => setTouchDragMode((v) => !v)}
          >
            <Hand size={15} aria-hidden="true" />
            <span>{touchDragMode ? 'Mode geser: Aktif' : 'Mode geser'}</span>
          </button>
        )}
      </div>

      <p className="image-pos__shared-note">
        Satu posisi dipakai di semua tampilan. Periksa bingkai lain sebelum menyimpan.
      </p>

      <div className="image-pos__frames" role="group" aria-label="Pilih bingkai pratinjau">
        {FRAMES.map((frame) => {
          const active = frame.id === activeFrame.id;
          return (
            <button
              key={frame.id}
              type="button"
              className={`image-pos__frame-btn${active ? ' is-active' : ''}`}
              aria-pressed={active}
              onClick={() => setFrameId(frame.id)}
            >
              {frame.label}
            </button>
          );
        })}
      </div>

      <div className="image-pos__stage">
        <div
          ref={frameRef}
          className={[
            'image-pos__frame',
            `image-pos__frame--${activeFrame.modifier}`,
            touchDragMode ? 'is-touch-drag' : '',
            dragging ? 'is-dragging' : '',
            !canDrag ? 'is-disabled' : '',
          ]
            .filter(Boolean)
            .join(' ')}
          style={{ '--frame-ratio': `${frameRatio}` }}
          role="application"
          aria-label="Atur letak gambar"
          aria-disabled={!canDrag}
          tabIndex={canDrag ? 0 : -1}
          onPointerDown={handlePointerDown}
          onPointerMove={handlePointerMove}
          onPointerUp={handlePointerEnd}
          onPointerCancel={handlePointerEnd}
          onKeyDown={handleKeyDown}
        >
          {isCandidateUrl && !imgFailed && (
            <>
              <div
                className="image-pos__surface"
                style={{
                  backgroundImage: `url("${trimmed}")`,
                  backgroundPosition: `${curX}% ${curY}%`,
                }}
                aria-hidden="true"
              />
              <img
                src={trimmed}
                alt={alt}
                draggable={false}
                className="image-pos__probe"
                onLoad={(e) => {
                  setNaturalSize({
                    w: e.currentTarget.naturalWidth || 0,
                    h: e.currentTarget.naturalHeight || 0,
                  });
                  setImgLoaded(true);
                  setImgFailed(false);
                }}
                onError={() => {
                  setImgFailed(true);
                  setImgLoaded(false);
                }}
              />
            </>
          )}

          {canDrag && activeFrame.id === 'hero' && (
            <div className="image-pos__hero-guide" aria-hidden="true">
              <div className="image-pos__hero-text-box">
                <span className="image-pos__panel-label">Area teks</span>
              </div>
            </div>
          )}

          {canDrag && activeFrame.id === 'viewport' && (
            <div className="image-pos__panel-guide" aria-hidden="true">
              <div className="image-pos__panel-side" style={{ width: `${sideWidthPct}%` }} />
              <div className="image-pos__panel-center" style={{ width: `${panelWidthPct}%` }}>
                <span className="image-pos__panel-label">Tertutup panel</span>
              </div>
              <div className="image-pos__panel-side" style={{ width: `${sideWidthPct}%` }} />
            </div>
          )}

          {(!isCandidateUrl || imgFailed) && (
            <div className="image-pos__status">
              <ImageIcon size={20} aria-hidden="true" />
              <span>Gambar belum bisa dimuat</span>
            </div>
          )}
        </div>
      </div>

      {canDrag && (
        <div className="image-pos-live-wrap">
          <div className="image-pos-live__caption">Seperti di halaman</div>
          <div
            className="image-pos-live"
            style={{ '--frame-ratio': `${viewportRatio}` }}
            aria-label="Pratinjau seperti di halaman"
          >
            <div
              className="page-bg__layer page-bg__layer--active"
              style={{
                backgroundImage: `url("${trimmed}")`,
                backgroundPosition: `${curX}% ${curY}%`,
                transformOrigin: `${curX}% ${curY}%`,
              }}
              aria-hidden="true"
            />
            <div className="page-bg__overlay page-bg__overlay--dynamic" aria-hidden="true" />
            <div
              className="image-pos-live__panel"
              style={{ width: `${panelWidthPct}%` }}
              aria-hidden="true"
            >
              <span className="image-pos-live__bar image-pos-live__bar--title" />
              <span className="image-pos-live__bar" />
              <span className="image-pos-live__bar image-pos-live__bar--short" />
            </div>
          </div>
        </div>
      )}

      <div className="image-pos__actions">
        <button
          type="button"
          className="btn-secondary image-pos__action-btn"
          disabled={!canDrag}
          onClick={() => onPositionChange?.(50, 50)}
        >
          <RotateCcw size={15} aria-hidden="true" />
          <span>Setel ulang</span>
        </button>
        {typeof onClearImage === 'function' && (
          <button
            type="button"
            className="btn-outline image-pos__action-btn"
            onClick={onClearImage}
          >
            <Trash2 size={15} aria-hidden="true" />
            <span>Hapus gambar</span>
          </button>
        )}
      </div>
    </div>
  );
}
