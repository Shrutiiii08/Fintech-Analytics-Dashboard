-- Mock Data Seeding for FinTrend Analytics Platform

-- Seed Schemes
INSERT INTO schemes (name, category, return_3m, benchmark_diff, total_aum) VALUES
('FinVista Bluechip Fund', 'Large Cap', 15.42, 3.90, 18024.00),
('FinVista Midcap Fund', 'Mid Cap', 12.15, 0.63, 12450.00),
('FinVista Smallcap Fund', 'Small Cap', 4.25, -7.27, 8600.00),
('FinVista Corporate Bond Fund', 'Debt', 7.80, 1.20, 14200.00),
('FinVista Liquid Treasury Fund', 'Liquidity', 6.20, 0.40, 9500.00),
('FinVista Flexi Cap Fund', 'Flexi Cap', 16.85, 4.33, 21000.00),
('FinVista Balanced Advantage Fund', 'Balanced Advantage', 14.03, 2.51, 15000.00);

-- Seed Initial Default Fund Manager
INSERT INTO managers (userid, password, name, phone, age, email, state, city) VALUES
('manager123', 'password', 'Sarah Connor', '9876543210', 34, 'sarah.connor@fintrend.com', 'Maharashtra', 'Mumbai');
