const express = require('express');
const fs = require('fs');
const os = require('os');

const app = express();

app.get('/', (req, res) => {
  const log = `${new Date().toISOString()} - requête reçue\n`;
  fs.appendFileSync('/app/logs/access.log', log);

  res.json({
    message: 'Phase 2 Docker — Arif Bouzid',
    version: '1.0.0',
    env: process.env.NODE_ENV || 'development',
    hostname: os.hostname()
  });
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});