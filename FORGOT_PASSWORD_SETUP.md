# 🔐 Funcionalidad de Recuperación de Contraseña - Guía de Configuración

## ✅ Implementación Completada

Se ha agregado exitosamente la funcionalidad de recuperación de contraseña (Forgot Password) con reseteo por email al sistema Pansoft.

---

## 📋 Cambios Realizados

### Backend (`backend/routes/auth.js`)
- ✅ **Nuevo endpoint `/auth/forgot-password`**: Genera token temporal y envía email de recuperación
- ✅ **Nuevo endpoint `/auth/reset-password`**: Valida token y establece nueva contraseña
- ✅ Función `sendResetEmail()`: Envía email HTML con link de recuperación
- ✅ Tokens con verificación de expiración (30 minutos)

### Base de Datos
- ✅ Columnas `reset_token` y `reset_token_expires` agregadas a tabla `users`
- ✅ Índices creados para mejor rendimiento

### Frontend
- ✅ **Componente `ForgotPasswordModal.jsx`**: Modal para solicitar recuperación
- ✅ **Componente `ResetPassword.jsx`**: Página para resetear contraseña con token
- ✅ **Modificado `login.jsx`**: Integración del modal de forgot password
- ✅ **Actualizado `App.jsx`**: Nuevas rutas `/reset-password`
- ✅ **API `services/api.jsx`**: Métodos `forgotPassword()` y `resetPassword()`

### Email
- ✅ **Archivo `emailConfig.js`**: Configuración de Nodemailer con Mailtrap
- ✅ Template HTML profesional con branding corporativo

---

## 🔧 Configuración de Mailtrap

### Paso 1: Crear cuenta en Mailtrap
1. Ir a https://mailtrap.io/
2. Registrarse con email
3. Crear proyecto (p.ej: "Pansoft - Recuperación")

### Paso 2: Obtener credenciales SMTP
1. En tu proyecto de Mailtrap, ir a **Settings**
2. Copiar valores de **SMTP Settings**:
   - **Host**: `smtp.mailtrap.io`
   - **Port**: `587`
   - **Username**: (copiar)
   - **Password**: (copiar)

### Paso 3: Configurar variables de entorno

Editar `backend/.env`:
```env
# Email configuration (Mailtrap for testing)
EMAIL_HOST=smtp.mailtrap.io
EMAIL_PORT=587
EMAIL_USER=tu_usuario_mailtrap
EMAIL_PASS=tu_password_mailtrap

# Frontend URL for password reset links
FRONTEND_URL=http://localhost:5173
```

**Para producción**, cambiar:
```env
FRONTEND_URL=https://tu-dominio-produccion.com
```

### Paso 4: Reiniciar backend
```bash
docker-compose restart backend
```

---

## 🧪 Prueba de Funcionamiento

### 1. Ir a la página de Login
- URL: `http://localhost:5173/login`

### 2. Hacer clic en "¿Olvidó su contraseña?"
- Se abrirá un modal del formulario

### 3. Ingresar email registrado
- Ejemplo: `admin@pansoft.com`
- Hacer clic en "Enviar Instrucciones"

### 4. Verificar email en Mailtrap
1. Ir a Mailtrap Dashboard → Tu Proyecto
2. Ver el email recibido en la bandeja
3. Copiar el link de recuperación desde el email

### 5. Resetear contraseña
- Ir al link o acceder a:
  `http://localhost:5173/reset-password?token=CODIGO_DEL_EMAIL`
- Ingresar nueva contraseña
- Hacer clic en "Actualizar Contraseña"

### 6. Verificar en la BD
```bash
docker exec pansoft-final-mysql-db-1 mysql -u root -pexample pansoft_db -e "SELECT username, reset_token, reset_token_expires FROM users WHERE username='admin';"
```

---

## 🔒 Características de Seguridad

| Feature | Detalle |
|---------|---------|
| **Token Temporal** | Válido solo por 30 minutos |
| **Validación de Email** | Solo usuarios registrados pueden recuperar |
| **Hashing de Contraseña** | Bcrypt con 10 salt rounds |
| **Token Único** | Generado con `crypto.randomBytes(32)` |
| **Limpieza Automática** | Token se elimina después de usar |
| **No revelar usuarios** | Mismo mensaje si email existe o no |

---

## 📧 Variables de Email Disponibles

```javascript
// Usar en futuras expansiones:
process.env.EMAIL_HOST      // SMTP Server
process.env.EMAIL_PORT      // Puerto (587 para TLS, 465 para SSL)
process.env.EMAIL_USER      // Usuario de Mailtrap
process.env.EMAIL_PASS      // Contraseña de Mailtrap
process.env.FRONTEND_URL    // URL del frontend (para generar links)
```

---

## 📊 Flujo Completo

```
1. Usuario hace clic en "¿Olvidó contraseña?"
   ↓
2. Ingresa email en modal - POST /auth/forgot-password
   ↓
3. Backend:
   - Busca usuario por email
   - Genera token aleatorio
   - Guarda: reset_token, reset_token_expires (NOW + 30 min)
   - Envía email con link de reseteo
   ↓
4. Usuario recibe email en Mailtrap
   ↓
5. Usuario hace clic en link: /reset-password?token=XXX
   ↓
6. Frontend valida token (verifica que esté presente)
   ↓
7. Usuario ingresa nueva contraseña - POST /auth/reset-password
   ↓
8. Backend:
   - Valida token y fecha expiración
   - Hashea nueva contraseña (bcrypt)
   - Actualiza contraseña
   - Limpia: reset_token = NULL, reset_token_expires = NULL
   ↓
9. ✅ Contraseña resetada exitosamente - Redirige a /login
```

---

## ⚙️ Endpoints API

### `POST /auth/forgot-password`
**Request:**
```json
{
  "email": "usuario@example.com"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "Si el email existe en nuestro sistema, recibirás un correo de recuperación"
}
```

---

### `POST /auth/reset-password`
**Request:**
```json
{
  "token": "abc123def456...",
  "newPassword": "nuevaContraseña123"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "Contraseña actualizada correctamente"
}
```

---

## 🐛 Troubleshooting

### ❌ "Error al enviar el email"
- Verificar credenciales de EMAIL_USER y EMAIL_PASS
- Verificar que EMAIL_HOST sea correcto
- Ver logs del backend: `docker logs pansoft-final-mysql-backend-1`

### ❌ "Token inválido o expirado"
- El token puede haber expirado (máximo 30 minutos)
- Solicitar un nuevo email de recuperación

### ❌ "No recibo el email"
- Verificar en **Mailtrap Dashboard → Bandeja de entrada**
- Revisar carpeta de **Spam**
- Verificar que el email esté registrado en la BD

### ❌ "La columna reset_token no existe"
```bash
docker exec pansoft-final-mysql-db-1 mysql -u root -pexample pansoft_db -e "
  ALTER TABLE users ADD COLUMN reset_token VARCHAR(500);
  ALTER TABLE users ADD COLUMN reset_token_expires DATETIME;
"
```

---

## 🚀 Próximas Mejoras Opcionales

1. **Autenticación de 2 Factores (2FA)**
   - Código OTP por email
   - Verificación en el reset

2. **Historial de Cambios**
   - Registrar cuándo se cambió la contraseña
   - Columna `password_changed_at`

3. **Intentos Fallidos**
   - Limitar intentos de reset
   - Rate limiting por email

4. **Notificaciones en tiempo real**
   - WebSocket para alertas de seguridad
   - Notificación de cambio de contraseña

5. **Respaldo de Recuperación**
   - Códigos de backup generados
   - Preguntas de seguridad

---

## 📞 Soporte

Para cambios en la URL del frontend en producción, actualizar:
- `backend/.env` → `FRONTEND_URL`
- Reiniciar: `docker-compose restart backend`

Para cambiar proveedores de email:
- Editar `backend/emailConfig.js`
- Cambiar parámetros de `nodemailer.createTransport()`
