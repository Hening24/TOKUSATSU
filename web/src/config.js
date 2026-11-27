// Isi data diri di sini, dipakai di halaman Tentang.
export const PROFILE = {
  name: 'Hening Wijaya Imanda',
  nim: '21120124120036',
  program: 'Teknik Komputer, Universitas Diponegoro',
  course: 'Praktikum Pemrograman Perangkat Bergerak (PPB)',
  title: 'Tokusatsu Zukan: Ensiklopedia Tokusatsu Berbasis Progressive Web App',
  repo: 'https://github.com/Hening24/TOKUSATSU',
};

// Aktifkan/nonaktifkan fitur tambah, edit, hapus di UI lewat variabel lingkungan.
export const ENABLE_EDIT =
  String(import.meta.env.VITE_ENABLE_EDIT ?? 'true').trim().toLowerCase() !== 'false';
