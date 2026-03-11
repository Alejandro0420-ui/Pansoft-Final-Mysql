import { useState } from "react";
import { Mail, X, CheckCircle } from "lucide-react";
import { authAPI } from "../services/api";

export function ForgotPasswordModal({ isOpen, onClose }) {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      const response = await authAPI.forgotPassword(email);
      console.log("Respuesta forgot-password:", response);
      setSuccess(true);
      setEmail("");
      
      // Cerrar el modal después de 3 segundos
      setTimeout(() => {
        onClose();
        setSuccess(false);
      }, 3000);
    } catch (err) {
      setError(err.response?.data?.error || "Error al procesar la solicitud");
      console.error("Error en forgot-password:", err);
    } finally {
      setLoading(false);
    }
  };

  if (!isOpen) return null;

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
        zIndex: 1050,
      }}
      onClick={onClose}
    >
      <div
        className="card"
        style={{
          width: "100%",
          maxWidth: "400px",
          boxShadow: "0 5px 15px rgba(0,0,0,0.3)",
        }}
        onClick={(e) => e.stopPropagation()}
      >
        <div
          className="card-header d-flex justify-content-between align-items-center"
          style={{ backgroundColor: "#EBB583", borderColor: "#EBB583" }}
        >
          <h5 className="mb-0 text-white">Recuperar Contraseña</h5>
          <button
            type="button"
            className="btn-close btn-close-white"
            onClick={onClose}
            aria-label="Close"
          />
        </div>

        <div className="card-body">
          {success ? (
            <div className="text-center py-3">
              <div style={{ marginBottom: "1rem" }}>
                <CheckCircle
                  size={64}
                  style={{ color: "#28a745" }}
                  className="mx-auto"
                />
              </div>
              <h6 className="text-success mb-2">¡Email Enviado Exitosamente!</h6>
              <p className="text-muted mb-0">
                Revisa tu correo para obtener las instrucciones de recuperación.
                El enlace expirará en <strong>30 minutos</strong>.
              </p>
            </div>
          ) : (
            <form onSubmit={handleSubmit}>
              {error && (
                <div className="alert alert-danger alert-dismissible fade show" role="alert">
                  {error}
                  <button
                    type="button"
                    className="btn-close"
                    onClick={() => setError("")}
                  />
                </div>
              )}

              <p className="text-muted text-small mb-3">
                Ingresa tu email registrado y te enviaremos un enlace para recuperar tu contraseña.
              </p>

              <div className="mb-3">
                <label className="form-label d-flex align-items-center gap-2">
                  <Mail size={18} className="text-danger" />
                  <span>Email</span>
                </label>
                <input
                  type="email"
                  className="form-control border-2 rounded-3"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="tu@email.com"
                  required
                  disabled={loading}
                  style={{ borderColor: "#EBB583" }}
                />
              </div>

              <div className="d-grid gap-2">
                <button
                  type="submit"
                  className="btn text-white fw-semibold rounded-3"
                  style={{
                    backgroundColor: "#EA7028",
                    padding: "0.65rem",
                  }}
                  disabled={loading}
                >
                  {loading ? (
                    <>
                      <span className="spinner-border spinner-border-sm me-2" />
                      Enviando...
                    </>
                  ) : (
                    "Enviar Instrucciones"
                  )}
                </button>
              </div>

              <p className="text-center text-muted small mt-3 mb-0">
                ¿Recuerdas tu contraseña?{" "}
                <button
                  type="button"
                  className="btn btn-link p-0"
                  style={{ color: "#EA7028", textDecoration: "none" }}
                  onClick={onClose}
                >
                  Volver al login
                </button>
              </p>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
