import { THEME, FONTS, CATEGORIES, CITIES } from "./constants";

export function SupplierModal({
  isOpen,
  isEditing,
  formData,
  error,
  success,
  onFormChange,
  onSave,
  onClose,
  onErrorDismiss,
  onSuccessDismiss,
}) {
  if (!isOpen) return null;

  return (
    <div
      className="modal d-block"
      onClick={onClose}
      style={{ backgroundColor: "rgba(0,0,0,0.5)", zIndex: 1050 }}
    >
      <div
        className="modal-dialog modal-xl"
        onClick={(e) => e.stopPropagation()}
        style={{ maxWidth: "1200px", marginTop: "5rem" }}
      >
        <div className="modal-content border-0 shadow-lg">
          <div
            className="modal-header border-bottom"
            style={{ borderColor: THEME.light, padding: "1rem" }}
          >
            <h5
              className="modal-title"
              style={{
                fontFamily: FONTS.title,
                fontWeight: 600,
              }}
            >
              {isEditing ? "Editar Proveedor" : "Agregar Nuevo Proveedor"}
            </h5>
            <button
              type="button"
              className="btn-close"
              onClick={onClose}
            ></button>
          </div>
          <div
            className="modal-body"
            style={{
              padding: "1rem",
              maxHeight: "70vh",
              overflowY: "auto",
            }}
          >
            {error && (
              <div
                className="alert alert-danger alert-dismissible fade show mb-3"
                role="alert"
              >
                {error}
                <button
                  type="button"
                  className="btn-close"
                  onClick={onErrorDismiss}
                ></button>
              </div>
            )}
            {success && (
              <div
                className="alert alert-success alert-dismissible fade show mb-3"
                role="alert"
              >
                {success}
                <button
                  type="button"
                  className="btn-close"
                  onClick={onSuccessDismiss}
                ></button>
              </div>
            )}

            <div className="mb-2">
              <label
                className="form-label"
                style={{
                  fontFamily: FONTS.body,
                  fontWeight: 500,
                  marginBottom: "0.3rem",
                }}
              >
                Nombre de la Empresa *
              </label>
              <input
                type="text"
                className="form-control form-control-sm"
                style={{ borderColor: THEME.light }}
                placeholder="Ej: Molinos XYZ"
                value={formData.company_name}
                onChange={(e) =>
                  onFormChange({ ...formData, company_name: e.target.value })
                }
              />
            </div>

            <div className="row g-2">
              <div className="col-md-6">
                <div className="mb-2">
                  <label
                    className="form-label"
                    style={{
                      fontFamily: FONTS.body,
                      fontWeight: 500,
                      marginBottom: "0.3rem",
                    }}
                  >
                    Persona de Contacto *
                  </label>
                  <input
                    type="text"
                    className="form-control form-control-sm"
                    style={{ borderColor: THEME.light }}
                    placeholder="Ej: Juan Pérez"
                    value={formData.contact_person || ""}
                    onChange={(e) =>
                      onFormChange({
                        ...formData,
                        contact_person: e.target.value,
                      })
                    }
                  />
                </div>
              </div>
              <div className="col-md-6">
                <div className="mb-2">
                  <label
                    className="form-label"
                    style={{
                      fontFamily: FONTS.body,
                      fontWeight: 500,
                      marginBottom: "0.3rem",
                    }}
                  >
                    Correo Electrónico *
                  </label>
                  <input
                    type="email"
                    className="form-control form-control-sm"
                    style={{ borderColor: THEME.light }}
                    placeholder="contacto@empresa.com"
                    value={formData.email || ""}
                    onChange={(e) =>
                      onFormChange({ ...formData, email: e.target.value })
                    }
                  />
                </div>
              </div>
            </div>

            <div className="row g-2">
              <div className="col-md-6">
                <div className="mb-2">
                  <label
                    className="form-label"
                    style={{
                      fontFamily: FONTS.body,
                      fontWeight: 500,
                      marginBottom: "0.3rem",
                    }}
                  >
                    Teléfono *
                  </label>
                  <input
                    type="tel"
                    className="form-control form-control-sm"
                    style={{ borderColor: THEME.light }}
                    placeholder="3110020020"
                    value={formData.phone || ""}
                    onChange={(e) =>
                      onFormChange({ ...formData, phone: e.target.value })
                    }
                  />
                </div>
              </div>
              <div className="col-md-6">
                <div className="mb-2">
                  <label
                    className="form-label"
                    style={{
                      fontFamily: FONTS.body,
                      fontWeight: 500,
                      marginBottom: "0.3rem",
                    }}
                  >
                    Categoría de Productos
                  </label>
                  <select
                    className="form-select form-select-sm"
                    style={{ borderColor: THEME.light }}
                    value={formData.category || ""}
                    onChange={(e) =>
                      onFormChange({ ...formData, category: e.target.value })
                    }
                  >
                    <option value="">Seleccione categoría</option>
                    {CATEGORIES.map((cat) => (
                      <option key={cat} value={cat}>
                        {cat}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
            </div>

            <div className="mb-2">
              <label
                className="form-label"
                style={{
                  fontFamily: FONTS.body,
                  fontWeight: 500,
                  marginBottom: "0.3rem",
                }}
              >
                Dirección
              </label>
              <textarea
                className="form-control"
                style={{
                  borderColor: THEME.light,
                  resize: "none",
                  fontSize: "0.9rem",
                }}
                placeholder="Dirección completa"
                rows="2"
                value={formData.address || ""}
                onChange={(e) =>
                  onFormChange({ ...formData, address: e.target.value })
                }
              ></textarea>
            </div>

            <div className="row g-2">
              <div className="col-md-6">
                <div className="mb-2">
                  <label
                    className="form-label"
                    style={{
                      fontFamily: FONTS.body,
                      fontWeight: 500,
                      marginBottom: "0.3rem",
                    }}
                  >
                    Ciudad
                  </label>
                  <select
                    className="form-select form-select-sm"
                    style={{ borderColor: THEME.light }}
                    value={formData.city || ""}
                    onChange={(e) =>
                      onFormChange({ ...formData, city: e.target.value })
                    }
                  >
                    <option value="">Seleccione ciudad</option>
                    {CITIES.map((city) => (
                      <option key={city} value={city}>
                        {city}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div
            className="modal-footer border-top"
            style={{ borderColor: THEME.light }}
          >
            <button
              type="button"
              className="btn border-2"
              style={{ borderColor: THEME.light, color: THEME.dark }}
              onClick={onClose}
            >
              Cancelar
            </button>
            <button
              type="button"
              className="btn text-white"
              style={{
                backgroundColor: THEME.primary,
                borderColor: THEME.primary,
              }}
              onClick={onSave}
            >
              {isEditing ? "Guardar Cambios" : "Guardar Proveedor"}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
