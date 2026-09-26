import Link from 'next/link';
import { notFound } from 'next/navigation';
import { getProvincia, getComarques, getMonumentsProv } from '@/lib/api';

export default async function ProvinciaPage({ params }) {
  const provincia = await getProvincia(params.id);
  if (!provincia) notFound();

  const [comarques, monuments] = await Promise.all([
    getComarques(params.id),
    getMonumentsProv(params.id),
  ]);

  return (
    <main className="container">
      <Link href="/" className="back">← Tornar a l'inici</Link>

      <h1 className="page-title">{provincia.nom}</h1>

      <div className="card">
        <p>{provincia.descripcio}</p>
      </div>

      {comarques.length > 0 && (
        <>
          <h2 className="section-title">Comarques ({comarques.length})</h2>
          <div className="grid">
            {comarques.map((c) => (
              <div key={c.id} className="card small">
                <h3>{c.nom}</h3>
                <p><strong>Capital:</strong> {c.capital}</p>
              </div>
            ))}
          </div>
        </>
      )}

      {monuments.length > 0 && (
        <>
          <h2 className="section-title">Monuments ({monuments.length})</h2>
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
        </>
      )}
    </main>
  );
}
