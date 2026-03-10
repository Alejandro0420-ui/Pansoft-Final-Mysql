import express from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "tu_secret_key_segura_aqui";

export default function authRoutes(pool) {
  const router = express.Router();

  // LOGIN CON VALIDACIÓN DE CONTRASEÑA Y JWT
  router.post("/login", async (req, res) => {
    try {
      const { username, password } = req.body;

      // Validar que los datos requeridos existan
      if (!username || !password) {
        return res
          .status(400)
          .json({ error: "Usuario y contraseña requeridos" });
      }

      // Validar longitud mínima
      if (password.length < 6) {
        return res
          .status(400)
          .json({ error: "Contraseña debe tener al menos 6 caracteres" });
      }

      // Buscar usuario en la base de datos
      const [users] = await pool.query(
        "SELECT * FROM users WHERE username = ?",
        [username],
      );

      if (users.length === 0) {
        return res
          .status(401)
          .json({ error: "Usuario o contraseña incorrectos" });
      }

      const user = users[0];

      // Validar contraseña con bcrypt
      let passwordIsValid = await bcrypt.compare(password, user.password);

      // MIGRACIÓN: Si falla bcrypt, intentar con texto plano (usuarios antiguos)
      if (!passwordIsValid && user.password === password) {
        passwordIsValid = true;
        // Hashear y actualizar la contraseña en la BD
        const hashedPassword = await bcrypt.hash(password, 10);
        await pool.query("UPDATE users SET password = ? WHERE id = ?", [
          hashedPassword,
          user.id,
        ]);
        console.log(`Contraseña migrada para usuario: ${user.username}`);
      }

      if (!passwordIsValid) {
        return res
          .status(401)
          .json({ error: "Usuario o contraseña incorrectos" });
      }

      // Generar JWT real con información segura
      const token = jwt.sign(
        {
          id: user.id,
          username: user.username,
          email: user.email,
          roleId: user.role_id,
        },
        JWT_SECRET,
        { expiresIn: "24h" }, // Token expira en 24 horas
      );

      res.json({
        success: true,
        token,
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          roleId: user.role_id,
          mustChangePassword: user.must_change_password || false,
        },
      });
    } catch (error) {
      console.error("Error en login:", error);
      res.status(500).json({ error: "Error en el servidor" });
    }
  });

  // REGISTER CON VALIDACIÓN DE USUARIO EXISTENTE Y HASH DE CONTRASEÑA
  router.post("/register", async (req, res) => {
    try {
      const { username, email, password, full_name } = req.body;

      // Validar datos requeridos
      if (!username || !email || !password || !full_name) {
        return res
          .status(400)
          .json({ error: "Todos los campos son requeridos" });
      }

      // Validar longitud de contraseña
      if (password.length < 6) {
        return res
          .status(400)
          .json({ error: "Contraseña debe tener al menos 6 caracteres" });
      }

      // Validar formato de email
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        return res.status(400).json({ error: "Email inválido" });
      }

      // Validar si el usuario ya existe
      const [existingUsers] = await pool.query(
        "SELECT id FROM users WHERE username = ? OR email = ?",
        [username, email],
      );

      if (existingUsers.length > 0) {
        return res
          .status(409)
          .json({ error: "El usuario o email ya está registrado" });
      }

      // Hash de la contraseña con bcrypt
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(password, saltRounds);

      // Insertar usuario con rol por defecto 'employee'
      const [result] = await pool.query(
        "INSERT INTO users (username, email, password, full_name, role) VALUES (?, ?, ?, ?, ?)",
        [username, email, hashedPassword, full_name, "employee"],
      );

      // Generar token JWT para login automático
      const token = jwt.sign(
        {
          id: result.insertId,
          username,
          email,
          role: "employee",
        },
        JWT_SECRET,
        { expiresIn: "24h" },
      );

      res.json({
        success: true,
        token,
        user: {
          id: result.insertId,
          username,
          email,
          role: "employee",
        },
      });
    } catch (error) {
      console.error("Error en registro:", error);
      res.status(500).json({ error: "Error al registrar usuario" });
    }
  });

  // OBTENER PERMISOS DEL USUARIO AUTENTICADO
  router.get("/user/permissions", async (req, res) => {
    try {
      // Verificar token JWT
      const token = req.headers.authorization?.split(" ")[1];
      if (!token) {
        return res.status(401).json({ error: "Token no proporcionado" });
      }

      let decoded;
      try {
        decoded = jwt.verify(token, JWT_SECRET);
      } catch (error) {
        return res.status(401).json({ error: "Token inválido o expirado" });
      }

      const userId = decoded.id;
      const roleId = decoded.roleId;

      // Obtener usuario con rol
      const [users] = await pool.query(
        `SELECT u.id, u.username, u.email, u.role_id, r.name as role_name 
         FROM users u 
         LEFT JOIN roles r ON u.role_id = r.id 
         WHERE u.id = ?`,
        [userId],
      );

      // Verificar que el roleId del JWT coincida
      if (users.length === 0 || (roleId && users[0].role_id !== roleId)) {
        return res.status(401).json({ error: "Token inválido" });
      }

      if (users.length === 0) {
        return res.status(404).json({ error: "Usuario no encontrado" });
      }

      const user = users[0];

      // Obtener permisos del usuario a través de su rol
      const [permissions] = await pool.query(
        `SELECT DISTINCT p.id, p.name, p.module, p.action, p.description
         FROM permissions p
         JOIN role_permissions rp ON p.id = rp.permission_id
         WHERE rp.role_id = ?
         ORDER BY p.module, p.action`,
        [user.role_id],
      );

      // Estructurar permisos por módulo
      const permissionsByModule = {};
      permissions.forEach((perm) => {
        if (!permissionsByModule[perm.module]) {
          permissionsByModule[perm.module] = {
            read: false,
            write: false,
            delete: false,
          };
        }
        if (perm.action === "read")
          permissionsByModule[perm.module].read = true;
        if (perm.action === "write")
          permissionsByModule[perm.module].write = true;
        if (perm.action === "delete")
          permissionsByModule[perm.module].delete = true;
      });

      res.json({
        success: true,
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          roleId: user.role_id,
          roleName: user.role_name,
        },
        permissions: permissionsByModule,
        allPermissions: permissions, // Para UI avanzada (permiso específico)
      });
    } catch (error) {
      console.error("Error al obtener permisos:", error);
      res.status(500).json({ error: "Error al obtener permisos" });
    }
  });

  // CAMBIAR CONTRASEÑA DEL USUARIO
  router.post("/change-password", async (req, res) => {
    try {
      const { userId, newPassword } = req.body;

      // Validar datos requeridos
      if (!userId || !newPassword) {
        return res
          .status(400)
          .json({ error: "Usuario y nueva contraseña requeridos" });
      }

      if (newPassword.length < 6) {
        return res
          .status(400)
          .json({ error: "Contraseña debe tener al menos 6 caracteres" });
      }

      // Hash de la nueva contraseña
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(newPassword, saltRounds);

      // Actualizar contraseña y establecer must_change_password a FALSE
      await pool.query(
        "UPDATE users SET password = ?, must_change_password = FALSE WHERE id = ?",
        [hashedPassword, userId],
      );

      res.json({
        success: true,
        message: "Contraseña actualizada correctamente",
      });
    } catch (error) {
      console.error("Error al cambiar contraseña:", error);
      res.status(500).json({ error: "Error al cambiar contraseña" });
    }
  });

  return router;
}
