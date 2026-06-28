import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// API Status Check
app.get('/api/status', (req, res) => {
  res.json({ status: 'OK', message: 'FinTrend Analytics API is functional' });
});

// Authentication Mock Route
app.post('/api/auth/login', (req, res) => {
  const { userId, password } = req.body;
  if (userId && password) {
    res.json({ success: true, token: 'mock-jwt-token-123', userId });
  } else {
    res.status(400).json({ success: false, message: 'Invalid credentials' });
  }
});

// app.js exports app to server.js

export default app;
