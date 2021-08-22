const staticCacheName = 's-app-v53'
const dynamicCacheName = 'd-app-v53'

const assetUrls = [ '/',
'/NodeFilter.html',
'/index.html',
'/ms-icon-144x144.png',
'/qtlogo.svg',
'/storage.dat',
'/NodeFilter.wasm',
'/NodeFilter.js',
'/manifest.json',
'/NodeFilter.data',
'/NodeFilter.wasm.map',

'/qtloader.js',]

self.addEventListener('install', async event => {
  self.skipWaiting();
  const cache = await caches.open(staticCacheName)
  await cache.addAll(assetUrls)
})

self.addEventListener('activate', async event => {
  const cacheNames = await caches.keys()
  await Promise.all(
    cacheNames
      .filter(name => name !== staticCacheName)
      .filter(name => name !== dynamicCacheName)
      .map(name => caches.delete(name))
  )
})

self.addEventListener('fetch', event => {
  const {request} = event

  // const url = new URL(request.url)
  // if (url.origin === location.origin) {
    event.respondWith(cacheFirst(request))
  // } else {
  //   event.respondWith(networkFirst(request))
  // }
})


async function cacheFirst(request) {
  const cached = await caches.match(request)
  return cached ?? await fetch(request)
}

async function networkFirst(request) {
  const cache = await caches.open(dynamicCacheName)
  try {
    const response = await fetch(request)
    await cache.put(request, response.clone())
    return response
  } catch (e) {
    const cached = await cache.match(request)
    return cached ?? await caches.match('/offline.html')
  }
}