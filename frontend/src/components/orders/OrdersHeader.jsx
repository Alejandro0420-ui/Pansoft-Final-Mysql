import { ShoppingCart, Package, CheckCircle } from "lucide-react";
import { StatCard } from "./StatCard";

export function OrdersHeader({ stats, loading, activeTab, onTabChange }) {
  return (
    <>
      {/* Encabezado */}
      <div className="mb-4">
        <h1 style={{ fontFamily: "Open Sans" }}>
          Órdenes de Venta / Producción
        </h1>
        <p className="text-muted">Gestione órdenes de venta y producción</p>
        {loading && (
          <div
            className="spinner-border spinner-border-sm text-warning mt-2"
            role="status"
          >
            <span className="visually-hidden">Cargando...</span>
          </div>
        )}
      </div>

      {/* Stats */}
      <div className="row mb-4 g-3">
        <div className="col-md-3">
          <StatCard
            label="Órdenes de Venta"
            value={stats.totalSales}
            icon={ShoppingCart}
            color="#EA7028"
          />
        </div>
        <div className="col-md-3">
          <StatCard
            label="Ventas Completadas"
            value={stats.completedSales}
            icon={CheckCircle}
            color="#EBCC83"
          />
        </div>
        <div className="col-md-3">
          <StatCard
            label="Órdenes Producción"
            value={stats.totalProduction}
            icon={Package}
            color="#EBA94D"
          />
        </div>
        <div className="col-md-3">
          <StatCard
            label="Prod. Completadas"
            value={stats.completedProduction}
            icon={CheckCircle}
            color="#EBCC83"
          />
        </div>
      </div>

      {/* Tabs */}
      <div className="card">
        <div
          className="card-header"
          style={{
            backgroundColor: "#ffffff",
            borderBottom: "1px solid #dee2e6",
          }}
        >
          <ul className="nav nav-tabs card-header-tabs mb-0">
            <li className="nav-item">
              <button
                style={{
                  backgroundColor:
                    activeTab === "sales" ? "#EA7028" : "#f0f0f0",
                  color: activeTab === "sales" ? "white" : "#333",
                  border: "2px solid #333",
                  fontWeight: "600",
                  padding: "0.5rem 1rem",
                  cursor: "pointer",
                  borderRadius: "0.375rem",
                  display: "inline-flex",
                  alignItems: "center",
                  transition: "all 0.2s ease",
                }}
                onMouseEnter={(e) => {
                  if (activeTab !== "sales") {
                    e.target.style.backgroundColor = "#EA7028";
                    e.target.style.color = "white";
                  }
                }}
                onMouseLeave={(e) => {
                  if (activeTab !== "sales") {
                    e.target.style.backgroundColor = "#f0f0f0";
                    e.target.style.color = "#333";
                  }
                }}
                onClick={() => onTabChange("sales")}
              >
                <ShoppingCart
                  size={16}
                  className="me-2"
                  style={{ display: "inline" }}
                />
                Órdenes de Venta
              </button>
            </li>
            <li className="nav-item" style={{ marginLeft: "0.5rem" }}>
              <button
                style={{
                  backgroundColor:
                    activeTab === "production" ? "#EA7028" : "#f0f0f0",
                  color: activeTab === "production" ? "white" : "#333",
                  border: "2px solid #333",
                  fontWeight: "600",
                  padding: "0.5rem 1rem",
                  cursor: "pointer",
                  borderRadius: "0.375rem",
                  display: "inline-flex",
                  alignItems: "center",
                  transition: "all 0.2s ease",
                }}
                onMouseEnter={(e) => {
                  if (activeTab !== "production") {
                    e.target.style.backgroundColor = "#EA7028";
                    e.target.style.color = "white";
                  }
                }}
                onMouseLeave={(e) => {
                  if (activeTab !== "production") {
                    e.target.style.backgroundColor = "#f0f0f0";
                    e.target.style.color = "#333";
                  }
                }}
                onClick={() => onTabChange("production")}
              >
                <Package
                  size={16}
                  className="me-2"
                  style={{ display: "inline" }}
                />
                Órdenes de Producción
              </button>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
}
