# Database Design — FinTrend Analytics Platform

This document describes the schema tables and indexes configured for the FinTrend analytics backend.

## 1. Entity Tables
* **`managers`**: Holds registered fund manager authentication profiles.
* **`schemes`**: Mutual fund performance listing metrics (AUM, return categories).
* **`sip_trends`**: Stores chronological SIP inflow counts and stoppage averages.
* **`transactions`**: High-frequency transactional records for fund comparison graphs.

## 2. Foreign Key References
* `transactions.scheme_id` references `schemes.id` (1-to-many relationship).
