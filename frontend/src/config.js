/**
 * Configuración centralizada de URLs de API
 * En desarrollo usa localhost:5000
 * En producción usa la variable de entorno VITE_API_BASE_URL o la misma origin
 */

// Detectar si estamos en desarrollo o producción
const isDevelopment = import.meta.env.DEV;

// Obtener la URL base de la API
const getApiBaseUrl = () => {
  // Si hay variable de entorno, usarla (pero validar que no sea placeholder)
  const envUrl = import.meta.env.VITE_API_BASE_URL;
  if (
    envUrl &&
    envUrl.trim() &&
    !envUrl.includes("your-backend") &&
    !envUrl.includes("VITE_API")
  ) {
    // Asegurar que termina sin slash
    console.log("✅ [Config] Usando VITE_API_BASE_URL:", envUrl);
    return envUrl.replace(/\/$/, "");
  }

  // En desarrollo, usar localhost:5000
  if (isDevelopment) {
    console.log("✅ [Config] Modo desarrollo - usando localhost:5000");
    return "http://localhost:5000";
  }

  // En producción: Intentar con hardcoded URL del backend en Railway
  // Esta es la URL conocida del backend en producción
  const railwayBackendUrl = "https://pansoft-backend-production-6467.up.railway.app";
  console.log("⚠️ [Config] VITE_API_BASE_URL no está configurada. Usando Railway backend:", railwayBackendUrl);
  return railwayBackendUrl;
};

export const API_BASE_URL = getApiBaseUrl();

console.log(`🔧 API Base URL: ${API_BASE_URL}`);
console.log(`🔧 Development Mode: ${isDevelopment}`);

/**
 * Obtener URL completa para un endpoint
 * @param {string} endpoint - Ruta de la API (e.g., "/api/notifications")
 * @returns {string} URL completa
 */
export const getApiUrl = (endpoint) => {
  if (endpoint.startsWith("http")) {
    return endpoint;
  }
  // Si el endpoint no comienza con /api, agregarlo
  const path = endpoint.startsWith("/api") ? endpoint : `/api${endpoint}`;
  return `${API_BASE_URL}${path}`;
};

export default {
  API_BASE_URL,
  getApiUrl,
};
