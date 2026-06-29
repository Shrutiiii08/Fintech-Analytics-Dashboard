const transactionService = require('../services/transaction.service');
const { asyncHandler } = require('../utils/asyncHandler');

const getAll = asyncHandler(async (_req, res) => {
  try {
    const txns = await transactionService.getAllTransactions();
    res.status(200).json(txns);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = { getAll };
