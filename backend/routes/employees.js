import express from "express";
import bcrypt from "bcrypt";

export default function employeesRoutes(pool) {
  const router = express.Router();

  // Get all employees
  router.get("/", async (req, res) => {
    try {
      const [result] = await pool.query(
        "SELECT * FROM employees ORDER BY last_name, first_name",
      );
      res.json(result);
    } catch (error) {
      console.error("Error al obtener empleados:", error);
      res.status(500).json({ error: "Error al obtener empleados" });
    }
  });

  // Get employee by ID
  router.get("/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const [result] = await pool.query(
        "SELECT * FROM employees WHERE id = ?",
        [id],
      );
      res.json(result[0] || {});
    } catch (error) {
      console.error("Error al obtener empleado:", error);
      res.status(500).json({ error: "Error al obtener empleado" });
    }
  });

  // Create employee
  router.post("/", async (req, res) => {
    try {
      const {
        first_name,
        last_name,
        email,
        phone,
        position,
        department,
        hire_date,
        salary,
        password,
      } = req.body;

      // Validar que la contraseña sea proporcionada
      if (!password || password.length < 6) {
        return res.status(400).json({
          error: "Contraseña requerida y debe tener al menos 6 caracteres",
        });
      }

      // Validar email único en users
      const [existingUser] = await pool.query(
        "SELECT id FROM users WHERE email = ?",
        [email],
      );
      if (existingUser.length > 0) {
        return res.status(409).json({
          error: "El email ya está registrado en el sistema",
        });
      }

      // Hash de la contraseña
      const hashedPassword = await bcrypt.hash(password, 10);

      // Obtener el role_id del rol "Panadero" (default para empleados)
      const [roles] = await pool.query("SELECT id FROM roles WHERE name = ?", [
        "Panadero",
      ]);
      const roleId = roles.length > 0 ? roles[0].id : 4; // Default a 4 si no existe

      // Crear username: parte del email antes del @
      const username = email.split("@")[0];

      // Crear usuario asociado
      const [userResult] = await pool.query(
        "INSERT INTO users (username, email, password, full_name, role_id, must_change_password) VALUES (?, ?, ?, ?, ?, TRUE)",
        [username, email, hashedPassword, `${first_name} ${last_name}`, roleId],
      );

      // Crear empleado
      const [employeeResult] = await pool.query(
        "INSERT INTO employees (first_name, last_name, email, phone, position, department, hire_date, salary) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [
          first_name,
          last_name,
          email,
          phone,
          position,
          department,
          hire_date,
          salary,
        ],
      );

      res.status(201).json({
        id: employeeResult.insertId,
        user_id: userResult.insertId,
        first_name,
        last_name,
        email,
        phone,
        position,
        department,
        hire_date,
        salary,
        username,
      });
    } catch (error) {
      console.error("Error al crear empleado:", error);
      // Mensajes de error más específicos
      let errorMessage = "Error al crear empleado";
      if (error.code === "ER_DUP_ENTRY") {
        if (error.sqlMessage.includes("username")) {
          errorMessage = "El nombre de usuario ya existe";
        } else if (error.sqlMessage.includes("email")) {
          errorMessage = "El email ya está registrado";
        }
      }
      res.status(500).json({ error: errorMessage, details: error.message });
    }
  });

  // Update employee
  router.put("/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const {
        first_name,
        last_name,
        email,
        phone,
        position,
        department,
        hire_date,
        salary,
        status,
      } = req.body;

      // Usar "active" como valor por defecto si no viene status
      const employeeStatus = status || "active";

      await pool.query(
        "UPDATE employees SET first_name=?, last_name=?, email=?, phone=?, position=?, department=?, hire_date=?, salary=?, status=?, updated_at=NOW() WHERE id=?",
        [
          first_name,
          last_name,
          email,
          phone,
          position,
          department,
          hire_date,
          salary,
          employeeStatus,
          id,
        ],
      );
      res.json({
        id,
        first_name,
        last_name,
        email,
        phone,
        position,
        department,
        hire_date,
        salary,
        status: employeeStatus,
      });
    } catch (error) {
      console.error("Error al actualizar empleado:", error);
      res.status(500).json({ error: "Error al actualizar empleado" });
    }
  });

  // Delete employee
  router.delete("/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await pool.query("DELETE FROM employees WHERE id = ?", [id]);
      res.json({ success: true });
    } catch (error) {
      console.error("Error al eliminar empleado:", error);
      res.status(500).json({ error: "Error al eliminar empleado" });
    }
  });

  return router;
}
