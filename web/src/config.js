// Isi data diri di sini, dipakai di halaman Tentang.
export const PROFILE = {
  name: '[Nama]',
  nim: '[NIM]',
  program: 'Teknik Komputer, Universitas Diponegoro',
  course: '[Mata kuliah]',
  repo: 'https://github.com/Hening24/TOKUSATSU',
};

// Aktifkan/nonaktifkan fitur tambah, edit, hapus di UI lewat variabel lingkungan.
export const ENABLE_EDIT =
  String(import.meta.env.VITE_ENABLE_EDIT ?? 'true').trim().toLowerCase() !== 'false';
