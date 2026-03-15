import express from "express";
import {
  verifyToken,
  checkRole,
  authenticate,
} from "../middleware/auth.middleware.js";

export default function dashboardRoutes(pool) {
  const router = express.Router();

  // Deshabilitar cache en respuestas durante desarrollo
  router.use((req, res, next) => {
    res.set("Cache-Control", "no-store, no-cache, must-revalidate, proxy-revalidate");
    res.set("Pragma", "no-cache");
    res.set("Expires", "0");
    res.set("Surrogate-Control", "no-store");
    next();
  });
  // GET /api/dashboard/stats
  router.get("/stats", async (req, res) => {
    try {
      // Ventas del mes actual (incluyendo orders y sales_orders)
      const salesQuery = `
        SELECT COALESCE(SUM(total), 0) as total FROM (
          SELECT total_amount as total, order_date FROM orders
          UNION ALL
          SELECT total_amount as total, order_date FROM sales_orders
        ) as all_sales
        WHERE MONTH(order_date) = MONTH(NOW()) AND YEAR(order_date) = YEAR(NOW())
      `;
      const [salesResult] = await pool.query(salesQuery);

      // Ventas del mes anterior
      const lastMonthQuery = `
        SELECT COALESCE(SUM(total), 0) as total FROM (
          SELECT total_amount as total, order_date FROM orders
          UNION ALL
          SELECT total_amount as total, order_date FROM sales_orders
        ) as all_sales
        WHERE MONTH(order_date) = MONTH(NOW() - INTERVAL 1 MONTH) 
          AND YEAR(order_date) = YEAR(NOW() - INTERVAL 1 MONTH)
      `;
      const [lastMonthResult] = await pool.query(lastMonthQuery);

      // Calcular porcentaje de cambio
      const currentSales = parseFloat(salesResult[0].total || 0);
      const lastMonthSales = parseFloat(lastMonthResult[0].total || 0);
      let salesChange = 0;
      if (lastMonthSales > 0) {
        salesChange = ((currentSales - lastMonthSales) / lastMonthSales) * 100;
      } else if (currentSales > 0) {
        salesChange = 100; // Nuevo mes con ventas
      }
      const salesChangePercent = Math.round(salesChange * 10) / 10;

      // Total de productos
      const [productsResult] = await pool.query(
        "SELECT COUNT(*) as total FROM products",
      );

      // Producto más vendido (basado en order_items y sales_order_items)
      const [bestSellingResult] = await pool.query(`
        SELECT 
          p.id,
          p.name,
          p.category,
          COALESCE(SUM(quantities.qty), 0) as total_sold
        FROM products p
        LEFT JOIN (
          SELECT product_id, SUM(quantity) as qty FROM order_items GROUP BY product_id
          UNION ALL
          SELECT product_id, SUM(quantity) as qty FROM sales_order_items GROUP BY product_id
        ) as quantities ON p.id = quantities.product_id
        GROUP BY p.id, p.name, p.category
        ORDER BY total_sold DESC
        LIMIT 1
      `);

      // Órdenes pendientes (de ambas tablas)
      const [ordersResult] = await pool.query(`
        SELECT COALESCE(SUM(total), 0) as total FROM (
          SELECT COUNT(*) as total FROM orders WHERE status = 'pending'
          UNION ALL
          SELECT COUNT(*) as total FROM sales_orders WHERE status = 'pending'
        ) as pending
      `);

      const stats = {
        monthly_sales: salesResult[0],
        sales_change_percent: salesChangePercent,
        total_products: productsResult[0],
        best_selling_product: bestSellingResult[0] || {
          name: "N/A",
          total_sold: 0,
        },
        pending_orders: { total: ordersResult[0]?.total || 0 },
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
      // Ventas por mes del año actual (incluyendo orders y sales_orders)
      const salesQuery = `
        SELECT 
          MONTH(order_date) as month,
          COALESCE(SUM(total_amount), 0) as ventas
        FROM (
          SELECT order_date, total_amount FROM orders
          UNION ALL
          SELECT order_date, total_amount FROM sales_orders
        ) as all_orders
        WHERE YEAR(order_date) = YEAR(NOW())
        GROUP BY MONTH(order_date)
        ORDER BY MONTH(order_date)
      `;

      const [salesResult] = await pool.query(salesQuery);

      // Compras por mes (basado en producción - estimado básico)
      // Ya que production_orders no tiene campo de costo, usamos un estimado
      const purchasesQuery = `
        SELECT 
          MONTH(order_date) as month,
          COUNT(*) * 100 as compras
        FROM production_orders
        WHERE YEAR(order_date) = YEAR(NOW()) AND status != 'cancelada'
        GROUP BY MONTH(order_date)
        ORDER BY MONTH(order_date)
      `;

      const [purchasesResult] = await pool.query(purchasesQuery);

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
        const purchase = purchasesResult.find((r) => r.month === month);

        return {
          name,
          ventas: parseFloat(sale?.ventas || 0),
          compras: parseFloat(purchase?.compras || 0),
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

      // Órdenes pendientes (de ambas tablas)
      const [pendingOrders] = await pool.query(`
        SELECT COALESCE(SUM(total), 0) as total FROM (
          SELECT COUNT(*) as total FROM orders WHERE status = 'pending'
          UNION ALL
          SELECT COUNT(*) as total FROM sales_orders WHERE status = 'pending'
        ) as pending
      `);

      // Órdenes de producción pendientes
      const [pendingProduction] = await pool.query(`
        SELECT COUNT(*) as total 
        FROM production_orders 
        WHERE status = 'pendiente'
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

      // Agregar alerta si hay órdenes de venta pendientes
      if (pendingOrders[0]?.total > 0) {
        alerts.push({
          text: `${pendingOrders[0].total} órdenes de venta pendientes`,
          type: "info",
        });
      }

      // Agregar alerta si hay órdenes de producción pendientes
      if (pendingProduction[0]?.total > 0) {
        alerts.push({
          text: `${pendingProduction[0].total} órdenes de producción pendientes`,
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
      // Productos agregados/actualizados recientemente (últimas 24 horas)
      const [productsActivity] = await pool.query(`
        SELECT 
          CONCAT('Producto \"', name, '\" actualizado') as action,
          'Sistema' as user,
          updated_at as time
        FROM products
        WHERE updated_at IS NOT NULL 
          AND updated_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        ORDER BY updated_at DESC
        LIMIT 3
      `);

      // Si no hay productos actualizados recently, mostrar los más recientes sin importar fecha
      const [allProductsActivity] = await pool.query(`
        SELECT 
          CONCAT('Producto \"', name, '\" en sistema') as action,
          'Sistema' as user,
          created_at as time
        FROM products
        ORDER BY created_at DESC
        LIMIT 2
      `);

      // Órdenes de venta creadas recientemente
      const [salesOrdersActivity] = await pool.query(`
        SELECT 
          CONCAT('Nueva orden de venta #', id, ' - ', COALESCE(customer_name, 'Sin cliente')) as action,
          'Sistema' as user,
          order_date as time
        FROM sales_orders
        WHERE order_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)
        ORDER BY order_date DESC
        LIMIT 2
      `);

      // Órdenes de producción creadas recientemente
      const [productionOrdersActivity] = await pool.query(`
        SELECT 
          CONCAT('Orden producción #', order_number, ' - ', status) as action,
          'Sistema' as user,
          order_date as time
        FROM production_orders
        ORDER BY order_date DESC
        LIMIT 2
      `);

      // Órdenes de venta completadas
      const [completedSalesOrders] = await pool.query(`
        SELECT 
          CONCAT('Orden venta #', id, ' completada') as action,
          'Sistema' as user,
          updated_at as time
        FROM sales_orders
        WHERE status = 'completed'
        ORDER BY updated_at DESC
        LIMIT 1
      `);

      // Órdenes de producción completadas
      const [completedProduction] = await pool.query(`
        SELECT 
          CONCAT('Producción #', order_number, ' completada') as action,
          'Sistema' as user,
          updated_at as time
        FROM production_orders
        WHERE status = 'completada'
        ORDER BY updated_at DESC
        LIMIT 1
      `);

      const activityList = [
        ...productsActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...(productsActivity.length === 0 ? allProductsActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })) : []),
        ...salesOrdersActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...productionOrdersActivity.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...completedSalesOrders.map((act) => ({
          ...act,
          time: act.time ? new Date(act.time) : new Date(),
        })),
        ...completedProduction.map((act) => ({
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

  // Obtener categorias con conteo de productos
  router.get("/categories", async (req, res) => {
    try {
      const [categoriesResult] = await pool.query(`
        SELECT 
          COALESCE(category, 'Sin categoria') as name,
          COUNT(*) as value
        FROM products
        WHERE is_active = 1
        GROUP BY category
        ORDER BY value DESC
      `);

      if (categoriesResult.length === 0) {
        return res.json([
          { name: "Panes", value: 0 },
          { name: "Pasteleria", value: 0 },
          { name: "Tortas", value: 0 },
          { name: "Galletas", value: 0 },
          { name: "Otros", value: 0 },
        ]);
      }

      res.json(categoriesResult);
    } catch (error) {
      console.error("Error en categorias:", error);
      res.status(500).json({ error: "Error al obtener categorias" });
    }
  });

  return router;
}
