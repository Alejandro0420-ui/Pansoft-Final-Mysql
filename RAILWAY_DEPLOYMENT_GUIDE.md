# Instrucciones para Deployar en Railway

## Problema Identificado
El frontend estaba hardcodeado a `http://localhost:5000`, lo que causa errores en producción:
- `GET http://localhost:5000/api/notifications/unread/count net::ERR_CONNECTION_REFUSED`
- `TypeError: a.map is not a function` (cuando las APIs no responden)

## Solución Implementada

Se ha centralizado la configuración de la URL de la API en `src/config.js`. El frontend ahora usa variables de entorno para determinar la URL del backend:

- **Desarrollo**: `http://localhost:5000` (por defecto)
- **Producción**: Lee de variable de entorno `VITE_API_BASE_URL`

## Pasos para Deployar en Railway

### 1. Variables de Entorno en Railway

En tu proyecto de Railway, configura las siguientes variables de entorno:

**Para el Frontend:**
```
VITE_API_BASE_URL=https://your-backend-url.railway.app
```

**Para el Backend:**
```
MYSQL_URL=mysql://usuario:password@host:puerto/basedatos
PORT=5000
NODE_ENV=production
```

### 2. Actualizar Build Command

En Railway, el comando de build debe ser:
```
npm install && npm run build
```

### 3. Servir el Frontend

Para servir el frontend compilado en Railway, necesitas:

**Option A: Estar seguro que Railway está configurado para servir la carpeta `dist/`**

**Option B: Usar un servidor escrito en Node.js** (recomendado)

Crea un archivo `server.js` en la raíz del proyecto frontend:

```javascript
import express from 'express';
import path from 'path';

const app = express();
const PORT = process.env.PORT || 3000;

// Servir archivos estáticos desde la carpeta dist
app.use(express.static(path.join(process.cwd(), 'dist')));

// Para cualquier ruta no encontrada, servir index.html (SPA)
app.get('*', (req, res) => {
  res.sendFile(path.join(process.cwd(), 'dist', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Frontend server running on port ${PORT}`);
});
```

Y actualiza el `package.json` del frontend:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "start": "node server.js",
    "preview": "vite preview"
  }
}
```

### 4. CORS Configuration

El backend tiene CORS habilitado. Si necesitas restringirlo a dominios específicos, actualiza el backend:

```javascript
app.use(cors({
  origin: process.env.FRONTEND_URL || '*',
  credentials: true
}));
```

Y añade en las variables de entorno del backend:
```
FRONTEND_URL=https://your-frontend-url.railway.app
```

### 5. HTTPS y Dominios

Railway proporciona URLs HTTPS automáticamente. Asegúrate de que:
- Frontend y Backend estén en dominios diferentes de Railway
- La variable `VITE_API_BASE_URL` apunte al backend correcto

### 6. Testing

Después de deployar:

1. **En Consola del Browser (DevTools)**:
   - Verifica que las requests vayan a la URL correcta (no a localhost)
   - Busca errores de CORS

2. **Test de Notificaciones**:
   - Inicia sesión
   - Abre DevTools > Network
   - Verifica que las requests a `/api/notifications` devuelvan datos correctos

3. **Test de Imágenes**:
   - Verifica que se carguen correctamente
   - Las imágenes deben venir de `{API_BASE_URL}/ruta/imagen.jpg`

## Archivos Modificados

Los siguientes archivos han sido actualizados para usar URLs dinámicas:

- `src/config.js` (nuevo) - Configuración centralizada
- `.env` - Variables de entorno para desarrollo
- `.env.example` - Ejemplo para producción
- `src/App.jsx` - Usa `getApiUrl()`
- `src/components/notifications.jsx` - Usa `getApiUrl()`
- `src/components/suppliers.jsx` - Usa `getApiUrl()`
- `src/components/ProductsSection.jsx` - Usa `getApiUrl()`
- `src/components/SuppliesSection.jsx` - Usa `getApiUrl()`
- `src/components/billing/SalesPoint.jsx` - Usa `getApiUrl()`
- `src/components/products/ProductsGrid.jsx` - Usa `getApiUrl()`
- `src/components/inventory/InventoryGrid.jsx` - Usa `getApiUrl()`

## Troubleshooting

### Error: "Cannot find module './config'"
- Asegúrate de que `src/config.js` existe
- Verifica los imports en el archivo que falla

### Error: "a.map is not a function"
- Significa que una API no devuelve un array esperado
- Verifica en DevTools > Network que la respuesta es JSON válido
- Confirma que `VITE_API_BASE_URL` está correctamente configurado

### CORS Error
- El backend debe tener CORS habilitado
- El frontend y backend pueden estar en dominios diferentes en Railway (está bien)
- Verifica que las URLs no tengan puertos incorrectos
