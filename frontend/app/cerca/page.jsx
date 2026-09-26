import { getCerca } from '@/lib/api';
import Badge from '@/components/Badge';

export const revalidate = 0;

export default async function CercaPage({ searchParams }) {
  const q = searchParams.q || '';
  const resultats = q ? await getCerca(q) : [];

  return (
    <main className="container">
      <h1 className="page-title">
        {resultats.length} resultats
      </h1>
      {q && (
        <p style={{
          textAlign: 'center',
          color: 'var(--tinta-suau)',
          marginBottom: 30,
          fontFamily: 'Montserrat, sans-serif'
        }}>
          per a <strong style={{ color: 'var(--granate)' }}>"{q}"</strong>
        </p>
      )}

      {resultats.length === 0 ? (
        <div className="empty-state">
          <p>🔍 Cap resultat trobat.</p>
          <p style={{ fontSize: '0.9em', marginTop: 12 }}>
            Prova amb una altra paraula: monuments, comarques, plats...
          </p>
        </div>
      ) : (
        <div className="grid">
          {resultats.map((r, i) => (
            <div key={r.tipus + '-' + r.id + '-' + i} className="card small">
              <Badge tipus={r.tipus}>{r.tipus}</Badge>
              <h3>{r.nom}</h3>
              {r.descripcio && <p>{r.descripcio}</p>}
            </div>
          ))}
        </div>
      )}
    </main>
  );
}
