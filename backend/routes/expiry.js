import express from "express";
import { verifyToken } from "../middleware/permissions.middleware.js";
import { checkExpiryDates, getExpirySummary } from "./expiryService.js";

export default function expiryRoutes(pool) {
  const router = express.Router();

  /**
   * GET /api/expiry/summary
   * Obtiene un sumario de productos vencidos y próximos a vencer
   */
  router.get("/summary", verifyToken, async (req, res) => {
    try {
      const summary = await getExpirySummary(pool);
      res.json(summary);
    } catch (error) {
      console.error("Error al obtener sumario de caducidad:", error);
      res.status(500).json({
        error: "Error al obtener sumario de caducidad",
        details: error.message,
      });
    }
  });

  /**
   * POST /api/expiry/check
   * Ejecuta una verificación manual de caducidades
   * Requiere autenticación de admin
   */
  router.post("/check", verifyToken, async (req, res) => {
    try {
      const result = await checkExpiryDates(pool);
      res.json({
        success: true,
        message: "Verificación de caducidad completada",
        data: result,
      });
    } catch (error) {
      console.error("Error al ejecutar verificación de caducidad:", error);
      res.status(500).json({
        error: "Error al ejecutar verificación",
        details: error.message,
      });
    }
  });

  return router;
}
