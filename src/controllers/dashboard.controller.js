const dashboardService = require("../services/dashboard.service");

exports.getStats = async (req, res) => {
  try {
    const stats = await dashboardService.getStats();
    res.json(stats);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.getRevenue = async (req, res) => {
  try {
    const data = await dashboardService.getRevenue(req.query);
    res.json(data);
  } catch (err) {
    res.status(err.status || 500).json({ message: err.message });
  }
};
