const fundService = require('../services/fund.service');
const { asyncHandler } = require('../utils/asyncHandler');

const getAll = asyncHandler(async (_req, res) => {
  try {
    const funds = await fundService.getAllFunds();
    res.status(200).json(funds);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = { getAll };
