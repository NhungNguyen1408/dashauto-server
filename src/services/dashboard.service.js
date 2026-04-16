const db = require("../db");

exports.getStats = async () => {
  const revenueQ = db.query(
    "SELECT COALESCE(SUM(total_amount), 0) AS total FROM orders WHERE status = 'completed'"
  );
  const ordersQ = db.query("SELECT COUNT(*) AS total FROM orders");
  const productsSoldQ = db.query(
    `SELECT COALESCE(SUM(oi.quantity), 0) AS total
     FROM order_items oi
     JOIN orders o ON o.id = oi.order_id
     WHERE o.status = 'completed'`
  );
  const reportsQ = db.query("SELECT COUNT(*) AS total FROM reports");
  const alertsQ = db.query("SELECT COUNT(*) AS total FROM alerts WHERE status = 'open'");

  const [revenue, orders, productsSold, reports, alerts] = await Promise.all([
    revenueQ,
    ordersQ,
    productsSoldQ,
    reportsQ,
    alertsQ,
  ]);

  return {
    totalRevenue: Number(revenue.rows[0].total),
    totalOrders: Number(orders.rows[0].total),
    productsSold: Number(productsSold.rows[0].total),
    totalReports: Number(reports.rows[0].total),
    openAlerts: Number(alerts.rows[0].total),
  };
};
