import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'prompt',
      includeAssets: ['favicon.svg', 'offline.html', 'icons/*.png'],
      manifest: {
        name: 'Tokusatsu Zukan',
        short_name: 'Zukan',
        description: 'Ensiklopedia tokusatsu: Kamen Rider, Super Sentai, Ultraman, dan Metal Hero.',
        lang: 'id',
        start_url: '/',
        scope: '/',
        display: 'standalone',
        background_color: '#080B14',
        theme_color: '#080B14',
        icons: [
          { src: '/icons/icon-192.png', sizes: '192x192', type: 'image/png', purpose: 'any' },
          { src: '/icons/icon-512.png', sizes: '512x512', type: 'image/png', purpose: 'any' },
          { src: '/icons/icon-maskable-512.png', sizes: '512x512', type: 'image/png', purpose: 'maskable' },
        ],
      },
      workbox: {
        globPatterns: ['**/*.{js,css,html,ico,png,svg,jpg,jpeg,webp,woff2}'],
        navigateFallback: '/index.html',
        runtimeCaching: [
          {
            // Data dari API memakai NetworkFirst agar selalu segar saat online dan tetap tersedia saat offline
            urlPattern: ({ url }) => /^\/(series|characters|actors)/.test(url.pathname),
            handler: 'NetworkFirst',
            options: {
              cacheName: 'zukan-api',
              networkTimeoutSeconds: 4,
              expiration: { maxEntries: 60, maxAgeSeconds: 60 * 60 * 24 * 7 },
              cacheableResponse: { statuses: [200] },
            },
          },
          {
            urlPattern: /^https:\/\/fonts\.(googleapis|gstatic)\.com\/.*/i,
            handler: 'CacheFirst',
            options: {
              cacheName: 'zukan-fonts',
              expiration: { maxEntries: 20, maxAgeSeconds: 60 * 60 * 24 * 365 },
              cacheableResponse: { statuses: [0, 200] },
            },
          },
        ],
      },
    }),
  ],
});
