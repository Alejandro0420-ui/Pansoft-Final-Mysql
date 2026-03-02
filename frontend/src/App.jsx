import { useState, useEffect } from "react";
import { useNavigate, useLocation, Routes, Route } from "react-router-dom";
import { Login } from "./components/login";
import { Dashboard } from "./components/dashboard";
import { Inventory } from "./components/inventory";
import { Products } from "./components/products";
import { Suppliers } from "./components/suppliers";
import { Reports } from "./components/reports";
import { Orders } from "./components/orders";
import { Billing } from "./components/billing";
import { Employees } from "./components/employees";
import { Settings } from "./components/settings";
import { Notifications } from "./components/notifications";
import {
  PermissionsProvider,
  usePermissions,
} from "./utils/permissionsContext";
import {
  LayoutDashboard,
  Package,
  ShoppingCart,
  FileText,
  Users,
  TruckIcon,
  BarChart3,
  Bell,
  Settings as SettingsIcon,
  LogOut,
  Menu,
  X,
  ShoppingBag,
  UserCircle2,
} from "lucide-react";
import "bootstrap/dist/css/bootstrap.min.css";
import "./styles/app.css";
import logo from "./images/Logo-Pansoft.png";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [unreadCount, setUnreadCount] = useState(0);
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);
  const navigate = useNavigate();
  const location = useLocation();

  // Detectar cambios de tamaño de pantalla
  useEffect(() => {
    const handleResize = () => {
      const mobile = window.innerWidth < 768;
      setIsMobile(mobile);
      // Cerrar sidebar en móvil
      if (mobile) {
        setSidebarOpen(false);
      }
    };

    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  // Cerrar sidebar al cambiar de ruta en móvil
  useEffect(() => {
    if (isMobile) {
      setSidebarOpen(false);
    }
  }, [location.pathname, isMobile]);

  // Determinar la página actual basada en la ruta
  const getCurrentPageFromPath = () => {
    const path = location.pathname;
    if (path === "/" || path === "/dashboard") return "dashboard";
    // Mapear rutas a IDs internos
    const routeMap = {
      "/inventario": "inventario",
      "/productos": "productos",
      "/proveedores": "proveedores",
      "/ordenes": "ordenes",
      "/facturacion": "facturacion",
      "/empleados": "empleados",
      "/reportes": "reportes",
      "/notificaciones": "notificaciones",
      "/configuracion": "configuracion",
    };
    return routeMap[path] || "dashboard";
  };

  const currentPage = getCurrentPageFromPath();

  // Obtener conteo de notificaciones sin leer
  useEffect(() => {
    const fetchUnreadCount = async () => {
      try {
        const response = await fetch(
          "http://localhost:5000/api/notifications/unread/count",
        );
        const data = await response.json();
        setUnreadCount(data.unreadCount || 0);
      } catch (error) {
        console.error("Error obteniendo conteo de notificaciones:", error);
      }
    };

    fetchUnreadCount();
    // Actualizar cada 10 segundos
    const interval = setInterval(fetchUnreadCount, 10000);
    return () => clearInterval(interval);
  }, []);

  if (!isLoggedIn) {
    return <Login onLogin={() => setIsLoggedIn(true)} />;
  }

  // Definir menú items
  const menuItems = [
    { id: "dashboard", label: "Dashboard", icon: LayoutDashboard, path: "/" },
    {
      id: "inventario",
      label: "Inventario",
      icon: Package,
      path: "/inventario",
    },
    {
      id: "productos",
      label: "Productos",
      icon: ShoppingBag,
      path: "/productos",
    },
    {
      id: "proveedores",
      label: "Proveedores",
      icon: TruckIcon,
      path: "/proveedores",
    },
    { id: "ordenes", label: "Órdenes", icon: ShoppingCart, path: "/ordenes" },
    {
      id: "facturacion",
      label: "Facturación",
      icon: FileText,
      path: "/facturacion",
    },
    {
      id: "empleados",
      label: "Empleados",
      icon: UserCircle2,
      path: "/empleados",
    },
    { id: "reportes", label: "Reportes", icon: BarChart3, path: "/reportes" },
    {
      id: "notificaciones",
      label: "Notificaciones",
      icon: Bell,
      path: "/notificaciones",
    },
    {
      id: "configuracion",
      label: "Configuración",
      icon: SettingsIcon,
      path: "/configuracion",
    },
  ];

  // Cuando está logueado, envolver con PermissionsProvider
  return (
    <PermissionsProvider>
      <AppContent
        sidebarOpen={sidebarOpen}
        setSidebarOpen={setSidebarOpen}
        isMobile={isMobile}
        setIsMobile={setIsMobile}
        unreadCount={unreadCount}
        setUnreadCount={setUnreadCount}
        navigate={navigate}
        location={location}
        setIsLoggedIn={setIsLoggedIn}
        currentPage={currentPage}
        menuItems={menuItems}
      />
    </PermissionsProvider>
  );
}

// Componente separado para el contenido dentro del proveedor
function AppContent({
  sidebarOpen,
  setSidebarOpen,
  isMobile,
  unreadCount,
  navigate,
  location,
  setIsLoggedIn,
  currentPage,
  menuItems,
}) {
  // Obtener permisos del contexto
  const { loading: permissionsLoading, permissions } = usePermissions();

  // Mapeo de IDs del menú a módulos de BD
  const moduleMap = {
    dashboard: "dashboard",
    inventario: "inventory",
    productos: "products",
    proveedores: "suppliers",
    ordenes: "orders",
    facturacion: "billing",
    empleados: "employees",
    reportes: "reports",
    notificaciones: "notifications",
    configuracion: "settings",
  };

  // Filtrar menú items basado en permisos
  const filteredMenuItems = menuItems.filter((item) => {
    const module = moduleMap[item.id] || item.id;
    const hasMenuAccess = permissions[module]?.read || false;
    // Siempre mostrar dashboard
    return item.id === "dashboard" || hasMenuAccess;
  });

  // Mostrar loading mientras se cargan permisos
  if (permissionsLoading) {
    return (
      <div
        className="d-flex align-items-center justify-content-center"
        style={{ minHeight: "100vh", backgroundColor: "#f8f9fa" }}
      >
        <div className="text-center">
          <div className="spinner-border text-primary mb-3" role="status">
            <span className="visually-hidden">Cargando...</span>
          </div>
          <p className="text-muted">Cargando permisos...</p>
        </div>
      </div>
    );
  }

  return (
    <div
      className="d-flex"
      style={{ minHeight: "100vh", backgroundColor: "#f8f9fa" }}
    >
      {/* Sidebar */}
      <aside
        className={`bg-white border-end ${sidebarOpen ? "sidebar-open" : "sidebar-closed"}`}
        style={{
          width: sidebarOpen ? "300px" : "0px",
          transition: "width 0.3s ease",
          overflow: "hidden",
          display: "flex",
          flexDirection: "column",
          borderRight: "1px solid #dee2e6",
        }}
      >
        {/* Logo */}
        <div
          className="p-4 border-bottom"
          style={{
            background: "linear-gradient(135deg, #EBB583 0%, #EBCC83 100%)",
          }}
        >
          <div className="d-flex justify-content-center">
            <img src={logo} id="pansoft-logo" alt="Pansoft Logo" />
          </div>
        </div>

        {/* Menu */}
        <nav className="flex-grow-1 p-3 overflow-y-auto">
          <div className="nav flex-column">
            {filteredMenuItems.map((item) => {
              const Icon = item.icon;
              return (
                <button
                  key={item.id}
                  className={`nav-link text-start d-flex align-items-center gap-3 px-3 py-2 mb-2 rounded-2 ${currentPage === item.id ? "active" : ""}`}
                  style={{
                    backgroundColor:
                      currentPage === item.id ? "#EA7028" : "transparent",
                    color: currentPage === item.id ? "white" : "#333",
                    border: "none",
                    fontFamily: "Roboto, sans-serif",
                  }}
                  onClick={() => navigate(item.path)}
                >
                  <Icon size={20} />
                  <span>{item.label}</span>
                </button>
              );
            })}
          </div>
        </nav>

        {/* Logout Button */}
        <div className="p-3 border-top">
          <button
            className="w-100 btn btn-outline-danger d-flex align-items-center justify-content-center gap-2"
            onClick={() => {
              localStorage.removeItem("token");
              setIsLoggedIn(false);
            }}
          >
            <LogOut size={18} />
            Salir
          </button>
        </div>
      </aside>

      {/* Main Content */}
      <div
        className="flex-grow-1 d-flex flex-column"
        style={{ height: "100vh", maxHeight: "100vh", boxSizing: "border-box" }}
      >
        {/* Header */}
        <header
          className="bg-white border-bottom p-2 p-sm-3 d-flex justify-content-between align-items-center"
          style={{
            boxShadow: "0 1px 3px rgba(0,0,0,0.1)",
            minHeight: "60px",
            flexShrink: 0,
          }}
        >
          <button
            className="btn btn-sm btn-light d-md-none"
            onClick={() => setSidebarOpen(!sidebarOpen)}
            style={{ width: "44px", height: "44px", minWidth: "44px" }}
            title={sidebarOpen ? "Cerrar menú" : "Abrir menú"}
          >
            {sidebarOpen ? <X size={22} /> : <Menu size={22} />}
          </button>

          <div className="d-flex align-items-center gap-2 gap-sm-3 ms-auto">
            <button
              className="btn btn-light btn-sm position-relative"
              onClick={() => navigate("/notificaciones")}
              style={{ width: "44px", height: "44px", minWidth: "44px" }}
              title="Ver notificaciones"
            >
              <Bell size={20} />
              {unreadCount > 0 && (
                <span
                  className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                  style={{ fontSize: "10px", padding: "0.2rem 0.4rem" }}
                >
                  {unreadCount}
                </span>
              )}
            </button>
            <span
              className="rounded-circle"
              style={{ width: "40px", height: "40px", minWidth: "40px" }}
            />
          </div>
        </header>

        {/* Content Area */}
        <main
          className="flex-grow-1 overflow-y-auto"
          style={{
            flex: 1,
            boxSizing: "border-box",
            width: "100%",
            overflowX: "hidden",
          }}
        >
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/inventario" element={<Inventory />} />
            <Route path="/productos" element={<Products />} />
            <Route path="/proveedores" element={<Suppliers />} />
            <Route path="/ordenes" element={<Orders />} />
            <Route path="/facturacion" element={<Billing />} />
            <Route path="/empleados" element={<Employees />} />
            <Route path="/reportes" element={<Reports />} />
            <Route path="/notificaciones" element={<Notifications />} />
            <Route path="/configuracion" element={<Settings />} />
          </Routes>
        </main>
      </div>
    </div>
  );
}

export default App;
