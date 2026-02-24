/**
 * Configuración centralizada de URLs de API
 * En desarrollo usa localhost:5000
 * En producción usa la variable de entorno VITE_API_BASE_URL o detecta automáticamente
 */

// Detectar si estamos en desarrollo o producción
const isDevelopment = import.meta.env.DEV;

// Obtener la URL base de la API
const getApiBaseUrl = () => {
  // Si hay variable de entorno, usarla
  if (import.meta.env.VITE_API_BASE_URL) {
    return import.meta.env.VITE_API_BASE_URL;
  }

  // En desarrollo, usar localhost:5000
  if (isDevelopment) {
    return "http://localhost:5000";
  }

  // En producción, usar el mismo dominio que el frontend
  // Esto asume que el backend está en el mismo dominio (e.g., same-origin)
  return window.location.origin;
};

export const API_BASE_URL = getApiBaseUrl();

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
