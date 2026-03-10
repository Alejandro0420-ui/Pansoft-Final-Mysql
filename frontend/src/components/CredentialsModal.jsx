import { CheckCircle } from "lucide-react";

export function CredentialsModal({
  onClose,
  firstName,
  username,
  initialPassword,
}) {
  return (
    <div
      style={{
        position: "fixed",
        top: 0,
        left: 0,
        width: "100%",
        height: "100%",
        backgroundColor: "rgba(0, 0, 0, 0.5)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 9999,
      }}
      onClick={onClose}
    >
      <div
        style={{
          backgroundColor: "white",
          borderRadius: "0.5rem",
          padding: "2.5rem",
          maxWidth: "450px",
          width: "90%",
          boxShadow: "0 20px 25px -5px rgba(0, 0, 0, 0.1)",
        }}
        onClick={(e) => e.stopPropagation()}
      >
        <div style={{ textAlign: "center", marginBottom: "1.5rem" }}>
          <CheckCircle
            size={48}
            color="#198754"
            style={{ marginBottom: "1rem" }}
          />
          <h2
            style={{ margin: "0.5rem 0", fontSize: "1.5rem", color: "#198754" }}
          >
            ¡Empleado Creado Exitosamente!
          </h2>
        </div>

        <div style={{ marginBottom: "2rem" }}>
          <p style={{ color: "#666", marginBottom: "1.5rem" }}>
            Guarda estas credenciales de acceso. El empleado deberá cambiar su
            contraseña en el primer acceso.
          </p>

          <div
            style={{
              backgroundColor: "#f8f9fa",
              padding: "1.5rem",
              borderRadius: "0.375rem",
              border: "1px solid #dee2e6",
              marginBottom: "1.5rem",
            }}
          >
            <div style={{ marginBottom: "1rem" }}>
              <small
                style={{
                  color: "#666",
                  display: "block",
                  marginBottom: "0.25rem",
                }}
              >
                Usuario:
              </small>
              <div
                style={{
                  fontSize: "1.125rem",
                  fontWeight: "600",
                  color: "#333",
                  fontFamily: "monospace",
                  padding: "0.75rem",
                  backgroundColor: "white",
                  borderRadius: "0.375rem",
                  border: "1px solid #ddd",
                }}
              >
                {username || firstName}
              </div>
            </div>

            <div>
              <small
                style={{
                  color: "#666",
                  display: "block",
                  marginBottom: "0.25rem",
                }}
              >
                Contraseña:
              </small>
              <div
                style={{
                  fontSize: "1.125rem",
                  fontWeight: "600",
                  color: "#333",
                  fontFamily: "monospace",
                  padding: "0.75rem",
                  backgroundColor: "white",
                  borderRadius: "0.375rem",
                  border: "1px solid #ddd",
                }}
              >
                {initialPassword}
              </div>
            </div>
          </div>

          <div
            style={{
              backgroundColor: "#fff3cd",
              border: "1px solid #ffeaa7",
              color: "#856404",
              padding: "1rem",
              borderRadius: "0.375rem",
              fontSize: "0.875rem",
            }}
          >
            <strong>⚠️ Importante:</strong> Comunica estas credenciales al
            empleado de forma segura.
          </div>
        </div>

        <button
          onClick={onClose}
          style={{
            width: "100%",
            padding: "0.75rem",
            backgroundColor: "#198754",
            color: "white",
            border: "none",
            borderRadius: "0.375rem",
            fontSize: "1rem",
            fontWeight: "600",
            cursor: "pointer",
          }}
        >
          Entendido
        </button>
      </div>
    </div>
  );
}
