const db = require("../db");

const VALID_GROUPS = ["day", "month"];

exports.getRevenue = async ({ groupBy = "day", from, to } = {}) => {
  if (!VALID_GROUPS.includes(groupBy)) {
    throw { status: 400, message: "groupBy phai la 'day' hoac 'month'" };
  }

  const params = [];
  const where = ["status = 'completed'"];

  if (from) {
    params.push(from);
    where.push(`created_at >= $${params.length}`);
  }
  if (to) {
    params.push(to);
    where.push(`created_at <= $${params.length}`);
  }

  const result = await db.query(
    `SELECT DATE_TRUNC('${groupBy}', created_at) AS period,
            COALESCE(SUM(total_amount), 0) AS revenue,
            COUNT(*) AS orders
     FROM orders
     WHERE ${where.join(" AND ")}
     GROUP BY period
     ORDER BY period ASC`,
    params
  );

  return result.rows.map((r) => ({
    period: r.period,
    revenue: Number(r.revenue),
    orders: Number(r.orders),
  }));
};

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
