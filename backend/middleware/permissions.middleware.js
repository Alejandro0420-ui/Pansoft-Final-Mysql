import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "tu_secret_key_segura_aqui";

// ============================================
// MIDDLEWARE: Verificar Token JWT
// ============================================
export const verifyToken = (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];

  if (!token) {
    return res.status(401).json({ error: "Token no proporcionado" });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ error: "Token inválido o expirado" });
  }
};

// ============================================
// MIDDLEWARE: Verificar Rol (inyectar pool)
// ============================================
export const checkRole = (pool) => {
  return (allowedRoles) => {
    return async (req, res, next) => {
      try {
        if (!req.user || !req.user.id) {
          return res.status(401).json({ error: "Usuario no autenticado" });
        }

        const [userRole] = await pool.query(
          "SELECT role_id FROM users WHERE id = ?",
          [req.user.id],
        );

        if (!userRole.length) {
          return res.status(404).json({ error: "Usuario no encontrado" });
        }

        const roleId = userRole[0].role_id;

        // Obtener el nombre del rol
        const [role] = await pool.query("SELECT name FROM roles WHERE id = ?", [
          roleId,
        ]);

        if (!role.length) {
          return res.status(404).json({ error: "Rol no encontrado" });
        }

        const roleName = role[0].name;

        if (!allowedRoles.includes(roleName)) {
          return res.status(403).json({
            error: "No tienes permisos para acceder a este recurso",
            requiredRoles: allowedRoles,
            userRole: roleName,
          });
        }

        req.userRole = roleName;
        req.roleId = roleId;
        next();
      } catch (error) {
        console.error("Error en checkRole:", error);
        res.status(500).json({ error: "Error verificando rol" });
      }
    };
  };
};

// ============================================
// MIDDLEWARE: Verificar Permiso Específico
// ============================================
export const checkPermission = (pool) => {
  return (requiredPermission) => {
    return async (req, res, next) => {
      try {
        if (!req.user || !req.user.id) {
          return res.status(401).json({ error: "Usuario no autenticado" });
        }

        // Obtener permisos del usuario a través de su rol
        const [permissions] = await pool.query(
          `SELECT p.name FROM permissions p
           INNER JOIN role_permissions rp ON p.id = rp.permission_id
           INNER JOIN users u ON rp.role_id = u.role_id
           WHERE u.id = ? AND p.name = ?`,
          [req.user.id, requiredPermission],
        );

        if (!permissions.length) {
          return res.status(403).json({
            error: "No tienes permiso para esta acción",
            requiredPermission,
          });
        }

        next();
      } catch (error) {
        console.error("Error en checkPermission:", error);
        res.status(500).json({ error: "Error verificando permiso" });
      }
    };
  };
};

// ============================================
// HELPER: Obtener Permisos del Usuario
// ============================================
export const getUserPermissions = async (pool, userId) => {
  try {
    const [permissions] = await pool.query(
      `SELECT DISTINCT p.name, p.module, p.action 
       FROM permissions p
       INNER JOIN role_permissions rp ON p.id = rp.permission_id
       INNER JOIN users u ON rp.role_id = u.role_id
       WHERE u.id = ?`,
      [userId],
    );

    return permissions;
  } catch (error) {
    console.error("Error obteniendo permisos:", error);
    return [];
  }
};

// ============================================
// HELPER: Filtrar por Rol (agrega permisos a req)
// ============================================
export const attachUserPermsissions = (pool) => {
  return async (req, res, next) => {
    try {
      const [userRole] = await pool.query(
        "SELECT role_id FROM users WHERE id = ?",
        [req.user.id],
      );

      if (!userRole.length) {
        return res.status(404).json({ error: "Usuario no encontrado" });
      }

      const roleId = userRole[0].role_id;

      const [permissions] = await pool.query(
        `SELECT DISTINCT p.name, p.module, p.action 
         FROM permissions p
         INNER JOIN role_permissions rp ON p.id = rp.permission_id
         WHERE rp.role_id = ?`,
        [roleId],
      );

      // Crear objeto con estructura modular
      req.userPermissions = {};
      permissions.forEach((perm) => {
        if (!req.userPermissions[perm.module]) {
          req.userPermissions[perm.module] = [];
        }
        req.userPermissions[perm.module].push({
          name: perm.name,
          action: perm.action,
        });
      });

      next();
    } catch (error) {
      console.error("Error en attachUserPermissions:", error);
      res.status(500).json({ error: "Error cargando permisos" });
    }
  };
};

// ============================================
// HELPER: Verificar si usuario tiene permiso
// ============================================
export const hasPermission = (userPermissions, module, action) => {
  if (!userPermissions[module]) return false;

  return userPermissions[module].some(
    (perm) => perm.action === "read" || perm.action === action,
  );
};

// ============================================
// HELPER: Verificar si es administrador
// ============================================
export const isAdmin = async (userId) => {
  try {
    const connection = await pool.getConnection();

    const [result] = await connection.query(
      `SELECT u.id FROM users u
       INNER JOIN roles r ON u.role_id = r.id
       WHERE u.id = ? AND r.name = 'Administrador'`,
      [userId],
    );

    connection.release();
    return result.length > 0;
  } catch (error) {
    console.error("Error verificando admin:", error);
    return false;
  }
};

// ============================================
// MIDDLEWARE DE CADENA
// ============================================
export const requireAuth = [verifyToken, attachUserPermsissions];

export const requireAuthAndRole = (roles) => [
  verifyToken,
  checkRole(roles),
  attachUserPermsissions,
];

export const requireAuthAndPermission = (permission) => [
  verifyToken,
  checkPermission(permission),
  attachUserPermsissions,
];
