import { Plus } from "lucide-react";
import { THEME, FONTS } from "./constants";

export function SuppliersHeader({ onOpenModal }) {
  return (
    <div className="d-flex justify-content-between align-items-start mb-4">
      <div>
        <h1
          className="mb-2"
          style={{ fontFamily: FONTS.title, fontWeight: 600 }}
        >
          Gestión de Proveedores
        </h1>
        <p className="text-muted mb-0" style={{ fontFamily: FONTS.body }}>
          Administre proveedores y contactos comerciales
        </p>
      </div>
      <button
        className="btn d-flex align-items-center gap-2"
        onClick={onOpenModal}
        style={{
          backgroundColor: THEME.primary,
          color: THEME.white,
          borderColor: THEME.primary,
        }}
      >
        <Plus size={18} />
        Nuevo Proveedor
      </button>
    </div>
  );
}
