import { getFestes } from '@/lib/api';

export default async function CulturaPage() {
  const festes = await getFestes();

  return (
    <main className="container">
      <h1 className="page-title">Cultura i Tradicions</h1>
      <div className="grid">
        {festes.map((f) => (
          <div key={f.id} className="card small">
            <h3>
              {f.nom} {f.patrimoni_unesco && '🏛️'}
            </h3>
            <p style={{ fontSize: '.9em', color: '#c60b1e', marginBottom: 8 }}>
              📍 {f.lloc} · 📅 {f.epoca}
            </p>
            <p>{f.descripcio}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
