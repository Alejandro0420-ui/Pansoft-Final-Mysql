/**
 * Servicio de alertas de caducidad
 * Verifica productos y suministros próximos a vencer y crea notificaciones
 */

export async function checkExpiryDates(pool) {
  try {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    console.log("🔍 Verificando productos y suministros próximos a vencer...");

    // 1. Obtener productos próximos a vencer (próximos 7 días)
    const [expiringProducts] = await pool.query(`
      SELECT 
        id, 
        name, 
        expiry_date,
        DATEDIFF(expiry_date, CURDATE()) as days_until_expiry
      FROM products 
      WHERE expiry_date IS NOT NULL 
        AND is_active = TRUE
        AND DATEDIFF(expiry_date, CURDATE()) BETWEEN -999 AND 7
        AND DATEDIFF(expiry_date, CURDATE()) != 999
      ORDER BY expiry_date ASC
    `);

    // 2. Obtener suministros próximos a vencer (próximos 7 días)
    const [expiyingSupplies] = await pool.query(`
      SELECT 
        id, 
        name, 
        expiry_date,
        DATEDIFF(expiry_date, CURDATE()) as days_until_expiry
      FROM supplies 
      WHERE expiry_date IS NOT NULL 
        AND is_active = TRUE
        AND DATEDIFF(expiry_date, CURDATE()) BETWEEN -999 AND 7
        AND DATEDIFF(expiry_date, CURDATE()) != 999
      ORDER BY expiry_date ASC
    `);

    let createdAlerts = 0;

    // 3. Procesar productos
    for (const product of expiringProducts) {
      const daysUntilExpiry = product.days_until_expiry;
      let alertType = "expiring_this_week";

      if (daysUntilExpiry < 0) {
        alertType = "expired";
      } else if (daysUntilExpiry <= 1) {
        alertType = "expiring_today_or_tomorrow";
      }

      // Verificar si ya existe alerta activa
      const [existingAlert] = await pool.query(
        `SELECT id FROM expiry_alerts 
         WHERE product_id = ? AND is_active = TRUE AND alert_type = ?`,
        [product.id, alertType],
      );

      if (existingAlert.length === 0) {
        // Crear nueva alerta
        await pool.query(
          `INSERT INTO expiry_alerts 
           (product_id, alert_type, expiry_date, days_until_expiry, is_active) 
           VALUES (?, ?, ?, ?, TRUE)`,
          [product.id, alertType, product.expiry_date, daysUntilExpiry],
        );

        // Crear notificación
        const messageTitle =
          alertType === "expired"
            ? ` PRODUCTO VENCIDO: ${product.name}`
            : alertType === "expiring_today_or_tomorrow"
              ? ` VENCE HOY/MAÑANA: ${product.name}`
              : ` PRÓXIMO A VENCER: ${product.name}`;

        const messageBody =
          alertType === "expired"
            ? `El producto "${product.name}" venció hace ${Math.abs(daysUntilExpiry)} días (${product.expiry_date})`
            : `El producto "${product.name}" vence en ${daysUntilExpiry} día(s) (${product.expiry_date})`;

        await pool.query(
          `INSERT INTO notifications 
           (title, message, type, module, related_id, is_read, status) 
           VALUES (?, ?, ?, ?, ?, FALSE, 'active')`,
          [messageTitle, messageBody, "expiry_alert", "inventory", product.id],
        );

        createdAlerts++;
        console.log(` Alerta creada - ${messageTitle}`);
      }
    }

    // 4. Procesar suministros
    for (const supply of expiyingSupplies) {
      const daysUntilExpiry = supply.days_until_expiry;
      let alertType = "expiring_this_week";

      if (daysUntilExpiry < 0) {
        alertType = "expired";
      } else if (daysUntilExpiry <= 1) {
        alertType = "expiring_today_or_tomorrow";
      }

      const [existingAlert] = await pool.query(
        `SELECT id FROM expiry_alerts 
         WHERE supply_id = ? AND is_active = TRUE AND alert_type = ?`,
        [supply.id, alertType],
      );

      if (existingAlert.length === 0) {
        await pool.query(
          `INSERT INTO expiry_alerts 
           (supply_id, alert_type, expiry_date, days_until_expiry, is_active) 
           VALUES (?, ?, ?, ?, TRUE)`,
          [supply.id, alertType, supply.expiry_date, daysUntilExpiry],
        );

        const messageTitle =
          alertType === "expired"
            ? `⚠️ INSUMO VENCIDO: ${supply.name}`
            : alertType === "expiring_today_or_tomorrow"
              ? `🚨 VENCE HOY/MAÑANA: ${supply.name}`
              : `⏰ PRÓXIMO A VENCER: ${supply.name}`;

        const messageBody =
          alertType === "expired"
            ? `El insumo "${supply.name}" venció hace ${Math.abs(daysUntilExpiry)} días (${supply.expiry_date})`
            : `El insumo "${supply.name}" vence en ${daysUntilExpiry} día(s) (${supply.expiry_date})`;

        await pool.query(
          `INSERT INTO notifications 
           (title, message, type, module, related_id, is_read, status) 
           VALUES (?, ?, ?, ?, ?, FALSE, 'active')`,
          [messageTitle, messageBody, "expiry_alert", "supplies", supply.id],
        );

        createdAlerts++;
        console.log(`✅ Alerta creada - ${messageTitle}`);
      }
    }

    console.log(
      `\n✅ Verificación completada. ${createdAlerts} nuevas alertas creadas.`,
    );
    return {
      expiringProducts: expiringProducts.length,
      expiyingSupplies: expiyingSupplies.length,
      createdAlerts,
    };
  } catch (error) {
    console.error("❌ Error en checkExpiryDates:", error);
    throw error;
  }
}

/**
 * Obtiene un sumario de productos próximos a vencer
 */
export async function getExpirySummary(pool) {
  try {
    const [expired] = await pool.query(`
      SELECT 'product' as type, id, name, expiry_date, 'expired' as status
      FROM products 
      WHERE expiry_date IS NOT NULL AND expiry_date < CURDATE() AND is_active = TRUE
      UNION ALL
      SELECT 'supply' as type, id, name, expiry_date, 'expired' as status
      FROM supplies 
      WHERE expiry_date IS NOT NULL AND expiry_date < CURDATE() AND is_active = TRUE
    `);

    const [expiringSoon] = await pool.query(`
      SELECT 'product' as type, id, name, expiry_date, 'expiring_soon' as status
      FROM products 
      WHERE expiry_date IS NOT NULL 
        AND expiry_date >= CURDATE() 
        AND expiry_date <= DATE_ADD(CURDATE(), INTERVAL 7 DAY)
        AND is_active = TRUE
      UNION ALL
      SELECT 'supply' as type, id, name, expiry_date, 'expiring_soon' as status
      FROM supplies 
      WHERE expiry_date IS NOT NULL 
        AND expiry_date >= CURDATE() 
        AND expiry_date <= DATE_ADD(CURDATE(), INTERVAL 7 DAY)
        AND is_active = TRUE
    `);

    return {
      expired: expired || [],
      expiringSoon: expiringSoon || [],
    };
  } catch (error) {
    console.error("❌ Error en getExpirySummary:", error);
    throw error;
  }
}
