import { useState, useEffect } from "react";
import { DollarSign, X, Loader2 } from "lucide-react";
import { reportsAPI } from "../../services/api";

export function TodaySalesSection({ data = { sales: [], total: 0, count: 0 } }) {
  const [selectedSale, setSelectedSale] = useState(null);
  const [saleDetail, setSaleDetail] = useState(null);
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [showModal, setShowModal] = useState(false);

  const handleViewDetail = async (sale) => {
    setSelectedSale(sale);
    setShowModal(true);
    setLoadingDetail(true);
    setSaleDetail(null);

    try {
      const response = await reportsAPI.getSaleDetail(sale.id, sale.type);
      setSaleDetail(response.data);
    } catch (error) {
      console.error("Error loading sale detail:", error);
    } finally {
      setLoadingDetail(false);
    }
  };

  const closeModal = () => {
    setShowModal(false);
    setSelectedSale(null);
    setSaleDetail(null);
  };

  const columns = [
    { 
      key: "number", 
      label: "Número",
      render: (value, item) => (
        <a 
          href="#" 
          onClick={(e) => { e.preventDefault(); handleViewDetail(item); }}
          className="text-primary text-decoration-none fw-bold"
          style={{ cursor: "pointer" }}
        >
          {value}
        </a>
      )
    },
    { 
      key: "date", 
      label: "Hora",
      render: (value) => {
        if (!value) return '-';
        const date = new Date(value);
        return date.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });
      }
    },
    {
      key: "type",
      label: "Tipo",
      render: (value) => (
        <span className={`badge ${value === 'POS' ? 'bg-success' : 'bg-primary'}`}>
          {value}
        </span>
      ),
    },
    {
      key: "status",
      label: "Estado",
      render: (value) => (
        <span className={`badge ${value === 'paid' || value === 'completada' ? 'bg-success' : 'bg-warning'}`}>
          {value === 'paid' ? 'Pagado' : value}
        </span>
      ),
    },
    {
      key: "amount",
      label: "Monto",
      render: (value) => `$${parseFloat(value || 0).toFixed(2)}`,
    },
  ];

  return (
    <>
      <div className="card mb-4">
        <div className="card-body">
          <div className="d-flex align-items-center justify-content-between mb-3">
            <div className="d-flex align-items-center gap-2">
              <DollarSign size={24} className="text-success" />
              <h5 className="card-title mb-0">Ventas de Hoy</h5>
              <span className="badge bg-secondary">{data.count || 0}</span>
            </div>
            <div className="text-end">
              <small className="text-muted">Total del día</small>
              <div className="fs-5 fw-bold text-success">
                ${(data.total || 0).toFixed(2)}
              </div>
            </div>
          </div>

          {data.sales && data.sales.length > 0 ? (
            <div className="table-responsive">
              <table className="table table-sm table-hover">
                <thead className="table-light">
                  <tr>
                    {columns.map((col) => (
                      <th key={col.key} style={{ minWidth: col.width || "auto" }}>
                        {col.label}
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {data.sales.map((item, idx) => (
                    <tr key={item.id || idx}>
                      {columns.map((col) => (
                        <td key={col.key}>
                          {col.render
                            ? col.render(item[col.key], item)
                            : item[col.key]}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <div className="text-center text-muted py-4">
              No hay ventas registradas hoy
            </div>
          )}
        </div>
      </div>

      {/* Modal de Detalle de Venta */}
      {showModal && (
        <div
          className="modal d-block"
          style={{
            backgroundColor: "rgba(0,0,0,0.5)",
            position: "fixed",
            top: 0,
            left: 0,
            width: "100%",
            height: "100%",
            zIndex: 1050,
          }}
          onClick={(e) => { if (e.target === e.currentTarget) closeModal(); }}
        >
          <div className="modal-dialog modal-lg">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">
                  Detalle de Venta - {selectedSale?.number}
                </h5>
                <button type="button" className="btn-close" onClick={closeModal}></button>
              </div>
              <div className="modal-body">
                {loadingDetail ? (
                  <div className="text-center py-4">
                    <Loader2 className="spin" size={32} />
                    <p className="mt-2">Cargando detalle...</p>
                  </div>
                ) : saleDetail ? (
                  <>
                    {/* Info de la venta */}
                    <div className="row mb-4">
                      <div className="col-md-6">
                        <p className="text-muted small mb-1">Número</p>
                        <p className="fw-bold">{saleDetail.header?.number}</p>
                      </div>
                      <div className="col-md-6">
                        <p className="text-muted small mb-1">Fecha</p>
                        <p className="fw-bold">
                          {saleDetail.header?.date ? new Date(saleDetail.header.date).toLocaleString('es-ES') : '-'}
                        </p>
                      </div>
                    </div>
                    
                    {saleDetail.header?.customer_name && (
                      <div className="row mb-4">
                        <div className="col-12">
                          <p className="text-muted small mb-1">Cliente</p>
                          <p className="fw-bold">{saleDetail.header.customer_name}</p>
                        </div>
                      </div>
                    )}

                    {/* Items */}
                    <h6 className="mb-3">Items</h6>
                    {saleDetail.items && saleDetail.items.length > 0 ? (
                      <div className="table-responsive">
                        <table className="table table-sm">
                          <thead className="table-light">
                            <tr>
                              <th>Producto</th>
                              <th className="text-center">Cantidad</th>
                              <th className="text-end">Precio</th>
                              <th className="text-end">Subtotal</th>
                            </tr>
                          </thead>
                          <tbody>
                            {saleDetail.items.map((item, idx) => (
                              <tr key={idx}>
                                <td>{item.name}</td>
                                <td className="text-center">{item.quantity}</td>
                                <td className="text-end">${parseFloat(item.price || 0).toFixed(2)}</td>
                                <td className="text-end">${parseFloat(item.subtotal || 0).toFixed(2)}</td>
                              </tr>
                            ))}
                          </tbody>
                          <tfoot>
                            <tr className="table-light">
                              <td colSpan="3" className="text-end fw-bold">Total:</td>
                              <td className="text-end fw-bold text-success">
                                ${parseFloat(saleDetail.header?.amount || 0).toFixed(2)}
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    ) : (
                      <div className="alert alert-warning">
                        <p className="mb-0">No hay detalle de items guardado para esta venta.</p>
                        <small>Esta venta fue realizada antes de la actualización del sistema.</small>
                      </div>
                    )}
                  </>
                ) : (
                  <div className="text-center text-muted py-4">
                    No se pudo cargar el detalle
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
