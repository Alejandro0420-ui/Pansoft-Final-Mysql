import { useState, useEffect } from "react";
import { useSearchParams, useNavigate } from "react-router-dom";
import { Lock, CheckCircle, AlertCircle } from "lucide-react";
import { authAPI } from "../services/api";
import logo from "../images/Logo-Pansoft.png";

export function ResetPassword() {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);
  const [tokenValid, setTokenValid] = useState(null);

  const token = searchParams.get("token");

  useEffect(() => {
    // Validar si el token está presente
    if (!token) {
      setTokenValid(false);
      setError("Token no proporcionado. El enlace de recuperación es inválido.");
    } else {
      setTokenValid(true);
    }
  }, [token]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    // Validar que las contraseñas coincidan
    if (newPassword !== confirmPassword) {
      setError("Las contraseñas no coinciden");
      return;
    }

    if (newPassword.length < 6) {
      setError("La contraseña debe tener al menos 6 caracteres");
      return;
    }

    setLoading(true);

    try {
      const response = await authAPI.resetPassword(token, newPassword);
      console.log("Respuesta reset-password:", response);
      setSuccess(true);

      // Redirigir al login después de 3 segundos
      setTimeout(() => {
        navigate("/login");
      }, 3000);
    } catch (err) {
      setError(
        err.response?.data?.error || "Error al resetear la contraseña"
      );
      console.error("Error en reset-password:", err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div
      className="d-flex align-items-center justify-content-center p-2"
      style={{
        height: "100vh",
        width: "100%",
        background: "linear-gradient(135deg, #EBB583 0%, #EBCC83 100%)",
        margin: 0,
        padding: "1rem !important",
        boxSizing: "border-box",
      }}
    >
      <div
        className="card shadow-lg border-0 w-100"
        style={{ maxWidth: "450px" }}
      >
        <div className="card-body p-3 p-sm-4 p-md-5">
          <div className="text-center mb-4">
            <div
              className="d-flex justify-content-center"
              style={{ marginBottom: "-10px" }}
            >
              <img
                src={logo}
                id="pansoft-logo"
                alt="Pansoft Logo"
                className="img-fluid"
              />
            </div>
            <p
              className="text-muted small text-center"
              style={{
                fontFamily: "Roboto, sans-serif",
                position: "relative",
                top: "-20px",
              }}
            >
              Sistema de Gestión para Panaderías
            </p>
          </div>

          {success ? (
            <div className="text-center py-3">
              <div style={{ marginBottom: "1rem" }}>
                <CheckCircle
                  size={64}
                  style={{ color: "#28a745" }}
                  className="mx-auto"
                />
              </div>
              <h5 className="text-success mb-2">¡Contraseña Actualizada!</h5>
              <p className="text-muted mb-3">
                Tu contraseña ha sido resetada correctamente.
              </p>
              <p className="text-muted small">
                Serás redirigido al login en unos momentos...
              </p>
            </div>
          ) : tokenValid === false ? (
            <div className="alert alert-danger" role="alert">
              <div className="d-flex gap-2 align-items-center">
                <AlertCircle size={24} />
                <div>
                  <h5 className="alert-heading mb-0">Enlace Inválido</h5>
                  <small>{error}</small>
                </div>
              </div>
              <hr />
              <p className="mb-0">
                Por favor,{" "}
                <a
                  href="/login"
                  style={{ color: "#EA7028", textDecoration: "none" }}
                >
                  solicita un nuevo enlace de recuperación
                </a>
                .
              </p>
            </div>
          ) : (
            <form onSubmit={handleSubmit}>
              <h5 className="mb-3 text-center">Establecer Nueva Contraseña</h5>

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

              <div className="mb-3">
                <label className="form-label d-flex align-items-center gap-2">
                  <Lock className="text-danger flex-shrink-0" size={18} />
                  <span>Nueva Contraseña</span>
                </label>
                <input
                  type="password"
                  className="form-control border-2 rounded-3"
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  placeholder="Ingrese su nueva contraseña"
                  required
                  disabled={loading}
                  style={{ borderColor: "#EBB583" }}
                />
                <small className="form-text text-muted">
                  Mínimo 6 caracteres
                </small>
              </div>

              <div className="mb-3">
                <label className="form-label d-flex align-items-center gap-2">
                  <Lock className="text-danger flex-shrink-0" size={18} />
                  <span>Confirmar Contraseña</span>
                </label>
                <input
                  type="password"
                  className="form-control border-2 rounded-3"
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  placeholder="Confirme su contraseña"
                  required
                  disabled={loading}
                  style={{ borderColor: "#EBB583" }}
                />
              </div>

              <button
                type="submit"
                className="btn w-100 text-white fw-semibold rounded-3"
                style={{
                  backgroundColor: "#EA7028",
                  padding: "0.65rem",
                  fontSize: "1rem",
                }}
                disabled={loading}
              >
                {loading ? "Actualizando..." : "Actualizar Contraseña"}
              </button>
            </form>
          )}

          <div className="mt-4 text-center">
            <p
              className="text-muted text-center"
              style={{ fontFamily: "Roboto, sans-serif", fontSize: "0.8rem" }}
            >
              © 2026 Pansoft. Todos los derechos reservados.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
