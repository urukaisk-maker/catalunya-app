import { getPlats } from '@/lib/api';

export default async function GastronomiaPage() {
  const plats = await getPlats();

  return (
    <main className="container">
      <h1 className="page-title">Gastronomia de Catalunya</h1>
      <div className="grid">
        {plats.map((p) => (
          <div key={p.id} className="card small">
            <h3>{p.nom}</h3>
            <p style={{ fontSize: '.9em', color: '#c60b1e', marginBottom: 8 }}>
              📍 {p.origen} · 🍽️ {p.temporada}
            </p>
            <p>{p.descripcio}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
