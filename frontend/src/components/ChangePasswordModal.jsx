import { useState } from "react";
import { Lock } from "lucide-react";

export function ChangePasswordModal({ onSubmit, isRequired = false }) {
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    // Validaciones
    if (!newPassword || !confirmPassword) {
      setError("Todos los campos son requeridos");
      return;
    }

    if (newPassword.length < 6) {
      setError("La contraseña debe tener al menos 6 caracteres");
      return;
    }

    if (newPassword !== confirmPassword) {
      setError("Las contraseñas no coinciden");
      return;
    }

    try {
      setLoading(true);
      await onSubmit(newPassword);
    } catch (err) {
      setError(err.message || "Error al cambiar la contraseña");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        width: "100%",
        height: "100%",
        backgroundColor: "rgba(0, 0, 0, 0.7)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 9999,
      }}
    >
      <div
        style={{
          backgroundColor: "white",
          borderRadius: "0.5rem",
          padding: "2rem",
          maxWidth: "400px",
          width: "90%",
          boxShadow: "0 20px 25px -5px rgba(0, 0, 0, 0.1)",
        }}
      >
        <div style={{ textAlign: "center", marginBottom: "1.5rem" }}>
          <div
            style={{
              display: "inline-flex",
              alignItems: "center",
              justifyContent: "center",
              width: "48px",
              height: "48px",
              borderRadius: "50%",
              backgroundColor: "#EBB583",
              marginBottom: "1rem",
            }}
          >
            <Lock size={24} color="white" />
          </div>
          <h2 style={{ margin: "0.5rem 0", fontSize: "1.5rem" }}>
            Cambiar Contraseña
          </h2>
          <p
            style={{
              color: "#666",
              margin: "0.5rem 0 0 0",
              fontSize: "0.875rem",
            }}
          >
            {isRequired
              ? "Debes cambiar tu contraseña inicial para continuar"
              : "Crear una nueva contraseña segura"}
          </p>
        </div>

        <form onSubmit={handleSubmit}>
          {error && (
            <div
              style={{
                backgroundColor: "#f8d7da",
                color: "#721c24",
                padding: "0.75rem",
                borderRadius: "0.375rem",
                marginBottom: "1rem",
                fontSize: "0.875rem",
              }}
            >
              {error}
            </div>
          )}

          <div style={{ marginBottom: "1rem" }}>
            <label
              style={{
                display: "block",
                marginBottom: "0.5rem",
                fontWeight: "600",
                fontSize: "0.875rem",
              }}
            >
              Nueva Contraseña
            </label>
            <input
              type="password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              placeholder="Mínimo 6 caracteres"
              style={{
                width: "100%",
                padding: "0.75rem",
                border: "1.5px solid #ddd",
                borderRadius: "0.375rem",
                fontSize: "1rem",
                boxSizing: "border-box",
              }}
              disabled={loading}
            />
          </div>

          <div style={{ marginBottom: "1.5rem" }}>
            <label
              style={{
                display: "block",
                marginBottom: "0.5rem",
                fontWeight: "600",
                fontSize: "0.875rem",
              }}
            >
              Confirmar Contraseña
            </label>
            <input
              type="password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder="Confirma tu contraseña"
              style={{
                width: "100%",
                padding: "0.75rem",
                border: "1.5px solid #ddd",
                borderRadius: "0.375rem",
                fontSize: "1rem",
                boxSizing: "border-box",
              }}
              disabled={loading}
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            style={{
              width: "100%",
              padding: "0.75rem",
              backgroundColor: "#EA7028",
              color: "white",
              border: "none",
              borderRadius: "0.375rem",
              fontSize: "1rem",
              fontWeight: "600",
              cursor: loading ? "not-allowed" : "pointer",
              opacity: loading ? 0.7 : 1,
            }}
          >
            {loading ? "Actualizando..." : "Cambiar Contraseña"}
          </button>

          {!isRequired && (
            <button
              type="button"
              style={{
                width: "100%",
                marginTop: "0.75rem",
                padding: "0.75rem",
                backgroundColor: "transparent",
                color: "#666",
                border: "1.5px solid #ddd",
                borderRadius: "0.375rem",
                fontSize: "1rem",
                fontWeight: "600",
                cursor: "pointer",
              }}
            >
              Cancelar
            </button>
          )}
        </form>
      </div>
    </div>
  );
}
