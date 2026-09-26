const BACKEND_URL = process.env.BACKEND_URL || 'http://backend:5000';

async function jget(path) {
  const res = await fetch(`${BACKEND_URL}${path}`, { cache: 'no-store' });
  if (!res.ok) throw new Error(`Error ${res.status} a ${path}`);
  return res.json();
}

export const getProvincies    = ()        => jget('/api/provincies');
export const getComarques     = (id)      => jget(`/api/provincies/${id}/comarques`);
export const getMonuments     = ()        => jget('/api/monuments');
export const getMonumentsProv = (id)      => jget(`/api/provincies/${id}/monuments`);

export async function getProvincia(id) {
  const list = await getProvincies();
  return list.find(p => p.id === Number(id)) || null;
}
export const getPlats  = () => jget('/api/plats');
export const getFestes = () => jget('/api/festes');
