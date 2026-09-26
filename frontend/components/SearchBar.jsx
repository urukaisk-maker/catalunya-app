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
    <form onSubmit={submit} className="search-wrap">
      <input
        type="text"
        placeholder="Cerca monuments, comarques, municipis, plats..."
        value={q}
        onChange={(e) => setQ(e.target.value)}
        aria-label="Cercador global"
      />
      <button type="submit" aria-label="Cercar">🔍</button>
    </form>
  );
}
