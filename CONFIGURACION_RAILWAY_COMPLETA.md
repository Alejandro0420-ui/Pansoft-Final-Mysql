# 🎯 RESUMEN COMPLETO: CONFIGURACIÓN PARA RAILWAY

## 📋 Diagrama del Flujo

```
┌─────────────────────────────────────────────────────────────────┐
│                        USUARIO                                  │
└─────────────────────────────────────────────────════────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│      Frontend (Railway)                                          │
│  https://pnasoft-frontend-production.up.railway.app             │
│                                                                  │
│  .env.production:                                               │
│  VITE_API_BASE_URL=https://pansoft-backend-xxxx.railway.app     │
│                                                                  │
│  src/config.js valida esta variable                             │
└─────────────────────────────────────────────────────────────────┘
                              ↓ (CORS policy check)
                         Fetch Request
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│      Backend (Railway)                                           │
│  https://pansoft-backend-xxxx.railway.app                       │
│                                                                  │
│  server.js:                                                     │
│  - CORS habilitado con variables FRONTEND_URL                   │
│  - Acepta requests desde el frontend                            │
│  - Devuelve: Access-Control-Allow-Origin: (origen correcto)    │
└─────────────────────────────────────────────────────────────────┘
```

## 🔧 Cambios Realizados

### 1. Frontend - Configuración Centralizada
**Archivo**: `src/config.js`
```javascript
// Valida que VITE_API_BASE_URL no sea placeholder
// En desarrollo: http://localhost:5000
// En producción: Variable de entorno
```

**Importado por**:
- App.jsx
- components/notifications.jsx
- components/suppliers.jsx
- components/ProductsSection.jsx
- components/SuppliesSection.jsx
- components/billing/SalesPoint.jsx
- components/products/ProductsGrid.jsx
- components/inventory/InventoryGrid.jsx

### 2. Backend - CORS Correcto
**Archivo**: `server.js` (líneas 17-44)
```javascript
const corsOptions = {
  origin: (origin, callback) => {
    // Permite localhost en desarrollo
    // En producción: permite desde FRONTEND_URL
  },
  credentials: true,
  methods: ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
};

app.use(cors(corsOptions));
```

### 3. Variables de Entorno

#### Frontend:
- `.env` - Desarrollo
- `.env.example` - Template
- `.env.production` - Producción (LLENAR CON TU URL)

#### Backend:
- `.env` - Ya existe (verificar MYSQL_URL)
- `.env.production.example` - Template (NUEVO)

## ✅ Checklist de Configuración

### En Railway Dashboard

#### Backend Service:
```
VARIABLES:
☐ MYSQL_URL = mysql://user:pass@host:port/db
☐ PORT = 5000
☐ NODE_ENV = production
☐ FRONTEND_URL = https://pnasoft-frontend-production.up.railway.app
☐ JWT_SECRET = (valor seguro)
```

#### Frontend Service:
```
VARIABLES:
☐ VITE_API_BASE_URL = https://pansoft-backend-xxxx.railway.app
```

**⚠️ IMPORTANTE**: Asegúrate de que NO hay placeholders como:
- ❌ `your-backend-service.railway.app`
- ❌ `your-frontend-url.railway.app`
- ❌ `{BACKEND_URL}`

### Build & Start Commands

#### Backend:
```
Start Command: npm start
```

#### Frontend:
```
Start Command: npm run build && npm run preview
  O
Start Command: node server.js (si tienes servidor custom)
Build Command: npm run build
```

## 🧪 Testing

### Test 1: Verificar URLs en DevTools

1. Abre el Frontend
2. F12 → Network tab
3. Log in
4. Busca request a `/api/notifications`
5. Verifica que vaya a: `https://pansoft-backend-xxxx.railway.app/api/notifications`

✅ Correcto:
```
https://pansoft-backend-production-123abc.railway.app/api/notifications
Status: 200 ✓
```

❌ Incorrecto:
```
http://localhost:5000/api/notifications
Error: ERR_CONNECTION_REFUSED
```

### Test 2: Verificar CORS

En DevTools Console, ejecuta:
```javascript
fetch('https://pansoft-backend-xxxx.railway.app/api/notifications', {
  headers: {
    'Authorization': `Bearer ${localStorage.getItem('token')}`
  }
})
.then(r => r.json())
.then(d => console.log('✅ Success:', d))
.catch(e => console.error('❌ Error:', e))
```

Debe retornar datos, no error de CORS.

## 🐛 Troubleshooting

### Error: "CORS policy: Access-Control-Allow-Origin"

**Causa 1**: Variable `VITE_API_BASE_URL` es un placeholder
```
❌ VITE_API_BASE_URL=https://your-backend-service.railway.app
✅ VITE_API_BASE_URL=https://pansoft-backend-prod-abc123.railway.app
```

**Solución**: 
- Ve a Railway → Frontend → Variables
- Copia URL REAL del backend desde Railway → Backend → Settings
- Pega en VITE_API_BASE_URL
- Redeploy Frontend

---

**Causa 2**: Backend no tiene FRONTEND_URL correcto
```
Backend doesn't know about:
https://pnasoft-frontend-production.up.railway.app
```

**Solución**:
- Ve a Railway → Backend → Variables
- Actualiza FRONTEND_URL con URL REAL del frontend
- Redeploy Backend

---

### Error: "TypeError: a.map is not a function"

Significa que al menos una API se está fallando (CORS u hostname incorrectos).

**Solución**: 
- Verifica en DevTools Network tab
- ¿Las requests llegan al backend correcto?
- ¿El backend está respondiendo?
- ¿Las respuestas son JSON válido?

---

### Error: "Failed to fetch"

CORS indirecto o timeout

**Solución**:
- Verifica que las URLs no tengan typos
- Verifica que el backend esté "UP" en Railway
- Verifica logs del backend en Railway

---

### Todo funciona en localhost pero no en Railway

**Causa**: Diferencia entre URLs
- Desarrollo: `http://localhost:5000`
- Producción: `https://backend-url.railway.app`

**Solución**: Ya está configurado en `src/config.js` - solo asegúrate de que `VITE_API_BASE_URL` esté correcto.

---

## 📞 Archivos para Referencia

1. **src/config.js** - Configuración central de URLs
2. **backend/server.js** - CORS configurado
3. **RAILWAY_CORS_FIX.md** - Guía paso a paso
4. **RAILWAY_DEPLOYMENT_GUIDE.md** - Guía completa original

## 🚀 Próximos Pasos

1. ✅ Identifica URLs REALES en Railway
2. ✅ Actualiza variables de entorno
3. ✅ Redeploy ambos servicios
4. ✅ Test en navegador
5. 🎉 ¡Listo!

---

**Última actualización**: 2026-02-24
**Estado**: Listo para producción en Railway
