import Link from 'next/link';
import { getProvincies } from '@/lib/api';
import Badge from '@/components/Badge';

export default async function Home() {
  const provincies = await getProvincies();

  return (
    <main className="container">
      <h1 className="page-title">Les Quatre Províncies</h1>

      <div className="grid">
        {provincies.map((p) => (
          <Link key={p.id} href={`/provincia/${p.id}`} className="card">
            <Badge tipus="provincia">Província</Badge>
            <h2>{p.nom}</h2>
            <p>{p.descripcio}</p>
          </Link>
        ))}
      </div>

      <h2 className="section-title">Explora</h2>
      <div className="grid">
        <Link href="/comarques" className="card small">
          <Badge tipus="comarca">42 comarques</Badge>
          <h3>🗺️ Comarques</h3>
          <p>Descobreix les divisions territorials de Catalunya.</p>
        </Link>
        <Link href="/monuments" className="card small">
          <Badge tipus="monument">32 monuments</Badge>
          <h3>🏛️ Patrimoni</h3>
          <p>UNESCO, modernisme, romànic i castells.</p>
        </Link>
        <Link href="/gastronomia" className="card small">
          <Badge tipus="plat">22 plats</Badge>
          <h3>🍽️ Gastronomia</h3>
          <p>Calçotada, pa amb tomàquet, crema catalana...</p>
        </Link>
        <Link href="/mapa" className="card small">
          <Badge tipus="geografia">Interactiu</Badge>
          <h3>📍 Mapa</h3>
          <p>Tots els monuments geolocalitzats.</p>
        </Link>
      </div>
    </main>
  );
}
