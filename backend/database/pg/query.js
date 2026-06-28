import pool from './connection.js';

export default {
  query: (text, params) => pool.query(text, params)
};
