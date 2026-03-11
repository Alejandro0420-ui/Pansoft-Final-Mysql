// ============================================
// SISTEMA DE PERMISOS - FRONTEND
// ============================================

import {
  createContext,
  useState,
  useEffect,
  useCallback,
  useContext,
} from "react";
import axios from "axios";

// ============================================
// 1. CONTEXTO DE PERMISOS
// ============================================

export const PermissionsContext = createContext();

export const PermissionsProvider = ({ children }) => {
  const [permissions, setPermissions] = useState({});
  const [userRole, setUserRole] = useState(null);
  const [userId, setUserId] = useState(null);
  const [loading, setLoading] = useState(true);

  // Cargar permisos del usuario al montar
  useEffect(() => {
    const loadUserPermissions = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) {
          setLoading(false);
          return;
        }

        const response = await axios.get(
          "/api/auth/user/permissions",
          {
            headers: { Authorization: `Bearer ${token}` },
          },
        );

        console.log(" Permisos cargados:", response.data);

        setPermissions(response.data.permissions || {});
        setUserRole(response.data.user?.roleName || null);
        setUserId(response.data.user?.id || null);
      } catch (error) {
        console.error("Error cargando permisos:", error);
      } finally {
        // Esperar un tick para que React se sincronice
        setTimeout(() => setLoading(false), 100);
      }
    };

    loadUserPermissions();
  }, []);

  return (
    <PermissionsContext.Provider
      value={{ permissions, userRole, userId, loading }}
    >
      {children}
    </PermissionsContext.Provider>
  );
};

// ============================================
// 2. CUSTOM HOOK: usePermissions
// ============================================

export const usePermissions = () => {
  const context = useContext(PermissionsContext);
  if (!context) {
    throw new Error(
      "usePermissions debe ser usado dentro de PermissionsProvider",
    );
  }
  return context;
};

// ============================================
// 3. CUSTOM HOOK: useHasPermission
// ============================================

export const useHasPermission = (module, action = "read") => {
  const { permissions } = usePermissions();

  return useCallback(() => {
    const modulePerms = permissions[module];
    if (!modulePerms) return false;

    if (action === "read") return modulePerms.read === true;
    if (action === "write") return modulePerms.write === true;
    if (action === "delete") return modulePerms.delete === true;

    return false;
  }, [permissions, module, action]);
};

// ============================================
// 4. CUSTOM HOOK: useCanAccess
// ============================================

export const useCanAccess = (requiredModules, requiredAction = "read") => {
  const { permissions } = usePermissions();

  return requiredModules.some((module) => {
    const modulePerms = permissions[module];
    if (!modulePerms) return false;

    if (requiredAction === "read") return modulePerms.read === true;
    if (requiredAction === "write") return modulePerms.write === true;
    if (requiredAction === "delete") return modulePerms.delete === true;

    return false;
  });
};

// ============================================
// 5. CUSTOM HOOK: useCanAdmin
// ============================================

export const useCanAdmin = () => {
  const { userRole } = usePermissions();
  return userRole === "Administrador General";
};

// ============================================
// 6. COMPONENTE: ProtectedRoute
// ============================================

import { Navigate } from "react-router-dom";

export const ProtectedRoute = ({
  children,
  requiredRoles = [],
  requiredPermission = null,
}) => {
  const { userRole, permissions, loading } = usePermissions();

  if (loading) {
    return <div>Cargando...</div>;
  }

  // Verificar rol
  if (requiredRoles.length > 0 && !requiredRoles.includes(userRole)) {
    return <Navigate to="/denied" />;
  }

  // Verificar permiso
  if (requiredPermission) {
    const hasPermission = permissions.some(
      (perm) => perm.name === requiredPermission,
    );
    if (!hasPermission) {
      return <Navigate to="/denied" />;
    }
  }

  return children;
};

// ============================================
// 7. COMPONENTE: ConditionalRender
// ============================================

export const ConditionalRender = ({
  children,
  permission = null,
  roles = [],
  action = "read",
}) => {
  const { permissions, userRole } = usePermissions();

  // Verificar rol
  if (roles.length > 0 && !roles.includes(userRole)) {
    return null;
  }

  // Verificar permiso
  if (permission) {
    const [module, perm] = permission.split(".");
    const hasPermission = permissions.some(
      (p) => p.module === module && (p.action === "read" || p.action === perm),
    );
    if (!hasPermission) return null;
  }

  return children;
};

// ============================================
// 8. COMPONENTE: ToolbarWithPermissions
// ============================================

import { Plus, Edit, Trash2 } from "lucide-react";

export const ToolbarWithPermissions = ({ module }) => {
  const canCreate = useHasPermission(module, "write");
  const canEdit = useHasPermission(module, "write");
  const canDelete = useHasPermission(module, "delete");

  return (
    <div className="btn-group">
      {canCreate && (
        <button className="btn btn-primary btn-sm">
          <Plus size={18} /> Crear
        </button>
      )}
      {canEdit && (
        <button className="btn btn-secondary btn-sm">
          <Edit size={18} /> Editar
        </button>
      )}
      {canDelete && (
        <button className="btn btn-danger btn-sm">
          <Trash2 size={18} /> Eliminar
        </button>
      )}
    </div>
  );
};

// ============================================
// 9. COMPONENTE: NavbarWithRoles
// ============================================

export const NavbarWithRoles = () => {
  const { userRole } = usePermissions();

  return (
    <nav className="navbar">
      <div className="navbar-brand">Pansoft</div>
      <ul className="navbar-nav">
        {/* Menú disponible para todos */}
        <li className="nav-item">
          <a href="/dashboard">Dashboard</a>
        </li>

        {/* Menú solo para roles específicos */}
        <ConditionalRender roles={["Administrador", "Gerente"]}>
          <li className="nav-item">
            <a href="/employees">Empleados</a>
          </li>
        </ConditionalRender>

        <ConditionalRender permission="billing.view">
          <li className="nav-item">
            <a href="/billing">Facturación</a>
          </li>
        </ConditionalRender>

        {/* Admin solo */}
        <ConditionalRender roles={["Administrador"]}>
          <li className="nav-item">
            <a href="/settings">Configuración</a>
          </li>
        </ConditionalRender>

        <li className="nav-item">
          <span className="badge">{userRole}</span>
        </li>
      </ul>
    </nav>
  );
};

// ============================================
// 10. COMPONENTE: InventoryTable EJEMPLO
// ============================================

export const InventoryTable = () => {
  const canEdit = useHasPermission("inventory", "write");
  const canDelete = useHasPermission("inventory", "delete");
  const [inventory, setInventory] = useState([]);

  useEffect(() => {
    fetchInventory();
  }, []);

  const fetchInventory = async () => {
    try {
      const response = await axios.get("/api/inventory", {
        headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
      });
      setInventory(response.data);
    } catch (error) {
      console.error("Error:", error);
    }
  };

  return (
    <table className="table">
      <thead>
        <tr>
          <th>Producto</th>
          <th>Cantidad</th>
          {(canEdit || canDelete) && <th>Acciones</th>}
        </tr>
      </thead>
      <tbody>
        {inventory.map((item) => (
          <tr key={item.id}>
            <td>{item.name}</td>
            <td>{item.quantity}</td>
            {(canEdit || canDelete) && (
              <td>
                {canEdit && (
                  <button className="btn btn-sm btn-secondary">Editar</button>
                )}
                {canDelete && (
                  <button className="btn btn-sm btn-danger">Eliminar</button>
                )}
              </td>
            )}
          </tr>
        ))}
      </tbody>
    </table>
  );
};

// ============================================
// 11. SERVICIO DE API CON PERMISOS
// ============================================

export const apiService = {
  async canAccess(module, action = "read") {
    try {
      const response = await axios.post(
        "/api/check-permission",
        { module, action },
        {
          headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
        },
      );
      return response.data.hasPermission;
    } catch {
      return false;
    }
  },

  async getUserRole() {
    try {
      const response = await axios.get("/api/user/role", {
        headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
      });
      return response.data.role;
    } catch {
      return null;
    }
  },
};

// ============================================
// 12. EJEMPLO DE USO EN COMPONENTE
// ============================================

/**
 * EJEMPLO 1: Usar ProtectedRoute
 *
 * <Routes>
 *   <Route path="/inventario" element={
 *     <ProtectedRoute requiredRoles={['Administrador', 'Supervisor Stock']}>
 *       <Inventory />
 *     </ProtectedRoute>
 *   } />
 * </Routes>
 */

/**
 * EJEMPLO 2: Mostrar/Ocultar elementos según permiso
 *
 * export function ProductsPage() {
 *   const canCreate = useHasPermission('products', 'write')();
 *
 *   return (
 *     <div>
 *       {canCreate && <button>Crear Producto</button>}
 *       <ProductsTable />
 *     </div>
 *   );
 * }
 */

/**
 * EJEMPLO 3: Renderización condicional
 *
 * <ConditionalRender roles={['Administrador', 'Gerente']}>
 *   <AdminPanel />
 * </ConditionalRender>
 */

/**
 * EJEMPLO 4: Tabla con acciones según permisos
 *
 * {canEdit && <button onClick={handleEdit}>Editar</button>}
 * {canDelete && <button onClick={handleDelete}>Eliminar</button>}
 */
