import Link from 'next/link';
import SearchBar from '@/components/SearchBar';
import './globals.css';

export const metadata = {
  title: 'Explorador de Catalunya',
  description: 'Províncies, comarques, municipis i monuments de Catalunya',
};

export default function RootLayout({ children }) {
  return (
    <html lang="ca">
      <body>
        <header className="site">
          <h1>Explorador de Catalunya</h1>
          <p>Territori · Cultura · Patrimoni</p>
          <SearchBar />
        </header>

        <nav className="top">
          <Link href="/">🏠 Inici</Link>
          <Link href="/comarques">🗺️ Comarques</Link>
          <Link href="/monuments">🏛️ Monuments</Link>
          <Link href="/gastronomia">🍽️ Gastronomia</Link>
          <Link href="/cultura">🎭 Cultura</Link>
          <Link href="/mapa">📍 Mapa</Link>
          <Link href="/sobre">ℹ️ Sobre</Link>
        </nav>

        {children}

        <footer className="site-footer">
          <div className="diamond">◆ ◆ ◆</div>
          <p style={{ fontSize: '1.05em', fontWeight: 600, color: 'var(--granate)', marginBottom: 8 }}>
            Explorador de Catalunya
          </p>
          <p>Fet amb Next.js · PostgreSQL · Node.js · Docker</p>
          <p style={{ marginTop: 12, opacity: 0.7, fontSize: '0.85em' }}>
            © 2026 Urukaisk-maker · Llicència MIT
          </p>
        </footer>
      </body>
    </html>
  );
}
