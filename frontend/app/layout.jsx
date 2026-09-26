import Link from 'next/link';
import SearchBar from '@/components/SearchBar';
import './globals.css';

export const metadata = {
  title: 'Explorador de Catalunya',
  description: 'Provincies, comarques i monuments de Catalunya',
};

export default function RootLayout({ children }) {
  return (
    <html lang="ca">
      <body>
        <header className="site">
          <h1>Explorador de Catalunya</h1>
          <p>Descobreix el territori, la cultura i el patrimoni</p>
          <SearchBar />
        </header>
        <nav className="top">
          <Link href="/">Inici</Link>
          <Link href="/comarques">Comarques</Link>
          <Link href="/monuments">Monuments</Link>
          <Link href="/gastronomia">Gastronomia</Link>
          <Link href="/cultura">Cultura</Link>
          <Link href="/mapa">Mapa</Link>
          <Link href="/sobre">Sobre</Link>
        </nav>
        {children}
        <footer style={{ textAlign: 'center', color: '#fff', marginTop: 60, padding: '30px 20px', textShadow: '1px 1px 3px rgba(0,0,0,0.5)' }}>
          <p style={{ fontSize: '1.1em', marginBottom: 8 }}>🏔️ Explorador de Catalunya</p>
          <p style={{ opacity: 0.7, fontSize: '.9em' }}>Next.js · PostgreSQL · Node.js · Docker</p>
        </footer>
      </body>
    </html>
  );
}
