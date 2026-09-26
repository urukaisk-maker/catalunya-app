async function jget(path) {
  const baseUrl = process.env.BACKEND_URL || 'http://backend:5000';
  const res = await fetch(baseUrl + path, { cache: 'no-store' });
  return res.json();
}

export default async function SobrePage() {
  const [geo, cultura, dites, stats] = await Promise.all([
    jget('/api/geografia'), jget('/api/cultura'), jget('/api/dites'), jget('/api/estadistiques')
  ]);

  return (
    <main className="container">
      <h1 className="page-title">Sobre Catalunya</h1>

      <h2 className="section-title">Estadistiques</h2>
      <div className="grid">
        {stats.map(s => (
          <div key={s.id} className="card small" style={{ textAlign: 'center' }}>
            <p style={{ fontSize: '2em', color: '#c60b1e', fontWeight: 700 }}>{s.valor}</p>
            <h3 style={{ marginBottom: 6 }}>{s.etiqueta}</h3>
            <p style={{ fontSize: '.85em' }}>{s.descripcio}</p>
          </div>
        ))}
      </div>

      <h2 className="section-title">Geografia</h2>
      <div className="grid">
        {geo.map(g => (
          <div key={g.id} className="card small">
            <h3>{g.nom}</h3>
            <p style={{ fontSize: '.85em', color: '#c60b1e' }}>{g.tipus}{g.altitud ? ' · ' + g.altitud + ' m' : ''}</p>
            <p>{g.descripcio}</p>
          </div>
        ))}
      </div>

      <h2 className="section-title">Cultura i simbols</h2>
      <div className="grid">
        {cultura.map(c => (
          <div key={c.id} className="card small">
            <h3>{c.nom}</h3>
            <p style={{ fontSize: '.85em', color: '#c60b1e' }}>{c.categoria}</p>
            <p>{c.descripcio}</p>
          </div>
        ))}
      </div>

      <h2 className="section-title">Dites catalanes</h2>
      <div className="grid">
        {dites.map(d => (
          <div key={d.id} className="card small">
            <h3 style={{ fontStyle: 'italic' }}>"{d.text}"</h3>
            <p style={{ fontSize: '.9em' }}>{d.significat}</p>
          </div>
        ))}
      </div>
    </main>
  );
}
