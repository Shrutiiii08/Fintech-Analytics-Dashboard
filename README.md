# FinTech Analytics & Compliance Platform (FinTrend)

This repository contains the complete working baseline for the FinTrend Analytics & Compliance Platform monorepo. It contains project configurations, shared UI shells, database schemas, and clean placeholder components ready for module development.

---

## Directory Structure

```
FinTech-Analytics-Compliance-Dashboard/
│
├── frontend/                     # React.js Single Page Application (Vite)
│   ├── src/                      # Source components, router, and assets
│   ├── public/                   # Public icons, favicon, and brand logo
│   ├── package.json              # Frontend npm dependencies
│   └── README.md                 # Frontend setup guide
│
├── backend/                      # Express.js REST API
│   ├── src/                      # API routing, controllers, and models
│   ├── package.json              # Backend npm dependencies
│   └── .env.example              # Server environment parameters
│
├── database/                     # Database initialization
│   ├── schema.sql                # Table definitions (managers, schemes, sips)
│   ├── seed.sql                  # Initial mock seeding
│   └── README.md                 # Database setup guidelines
│
├── docs/                         # Technical documentation
│   ├── API_Documentation.md      # Authentication and query endpoints spec
│   └── Project_Architecture.md   # Architectural HLD, LLD, and system flows
│
├── .gitignore                    # Monorepo git ignore settings
├── README.md                     # Root monorepo overview (this file)
├── CONTRIBUTING.md               # Guide for team contributors
└── LICENSE                       # Project license (MIT)
```

---

## Quick Start

### 1. Database Setup
Follow the instructions in `database/README.md` to configure and seed your local SQL database.

### 2. Backend Setup
1. Navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Copy the environment template:
   ```bash
   cp .env.example .env
   ```
3. Install dependencies and start development server:
   ```bash
   npm install
   npm run dev
   ```

### 3. Frontend Setup
1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```
2. Install dependencies and start React Vite server:
   ```bash
   npm install
   npm run dev
   ```
