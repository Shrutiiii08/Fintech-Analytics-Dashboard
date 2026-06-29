// Import the database query coordinator function (resolves Postgres or SQLite fallback pool)
const { dbQuery } = require('../../database/db.js');

// Mock directory listing of active mutual fund schemes
const FUNDS_DATA = [
  { id: 'fnd-1', name: 'GrowTech Large Cap Bluechip Fund', category: 'EQUITY', nav: 84.32 },
  { id: 'fnd-2', name: 'Apex Mid Cap Opportunities Fund', category: 'EQUITY', nav: 112.45 },
  { id: 'fnd-3', name: 'Vanguard Small Cap Momentum Fund', category: 'EQUITY', nav: 45.60 },
  { id: 'fnd-4', name: 'Alpha Flexi Cap Multi-Asset Fund', category: 'EQUITY', nav: 62.15 },
  { id: 'fnd-5', name: 'TaxSaver ELSS Tax Shield Fund', category: 'ELSS', nav: 95.30 },
  { id: 'fnd-6', name: 'Vanguard Hybrid Balanced Allocation Fund', category: 'HYBRID', nav: 46.80 },
  { id: 'fnd-7', name: 'Apex Dynamic Debt Reserve Fund', category: 'DEBT', nav: 24.15 },
  { id: 'fnd-8', name: 'Sovereign Liquid Cash Reserve Fund', category: 'LIQUID', nav: 12.45 },
  { id: 'fnd-9', name: 'GrowTech Nifty 50 Index Passive Fund', category: 'INDEX', nav: 35.80 },
  { id: 'fnd-10', name: 'GreenEnergy Sectoral ESG Fund', category: 'SECTORAL', nav: 56.90 }
];


// Starts the mock trade generator, feeding live events to connected websockets
function startGenerator(wss) {
  console.log('[GENERATOR] Launching Real-time Transaction Generator...');
  
  // Track sequence numbers using a timestamp to guarantee uniqueness across server restarts
  let sequence = Date.now();

  // Recursive transaction creator method
  const generate = async () => {
    let user = null;
    let fund = null;
    let invId = null;
    try {
      // Pick a random user from actual registered DB users
      const dbUsers = await dbQuery.all('SELECT id, full_name as name FROM users');
      if (dbUsers.length === 0) {
        // No registered users yet, wait 5s and try again
        setTimeout(generate, 5000);
        return;
      }
      user = dbUsers[Math.floor(Math.random() * dbUsers.length)];
      
      // Pick a random mutual fund scheme from the list
      fund = FUNDS_DATA[Math.floor(Math.random() * FUNDS_DATA.length)];
      
      // Select type with realistic weights (Purchase: 55%, Redemption: 25%, SIP: 10%, Switch In: 5%, Switch Out: 5%)
      const r = Math.random();
      let type = 'PURCHASE';
      if (r < 0.55) type = 'PURCHASE';
      else if (r < 0.80) type = 'REDEMPTION';
      else if (r < 0.90) type = 'SIP_AUTO';
      else if (r < 0.95) type = 'SWITCH_IN';
      else type = 'SWITCH_OUT';

      // Decide transaction size (12% chance of HNW spike)
      const isHNW = Math.random() < 0.12;
      let amount = 0;
      if (isHNW) {
        amount = Math.floor(Math.random() * 55 + 5) * 10000000; // ₹5 Cr to ₹60 Cr
      } else {
        amount = Math.floor(Math.random() * 95 + 5) * 10000; // ₹50,000 to ₹10,00,000
      }

      // Format identifiers and calculate unit counts and stamp duties
      const txnId = `txn-live-${sequence++}`;
      invId = `inv-${user.id}-${fund.id}`;
      const nav = fund.nav;
      const units = parseFloat((amount / nav).toFixed(4));
      const stampDuty = parseFloat((amount * 0.00005).toFixed(2));
      const timestamp = new Date().toISOString();

      // Ensure investment record exists to satisfy foreign key constraints
      const invRow = await dbQuery.get('SELECT id FROM investments WHERE id = ?', [invId]);
      if (!invRow) {
        await dbQuery.run(`
          INSERT INTO investments (id, user_id, fund_id, fund_name, investment_type, amount, start_date, total_units, current_value, status)
          VALUES (?, ?, ?, ?, ?, 0, ?, 0, 0, 'ACTIVE')
        `, [invId, user.id, fund.id, fund.name, type === 'SIP_AUTO' ? 'SIP' : 'LUMPSUM', timestamp.split('T')[0]]);
      }

      // Write transaction to database
      await dbQuery.run(`
        INSERT INTO transactions (id, user_id, investment_id, fund_id, fund_name, transaction_type, amount, nav_applied, units, stamp_duty, status, created_at, settled_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'SETTLED', ?, ?)
      `, [txnId, user.id, invId, fund.id, fund.name, type, amount, nav, units, stampDuty, timestamp, timestamp]);

      // Check if this triggers a compliance alert (All HNW transactions > ₹30 Cr, or a 3% random trigger)
      let alertData = null;
      const isSuspicious = (isHNW && amount > 300000000) || (Math.random() < 0.03);
      
      // If suspicious criteria are met, trigger compliance alert entries
      if (isSuspicious) {
        const checkId = `chk-live-${sequence}`;
        const alertId = `alt-live-${sequence}`;
        const checkType = amount > 300000000 ? 'LARGE_VALUE_ALERT' : 'VELOCITY_LIMIT_EXCEEDED';
        const severity = amount > 300000000 ? 'HIGH' : 'MEDIUM';
        const description = amount > 300000000 
          ? `High-value transaction flagged: ₹${(amount / 10000000).toFixed(2)} Cr allocation in ${fund.name} by ${user.name}.`
          : `Velocity limit warning: Multiple trades detected within short window for ${user.name}.`;

        // Record compliance checks report in database
        await dbQuery.run(`
          INSERT INTO compliance_checks (id, transaction_id, user_id, check_type, risk_score, result, details, checked_at)
          VALUES (?, ?, ?, ?, ?, 'SUSPICIOUS', ?, ?)
        `, [checkId, txnId, user.id, checkType, Math.floor(Math.random() * 30 + 65), description, timestamp]);

        // Record active compliance alerts dashboard item in database
        await dbQuery.run(`
          INSERT INTO compliance_alerts (id, compliance_check_id, user_id, alert_type, severity, description, status, assigned_to, created_at)
          VALUES (?, ?, ?, ?, ?, ?, 'OPEN', 'sys-usr-2', ?)
        `, [alertId, checkId, user.id, checkType, severity, description, timestamp]);

        // Map database records to the alert output object
        alertData = {
          id: alertId,
          compliance_check_id: checkId,
          user_id: user.id,
          alert_type: checkType,
          severity,
          description,
          status: 'OPEN',
          assigned_to: 'sys-usr-2',
          created_at: timestamp
        };

        console.log(`[GENERATOR] ⚠️ Compliance Alert triggered: ${description}`);
      }

      // Broadcast transaction & optional alert to all connected WebSocket clients
      const payload = JSON.stringify({
        type: 'NEW_TRANSACTION',
        transaction: {
          id: txnId,
          user_id: user.id,
          user_name: user.name,
          investment_id: invId,
          fund_id: fund.id,
          fund_name: fund.name,
          category: fund.category,
          transaction_type: type,
          amount: amount,
          nav_applied: nav,
          units: units,
          stamp_duty: stampDuty,
          status: 'SETTLED',
          created_at: timestamp
        },
        alert: alertData
      });

      // Distribute payload to all active WS clients
      wss.clients.forEach(client => {
        if (client.readyState === 1) { // WebSocket.OPEN
          client.send(payload);
        }
      });

      console.log(`[GENERATOR] 💸 Broadcasted live transaction: ${type} of ₹${(amount / 10000000).toFixed(4)} Cr in ${fund.name}`);

    } catch (err) {
      console.error('[GENERATOR] Error generating transaction:', err.message, `| User ID: ${user?.id}, Fund ID: ${fund?.id}, Investment ID: ${invId}`);
    }

    // Schedule next transaction after a random interval between 1.5s and 4.5s
    const delay = Math.floor(Math.random() * 3000) + 1500;
    setTimeout(generate, delay);
  };

  // Start the loop after a 5 second warm-up delay
  setTimeout(generate, 5000);
}

// Export the start generator function
module.exports = {
  startGenerator
};
