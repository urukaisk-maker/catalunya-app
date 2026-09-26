'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function SearchBar() {
  const [q, setQ] = useState('');
  const router = useRouter();

  function submit(e) {
    e.preventDefault();
    if (q.trim()) router.push('/cerca?q=' + encodeURIComponent(q.trim()));
  }

  return (
    <form onSubmit={submit} style={{ maxWidth: 500, margin: '0 auto 20px', display: 'flex', gap: 8 }}>
      <input
        type="text"
        placeholder="Cerca monuments, comarques, plats..."
        value={q}
        onChange={(e) => setQ(e.target.value)}
        style={{
          flex: 1, padding: '10px 16px', borderRadius: 25,
          border: '2px solid #fff', background: 'rgba(255,255,255,0.95)',
          fontSize: '1em', outline: 'none'
        }}
      />
      <button type="submit" style={{
        padding: '10px 20px', borderRadius: 25, border: 'none',
        background: '#c60b1e', color: '#fff', fontWeight: 600, cursor: 'pointer'
      }}>🔍</button>
    </form>
  );
}
