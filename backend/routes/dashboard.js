import express from "express";
import {
  verifyToken,
  checkRole,
  authenticate,
} from "../middleware/auth.middleware.js";

export default function dashboardRoutes(pool) {
  const router = express.Router();

  // Ruta pública - Sin autenticación requerida
  // GET /api/dashboard/stats
  router.get("/stats", async (req, res) => {
    try {
      // Ventas del mes actual
      const [salesResult] = await pool.query(
        "SELECT COALESCE(SUM(total_amount), 0) as total FROM orders WHERE MONTH(order_date) = MONTH(NOW()) AND YEAR(order_date) = YEAR(NOW())",
      );

      // Total de productos
      const [productsResult] = await pool.query(
        "SELECT COUNT(*) as total FROM products",
      );

      // Producto más vendido (order_items, sales_order_items e invoices)
      const [bestSellingResult] = await pool.query(`
        SELECT 
          p.id,
          p.name,
          p.category,
          COALESCE(SUM(quantities.qty), 0) as total_sold,
          COALESCE(SUM(invoices.total_amount), 0) as invoice_total
        FROM products p
        LEFT JOIN (
          SELECT product_id, SUM(quantity) as qty FROM order_items GROUP BY product_id
          UNION ALL
          SELECT product_id, SUM(quantity) as qty FROM sales_order_items GROUP BY product_id
        ) as quantities ON p.id = quantities.product_id
        LEFT JOIN order_items oi ON p.id = oi.product_id
        LEFT JOIN orders o ON oi.order_id = o.id
        LEFT JOIN invoices ON invoices.order_id = o.id
        WHERE invoices.id IS NOT NULL OR quantities.qty IS NOT NULL
        GROUP BY p.id, p.name, p.category
        ORDER BY total_sold DESC, invoice_total DESC
        LIMIT 1
      `);

      // Órdenes pendientes
      const [ordersResult] = await pool.query(
        'SELECT COUNT(*) as total FROM orders WHERE status = "pending"',
      );

      const stats = {
        monthly_sales: salesResult[0],
        total_products: productsResult[0],
        best_selling_product: bestSellingResult[0] || {
          name: "N/A",
          total_sold: 0,
        },
        pending_orders: ordersResult[0],
      };

      res.json(stats);
    } catch (error) {
      console.error("Error en dashboard stats:", error);
      res.status(500).json({ error: "Error al obtener estadísticas" });
    }
  });

  // obtener datos para gráficos - GET /api/dashboard/charts
  router.get("/charts", async (req, res) => {
    try {
      // Ventas por mes del año actual
      const salesQuery = `
        SELECT 
          MONTH(order_date) as month,
          COALESCE(SUM(total_amount), 0) as ventas
        FROM orders
        WHERE YEAR(order_date) = YEAR(NOW())
        GROUP BY MONTH(order_date)
        ORDER BY MONTH(order_date)
      `;

      const [salesResult] = await pool.query(salesQuery);

      const months = [
        "Ene",
        "Feb",
        "Mar",
        "Abr",
        "May",
        "Jun",
        "Jul",
        "Ago",
        "Sep",
        "Oct",
        "Nov",
        "Dic",
      ];

      // Crear estructura de 12 meses
      const chartData = months.map((name, index) => {
        const month = index + 1;
        const sale = salesResult.find((r) => r.month === month);

        return {
          name,
          ventas: parseFloat(sale?.ventas || 0),
          compras: 0,
        };
      });

      res.json(chartData);
    } catch (error) {
      console.error("Error en charts:", error);
      res.status(500).json({ error: "Error al obtener datos de gráficos" });
    }
  });

  // obtener alertas de stock bajo
  router.get("/alerts", async (req, res) => {
    try {
      // Alertas de stock bajo
      const [lowStockProducts] = await pool.query(`
        SELECT name, stock_quantity, min_stock_level 
        FROM products 
        WHERE stock_quantity <= min_stock_level 
        LIMIT 5
      `);

      // Órdenes pendientes
      const [pendingOrders] = await pool.query(`
        SELECT COUNT(*) as total 
        FROM orders 
        WHERE status = 'pending'
      `);

      const alerts = [];

      // Agregar alertas de stock bajo
      lowStockProducts.forEach((product) => {
        if (product.stock_quantity === 0) {
          alerts.push({
            text: `Stock crítico: ${product.name} (0 unidades)`,
            type: "danger",
          });
        } else {
          alerts.push({
            text: `Stock bajo: ${product.name} (${product.stock_quantity} unidades)`,
            type: "warning",
          });
        }
      });

      // Agregar alerta si hay órdenes pendientes
      if (pendingOrders[0].total > 0) {
        alerts.push({
          text: `${pendingOrders[0].total} órdenes pendientes requieren atención`,
          type: "info",
        });
      }

      res.json(alerts.slice(0, 5));
    } catch (error) {
      console.error("Error en alertas:", error);
      res.status(500).json({ error: "Error al obtener alertas" });
    }
  });

  // obtener actividad reciente
  router.get("/activity", async (req, res) => {
    try {
      // Productos agregados/actualizados recientemente
      const [productsActivity] = await pool.query(`
        SELECT 
          'Producto actualizado' as action,
          IF(created_at IS NOT NULL AND DATE(created_at) = CURDATE(), 'Sistema', 'Sistema') as user,
          updated_at as time
        FROM products
        WHERE updated_at IS NOT NULL
        ORDER BY updated_at DESC
        LIMIT 2
      `);

      // Órdenes creadas recientemente
      const [ordersActivity] = await pool.query(`
        SELECT 
          CONCAT('Nueva orden #', id, ' creada') as action,
          'Sistema' as user,
          order_date as time
        FROM orders
        ORDER BY order_date DESC
        LIMIT 2
      `);

      // Órdenes completadas
      const [completedOrders] = await pool.query(`
        SELECT 
          CONCAT('Orden #', id, ' completada') as action,
          'Sistema' as user,
          updated_at as time
        FROM orders
        WHERE status = 'completed'
        ORDER BY updated_at DESC
        LIMIT 1
      `);

      const activityList = [
        ...productsActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...ordersActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...completedOrders.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
      ];

      // Ordenar por tiempo descendente y limitar a 5
      const sortedActivity = activityList
        .sort((a, b) => b.time - a.time)
        .slice(0, 5)
        .map((act) => ({
          action: act.action,
          user: act.user || "Sistema",
          time: formatTimeAgo(act.time),
        }));

      res.json(sortedActivity);
    } catch (error) {
      console.error("Error en actividad:", error);
      res.status(500).json({ error: "Error al obtener actividad" });
    }
  });

  // Función auxiliar para formatear tiempo
  const formatTimeAgo = (date) => {
    const now = new Date();
    const diffMs = now - new Date(date);
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return "Hace unos segundos";
    if (diffMins < 60) return `Hace ${diffMins} min`;
    if (diffHours < 24)
      return `Hace ${diffHours} hora${diffHours > 1 ? "s" : ""}`;
    if (diffDays < 7) return `Hace ${diffDays} día${diffDays > 1 ? "s" : ""}`;

    return date.toLocaleDateString("es-ES");
  };

  return router;
}
