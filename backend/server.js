const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

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

// ---------- HEALTHCHECK ----------
// ---------- COMARCA individual ----------
// ---------- PLATS TRADICIONALS ----------
app.get('/api/plats', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT p.*, pr.nom AS provincia
       FROM plats_tradicionals p
       LEFT JOIN provincies pr ON p.provincia_id = pr.id
       ORDER BY p.nom`
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ---------- FESTES I TRADICIONS ----------
app.get('/api/festes', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT f.*, pr.nom AS provincia
       FROM festes_tradicions f
       LEFT JOIN provincies pr ON f.provincia_id = pr.id
       ORDER BY f.nom`
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});
app.get('/api/comarques/:id', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT c.*, p.nom AS provincia
       FROM comarques c JOIN provincies p ON c.provincia_id = p.id
       WHERE c.id = $1`,
      [req.params.id]
    );
    if (!r.rows[0]) return res.status(404).json({ error: 'No trobat' });
    res.json(r.rows[0]);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ---------- MONUMENTS per província ----------
app.get('/api/provincies/:id/monuments', async (req, res) => {
  try {
    const r = await pool.query(
      `SELECT mo.*, mu.nom AS municipi
       FROM monuments mo
       JOIN municipis mu ON mo.municipi_id = mu.id
       JOIN comarques co ON mu.comarca_id = co.id
       WHERE co.provincia_id = $1
       ORDER BY mo.nom`,
      [req.params.id]
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});
app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.json({ status: 'ok', db: 'ok' });
  } catch (err) {
    res.status(503).json({ status: 'error', db: 'down' });
  }
});

// ---------- PROVÍNCIES ----------
app.get('/api/provincies', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM provincies ORDER BY id');
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ---------- COMARQUES (per província) ----------
app.get('/api/provincies/:id/comarques', async (req, res) => {
  try {
    const r = await pool.query(
      'SELECT * FROM comarques WHERE provincia_id = $1 ORDER BY nom',
      [req.params.id]
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ---------- MUNICIPIS (per comarca) ----------
app.get('/api/comarques/:id/municipis', async (req, res) => {
  try {
    const r = await pool.query(
      'SELECT * FROM municipis WHERE comarca_id = $1 ORDER BY nom',
      [req.params.id]
    );
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ---------- MONUMENTS (tots o filtrats) ----------
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

// ---------- CERCADOR GLOBAL ----------
app.get('/api/cerca', async (req, res) => {
  const q = `%${(req.query.q || '').toLowerCase()}%`;
  try {
    const r = await pool.query(`
      SELECT 'provincia' AS tipus, id, nom, descripcio FROM provincies WHERE LOWER(nom) LIKE $1 OR LOWER(descripcio) LIKE $1
      UNION ALL
      SELECT 'comarca'   AS tipus, id, nom, capital AS descripcio FROM comarques WHERE LOWER(nom) LIKE $1
      UNION ALL
      SELECT 'municipi'  AS tipus, id, nom, NULL AS descripcio FROM municipis WHERE LOWER(nom) LIKE $1
      UNION ALL
      SELECT 'monument'  AS tipus, id, nom, descripcio FROM monuments WHERE LOWER(nom) LIKE $1 OR LOWER(descripcio) LIKE $1
      LIMIT 50
    `, [q]);
    res.json(r.rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

app.get('/', (req, res) => res.send('API Explorador de Catalunya funcionant'));

const PORT = process.env.BACKEND_PORT || 5000;
app.listen(PORT, () => console.log(`Backend al port ${PORT}`));
