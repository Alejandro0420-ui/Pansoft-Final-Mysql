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
    return envUrl.replace(/\/$/, "");
  }

  // En desarrollo, usar localhost:5000
  if (isDevelopment) {
    return "http://localhost:5000";
  }

  // En producción sin variable de entorno configurada, usar mismo dominio
  // Esto asume que el backend está en el mismo servidor que el frontend
  // O usar un puerto diferente en el mismo host
  const protocol = window.location.protocol; // https: o http:
  const hostname = window.location.hostname; // dominio del frontend
  const port = window.location.port; // puerto si existe

  // Opción 1: Mismo dominio
  // return `${protocol}//${hostname}${port ? ":" + port : ""}`;

  // Opción 2: Buscar en variable VITE_API_URL (alternativa)
  const apiUrl = import.meta.env.VITE_API_URL;
  if (apiUrl && apiUrl.trim()) {
    return apiUrl.replace(/\/$/, "");
  }

  // Fallback a mismo dominio con ruta /api
  console.warn(
    "⚠️ VITE_API_BASE_URL no configurada en producción. Usando mismo dominio."
  );
  return `${protocol}//${hostname}${port ? ":" + port : ""}`;
};

export const API_BASE_URL = getApiBaseUrl();

console.log(`🔧 API Base URL: ${API_BASE_URL}`);

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
