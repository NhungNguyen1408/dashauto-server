const express = require("express");
const cors = require("cors");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Health check
app.get("/", (req, res) => {
  res.json({ message: "DashAuto Server is running" });
});

// Routes (se them sau)
// app.use("/api/auth", authRoutes);
// app.use("/api/dashboard", dashboardRoutes);
// app.use("/api/reports", reportRoutes);
// app.use("/api/alerts", alertRoutes);
// app.use("/api/workflows", workflowRoutes);

module.exports = app;
