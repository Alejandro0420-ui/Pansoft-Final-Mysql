import { Search } from "lucide-react";
import { THEME, FONTS } from "./constants";

export function SuppliersSearchBar({
  searchTerm,
  onSearchChange,
  showInactive,
  onToggleFilter,
}) {
  return (
    <div className="card mb-4 border-0 shadow-sm">
      <div className="card-body">
        <div className="d-flex gap-3">
          <div className="flex-grow-1 position-relative">
            <Search
              size={18}
              className="position-absolute"
              style={{
                left: "12px",
                top: "12px",
                color: "#999",
              }}
            />
            <input
              type="text"
              className="form-control ps-5"
              placeholder="Buscar proveedores..."
              value={searchTerm}
              onChange={(e) => onSearchChange(e.target.value)}
              style={{ borderColor: THEME.light, outline: "none" }}
              onFocus={(e) => (e.target.style.borderColor = THEME.primary)}
              onBlur={(e) => (e.target.style.borderColor = THEME.light)}
            />
          </div>
          <button
            className="btn border-2"
            style={{
              borderColor: showInactive ? THEME.primary : THEME.secondary,
              color: showInactive ? THEME.white : THEME.primary,
              backgroundColor: showInactive ? THEME.primary : "transparent",
              whiteSpace: "nowrap",
              padding: "0.5rem 1rem",
              height: "fit-content",
            }}
            onClick={onToggleFilter}
          >
            {showInactive ? "Solo Activos" : "Ver Todos"}
          </button>
        </div>
      </div>
    </div>
  );
}
