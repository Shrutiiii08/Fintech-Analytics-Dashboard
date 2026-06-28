# Project Architecture Specification — FinTrend Analytic Platform

This document describes the design structures and flow logic for the FinTrend monorepo workspace.

---

## 1. High-Level Design (HLD)

The FinTrend Analytic Platform is architected as a monorepo consisting of:
1. **Frontend App (`/frontend`)**: A React SPA that coordinates real-time dashboard updates, compliance tracking, and AI-powered allocation advice.
2. **Backend Server (`/backend`)**: An Express.js REST API providing secure mock authentication, status validation, and statistics endpoints.
3. **Database Schema (`/database`)**: SQL scripts for initializing schemas and seeding default accounts.

---

## 2. Low-Level Design (LLD)

The React client LLD details the core interface component dependencies:
* **App Core (`App.jsx`)**: Coordinates router gateways, checks active login state cookies, and mounts page layouts.
* **Auth Gateway (`Auth.jsx`)**: Persists registered user details in local storage, handles input validation, and manages session logs.
* **Performance Benchmarking (`PerformanceBenchmarking.jsx`)**: Compiles returns, alphas, and ratio calculations.
* **Dashboard Views**: Dashboard wrappers configured as clean component placeholders.

---

## 3. End-to-End System Flow
1. User visits the website; the black welcome splash loader overlay completes from 0% to 100% in 1.4 seconds.
2. The router checks local storage for an active session.
3. If empty, the user is redirected to the login/registration gateway.
4. If successful, the app shell is mounted, displaying sidebar items and selected dashboard components.
5. Users can query the FiNAI assistant, configure date filters, or log out to reset the session.
