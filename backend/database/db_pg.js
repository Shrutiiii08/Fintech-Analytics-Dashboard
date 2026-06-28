import pool from './pg/connection.js';

export async function executeQuery(text, params) {
  return pool.query(text, params);
}
