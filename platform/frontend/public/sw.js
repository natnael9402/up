const CACHE_NAME = 'uphold-onboarding-v1';
const URLS_TO_CACHE = [
    'https://images.unsplash.com/photo-1642790106117-e829e14a795f?q=80&w=3000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=3000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1640340434855-6084b1f4901c?q=80&w=3000&auto=format&fit=crop'
];

self.addEventListener('install', (event) => {
    self.skipWaiting();
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                return Promise.all(
                    URLS_TO_CACHE.map((url) => cache.add(url).catch(() => {}))
                );
            })
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
    if (event.request.method !== 'GET') {
        return;
    }
    if (event.request.mode === 'navigate') {
        return;
    }
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                if (response) {
                    return response;
                }
                return fetch(event.request);
            })
    );
});

self.addEventListener('push', (event) => {
    let data = { title: 'Uphold Trading', body: '' };
    try {
        if (event.data) {
            const parsed = event.data.json();
            data = Object.assign({}, data, parsed);
        }
    } catch (err) {
        // ignore malformed payload
    }

    const options = {
        body: data.body || '',
        icon: data.icon || undefined,
        badge: data.icon || undefined,
        data: Object.assign({ url: '/apps/live-chat' }, data.data || {}),
    };

    event.waitUntil(
        self.registration.showNotification(data.title || 'Uphold Trading', options)
    );
});

self.addEventListener('notificationclick', (event) => {
    event.notification.close();

    const url = (event.notification.data && event.notification.data.url) || '/apps/live-chat';
    event.waitUntil(
        self.clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((clientList) => {
                for (const client of clientList) {
                    if ('focus' in client) {
                        return client.focus();
                    }
                }
                if (self.clients.openWindow) {
                    return self.clients.openWindow(url);
                }
            })
    );
});
