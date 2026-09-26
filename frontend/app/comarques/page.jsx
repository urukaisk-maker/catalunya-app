async function getComarques() {
  const res = await fetch('http://backend:5000/api/comarques', { cache: 'no-store' });
  if (!res.ok) throw new Error('Error carregant comarques');
  return res.json();
}

export default async function ComarquesPage() {
  const comarques = await getComarques();
  const grouped = comarques.reduce((acc, c) => {
    (acc[c.provincia] ||= []).push(c);
    return acc;
  }, {});

  return (
    <main className="container">
      <h1 className="page-title">Comarques de Catalunya ({comarques.length})</h1>
      {Object.entries(grouped).map(([provincia, list]) => (
        <section key={provincia}>
          <h2 className="section-title">{provincia}</h2>
          <div className="grid">
            {list.map((c) => (
              <div key={c.id} className="card small">
                <h3>{c.nom}</h3>
                <p style={{ fontSize: '.85em', color: '#c60b1e', marginBottom: 6 }}>
                  Capital: {c.capital}
                </p>
                {c.descripcio && <p>{c.descripcio}</p>}
              </div>
            ))}
          </div>
        </section>
      ))}
    </main>
  );
}
