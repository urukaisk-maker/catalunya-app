const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const { basicAuth } = require('./middleware/auth');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  host: 'db',
  port: 5432,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB
});

app.get('/health', async (req, res) => {
  try { await pool.query('SELECT 1'); res.json({ status: 'ok' }); }
  catch (e) { res.status(503).json({ error: e.message }); }
});

app.get('/api/provincies', async (req, res) => {
  try { const r = await pool.query('SELECT * FROM provincies ORDER BY id'); res.json(r.rows); }
  catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/provincies/:id/comarques', async (req, res) => {
  try { const r = await pool.query('SELECT * FROM comarques WHERE provincia_id = $1 ORDER BY nom', [req.params.id]); res.json(r.rows); }
  catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/provincies/:id/monuments', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT mo.*, mu.nom AS municipi FROM monuments mo
       JOIN municipis mu ON mo.municipi_id = mu.id
       JOIN comarques co ON mu.comarca_id = co.id
       WHERE co.provincia_id = $1 ORDER BY mo.nom`,
      [req.params.id]
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/comarques', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT c.*, p.nom AS provincia FROM comarques c
       JOIN provincies p ON c.provincia_id = p.id ORDER BY c.nom`
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/comarques/:id', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT c.*, p.nom AS provincia FROM comarques c
       JOIN provincies p ON c.provincia_id = p.id WHERE c.id = $1`,
      [req.params.id]
    );
    if (!r.rows[0]) return res.status(404).json({ error: 'No trobat' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/comarques/:id/municipis', async (req, res) => {
  try { const r = await pool.query('SELECT * FROM municipis WHERE comarca_id = $1 ORDER BY nom', [req.params.id]); res.json(r.rows); }
  catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/municipis', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT m.*, c.nom AS comarca FROM municipis m
       JOIN comarques c ON m.comarca_id = c.id ORDER BY m.nom`
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/monuments', async (req, res) => {
  try {
    const { tipus } = req.query;
    const sql = tipus
      ? 'SELECT m.*, mu.nom AS municipi FROM monuments m JOIN municipis mu ON m.municipi_id = mu.id WHERE m.tipus = $1 ORDER BY m.nom'
      : 'SELECT m.*, mu.nom AS municipi FROM monuments m JOIN municipis mu ON m.municipi_id = mu.id ORDER BY m.nom';
    const r = await pool.query(sql, tipus ? [tipus] : []);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/monuments/:id', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT m.*, mu.nom AS municipi, c.nom AS comarca, p.nom AS provincia
       FROM monuments m
       JOIN municipis mu ON m.municipi_id = mu.id
       JOIN comarques c ON mu.comarca_id = c.id
       JOIN provincies p ON c.provincia_id = p.id
       WHERE m.id = $1`,
      [req.params.id]
    );
    if (!r.rows[0]) return res.status(404).json({ error: 'No trobat' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.post('/api/monuments', basicAuth, async (req, res) => {
  const { nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio } = req.body;
  if (!nom || !municipi_id) return res.status(400).json({ error: 'nom i municipi_id obligatoris' });
  try {
    const r = await pool.query(
      `INSERT INTO monuments (nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio]
    );
    res.status(201).json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.put('/api/monuments/:id', basicAuth, async (req, res) => {
  const { nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio } = req.body;
  try {
    const r = await pool.query(
      `UPDATE monuments SET nom=$1, municipi_id=$2, tipus=$3, descripcio=$4,
       latitud=$5, longitud=$6, any_construccio=$7 WHERE id=$8 RETURNING *`,
      [nom, municipi_id, tipus, descripcio, latitud, longitud, any_construccio, req.params.id]
    );
    if (!r.rows[0]) return res.status(404).json({ error: 'No trobat' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.delete('/api/monuments/:id', basicAuth, async (req, res) => {
  try {
    const r = await pool.query('DELETE FROM monuments WHERE id=$1 RETURNING *', [req.params.id]);
    if (!r.rows[0]) return res.status(404).json({ error: 'No trobat' });
    res.json({ ok: true, deleted: r.rows[0] });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/admin/check', basicAuth, (req, res) => {
  res.json({ ok: true, user: process.env.ADMIN_USER });
});

app.get('/api/plats', async (req, res) => {
  try {
    const r = await pool.query('SELECT p.*, pr.nom AS provincia FROM plats_tradicionals p LEFT JOIN provincies pr ON p.provincia_id=pr.id ORDER BY p.nom');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/festes', async (req, res) => {
  try {
    const r = await pool.query('SELECT f.*, pr.nom AS provincia FROM festes_tradicions f LEFT JOIN provincies pr ON f.provincia_id=pr.id ORDER BY f.nom');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/geografia', async (req, res) => {
  try {
    const r = await pool.query('SELECT g.*, p.nom AS provincia FROM geografia g LEFT JOIN provincies p ON g.provincia_id=p.id ORDER BY g.tipus, g.nom');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/cultura', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM cultura_general ORDER BY categoria, nom');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/dites', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM dites ORDER BY id');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/estadistiques', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM estadistiques ORDER BY id');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/api/cerca', async (req, res) => {
  const raw = (req.query.q || '').toLowerCase().trim();
  const q = '%' + raw + '%';
  const qs = '%' + raw.normalize('NFD').replace(/[\u0300-\u036f]/g, '') + '%';
  try {
    const r = await pool.query(
      `SELECT 'provincia' AS tipus, id, nom, descripcio FROM provincies
         WHERE LOWER(nom) LIKE $1 OR LOWER(descripcio) LIKE $1
       UNION ALL
       SELECT 'comarca', id, nom, descripcio FROM comarques
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2
       UNION ALL
       SELECT 'municipi', id, nom, NULL FROM municipis
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2
       UNION ALL
       SELECT 'monument', id, nom, descripcio FROM monuments
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2 OR LOWER(descripcio) LIKE $1
       UNION ALL
       SELECT 'plat', id, nom, descripcio FROM plats_tradicionals
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2 OR LOWER(descripcio) LIKE $1
       UNION ALL
       SELECT 'festa', id, nom, descripcio FROM festes_tradicions
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2 OR LOWER(descripcio) LIKE $1
       UNION ALL
       SELECT 'geografia', id, nom, descripcio FROM geografia
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2
       UNION ALL
       SELECT 'cultura', id, nom, descripcio FROM cultura_general
         WHERE LOWER(nom) LIKE $1 OR unaccent(LOWER(nom)) LIKE $2 OR LOWER(descripcio) LIKE $1
       UNION ALL
       SELECT 'dita', id, text AS nom, significat AS descripcio FROM dites
         WHERE LOWER(text) LIKE $1 OR unaccent(LOWER(text)) LIKE $2
       LIMIT 100`,
      [q, qs]
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/', (req, res) => res.send('API Explorador de Catalunya funcionant'));

const PORT = process.env.BACKEND_PORT || 5000;
app.listen(PORT, () => console.log('Backend OK port ' + PORT));
