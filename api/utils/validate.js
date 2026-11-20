const ALLOWED_FRANCHISES = ['Kamen Rider', 'Super Sentai', 'Ultraman', 'Metal Hero'];
const ALLOWED_ERAS = ['Showa', 'Heisei', 'Reiwa'];
const ALLOWED_ACTOR_ROLES = ['MC', 'Secondary Rider', 'Hero', 'Villain'];

const clean = (v) => (typeof v === 'string' && v.trim() ? v.trim() : null);

function validateString(value, fieldLabel, { required = false, max = 300 } = {}) {
  if (value === undefined || value === null || value === '') {
    if (required) return { error: `${fieldLabel} wajib diisi.` };
    return { value: null };
  }
  if (typeof value !== 'string') {
    return { error: `${fieldLabel} harus berupa teks.` };
  }
  const trimmed = value.trim();
  if (!trimmed) {
    if (required) return { error: `${fieldLabel} tidak boleh kosong.` };
    return { value: null };
  }
  if (trimmed.length > max) {
    return { error: `${fieldLabel} maksimal ${max} karakter.` };
  }
  return { value: trimmed };
}

function validateEnum(value, fieldLabel, allowed, { required = false, fallback = null } = {}) {
  const str = validateString(value, fieldLabel, { required, max: 100 });
  if (str.error) return str;
  if (str.value === null) return { value: fallback };
  if (!allowed.includes(str.value)) {
    return { error: `${fieldLabel} harus salah satu dari: ${allowed.join(', ')}.` };
  }
  return { value: str.value };
}

function validateInt(value, fieldLabel, { required = false, min = 0, max = 999999 } = {}) {
  if (value === undefined || value === null || value === '') {
    if (required) return { error: `${fieldLabel} wajib diisi.` };
    return { value: null };
  }
  const num = Number(value);
  if (!Number.isInteger(num) || num < min || num > max) {
    return { error: `${fieldLabel} harus berupa bilangan bulat antara ${min} dan ${max}.` };
  }
  return { value: num };
}

function validateNumber(value, fieldLabel, { min = 0, max = 1000000 } = {}) {
  if (value === undefined || value === null || value === '') {
    return { value: null };
  }
  const num = Number(value);
  if (!Number.isFinite(num) || num < min || num > max) {
    return { error: `${fieldLabel} harus berupa angka antara ${min} dan ${max}.` };
  }
  return { value: num };
}

function validateUrl(value, fieldLabel) {
  const str = validateString(value, fieldLabel, { required: false, max: 1000 });
  if (str.error) return str;
  if (str.value === null) return { value: null };
  if (!/^https?:\/\/\S+$/i.test(str.value) && !str.value.startsWith('/')) {
    return { error: `${fieldLabel} harus berupa URL http(s):// atau path relatif yang valid.` };
  }
  return { value: str.value };
}

function validateImagePos(value, fieldLabel) {
  if (value === undefined || value === null || value === '') {
    return { value: 50 };
  }
  const num = Number(value);
  if (!Number.isInteger(num) || num < 0 || num > 100) {
    return { error: `${fieldLabel} harus berupa bilangan bulat antara 0 dan 100.` };
  }
  return { value: num };
}

function validateSeriesPayload(body = {}) {
  const title = validateString(body.title, 'Judul series', { required: true, max: 200 });
  if (title.error) return { error: title.error };

  const franchise = validateEnum(body.franchise, 'Franchise', ALLOWED_FRANCHISES, { required: true });
  if (franchise.error) return { error: franchise.error };

  const era = validateEnum(body.era, 'Era', ALLOWED_ERAS, { required: true });
  if (era.error) return { error: era.error };

  const year = validateInt(body.year, 'Tahun tayang', { min: 1950, max: 2100 });
  if (year.error) return { error: year.error };

  const episodes = validateInt(body.episodes, 'Jumlah episode', { min: 1, max: 2000 });
  if (episodes.error) return { error: episodes.error };

  const studio = validateString(body.studio, 'Produksi / Studio', { max: 200 });
  if (studio.error) return { error: studio.error };

  const poster = validateUrl(body.poster, 'URL Poster');
  if (poster.error) return { error: poster.error };

  const image_pos_x = validateImagePos(body.image_pos_x, 'Posisi fokus X');
  if (image_pos_x.error) return { error: image_pos_x.error };

  const image_pos_y = validateImagePos(body.image_pos_y, 'Posisi fokus Y');
  if (image_pos_y.error) return { error: image_pos_y.error };

  const synopsis = validateString(body.synopsis, 'Sinopsis', { max: 5000 });
  if (synopsis.error) return { error: synopsis.error };

  const full_plot = validateString(body.full_plot, 'Alur cerita lengkap', { max: 25000 });
  if (full_plot.error) return { error: full_plot.error };

  let arcsJson = '[]';
  if (body.history_arcs !== undefined && body.history_arcs !== null) {
    if (Array.isArray(body.history_arcs)) {
      if (body.history_arcs.length > 50) {
        return { error: 'Maksimal 50 sub-bab riwayat diperbolehkan.' };
      }
      arcsJson = JSON.stringify(body.history_arcs);
    } else if (typeof body.history_arcs === 'string') {
      try {
        const parsed = JSON.parse(body.history_arcs);
        if (!Array.isArray(parsed)) return { error: 'history_arcs harus berupa array JSON.' };
        arcsJson = JSON.stringify(parsed);
      } catch {
        return { error: 'Format JSON history_arcs tidak valid.' };
      }
    } else {
      return { error: 'history_arcs harus berupa array.' };
    }
  }

  return {
    data: {
      title: title.value,
      franchise: franchise.value,
      era: era.value,
      year: year.value,
      episodes: episodes.value,
      studio: studio.value,
      poster: poster.value,
      image_pos_x: image_pos_x.value,
      image_pos_y: image_pos_y.value,
      synopsis: synopsis.value,
      full_plot: full_plot.value,
      arcsJson,
    },
  };
}

function validateCharacterPayload(body = {}) {
  const series_id = validateInt(body.series_id, 'Series asal', { required: true, min: 1, max: 1000000 });
  if (series_id.error) return { error: series_id.error };

  const name = validateString(body.name, 'Nama karakter', { required: true, max: 200 });
  if (name.error) return { error: name.error };

  const actor = validateString(body.actor, 'Aktor / Pengisi suara', { max: 200 });
  if (actor.error) return { error: actor.error };

  const power = validateString(body.power, 'Kekuatan & senjata', { max: 5000 });
  if (power.error) return { error: power.error };

  const image = validateUrl(body.image, 'URL Gambar karakter');
  if (image.error) return { error: image.error };

  const image_pos_x = validateImagePos(body.image_pos_x, 'Posisi fokus X');
  if (image_pos_x.error) return { error: image_pos_x.error };

  const image_pos_y = validateImagePos(body.image_pos_y, 'Posisi fokus Y');
  if (image_pos_y.error) return { error: image_pos_y.error };

  const bio = validateString(body.bio, 'Biografi karakter', { max: 10000 });
  if (bio.error) return { error: bio.error };

  const rider_name = validateString(body.rider_name, 'Nama wujud hero', { max: 200 });
  if (rider_name.error) return { error: rider_name.error };

  const civilian_name = validateString(body.civilian_name, 'Nama sipil', { max: 200 });
  if (civilian_name.error) return { error: civilian_name.error };

  const role = validateString(body.role, 'Peran', { max: 120 });
  if (role.error) return { error: role.error };

  const species = validateString(body.species, 'Species', { max: 150 });
  if (species.error) return { error: species.error };

  const team = validateString(body.team, 'Team', { max: 150 });
  if (team.error) return { error: team.error };

  const debut_episode = validateString(body.debut_episode, 'Episode debut', { max: 250 });
  if (debut_episode.error) return { error: debut_episode.error };

  const height_cm = validateNumber(body.height_cm, 'Tinggi (cm)', { min: 0.1, max: 100000 });
  if (height_cm.error) return { error: height_cm.error };

  const weight_kg = validateNumber(body.weight_kg, 'Berat (kg)', { min: 0.1, max: 10000000 });
  if (weight_kg.error) return { error: weight_kg.error };

  const punch_power_t = validateNumber(body.punch_power_t, 'Kekuatan pukulan (ton)', { min: 0.01, max: 100000 });
  if (punch_power_t.error) return { error: punch_power_t.error };

  const kick_power_t = validateNumber(body.kick_power_t, 'Kekuatan tendangan (ton)', { min: 0.01, max: 100000 });
  if (kick_power_t.error) return { error: kick_power_t.error };

  const max_jump_m = validateNumber(body.max_jump_m, 'Tinggi lompatan (m)', { min: 0.1, max: 10000 });
  if (max_jump_m.error) return { error: max_jump_m.error };

  const run_100m_s = validateNumber(body.run_100m_s, 'Lari 100m (detik)', { min: 0.01, max: 1000 });
  if (run_100m_s.error) return { error: run_100m_s.error };

  const age_text = validateString(body.age_text, 'Usia', { max: 100 });
  if (age_text.error) return { error: age_text.error };

  const origin = validateString(body.origin, 'Asal', { max: 200 });
  if (origin.error) return { error: origin.error };

  const blood_type = validateString(body.blood_type, 'Golongan darah', { max: 50 });
  if (blood_type.error) return { error: blood_type.error };

  const occupation = validateString(body.occupation, 'Pekerjaan', { max: 200 });
  if (occupation.error) return { error: occupation.error };

  const stats_note = validateString(body.stats_note, 'Catatan statistik', { max: 1000 });
  if (stats_note.error) return { error: stats_note.error };

  const source_url = validateUrl(body.source_url, 'URL Sumber');
  if (source_url.error) return { error: source_url.error };

  let arcsJson = '[]';
  if (body.history_arcs !== undefined && body.history_arcs !== null) {
    if (Array.isArray(body.history_arcs)) {
      if (body.history_arcs.length > 50) {
        return { error: 'Maksimal 50 sub-bab riwayat diperbolehkan.' };
      }
      arcsJson = JSON.stringify(body.history_arcs);
    } else if (typeof body.history_arcs === 'string') {
      try {
        const parsed = JSON.parse(body.history_arcs);
        if (!Array.isArray(parsed)) return { error: 'history_arcs harus berupa array JSON.' };
        arcsJson = JSON.stringify(parsed);
      } catch {
        return { error: 'Format JSON history_arcs tidak valid.' };
      }
    } else {
      return { error: 'history_arcs harus berupa array.' };
    }
  }

  return {
    data: {
      series_id: series_id.value,
      name: name.value,
      actor: actor.value,
      power: power.value,
      image: image.value,
      image_pos_x: image_pos_x.value,
      image_pos_y: image_pos_y.value,
      bio: bio.value,
      rider_name: rider_name.value,
      civilian_name: civilian_name.value,
      role: role.value,
      species: species.value,
      team: team.value,
      debut_episode: debut_episode.value,
      height_cm: height_cm.value,
      weight_kg: weight_kg.value,
      punch_power_t: punch_power_t.value,
      kick_power_t: kick_power_t.value,
      max_jump_m: max_jump_m.value,
      run_100m_s: run_100m_s.value,
      age_text: age_text.value,
      origin: origin.value,
      blood_type: blood_type.value,
      occupation: occupation.value,
      stats_note: stats_note.value,
      source_url: source_url.value,
      arcsJson,
    },
  };
}

function validateActorPayload(body = {}) {
  const name = validateString(body.name, 'Nama aktor', { required: true, max: 200 });
  if (name.error) return { error: name.error };

  const kanji = validateString(body.kanji, 'Nama Kanji', { max: 200 });
  if (kanji.error) return { error: kanji.error };

  const character = validateString(body.character, 'Nama karakter', { required: true, max: 250 });
  if (character.error) return { error: character.error };

  const role_type = validateEnum(body.role_type, 'Peran dalam cerita', ALLOWED_ACTOR_ROLES, {
    required: false,
    fallback: 'MC',
  });
  if (role_type.error) return { error: role_type.error };

  const series_id = validateInt(body.series_id, 'Series', { min: 1, max: 1000000 });
  if (series_id.error) return { error: series_id.error };

  const birth_date = validateString(body.birth_date, 'Tanggal lahir', { max: 120 });
  if (birth_date.error) return { error: birth_date.error };

  const birth_place = validateString(body.birth_place, 'Asal', { max: 150 });
  if (birth_place.error) return { error: birth_place.error };

  const agency = validateString(body.agency, 'Agensi', { max: 150 });
  if (agency.error) return { error: agency.error };

  const photo = validateUrl(body.photo, 'URL Foto');
  if (photo.error) return { error: photo.error };

  const image_pos_x = validateImagePos(body.image_pos_x, 'Posisi fokus X');
  if (image_pos_x.error) return { error: image_pos_x.error };

  const image_pos_y = validateImagePos(body.image_pos_y, 'Posisi fokus Y');
  if (image_pos_y.error) return { error: image_pos_y.error };

  const bio = validateString(body.bio, 'Biografi', { max: 5000 });
  if (bio.error) return { error: bio.error };

  return {
    data: {
      name: name.value,
      kanji: kanji.value,
      character: character.value,
      role_type: role_type.value,
      series_id: series_id.value,
      birth_date: birth_date.value,
      birth_place: birth_place.value,
      agency: agency.value,
      photo: photo.value,
      image_pos_x: image_pos_x.value,
      image_pos_y: image_pos_y.value,
      bio: bio.value,
    },
  };
}

function validateArcPayload(body = {}, { orderRequired = false } = {}) {
  const arc_order = validateInt(body.arc_order, 'Urutan arc', {
    required: orderRequired,
    min: 1,
    max: 1000,
  });
  if (arc_order.error) return { error: arc_order.error };

  const chapter_label = validateString(body.chapter_label, 'Label bab', { max: 100 });
  if (chapter_label.error) return { error: chapter_label.error };

  const title = validateString(body.title, 'Judul arc', { required: true, max: 250 });
  if (title.error) return { error: title.error };

  const episode_range = validateString(body.episode_range, 'Referensi episode', { max: 200 });
  if (episode_range.error) return { error: episode_range.error };

  const summary = validateString(body.summary, 'Narasi / ringkasan', { max: 25000 });
  if (summary.error) return { error: summary.error };

  const quote_text = validateString(body.quote_text, 'Kutipan dialog', { max: 1000 });
  if (quote_text.error) return { error: quote_text.error };

  const quote_by = validateString(body.quote_by, 'Tokoh pembicara', { max: 200 });
  if (quote_by.error) return { error: quote_by.error };

  const image_url = validateUrl(body.image_url, 'URL Gambar adegan');
  if (image_url.error) return { error: image_url.error };

  const image_caption = validateString(body.image_caption, 'Keterangan gambar', { max: 500 });
  if (image_caption.error) return { error: image_caption.error };

  return {
    data: {
      arc_order: arc_order.value,
      chapter_label: chapter_label.value,
      title: title.value,
      episode_range: episode_range.value,
      summary: summary.value,
      quote_text: quote_text.value,
      quote_by: quote_by.value,
      image_url: image_url.value,
      image_caption: image_caption.value,
    },
  };
}

const IMAGE_POS_MIGRATION_FILE = 'api/sql/migrations/005_image_position.sql';
const posColsCache = new Map();

async function hasImagePosColumns(pool, tableName) {
  if (posColsCache.get(tableName) === true) return true;
  const { rows } = await pool.query(
    `SELECT column_name FROM information_schema.columns
     WHERE table_schema = 'public' AND table_name = $1
       AND column_name IN ('image_pos_x', 'image_pos_y')`,
    [tableName]
  );
  const exists = rows.length === 2;
  if (exists) posColsCache.set(tableName, true);
  return exists;
}

function withImagePosMeta(row, withPos) {
  if (withPos) {
    return { ...row, image_pos_supported: true };
  }
  return {
    ...row,
    image_pos_supported: false,
    migration_file: IMAGE_POS_MIGRATION_FILE,
  };
}

module.exports = {
  ALLOWED_FRANCHISES,
  ALLOWED_ERAS,
  ALLOWED_ACTOR_ROLES,
  clean,
  hasImagePosColumns,
  withImagePosMeta,
  validateSeriesPayload,
  validateCharacterPayload,
  validateActorPayload,
  validateArcPayload,
};
