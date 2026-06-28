-- Supabase Schema for FinTrend Analytics Platform

-- 1. Fund Managers Table
CREATE TABLE IF NOT EXISTS managers (
    id SERIAL PRIMARY KEY,
    userid VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE NOT NULL,
    state VARCHAR(50),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Schemes Performance Table
CREATE TABLE IF NOT EXISTS schemes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    return_3m NUMERIC(5, 2) NOT NULL,
    benchmark_diff NUMERIC(5, 2) NOT NULL,
    total_aum NUMERIC(12, 2) NOT NULL
);

-- 3. SIP Trends Table
CREATE TABLE IF NOT EXISTS sip_trends (
    id SERIAL PRIMARY KEY,
    record_date DATE NOT NULL,
    inflow_cr NUMERIC(10, 2) NOT NULL,
    active_accounts INT NOT NULL,
    new_registrations INT NOT NULL,
    discontinuations INT NOT NULL,
    stoppage_ratio NUMERIC(5, 2) NOT NULL
);

-- 4. Transactions Log
CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    scheme_id INT REFERENCES schemes(id),
    volume_cr NUMERIC(10, 2) NOT NULL,
    transaction_type VARCHAR(20) NOT NULL CHECK (transaction_type IN ('INFLOW', 'OUTFLOW'))
);
