import { Truck, UserCheck, XCircle } from "lucide-react";
import { THEME, FONTS } from "./constants";

export function SuppliersStats({ totalSuppliers, totalActive, totalInactive }) {
  return (
    <div className="row mb-4">
      <div className="col-md-4 mb-3">
        <div
          className="card h-100 border-0"
          style={{
            background: `linear-gradient(to bottom right, white, ${THEME.lightBg})`,
          }}
        >
          <div className="card-body d-flex justify-content-between align-items-center">
            <div>
              <p className="text-muted mb-1" style={{ fontFamily: FONTS.body }}>
                Total Proveedores
              </p>
              <h3 className="mb-0" style={{ fontFamily: FONTS.title }}>
                {totalSuppliers}
              </h3>
            </div>
            <Truck size={40} color={THEME.primary} />
          </div>
        </div>
      </div>
      <div className="col-md-4 mb-3">
        <div
          className="card h-100 border-0"
          style={{
            background:
              "linear-gradient(to bottom right, white, rgba(40, 167, 69, 0.1))",
          }}
        >
          <div className="card-body d-flex justify-content-between align-items-center">
            <div>
              <p
                className="text-success mb-1"
                style={{ fontFamily: FONTS.body }}
              >
                Proveedores Activos
              </p>
              <h3
                className="text-success mb-0"
                style={{ fontFamily: FONTS.title }}
              >
                {totalActive}
              </h3>
            </div>
            <UserCheck size={40} color={THEME.success} />
          </div>
        </div>
      </div>
      <div className="col-md-4 mb-3">
        <div
          className="card h-100 border-0"
          style={{
            background:
              "linear-gradient(to bottom right, white, rgba(220, 53, 69, 0.1))",
          }}
        >
          <div className="card-body d-flex justify-content-between align-items-center">
            <div>
              <p
                className="text-danger mb-1"
                style={{ fontFamily: FONTS.body }}
              >
                Proveedores Inactivos
              </p>
              <h3
                className="text-danger mb-0"
                style={{ fontFamily: FONTS.title }}
              >
                {totalInactive}
              </h3>
            </div>
            <XCircle size={40} color={THEME.danger} />
          </div>
        </div>
      </div>
    </div>
  );
}
