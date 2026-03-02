import { THEME, FONTS } from "./constants";
import { SuppliersTableRow } from "./SuppliersTableRow";

export function SuppliersTable({ suppliers, loading, onEdit, onToggleStatus }) {
  return (
    <div className="card border-0 shadow-sm">
      <div className="card-body">
        <h5 style={{ fontFamily: FONTS.title }} className="mb-4">
          Lista de Proveedores
        </h5>

        {loading ? (
          <div className="text-center py-4">
            <div
              className="spinner-border"
              role="status"
              style={{ color: THEME.primary }}
            >
              <span className="visually-hidden">Cargando...</span>
            </div>
            <p className="text-muted mt-2">Cargando proveedores...</p>
          </div>
        ) : suppliers.length === 0 ? (
          <div className="text-center py-4">
            <p className="text-muted">No hay proveedores disponibles</p>
          </div>
        ) : (
          <div className="table-responsive">
            <table className="table table-hover mb-0">
              <thead style={{ backgroundColor: THEME.light }}>
                <tr>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Empresa
                  </th>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Contacto
                  </th>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Información
                  </th>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Categoría
                  </th>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Ciudad
                  </th>
                  <th
                    style={{
                      fontFamily: FONTS.title,
                      color: THEME.dark,
                    }}
                  >
                    Acciones
                  </th>
                </tr>
              </thead>
              <tbody>
                {suppliers.map((supplier) => (
                  <SuppliersTableRow
                    key={supplier.id}
                    supplier={supplier}
                    onEdit={onEdit}
                    onToggleStatus={onToggleStatus}
                  />
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
