# API Documentation — FinTrend Analytics Platform

This document describes the API interactions simulated by the FinTrend frontend components (via Auth and Advisor modules).

---

## 1. User Authentication API

### Signup Endpoint
* **Endpoint**: `POST /api/auth/signup`
* **Description**: Registers a new fund manager in the persistence layer.
* **Payload**:
```json
{
  "userid": "manager123",
  "password": "password",
  "name": "Sarah Connor",
  "phone": "9876543210",
  "age": 34,
  "email": "sarah.connor@fintrend.com",
  "state": "Maharashtra",
  "city": "Mumbai"
}
```
* **Response (201 Created)**:
```json
{
  "success": true,
  "message": "User registered successfully"
}
```

### Login Endpoint
* **Endpoint**: `POST /api/auth/login`
* **Description**: Verifies credentials and creates a session token.
* **Payload**:
```json
{
  "userId": "manager123",
  "password": "password"
}
```
* **Response (200 OK)**:
```json
{
  "success": true,
  "token": "mock-jwt-token-123",
  "user": {
    "userid": "manager123",
    "name": "Sarah Connor"
  }
}
```

---

## 2. Dashboard Analytics API

### KPI Inflows Endpoint
* **Endpoint**: `GET /api/v1/kpis`
* **Description**: Fetches total AUM, active SIP counts, and stoppage metrics.
* **Response (200 OK)**:
```json
{
  "totalAum": "18458 Cr",
  "netInflow": "1259 Cr",
  "activeSips": "9.67 Cr",
  "stoppageRatio": "94.36%"
}
```

### AI Advice Chat Assistant
* **Endpoint**: `POST /api/v1/chat`
* **Description**: Queries the NLP core for allocation insight replies.
* **Payload**:
```json
{
  "query": "explain current portfolio xirr and beta"
}
```
* **Response (200 OK)**:
```json
{
  "reply": "Our Portfolio Return (XIRR) stands at 14.28%, outperforming the NIFTY 50 TRI benchmark of 11.52%. Portfolio beta is fully optimized at 0.92."
}
```
