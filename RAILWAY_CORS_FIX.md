# ✅ SOLUCIÓN PARA ERROR DE CORS EN RAILWAY

## Problema Actual
```
Access-Control-Allow-Origin: https://railway.com (INCORRECTO)
Expected origin: https://pnasoft-frontend-production.up.railway.app
```

## Causa
- Variable `VITE_API_BASE_URL` tiene valor placeholder `https://your-backend-service.railway.app`
- O backend no está configurado para aceptar el origen correcto

## SOLUCIÓN PASO A PASO

### PASO 1️⃣: Obtener URL Real del Backend

1. Entra a [Railway.app](https://railway.app)
2. Abre tu **Backend Project**
3. Go a **Settings/Environment** tab
4. Busca la URL pública del backend - Se verá algo como:
   ```
   https://pansoft-backend-production-xxxx.railway.app
   ```

**COPIA ESTA URL** ⬇️

### PASO 2️⃣: Configurar CORS en Backend

En tu proyecto backend de Railway:

1. Entra a la pestaña **Variables**
2. Añade/Actualiza estas variables de entorno:

```
NODE_ENV=production
FRONTEND_URL=https://pnasoft-frontend-production.up.railway.app
```

(Reemplaza con tu URL real de frontend si es diferente)

### PASO 3️⃣: Configurar URL en Frontend

En tu proyecto frontend de Railway:

1. Entra a la pestaña **Variables**
2. Añade/Actualiza esta variable:

```
VITE_API_BASE_URL=https://pansoft-backend-production-xxxx.railway.app
```

**⚠️ IMPORTANTE**: Reemplaza `pansoft-backend-production-xxxx.railway.app` con la URL REAL de tu backend

### PASO 4️⃣: Deploy Ambos Servicios

1. **Backend**: Click en **Redeploy**
2. **Frontend**: Click en **Redeploy**
3. Espera a que ambos terminen (verás "UP" en verde)

### PASO 5️⃣: Probar en Navegador

Una vez deployado:

1. Abre tu frontend: `https://pnasoft-frontend-production.up.railway.app`
2. Abre DevTools (F12) → **Network** tab
3. Log in
4. Verifica que las requests vayan a:
   - ✅ `https://pansoft-backend-production-xxxx.railway.app/api/notifications/...`
   - ❌ No a `localhost`
   - ❌ No a `your-backend-service.railway.app`

## Si Aún da Error

### Opción A: Frontend y Backend en Mismo Servidor

Si quieres que frontend y backend estén en el MISMO dominio de Railway:

**En el backend `server.js`, haz build del frontend:**

```javascript
import express from "express";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();

// Servir frontend compilado
app.use(express.static(path.join(__dirname, "../frontend/dist")));

// API routes
app.use("/api", apiRoutes);

// SPA fallback
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/dist/index.html"));
});
```

Luego en Railway:
- Usa **UN SOLO servicio** (backend)
- No tendrás problemas de CORS
- Frontend y backend corren en `https://pansoft-backend.railway.app`

### Opción B: Usar API Proxy

Si prefieres servicios separados, configura Railway para hacer proxy:

En Railway config (railway.json o Dockerfile):
```dockerfile
FROM node:18

WORKDIR /app
COPY . .
RUN npm install && npm run build

# Configurar variables
ENV NODE_ENV=production
ENV CORS_ORIGIN=*

EXPOSE 5000
CMD ["npm", "start"]
```

## Archivos Actualizados

✅ `backend/server.js` - CORS configurado correctamente
✅ `frontend/src/config.js` - Valida URLs, rechaza placeholders
✅ `frontend/.env.production` - Plantilla
✅ `frontend/.env` - Desarrollo

## Comandos Útiles

Ver variables de entorno en Railway:
```bash
railway variables
```

Deployar desde terminal:
```bash
railway deploy
```

## Checklist Final

- [ ] Backend tiene `FRONTEND_URL` correcto en Railway
- [ ] Frontend tiene `VITE_API_BASE_URL` correctamente configurado
- [ ] Ambos servicios están marcados como "UP" en Railway
- [ ] DevTools Network muestra URLs correctas (no localhost)
- [ ] Sin errores de CORS en consola
- [ ] Login funciona
- [ ] Notificaciones cargan correctamente

¿Completaste todos estos pasos? Si aún hay problemas, reporta:
1. URL exacta del backend en Railway
2. URL exacta del frontend en Railway
3. Variables de entorno actuales (sin secretos)
