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
          <p style={{
            fontSize: '1.05em',
            fontWeight: 600,
            color: 'var(--granate)',
            marginBottom: 8,
            fontFamily: 'Cinzel, serif',
            letterSpacing: '0.05em'
          }}>
            Explorador de Catalunya
          </p>
          <p>Fet amb Next.js · PostgreSQL · Node.js · Docker</p>

          <div style={{
            margin: '24px auto 0',
            maxWidth: 520,
            padding: '20px',
            background: 'var(--carta)',
            borderRadius: 16,
            border: '1px solid var(--pedra-clar)',
            boxShadow: '0 2px 8px rgba(42,38,32,0.06)'
          }}>
            <p style={{
              fontSize: '0.8em',
              letterSpacing: '0.15em',
              textTransform: 'uppercase',
              color: 'var(--tinta-suau)',
              marginBottom: 8,
              fontFamily: 'Montserrat, sans-serif'
            }}>
              Desenvolupat per
            </p>
            <p style={{
              fontSize: '1.15em',
              fontWeight: 700,
              color: 'var(--cobalt)',
              marginBottom: 12,
              fontFamily: 'Cinzel, serif'
            }}>
              Urukaisk-maker
            </p>
            <a
              href="https://silly-boba-dc057e.netlify.app/"
              target="_blank"
              rel="noopener noreferrer"
              style={{
                display: 'inline-block',
                padding: '10px 22px',
                background: 'linear-gradient(135deg, var(--granate), var(--cobalt))',
                color: '#fff',
                textDecoration: 'none',
                borderRadius: 999,
                fontFamily: 'Montserrat, sans-serif',
                fontWeight: 600,
                fontSize: '0.9em',
                letterSpacing: '0.05em',
                transition: 'all 0.25s',
                boxShadow: '0 4px 12px rgba(122,31,43,0.25)'
              }}
            >
              🌐 Veure el portfolio
            </a>
            <p style={{
              marginTop: 16,
              fontSize: '0.85em',
              color: 'var(--tinta-suau)'
            }}>
              <a
                href="https://github.com/urukaisk-maker"
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: 'var(--cobalt)', textDecoration: 'none', marginRight: 12 }}
              >
                GitHub
              </a>
              ·
              <a
                href="https://github.com/urukaisk-maker/catalunya-app"
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: 'var(--cobalt)', textDecoration: 'none', marginLeft: 12 }}
              >
                Repositori
              </a>
            </p>
          </div>

          <p style={{ marginTop: 24, opacity: 0.7, fontSize: '0.85em' }}>
            © 2026 Urukaisk-maker · Llicència MIT
          </p>
        </footer>
      </body>
    </html>
  );
}
