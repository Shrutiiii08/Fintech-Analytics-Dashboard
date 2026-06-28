import pool from './pg/connection.js';

export default {
  getConnection: () => pool
};
