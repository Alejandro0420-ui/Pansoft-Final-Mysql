import { Edit2, CheckCircle, XCircle } from "lucide-react";
import { StatusBadge } from "./StatusBadge";
import { THEME_COLORS } from "./constants";

export function ProductionOrdersTable({
  orders,
  loading,
  onEdit,
  onUpdateStatus,
}) {
  return (
    <div className="table-responsive">
      <table
        className="table table-hover"
        style={{ borderTop: `2px solid ${THEME_COLORS.light}` }}
      >
        <thead style={{ backgroundColor: THEME_COLORS.light }}>
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
          {orders.length === 0 ? (
            <tr>
              <td colSpan="7" className="text-center text-muted py-4">
                No hay órdenes de producción
              </td>
            </tr>
          ) : (
            orders.map((order) => (
              <tr key={order.id} className="align-middle">
                <td>
                  <strong>{order.orderNo || order.order_number}</strong>
                </td>
                <td>{order.product_name || order.product}</td>
                <td>{order.quantity}</td>
                <td className="small">
                  {order.responsible_name || order.responsible}
                </td>
                <td className="small text-muted">
                  {order.date ||
                    (order.due_date
                      ? new Date(order.due_date).toLocaleDateString()
                      : "-")}
                </td>
                <td>
                  <StatusBadge status={order.status} />
                </td>
                <td>
                  <div className="btn-group btn-group-sm">
                    <button
                      className="btn"
                      style={{
                        backgroundColor: "#0d6efd",
                        color: "white",
                        border: "none",
                      }}
                      onClick={() => onEdit(order)}
                      title="Editar"
                      disabled={loading}
                    >
                      <Edit2 size={14} />
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
                          onClick={() => onUpdateStatus(order.id, "completada")}
                          title="Completar"
                          disabled={loading}
                        >
                          <CheckCircle size={14} />
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
                          onClick={() => onUpdateStatus(order.id, "cancelada")}
                          title="Cancelar"
                          disabled={loading}
                        >
                          <XCircle size={14} />
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
  );
}
