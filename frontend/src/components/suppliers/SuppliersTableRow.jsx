import {
  Edit,
  UserX,
  UserCheck,
  Truck,
  Mail,
  Phone,
  MapPin,
} from "lucide-react";
import { THEME, FONTS } from "./constants";

export function SuppliersTableRow({ supplier, onEdit, onToggleStatus }) {
  return (
    <tr style={{ borderBottom: "1px solid #eee" }} className="align-middle">
      <td>
        <div className="d-flex align-items-flex-start gap-3">
          <div
            className="rounded-circle d-flex align-items-center justify-content-center flex-shrink-0"
            style={{
              width: "40px",
              height: "40px",
              background: `linear-gradient(to bottom right, ${THEME.primary}, ${THEME.secondary})`,
            }}
          >
            <Truck size={20} color={THEME.white} />
          </div>
          <div
            style={{
              display: "flex",
              flexDirection: "column",
              width: "100%",
            }}
          >
            <div
              style={{
                display: "flex",
                justifyContent: "space-between",
                alignItems: "center",
                width: "100%",
              }}
            >
              <p className="mb-0 fw-bold" style={{ fontFamily: FONTS.body }}>
                {supplier.company_name}
              </p>
              {supplier.is_active === 0 && (
                <span
                  className="badge bg-danger ms-2"
                  style={{
                    fontSize: "0.75rem",
                    whiteSpace: "nowrap",
                  }}
                >
                  Deshabilitado
                </span>
              )}
            </div>
            <p
              className="mb-0 small text-muted"
              style={{ fontFamily: FONTS.body }}
            >
              {supplier.contact_person}
            </p>
          </div>
        </div>
      </td>
      <td>
        <div className="space-y-2">
          <div className="d-flex align-items-center gap-2 small text-muted">
            <Mail size={14} color={THEME.secondary} />
            <span style={{ fontFamily: FONTS.body }}>{supplier.email}</span>
          </div>
          <div className="d-flex align-items-center gap-2 small text-muted">
            <Phone size={14} color={THEME.secondary} />
            <span style={{ fontFamily: FONTS.body }}>{supplier.phone}</span>
          </div>
        </div>
      </td>
      <td>
        <div
          className="d-flex gap-2 small text-muted align-items-start"
          style={{ maxWidth: "200px" }}
        >
          <MapPin
            size={14}
            color={THEME.secondary}
            className="flex-shrink-0 mt-1"
          />
          <span style={{ fontFamily: FONTS.body }}>
            {supplier.address || "-"}
          </span>
        </div>
      </td>
      <td style={{ textAlign: "right" }}>
        <span
          className="badge"
          style={{ backgroundColor: "#EBCC83", color: THEME.dark }}
        >
          {supplier.category || "Sin categoría"}
        </span>
      </td>
      <td style={{ fontFamily: FONTS.body }}>{supplier.city || "-"}</td>
      <td>
        <div className="d-flex gap-2">
          <button
            className="btn btn-sm"
            style={{ color: THEME.primary, border: "none" }}
            onClick={() => onEdit(supplier)}
            title="Editar"
          >
            <Edit size={18} />
          </button>
          <button
            className="btn btn-sm"
            style={{
              color: supplier.is_active ? THEME.danger : THEME.success,
              border: "none",
            }}
            onClick={() => onToggleStatus(supplier.id, supplier)}
            title={supplier.is_active ? "Deshabilitar" : "Habilitar"}
          >
            {supplier.is_active ? <UserX size={18} /> : <UserCheck size={18} />}
          </button>
        </div>
      </td>
    </tr>
  );
}
