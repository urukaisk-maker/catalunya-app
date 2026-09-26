import { getMonuments } from '@/lib/api';

export default async function MonumentsPage() {
  const monuments = await getMonuments();

  return (
    <main className="container">
      <h1 className="page-title">Monuments de Catalunya</h1>
      <div className="grid">
        {monuments.map((m) => (
          <div key={m.id} className="card small">
            <h3>{m.nom}</h3>
            <p><strong>Tipus:</strong> {m.tipus}</p>
            <p><strong>Municipi:</strong> {m.municipi}</p>
            <p>{m.descripcio}</p>
            <p style={{ marginTop: 8, fontSize: '.85em', color: '#666' }}>
              📍 {m.latitud}, {m.longitud}
            </p>
          </div>
        ))}
      </div>
    </main>
  );
}
