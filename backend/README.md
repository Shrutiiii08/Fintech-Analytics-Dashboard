# FinTrend Analytics Backend REST API

This is the Express-based API backend for the monorepo workspace.

## Setup
1. Copy the environment template:
   ```bash
   cp .env.example .env
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Initialize the database schema and seed mock values:
   ```bash
   npm run db:init
   npm run db:seed
   ```
4. Start the server in hot-reload mode:
   ```bash
   npm run dev
   ```
