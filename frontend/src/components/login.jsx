import { useState } from "react";
import { authAPI } from "../services/api";
import { User, Lock } from "lucide-react";
import "../styles/Login.css";
import logo from "../images/Logo-Pansoft.png";

export function Login({ onLogin }) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      const response = await authAPI.login(username, password);
      localStorage.setItem("token", response.data.token);
      localStorage.setItem("user", JSON.stringify(response.data.user));
      localStorage.setItem(
        "mustChangePassword",
        response.data.user.mustChangePassword ? "true" : "false",
      );

      // Cargar permisos del usuario (esto será hecho por PermissionsProvider)
      // Solo almacenamos el token, PermissionsProvider cargará los permisos desde el endpoint

      onLogin();
    } catch (err) {
      setError("Usuario o contraseña incorrectos");
      console.error("Error en login:", err);
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (e, setter) => {
    setter(e.target.value);
    // No limpiar el error cuando el usuario escribe
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

          <form onSubmit={handleSubmit}>
            {error && (
              <div
                className="alert alert-danger alert-dismissible fade show"
                role="alert"
              >
                {error}
              </div>
            )}

            <div className="mb-3">
              <label className="form-label d-flex align-items-center gap-2">
                <User className="text-danger flex-shrink-0" size={18} />
                <span>Usuario</span>
              </label>
              <input
                type="text"
                className="form-control border-2 rounded-3"
                value={username}
                onChange={(e) => handleInputChange(e, setUsername)}
                placeholder="Ingrese su usuario"
                required
                style={{ borderColor: "#EBB583" }}
              />
            </div>

            <div className="mb-3">
              <label className="form-label d-flex align-items-center gap-2">
                <Lock className="text-danger flex-shrink-0" size={18} />
                <span>Contraseña</span>
              </label>
              <input
                type="password"
                className="form-control border-2 rounded-3"
                value={password}
                onChange={(e) => handleInputChange(e, setPassword)}
                placeholder="Ingrese su contraseña"
                required
                style={{ borderColor: "#EBB583" }}
              />
            </div>

            <div className="d-flex justify-content-between align-items-center mb-3">
              <a
                href="#"
                style={{
                  color: "#EA7028",
                  textDecoration: "none",
                  fontFamily: "Roboto, sans-serif",
                  fontSize: "0.9rem",
                }}
              >
                ¿Olvidó su contraseña?
              </a>
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
              {loading ? "Iniciando..." : "Iniciar Sesión"}
            </button>
          </form>

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
