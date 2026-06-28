import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import pool from './pg/connection.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function seedData() {
  try {
    const seedPath = path.join(__dirname, 'pg', 'seed.sql');
    const seedSql = fs.readFileSync(seedPath, 'utf8');
    await pool.query(seedSql);
    console.log('Postgres seeder data inserted successfully');
  } catch (err) {
    console.error('Failed to run database seeder:', err);
  } finally {
    await pool.end();
  }
}

seedData();
