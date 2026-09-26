import Link from 'next/link';
import { getProvincies } from '@/lib/api';

export default async function Home() {
  const provincies = await getProvincies();

  return (
    <main className="container">
      <div className="grid">
        {provincies.map((p) => (
          <Link key={p.id} href={`/provincia/${p.id}`} className="card">
            <h2>{p.nom}</h2>
            <p>{p.descripcio}</p>
          </Link>
        ))}
      </div>
    </main>
  );
}
