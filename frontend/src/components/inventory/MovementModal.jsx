import { useState, useMemo } from "react";

export function MovementModal({
  isOpen,
  onClose,
  items,
  formData,
  onFormChange,
  onSubmit,
}) {
  if (!isOpen) return null;

  // Encontrar el item actual seleccionado
  const selectedItem = useMemo(
    () => items.find((i) => i.name === formData.product),
    [formData.product, items],
  );

  // Calcular si hay error de exceso de stock para salida
  const quantity = parseInt(formData.quantity) || 0;
  const isExceedingStock =
    selectedItem && formData.type === "salida" && quantity > selectedItem.stock;

  return (
    <div
      className="modal d-block"
      tabIndex="-1"
      style={{ backgroundColor: "rgba(0,0,0,0.5)" }}
    >
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-header" style={{ backgroundColor: "#EBB583" }}>
            <h5 className="modal-title">Registrar Movimiento de Inventario</h5>
            <button
              type="button"
              className="btn-close"
              onClick={onClose}
            ></button>
          </div>
          <div className="modal-body">
            <div className="mb-3">
              <label className="form-label">Producto/Insumo *</label>
              <select
                className="form-select"
                style={{ borderColor: "#EBB583", borderWidth: "2px" }}
                value={formData.product}
                onChange={(e) => onFormChange("product", e.target.value)}
              >
                <option value="">Seleccione producto</option>
                {items.map((item) => (
                  <option key={item.id} value={item.name}>
                    {item.name}
                  </option>
                ))}
              </select>
            </div>
            <div className="row">
              <div className="col-md-6 mb-3">
                <label className="form-label">Tipo de Movimiento *</label>
                <select
                  className="form-select"
                  style={{ borderColor: "#EBB583", borderWidth: "2px" }}
                  value={formData.type}
                  onChange={(e) => onFormChange("type", e.target.value)}
                >
                  <option value="">Seleccione tipo</option>
                  <option value="entrada">Entrada</option>
                  <option value="salida">Salida</option>
                </select>
              </div>
              <div className="col-md-6 mb-3">
                <label className="form-label">Cantidad *</label>
                <input
                  type="number"
                  className="form-control"
                  style={{
                    borderColor: isExceedingStock ? "#EF4444" : "#EBB583",
                    borderWidth: "2px",
                  }}
                  value={formData.quantity}
                  onChange={(e) => onFormChange("quantity", e.target.value)}
                  placeholder="0"
                />
                {selectedItem && (
                  <small
                    style={{
                      display: "block",
                      marginTop: "0.5rem",
                      color: isExceedingStock ? "#EF4444" : "#6c757d",
                      fontWeight: isExceedingStock ? "600" : "normal",
                    }}
                  >
                    Disponible: {selectedItem.stock} {selectedItem.unit}
                  </small>
                )}
                {isExceedingStock && (
                  <small
                    style={{
                      display: "block",
                      marginTop: "0.25rem",
                      color: "#EF4444",
                      fontWeight: "600",
                    }}
                  >
                    No hay suficiente stock
                  </small>
                )}
              </div>
            </div>
            <div className="mb-3">
              <label className="form-label">Motivo / Descripción</label>
              <textarea
                className="form-control"
                style={{ borderColor: "#EBB583", borderWidth: "2px" }}
                value={formData.motivo}
                onChange={(e) => onFormChange("motivo", e.target.value)}
                placeholder="Descripción del movimiento"
                rows="3"
              ></textarea>
            </div>
          </div>
          <div className="modal-footer">
            <button
              type="button"
              className="btn btn-secondary"
              onClick={onClose}
            >
              Cancelar
            </button>
            <button
              type="button"
              className="btn text-white"
              style={{
                backgroundColor: isExceedingStock ? "#d4183d" : "#EA7028",
                opacity: isExceedingStock ? 0.6 : 1,
                cursor: isExceedingStock ? "not-allowed" : "pointer",
              }}
              onClick={onSubmit}
              disabled={isExceedingStock}
            >
              Registrar Movimiento
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
