'use client';

import { useEffect, useRef, useState } from 'react';

export default function MapaPage() {
  const mapRef = useRef(null);
  const mapInstance = useRef(null);
  const [monuments, setMonuments] = useState([]);
  const [carregat, setCarregat] = useState(false);

  useEffect(() => {
    fetch('/api/monuments')
      .then(r => r.json())
      .then(data => setMonuments(data.filter(m => m.latitud && m.longitud)))
      .catch(console.error);
  }, []);

  useEffect(() => {
    if (carregat || typeof window === 'undefined') return;
    const css = document.createElement('link');
    css.rel = 'stylesheet';
    css.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
    document.head.appendChild(css);
    const script = document.createElement('script');
    script.src = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.js';
    script.onload = () => setCarregat(true);
    document.body.appendChild(script);
  }, [carregat]);

  useEffect(() => {
    if (!carregat || !mapRef.current || mapInstance.current) return;
    const L = window.L;
    const map = L.map(mapRef.current).setView([41.6, 1.8], 8);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap', maxZoom: 18
    }).addTo(map);
    monuments.forEach(m => {
      L.marker([m.latitud, m.longitud]).addTo(map)
        .bindPopup('<strong>' + m.nom + '</strong><br/>' + (m.tipus || '') + '<br/>' + m.municipi);
    });
    mapInstance.current = map;
  }, [carregat, monuments]);

  return (
    <main className="container">
      <h1 className="page-title">Mapa de Monuments</h1>
      <p style={{ textAlign: 'center', color: '#fff', marginBottom: 20 }}>{monuments.length} monuments al mapa</p>
      <div ref={mapRef} style={{ height: '70vh', width: '100%', maxWidth: 1100, margin: '0 auto', borderRadius: 15, boxShadow: '0 8px 20px rgba(0,0,0,0.3)' }} />
    </main>
  );
}
