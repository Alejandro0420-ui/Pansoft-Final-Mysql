# Docker Compose - Desarrollo vs Producción

## 📁 Archivos

### `docker-compose.yml` (Desarrollo Local)
- ✅ Frontend en puerto **3000** (con hot-reload)
- ✅ Backend en puerto **5000**
- ✅ phpMyAdmin en puerto **8082**
- ✅ Volúmenes para desarrollo (live reload)
- ✅ Base de datos con setup automático

### `docker-compose.production.yml` (Producción/Servidor)
- ✅ Frontend en puerto **80** (Nginx)
- ✅ Backend en puerto **5000**
- ✅ phpMyAdmin en puerto **8082**
- ✅ Sin volúmenes de código (imagen completa)
- ✅ Base de datos con setup automático

---

## 🚀 Uso

### Desarrollo Local

```bash
# Inicia los servicios
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener
docker-compose down

# Reconstruir imágenes
docker-compose up -d --build
```

**URL de acceso:**
- Frontend: http://localhost:3000
- Backend: http://localhost:5000
- phpMyAdmin: http://localhost:8082

### Producción (Servidor)

```bash
# Inicia con el compose de producción
docker-compose -f docker-compose.production.yml up -d

# Ver logs
docker-compose -f docker-compose.production.yml logs -f

# Detener
docker-compose -f docker-compose.production.yml down

# Reconstruir imágenes
docker-compose -f docker-compose.production.yml up -d --build
```

**URL de acceso:**
- Frontend: http://tu-dominio.com (puerto 80)
- Backend: http://tu-dominio.com:5000
- phpMyAdmin: http://tu-dominio.com:8082

---

## ✅ Diferencias Clave

| Aspecto | Desarrollo | Producción |
|--------|-----------|-----------|
| **Frontend Port** | 3000 (dev server) | 80 (Nginx) |
| **Dockerfile Frontend** | Dockerfile.dev | Dockerfile |
| **Volúmenes** | ✅ Live reload | ❌ Sin volúmenes |
| **Hot-reload** | ✅ Habilitado | ❌ Deshabilitado |
| **Tamaño imagen** | Más grande | Optimizado |
| **Performance** | Dev-friendly | Optimizado |

---

## 🔧 Proceso Automático de Setup

Ambos compose ejecutan automáticamente:

1. ✅ Espera a que MySQL esté disponible (healthcheck)
2. ✅ Ejecuta `backend/db/setup_db.sh`
3. ✅ Lee credenciales del `.env`
4. ✅ Crea BD y usuario
5. ✅ Aplica schema completo
6. ✅ Carga todos los seeds
7. ✅ Inicia la aplicación

---

## 📋 Checklist Antes de Producción

- [ ] `.env` tiene credenciales correctas
- [ ] `packaged/full_schema.sql` está actualizado
- [ ] `seeds/` tienen los datos correctos
- [ ] `setup_db.sh` tiene permisos de ejecución
- [ ] Frontend usa `Dockerfile` (no `Dockerfile.dev`)
- [ ] Backend expone puerto 5000
- [ ] MySQL usa puerto interno 3306 (no expuesto)
- [ ] phpMyAdmin está disponible en 8082 (solo para admin)

---

## 🔄 Actualizar en Producción

Si agrega una columna nueva al schema:

```bash
# 1. Modifica el archivo base
# backend/db/01_base_schema_mysql.sql

# 2. Regenera schema consolidado
cd backend/db
python package_schema_and_seed.py

# 3. Commit y push
git add .
git commit -m "feat: agregar nueva columna"
git push

# 4. En servidor (pull)
cd /path/to/repo
git pull origin main

# 5. Reconstruir y reiniciar (ejecutará setup_db.sh nuevamente)
docker-compose -f docker-compose.production.yml up -d --build
```

---

## 🚨 Troubleshooting

### Error: "MySQL no está disponible"
```bash
# Ver estado
docker-compose logs db

# Reiniciar solo DB
docker-compose restart db

# O en producción
docker-compose -f docker-compose.production.yml restart db
```

### Error: "Port already in use"
```bash
# Cambiar puerto en docker-compose.yml
# Busca: ports: - "5000:5000"
# Cambia a: ports: - "5001:5000"
```

### Error: "setup_db.sh: permission denied"
```bash
# En la carpeta del repo, ejecuta:
chmod +x backend/db/setup_db.sh

# Commit y push
git add backend/db/setup_db.sh
git commit -m "fix: permisos setup_db.sh"
git push
```

### Error: "Database already exists"
```bash
# Es normal en reinicio, el script verifica con IF NOT EXISTS
# Puedes verificar con phpMyAdmin: http://localhost:8082
```

---

## 💡 Tips

### Conectar a MySQL desde terminal en Docker

```bash
# Desarrollo
docker-compose exec db mysql -u pansoft_user -p pansoft_db
# Ingresa contraseña: Pansoft@2026

# Producción
docker-compose -f docker-compose.production.yml exec db mysql -u pansoft_user -p pansoft_db
```

### Ver logs en tiempo real

```bash
# Todos los servicios
docker-compose logs -f

# Solo MySQL
docker-compose logs -f db

# Solo backend
docker-compose logs -f backend

# Producción
docker-compose -f docker-compose.production.yml logs -f backend
```

### Ejecutar comandos en el backend

```bash
# Desarrollo
docker-compose exec backend npm install

# Producción
docker-compose -f docker-compose.production.yml exec backend npm start
```

---

## 📝 Variables de Entorno (.env)

Ambos compose usan las mismas variables:

```env
# Base de datos
DB_USER=pansoft_user
DB_PASSWORD=Pansoft@2026
DB_HOST=db
DB_PORT=3306
DB_NAME=pansoft_db

# MySQL (Docker)
MYSQL_ROOT_PASSWORD=Pansoft@2026
MYSQL_DATABASE=pansoft_db
MYSQL_USER=pansoft_user
MYSQL_PASSWORD=Pansoft@2026

# Aplicación
JWT_SECRET=your_jwt_secret_key_here
PORT=5000
NODE_ENV=production  # Cambiar a production en servidor
```

---

## 🎯 Resumen

**Para Desarrollo:**
```bash
docker-compose up -d
# Acceder a http://localhost:3000
```

**Para Producción:**
```bash
docker-compose -f docker-compose.production.yml up -d
# Acceder a http://tu-dominio.com
```

Ambos ejecutarán automáticamente el setup de la BD. ¡Listo para usar!
