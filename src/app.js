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

// Routes
app.use("/api/auth", require("./routes/auth.routes"));
app.use("/api/dashboard", require("./routes/dashboard.routes"));

module.exports = app;
