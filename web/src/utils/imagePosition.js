let measuredHeroSize = null;
const heroListeners = new Set();

export function normalizePosValue(value, fallback = 50) {
  if (value === undefined || value === null || value === '') return fallback;
  const n = Number(value);
  if (!Number.isFinite(n)) return fallback;
  return Math.max(0, Math.min(100, Math.round(n)));
}

export function getImagePosition(item) {
  const posX = normalizePosValue(item?.image_pos_x, 50);
  const posY = normalizePosValue(item?.image_pos_y, 50);
  return {
    posX,
    posY,
    cssPosition: `${posX}% ${posY}%`,
  };
}

export function getImageObjectPositionStyle(item) {
  return { objectPosition: getImagePosition(item).cssPosition };
}

export function getCssHeroHeight(viewportWidth) {
  if (viewportWidth >= 1200) return 480;
  if (viewportWidth >= 768) return 440;
  return 300;
}

export function setMeasuredHeroSize(width, height) {
  if (!Number.isFinite(width) || !Number.isFinite(height) || width <= 0 || height <= 0) return;
  const next = { width: Math.round(width), height: Math.round(height) };
  if (
    measuredHeroSize &&
    measuredHeroSize.width === next.width &&
    measuredHeroSize.height === next.height
  ) {
    return;
  }
  measuredHeroSize = next;
  heroListeners.forEach((fn) => fn(measuredHeroSize));
}

export function getHeroAspectRatio(viewportWidth) {
  if (
    measuredHeroSize &&
    measuredHeroSize.width > 0 &&
    measuredHeroSize.height > 0 &&
    Math.abs(measuredHeroSize.width - viewportWidth) <= 32
  ) {
    return measuredHeroSize.width / measuredHeroSize.height;
  }
  return Math.max(1, viewportWidth) / getCssHeroHeight(viewportWidth);
}

export function subscribeHeroSize(fn) {
  heroListeners.add(fn);
  return () => heroListeners.delete(fn);
}

export function notifySaveWithImagePosCheck(showToast, savedResult, successMessage) {
  if (savedResult && savedResult.image_pos_supported === false) {
    const migrationFile =
      savedResult.migration_file || 'api/sql/migrations/005_image_position.sql';
    showToast(
      `Posisi gambar belum tersimpan karena migrasi database belum dijalankan. Jalankan file ${migrationFile} di Neon.`,
      'warning'
    );
    return;
  }
  showToast(successMessage);
}
