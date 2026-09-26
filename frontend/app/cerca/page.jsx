export const revalidate = 0;

async function search(q) {
  const baseUrl = process.env.BACKEND_URL || 'http://backend:5000';
  const res = await fetch(baseUrl + '/api/cerca?q=' + encodeURIComponent(q), { cache: 'no-store' });
  return res.json();
}

export default async function CercaPage({ searchParams }) {
  const q = searchParams.q || '';
  const resultats = q ? await search(q) : [];

  return (
    <main className="container">
      <h1 className="page-title">Resultats per: "{q}"</h1>
      {resultats.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: 40 }}>
          <p>Cap resultat trobat.</p>
        </div>
      ) : (
        <>
          <p style={{ textAlign: 'center', color: '#fff', marginBottom: 20 }}>
            <strong>{resultats.length}</strong> resultats
          </p>
          <div className="grid">
            {resultats.map((r, i) => (
              <div key={r.tipus + '-' + r.id + '-' + i} className="card small">
                <p style={{ fontSize: '.8em', color: '#999', textTransform: 'uppercase' }}>{r.tipus}</p>
                <h3>{r.nom}</h3>
                {r.descripcio && <p>{r.descripcio}</p>}
              </div>
            ))}
          </div>
        </>
      )}
    </main>
  );
}
