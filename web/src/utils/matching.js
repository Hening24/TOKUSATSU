function normalizeText(value) {
  return String(value || '')
    .toLowerCase()
    .replace(/\s+/g, ' ')
    .trim();
}

function splitNameCandidates(raw) {
  const full = normalizeText(raw);
  if (!full) return [];
  const cleaned = full.replace(/\([^)]*\)/g, ' ');
  const parts = cleaned
    .split(/[\/,&;|•]+/)
    .map((part) => normalizeText(part))
    .filter(Boolean);
  return Array.from(new Set([full, normalizeText(cleaned), ...parts].filter(Boolean)));
}

/**
 * Mencocokkan nama aktor pada data karakter dengan daftar pemeran dari series terkait.
 */
export function findActorForCharacter(actors, characterActorName) {
  if (!Array.isArray(actors) || actors.length === 0) return null;
  const candidates = splitNameCandidates(characterActorName);
  if (candidates.length === 0) return null;

  for (const cand of candidates) {
    const exact = actors.find((a) => normalizeText(a.name) === cand);
    if (exact) return exact;
  }

  for (const cand of candidates) {
    if (cand.length < 4) continue;
    const partial = actors.find((a) => {
      const actorName = normalizeText(a.name);
      return actorName.length >= 4 && (actorName.includes(cand) || cand.includes(actorName));
    });
    if (partial) return partial;
  }

  return null;
}

/**
 * Mencari karakter di series yang diperankan oleh aktor terkait.
 */
export function findRelatedCharactersForActor(characters, actor) {
  if (!Array.isArray(characters) || characters.length === 0 || !actor) return [];
  const actorName = normalizeText(actor.name);
  const roleCandidates = splitNameCandidates(actor.character);

  const exactMatches = [];
  const partialMatches = [];
  const seenIds = new Set();

  for (const ch of characters) {
    const chActor = normalizeText(ch.actor);
    const chFields = [
      normalizeText(ch.name),
      normalizeText(ch.rider_name),
      normalizeText(ch.civilian_name),
    ].filter(Boolean);

    const matchesActorName =
      actorName.length >= 4 &&
      chActor &&
      (chActor === actorName || chActor.includes(actorName) || actorName.includes(chActor));

    const hasExactField = roleCandidates.some((cand) => chFields.includes(cand));

    if ((matchesActorName || hasExactField) && !seenIds.has(ch.id)) {
      seenIds.add(ch.id);
      exactMatches.push(ch);
      continue;
    }

    const hasPartialField = roleCandidates.some(
      (cand) =>
        cand.length >= 4 &&
        chFields.some((field) => field.length >= 4 && (field.includes(cand) || cand.includes(field)))
    );

    if (hasPartialField && !seenIds.has(ch.id)) {
      seenIds.add(ch.id);
      partialMatches.push(ch);
    }
  }

  return exactMatches.length > 0 ? exactMatches : partialMatches;
}
