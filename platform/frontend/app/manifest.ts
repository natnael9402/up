import type { MetadataRoute } from 'next';

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: 'UPHOLD Trading',
    short_name: 'UPHOLD',
    description: 'Your Smart Trading Companion',
    display: 'standalone',
    start_url: '/',
    scope: '/',
    background_color: '#08110A',
    theme_color: '#08A763',
    icons: [
      { src: '/icon-192.png', sizes: '192x192', type: 'image/png' },
      { src: '/icon-512.png', sizes: '512x512', type: 'image/png' },
      { src: '/icon-512.png', sizes: '512x512', type: 'image/png', purpose: 'maskable' },
    ],
  };
}
