import Link from 'next/link';
import './globals.css';

export const metadata = {
  title: 'Explorador de Catalunya',
  description: 'Províncies, comarques i monuments de Catalunya',
};

export default function RootLayout({ children }) {
  return (
    <html lang="ca">
      <body>
        <header className="site">
          <h1>Explorador de Catalunya</h1>
          <p>Descobreix el territori, la cultura i el patrimoni</p>
        </header>
        <nav className="top">
          <Link href="/">Inici</Link>
          <Link href="/monuments">Monuments</Link>
        </nav>
        {children}
      </body>
    </html>
  );
}
