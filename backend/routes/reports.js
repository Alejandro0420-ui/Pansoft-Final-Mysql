import express from "express";

export default function reportsRoutes(pool) {
  const router = express.Router();

  // Get sales report (últimos 30 días) - incluye ventas del POS (invoices) y órdenes de venta (sales_orders)
  router.get("/sales", async (req, res) => {
    try {
      const { startDate, endDate } = req.query;
      
      // Si no hay fechas, usar últimos 30 días por defecto
      let defaultStartDate = null;
      let defaultEndDate = null;
      if (!startDate && !endDate) {
        defaultEndDate = new Date().toISOString().split('T')[0];
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
        defaultStartDate = thirtyDaysAgo.toISOString().split('T')[0];
      }
      
      const start = startDate || defaultStartDate;
      const end = endDate || defaultEndDate;
      
      // Consulta para ventas del POS (invoices)
      let invoicesQuery = `
        SELECT 
          DATE(issue_date) as date,
          COUNT(*) as invoice_count,
          SUM(total_amount) as total_sales,
          'POS' as source
        FROM invoices
        WHERE status = 'paid'
      `;
      
      if (start) {
        invoicesQuery += ` AND DATE(issue_date) >= '${start}'`;
      }
      if (end) {
        invoicesQuery += ` AND DATE(issue_date) <= '${end}'`;
      }
      
      invoicesQuery += ` GROUP BY DATE(issue_date)`;
      
      // Consulta para órdenes de venta (sales_orders)
      let ordersQuery = `
        SELECT 
          DATE(order_date) as date,
          COUNT(*) as order_count,
          SUM(total_amount) as total_sales,
          'Orden' as source
        FROM sales_orders
        WHERE status = 'completada'
      `;
      
      if (start) {
        ordersQuery += ` AND DATE(order_date) >= '${start}'`;
      }
      if (end) {
        ordersQuery += ` AND DATE(order_date) <= '${end}'`;
      }
      
      ordersQuery += ` GROUP BY DATE(order_date)`;
      
      // Ejecutar ambas consultas
      const [invoices] = await pool.query(invoicesQuery);
      const [orders] = await pool.query(ordersQuery);
      
      // Combinar resultados
      const combined = [...invoices, ...orders];
      
      // Agrupar por fecha
      const salesByDate = {};
      for (const sale of combined) {
        const dateKey = sale.date;
        if (!salesByDate[dateKey]) {
          salesByDate[dateKey] = {
            date: dateKey,
            invoice_count: 0,
            order_count: 0,
            total_sales: 0
          };
        }
        if (sale.source === 'POS') {
          salesByDate[dateKey].invoice_count = parseInt(sale.invoice_count) || 0;
        } else {
          salesByDate[dateKey].order_count = parseInt(sale.order_count) || 0;
        }
        salesByDate[dateKey].total_sales += parseFloat(sale.total_sales) || 0;
      }
      
      // Convertir a array y ordenar por fecha descendente
      const result = Object.values(salesByDate).sort((a, b) => new Date(b.date) - new Date(a.date));
      
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de ventas:", error);
      res.status(500).json({ error: "Error al obtener reporte de ventas" });
    }
  });

  // Get today's sales (for table display)
  router.get("/today-sales", async (req, res) => {
    try {
      const today = new Date().toISOString().split('T')[0];
      
      // Ventas del POS (invoices) de hoy
      const [invoices] = await pool.query(`
        SELECT 
          id,
          invoice_number as number,
          issue_date as date,
          total_amount as amount,
          status,
          'POS' as type
        FROM invoices
        WHERE DATE(issue_date) = ? AND status = 'paid'
        ORDER BY issue_date DESC
      `, [today]);
      
      // Órdenes de venta de hoy
      const [orders] = await pool.query(`
        SELECT 
          id,
          order_number as number,
          order_date as date,
          total_amount as amount,
          status,
          'Orden' as type
        FROM sales_orders
        WHERE DATE(order_date) = ? AND status = 'completada'
        ORDER BY order_date DESC
      `, [today]);
      
      // Combinar y ordenar por fecha
      const combined = [...invoices, ...orders].sort((a, b) => new Date(b.date) - new Date(a.date));
      
      // Calcular total
      const total = combined.reduce((sum, item) => sum + parseFloat(item.amount || 0), 0);
      
      res.json({
        sales: combined,
        total: total,
        count: combined.length
      });
    } catch (error) {
      console.error("Error en ventas de hoy:", error);
      res.status(500).json({ error: "Error al obtener ventas de hoy" });
    }
  });

  // Get sale detail (items)
  router.get("/sale-detail", async (req, res) => {
    try {
      const { id, type } = req.query;
      
      if (!id || !type) {
        return res.status(400).json({ error: "Faltan parámetros" });
      }
      
      let items = [];
      let header = {};
      
      if (type === 'POS') {
        // Obtener items de invoice_items
        [items] = await pool.query(`
          SELECT 
            product_name as name,
            quantity,
            unit_price as price,
            subtotal
          FROM invoice_items
          WHERE invoice_id = ?
        `, [id]);
        
        // Obtener info de la factura
        const [invoices] = await pool.query(`
          SELECT 
            invoice_number as number,
            issue_date as date,
            total_amount as amount,
            status
          FROM invoices
          WHERE id = ?
        `, [id]);
        
        if (invoices.length > 0) {
          header = {
            ...invoices[0],
            date: invoices[0].date,
            amount: invoices[0].amount
          };
        }
      } else {
        // Obtener items de sales_order_items
        [items] = await pool.query(`
          SELECT 
            p.name,
            soi.quantity,
            soi.unit_price as price,
            soi.subtotal
          FROM sales_order_items soi
          LEFT JOIN products p ON soi.product_id = p.id
          WHERE soi.sales_order_id = ?
        `, [id]);
        
        // Obtener info de la orden
        const [orders] = await pool.query(`
          SELECT 
            order_number as number,
            order_date as date,
            total_amount as amount,
            status,
            customer_name
          FROM sales_orders
          WHERE id = ?
        `, [id]);
        
        if (orders.length > 0) {
          header = {
            ...orders[0],
            customer_name: orders[0].customer_name
          };
        }
      }
      
      res.json({
        header,
        items
      });
    } catch (error) {
      console.error("Error en detalle de venta:", error);
      res.status(500).json({ error: "Error al obtener detalle de venta" });
    }
  });

  // Get today's sales (detailed list)
  router.get("/today-sales", async (req, res) => {
    try {
      const today = new Date().toISOString().split('T')[0];
      
      // Obtener facturas de hoy (POS)
      const [invoices] = await pool.query(`
        SELECT 
          id,
          invoice_number as order_number,
          'Factura' as type,
          issue_date as date,
          total_amount,
          status,
          customer_id
        FROM invoices
        WHERE DATE(issue_date) = '${today}'
        ORDER BY id DESC
      `);
      
      // Obtener órdenes de venta de hoy
      const [orders] = await pool.query(`
        SELECT 
          id,
          order_number,
          'Orden' as type,
          order_date as date,
          total_amount,
          status,
          customer_id
        FROM sales_orders
        WHERE DATE(order_date) = '${today}'
        ORDER BY id DESC
      `);
      
      // Combinar y ordenar por fecha descendente
      const combined = [...invoices, ...orders].sort((a, b) => 
        new Date(b.date) - new Date(a.date)
      );
      
      // Calcular total
      const total = combined.reduce((sum, item) => sum + parseFloat(item.total_amount || 0), 0);
      
      res.json({
        sales: combined,
        total: total,
        count: combined.length
      });
    } catch (error) {
      console.error("Error en ventas de hoy:", error);
      res.status(500).json({ error: "Error al obtener ventas de hoy" });
    }
  });

  // Get inventory report
  router.get("/inventory", async (req, res) => {
    try {
      const [result] = await pool.query(`
        SELECT p.id, p.name, p.sku, p.stock_quantity as quantity, p.price, 
               (p.stock_quantity * p.price) as total_value, p.min_stock_level
        FROM products p
        ORDER BY p.name
      `);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de inventario:", error);
      res.status(500).json({ error: "Error al obtener reporte de inventario" });
    }
  });

  // Get customer report
  router.get("/customers", async (req, res) => {
    try {
      const [result] = await pool.query(`
        SELECT 
          c.id,
          c.name,
          c.email,
          COUNT(o.id) as orders_count,
          COALESCE(SUM(o.total_amount), 0) as total_spent
        FROM customers c
        LEFT JOIN sales_orders o ON c.id = o.customer_id
        GROUP BY c.id, c.name, c.email
        ORDER BY total_spent DESC
      `);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de clientes:", error);
      res.status(500).json({ error: "Error al obtener reporte de clientes" });
    }
  });

  // Get production orders report
  router.get("/production-orders", async (req, res) => {
    try {
      const { status } = req.query;
      
      let query = `
        SELECT 
          po.id,
          po.order_number,
          p.name as product_name,
          po.quantity,
          po.status,
          DATE(po.order_date) as order_date,
          CONCAT(e.first_name, ' ', e.last_name) as responsible_name
        FROM production_orders po
        LEFT JOIN products p ON po.product_id = p.id
        LEFT JOIN employees e ON po.responsible_employee_id = e.id
        WHERE 1=1
      `;
      
      if (status) {
        query += ` AND po.status = '${status}'`;
      }
      
      query += ` ORDER BY po.order_date DESC`;
      
      const [result] = await pool.query(query);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de órdenes de producción:", error);
      res.status(500).json({ error: "Error al obtener reporte de órdenes de producción" });
    }
  });

  // Get sales orders report
  router.get("/sales-orders", async (req, res) => {
    try {
      const { status, startDate, endDate } = req.query;
      
      let query = `
        SELECT 
          so.id,
          so.order_number,
          so.customer_name,
          so.total_amount,
          so.status,
          DATE(so.order_date) as order_date,
          COUNT(soi.id) as items_count
        FROM sales_orders so
        LEFT JOIN sales_order_items soi ON so.id = soi.sales_order_id
        WHERE 1=1
      `;
      
      if (status) {
        query += ` AND so.status = '${status}'`;
      }
      if (startDate) {
        query += ` AND DATE(so.order_date) >= '${startDate}'`;
      }
      if (endDate) {
        query += ` AND DATE(so.order_date) <= '${endDate}'`;
      }
      
      query += ` GROUP BY so.id, so.order_number, so.customer_name, so.total_amount, so.status, so.order_date`;
      query += ` ORDER BY so.order_date DESC`;
      
      const [result] = await pool.query(query);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de órdenes de venta:", error);
      res.status(500).json({ error: "Error al obtener reporte de órdenes de venta" });
    }
  });

  // Get products report
  router.get("/products", async (req, res) => {
    try {
      const [result] = await pool.query(`
        SELECT 
          p.id,
          p.name,
          p.sku,
          p.category,
          p.price,
          p.stock_quantity,
          p.min_stock_level,
          (p.stock_quantity * p.price) as total_value,
          CASE 
            WHEN p.stock_quantity <= p.min_stock_level THEN 'Bajo'
            WHEN p.stock_quantity <= p.min_stock_level * 2 THEN 'Medio'
            ELSE 'Suficiente'
          END as stock_status
        FROM products p
        ORDER BY p.name
      `);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de productos:", error);
      res.status(500).json({ error: "Error al obtener reporte de productos" });
    }
  });

  // Get employees report
  router.get("/employees", async (req, res) => {
    try {
      const [result] = await pool.query(`
        SELECT 
          e.id,
          CONCAT(e.first_name, ' ', e.last_name) as name,
          e.position,
          e.email,
          e.phone,
          e.hire_date as start_date,
          COUNT(po.id) as production_orders_count
        FROM employees e
        LEFT JOIN production_orders po ON e.id = po.responsible_employee_id
        GROUP BY e.id, e.first_name, e.last_name, e.position, e.email, e.phone, e.hire_date
        ORDER BY e.first_name
      `);
      res.json(result);
    } catch (error) {
      console.error("Error en reporte de empleados:", error);
      res.status(500).json({ error: "Error al obtener reporte de empleados" });
    }
  });

  // Get summary report (dashboard)
  router.get("/summary", async (req, res) => {
    try {
      // Total de ventas = sales_orders + invoices (POS)
      const [salesOrdersTotal] = await pool.query(`
        SELECT COALESCE(SUM(total_amount), 0) as total 
        FROM sales_orders
      `);
      
      const [invoicesTotal] = await pool.query(`
        SELECT COALESCE(SUM(total_amount), 0) as total 
        FROM invoices
        WHERE status = 'paid'
      `);
      
      const totalSales = parseFloat(salesOrdersTotal[0]?.total || 0) + parseFloat(invoicesTotal[0]?.total || 0);
      
      const [totalProduction] = await pool.query(`
        SELECT COUNT(*) as count FROM production_orders
      `);
      
      const [totalProducts] = await pool.query(`
        SELECT COUNT(*) as count FROM products
      `);
      
      const [totalCustomers] = await pool.query(`
        SELECT COUNT(*) as count FROM customers
      `);

      res.json({
        total_sales: totalSales,
        total_production_orders: totalProduction[0]?.count || 0,
        total_products: totalProducts[0]?.count || 0,
        total_customers: totalCustomers[0]?.count || 0
      });
    } catch (error) {
      console.error("Error en reporte resumen:", error);
      res.status(500).json({ error: "Error al obtener reporte resumen" });
    }
  });

  return router;
}
