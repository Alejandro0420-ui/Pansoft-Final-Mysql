import { useState, useEffect } from "react";
import { dashboardAPI } from "../services/api";
import {
  Package,
  TrendingUp,
  Users,
  FileText,
  DollarSign,
  ShoppingCart,
  AlertTriangle,
  BarChart3,
} from "lucide-react";
import {
  AreaChart,
  Area,
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
} from "recharts";

const DEFAULT_COLORS = ["#EA7028", "#EBA94D", "#EBCC83", "#EBB583"];

export function Dashboard() {
  const [stats, setStats] = useState({
    monthly_sales: { total: 0 },
    total_products: { total: 0 },
    best_selling_product: { name: "Cargando...", total_sold: 0 },
    pending_orders: { total: 0 },
  });
  const [chartData, setChartData] = useState([
    { name: "Ene", ventas: 0, compras: 0 },
    { name: "Feb", ventas: 0, compras: 0 },
    { name: "Mar", ventas: 0, compras: 0 },
    { name: "Abr", ventas: 0, compras: 0 },
    { name: "May", ventas: 0, compras: 0 },
    { name: "Jun", ventas: 0, compras: 0 },
    { name: "Jul", ventas: 0, compras: 0 },
    { name: "Ago", ventas: 0, compras: 0 },
    { name: "Sep", ventas: 0, compras: 0 },
    { name: "Oct", ventas: 0, compras: 0 },
    { name: "Nov", ventas: 0, compras: 0 },
    { name: "Dic", ventas: 0, compras: 0 },
  ]);
  const [alerts, setAlerts] = useState([]);
  const [activity, setActivity] = useState([]);
  const [categoryData, setCategoryData] = useState([]);

  useEffect(() => {
    loadDashboardData();
    // Actualizar datos cada 30 segundos
    const interval = setInterval(loadDashboardData, 30000);
    return () => clearInterval(interval);
  }, []);

  const loadDashboardData = async () => {
    try {
      const [statsRes, chartsRes, alertsRes, activityRes, categoriesRes] = await Promise.all([
        dashboardAPI.getStats(),
        dashboardAPI.getCharts(),
        dashboardAPI.getAlerts(),
        dashboardAPI.getActivity(),
        dashboardAPI.getCategories(),
      ]);

      setStats(statsRes.data);
      if (chartsRes.data && chartsRes.data.length > 0) setChartData(chartsRes.data);
      if (alertsRes.data && alertsRes.data.length > 0) setAlerts(alertsRes.data);
      if (activityRes.data && activityRes.data.length > 0) setActivity(activityRes.data);
      if (categoriesRes.data && categoriesRes.data.length > 0) setCategoryData(categoriesRes.data);
    } catch (error) {
      console.error("Error cargando dashboard:", error);
    }
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h1 style={{ fontFamily: "Open Sans, sans-serif" }}>Dashboard</h1>
        <p className="text-muted" style={{ fontFamily: "Roboto, sans-serif" }}>
          Bienvenido al panel de control de Pansoft
        </p>
      </div>

      {/* Stats Cards */}
      <div className="row g-3 mb-4">
        <div className="col-md-6 col-lg-3">
          <div
            className="card border-start border-4 h-100"
            style={{ borderLeftColor: "#EA7028" }}
          >
            <div className="card-body">
              <div className="d-flex align-items-center justify-content-between">
                <div>
                  <p
                    className="text-muted small"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    Ventas del Mes
                  </p>
                  <h3
                    className="mt-2"
                    style={{ fontFamily: "Open Sans, sans-serif" }}
                  >
                    ${stats.monthly_sales?.total || 0}
                  </h3>
                  {stats.sales_change_percent !== undefined && (
                    <p
                      className={`small mt-2 ${stats.sales_change_percent >= 0 ? 'text-success' : 'text-danger'}`}
                      style={{ fontFamily: "Roboto, sans-serif" }}
                    >
                      {stats.sales_change_percent >= 0 ? '+' : ''}{stats.sales_change_percent}% vs mes anterior
                    </p>
                  )}
                </div>
                <div
                  className="p-3 rounded-3 text-white"
                  style={{ backgroundColor: "#EA7028" }}
                >
                  <DollarSign size={24} />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-6 col-lg-3">
          <div
            className="card border-start border-4 h-100"
            style={{ borderLeftColor: "#EBA94D" }}
          >
            <div className="card-body">
              <div className="d-flex align-items-center justify-content-between">
                <div>
                  <p
                    className="text-muted small"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    Productos
                  </p>
                  <h3
                    className="mt-2"
                    style={{ fontFamily: "Open Sans, sans-serif" }}
                  >
                    {stats.total_products?.total || 0}
                  </h3>
                  <p
                    className="text-muted small mt-2"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    En inventario
                  </p>
                </div>
                <div
                  className="p-3 rounded-3 text-white"
                  style={{ backgroundColor: "#EBA94D" }}
                >
                  <Package size={24} />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-6 col-lg-3">
          <div
            className="card border-start border-4 h-100"
            style={{ borderLeftColor: "#EBCC83" }}
          >
            <div className="card-body">
              <div className="d-flex align-items-center justify-content-between">
                <div>
                  <p
                    className="text-muted small"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    Producto Más Vendido
                  </p>
                  <h3
                    className="mt-2"
                    style={{ fontFamily: "Open Sans, sans-serif" }}
                  >
                    {stats.best_selling_product?.name || "N/A"}
                  </h3>
                  <p
                    className="text-info small mt-2"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    {stats.best_selling_product?.total_sold || 0} unidades
                    vendidas
                  </p>
                </div>
                <div
                  className="p-3 rounded-3 text-white"
                  style={{ backgroundColor: "#EBCC83" }}
                >
                  <TrendingUp size={24} />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-6 col-lg-3">
          <div
            className="card border-start border-4 h-100"
            style={{ borderLeftColor: "#EA7028" }}
          >
            <div className="card-body">
              <div className="d-flex align-items-center justify-content-between">
                <div>
                  <p
                    className="text-muted small"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    Órdenes Pendientes
                  </p>
                  <h3
                    className="mt-2"
                    style={{ fontFamily: "Open Sans, sans-serif" }}
                  >
                    {stats.pending_orders?.total || 0}
                  </h3>
                  <p
                    className="text-warning small mt-2"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  >
                    Requieren atención
                  </p>
                </div>
                <div
                  className="p-3 rounded-3 text-white"
                  style={{ backgroundColor: "#EA7028" }}
                >
                  <ShoppingCart size={24} />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Charts Row */}
      <div className="row g-3 mb-4">
        <div className="col-lg-6">
          <div className="card">
            <div className="card-body">
              <h5
                className="card-title"
                style={{ fontFamily: "Open Sans, sans-serif" }}
              >
                Ventas y Compras
              </h5>
              <ResponsiveContainer width="100%" height={300}>
                <AreaChart data={chartData}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis
                    dataKey="name"
                    style={{ fontFamily: "Roboto, sans-serif" }}
                  />
                  <YAxis style={{ fontFamily: "Roboto, sans-serif" }} />
                  <Tooltip />
                  <Area
                    type="monotone"
                    dataKey="ventas"
                    stackId="1"
                    stroke="#EA7028"
                    fill="#EA7028"
                  />
                  <Area
                    type="monotone"
                    dataKey="compras"
                    stackId="1"
                    stroke="#EBA94D"
                    fill="#EBA94D"
                  />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        <div className="col-lg-6">
          <div className="card">
            <div className="card-body">
              <h5
                className="card-title"
                style={{ fontFamily: "Open Sans, sans-serif" }}
              >
                Distribución por Categoría
              </h5>
              <ResponsiveContainer width="100%" height={300}>
                <PieChart>
                  <Pie
                    data={categoryData}
                    cx="50%"
                    cy="50%"
                    labelLine={false}
                    label={({ name, percent }) =>
                      `${name} ${(percent * 100).toFixed(0)}%`
                    }
                    outerRadius={80}
                    fill="#8884d8"
                    dataKey="value"
                  >
                    {categoryData.map((entry, index) => (
                      <Cell
                        key={`cell-${index}`}
                        fill={DEFAULT_COLORS[index % DEFAULT_COLORS.length]}
                      />
                    ))}
                  </Pie>
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>
      </div>

      {/* Alerts and Recent Activity */}
      <div className="row g-3">
        <div className="col-lg-6">
          <div className="card">
            <div className="card-body">
              <div className="d-flex align-items-center gap-2 mb-3">
                <AlertTriangle className="text-danger" size={20} />
                <h5
                  className="card-title mb-0"
                  style={{ fontFamily: "Open Sans, sans-serif" }}
                >
                  Alertas Recientes
                </h5>
              </div>
              <div className="space-y-3">
                {alerts.map((alert, index) => (
                  <div
                    key={index}
                    className={`p-3 rounded-2 border-start border-4 ${
                      alert.type === "danger"
                        ? "bg-danger-light border-danger"
                        : alert.type === "warning"
                          ? "bg-warning-light border-warning"
                          : "bg-info-light border-info"
                    }`}
                    style={{
                      backgroundColor:
                        alert.type === "danger"
                          ? "#f8d7da"
                          : alert.type === "warning"
                            ? "#fff3cd"
                            : "#d1ecf1",
                    }}
                  >
                    <p
                      className="small mb-0"
                      style={{ fontFamily: "Roboto, sans-serif" }}
                    >
                      {alert.text}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>

        <div className="col-lg-6">
          <div className="card">
            <div className="card-body">
              <div className="d-flex align-items-center gap-2 mb-3">
                <FileText className="text-danger" size={20} />
                <h5
                  className="card-title mb-0"
                  style={{ fontFamily: "Open Sans, sans-serif" }}
                >
                  Actividad Reciente
                </h5>
              </div>
              <div className="space-y-3">
                {activity.map((act, index) => (
                  <div
                    key={index}
                    className="d-flex gap-3 pb-3"
                    style={{
                      borderBottom:
                        index < activity.length - 1 ? "1px solid #eee" : "none",
                    }}
                  >
                    <div
                      className="mt-1"
                      style={{
                        width: "8px",
                        height: "8px",
                        borderRadius: "50%",
                        backgroundColor: "#EA7028",
                        flexShrink: 0,
                      }}
                    ></div>
                    <div className="flex-grow-1">
                      <p
                        className="small mb-1"
                        style={{ fontFamily: "Roboto, sans-serif" }}
                      >
                        {act.action}
                      </p>
                      <p
                        className="text-muted small mb-0"
                        style={{ fontFamily: "Roboto, sans-serif" }}
                      >
                        {act.user} • {act.time}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
