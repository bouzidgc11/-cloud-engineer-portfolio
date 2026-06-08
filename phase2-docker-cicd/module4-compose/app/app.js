const express = require('express');
const { Pool } = require('pg');

const app = express();
const PORT = process.env.PORT || 3000;

// Connexion à PostgreSQL via les variables d'environnement
const pool = new Pool({
  host: process.env.DB_HOST || 'db',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'secret',
  database: process.env.DB_NAME || 'module4db',
  port: 5432,
});

app.get('/', (req, res) => {
  res.send('Module 4 - App + PostgreSQL par Arif');
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Route qui interroge la base de données
app.get('/db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({
      message: 'Connexion DB reussie !',
      heure_db: result.rows[0].now,
    });
  } catch (err) {
    res.status(500).json({ erreur: 'Connexion DB echouee', details: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Serveur demarre sur le port ${PORT}`);
});