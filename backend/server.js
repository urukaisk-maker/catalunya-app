const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());

const pool = new Pool({
  host: 'db',
  port: 5432,
  user: 'catalunya_user',
  password: 'seny_i_rauxa',
  database: 'catalunya_db'
});

app.get('/api/provincies', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM provincies ORDER BY id');
    res.json(result.rows);
  } catch (err) {
    console.error('Error consultant la base de dades:', err);
    res.status(500).json({ error: 'Error intern del servidor' });
  }
});

app.get('/', (req, res) => {
  res.send('API Explorador de Catalunya funcionant');
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`Servidor backend escoltant al port ${PORT}`);
});
