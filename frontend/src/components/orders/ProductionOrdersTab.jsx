export function ProductionOrdersTab({
  orders,
  loading,
  searchTerm,
  onSearchChange,
  onAddOrder,
  onEditOrder,
  onStatusChange,
  getStatusLabel,
  getStatusBadgeClass,
}) {
  return (
    <div className="card border-0 shadow-sm">
      <div className="card-body">
        <div className="d-flex gap-3 mb-4">
          <div className="flex-grow-1">
            <input
              type="text"
              className="form-control"
              placeholder="Buscar órdenes de producción..."
              value={searchTerm}
              onChange={(e) => onSearchChange(e.target.value)}
            />
          </div>
          <button
            style={{
              backgroundColor: "#ffffff",
              color: "#333",
              border: "2px solid #333",
              fontWeight: "600",
              padding: "0.5rem 1rem",
              borderRadius: "0.375rem",
              cursor: "pointer",
              transition: "all 0.2s ease",
            }}
            onMouseEnter={(e) => {
              e.target.style.backgroundColor = "#333";
              e.target.style.color = "#ffffff";
            }}
            onMouseLeave={(e) => {
              e.target.style.backgroundColor = "#ffffff";
              e.target.style.color = "#333";
            }}
            onClick={onAddOrder}
          >
            + Nueva Orden de Producción
          </button>
        </div>

        <div className="table-responsive">
          <table className="table table-hover">
            <thead className="table-light">
              <tr>
                <th>N° Orden</th>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Responsable</th>
                <th>Fecha Límite</th>
                <th>Estado</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr>
                  <td colSpan="7" className="text-center py-3">
                    Cargando...
                  </td>
                </tr>
              ) : orders.length === 0 ? (
                <tr>
                  <td colSpan="7" className="text-center text-muted py-4">
                    No hay órdenes de producción
                  </td>
                </tr>
              ) : (
                orders.map((order) => (
                  <tr key={order.id}>
                    <td className="fw-bold">{order.order_number}</td>
                    <td>{order.product_name}</td>
                    <td>{order.quantity}</td>
                    <td>{order.responsible_name}</td>
                    <td>
                      {order.due_date
                        ? new Date(order.due_date).toLocaleDateString()
                        : "-"}
                    </td>
                    <td>
                      <span
                        className={`badge bg-${getStatusBadgeClass(order.status)}`}
                      >
                        {getStatusLabel(order.status)}
                      </span>
                    </td>
                    <td>
                      <div className="btn-group btn-group-sm" role="group">
                        <button
                          className="btn"
                          style={{
                            backgroundColor: "#0d6efd",
                            color: "white",
                            border: "none",
                            opacity:
                              order.status === "completada" ||
                              order.status === "cancelada"
                                ? 0.5
                                : 1,
                            cursor:
                              order.status === "completada" ||
                              order.status === "cancelada"
                                ? "not-allowed"
                                : "pointer",
                          }}
                          onClick={() => onEditOrder(order)}
                          disabled={
                            order.status === "completada" ||
                            order.status === "cancelada"
                          }
                          title={
                            order.status === "completada" ||
                            order.status === "cancelada"
                              ? "No se puede editar esta orden"
                              : "Editar"
                          }
                        >
                          Editar
                        </button>
                        {order.status !== "completada" &&
                          order.status !== "cancelada" && (
                            <button
                              className="btn"
                              style={{
                                backgroundColor: "#198754",
                                color: "white",
                                border: "none",
                              }}
                              onClick={() =>
                                onStatusChange(order.id, "completada")
                              }
                              title="Completar"
                            >
                              ✓ Completar
                            </button>
                          )}
                        {order.status !== "cancelada" &&
                          order.status !== "completada" && (
                            <button
                              className="btn"
                              style={{
                                backgroundColor: "#dc3545",
                                color: "white",
                                border: "none",
                              }}
                              onClick={() =>
                                onStatusChange(order.id, "cancelada")
                              }
                              title="Cancelar"
                            >
                              ✕ Cancelar
                            </button>
                          )}
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
