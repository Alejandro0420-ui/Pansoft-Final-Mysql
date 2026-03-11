# Documentación de funcionalidades — Pansoft

Este documento describe de forma concisa las funcionalidades del sistema Pansoft (backend, frontend, base de datos y despliegue) para que cualquier revisor entienda qué hace el proyecto y dónde encontrar cada componente.

## Resumen
- Stack: React (Vite) frontend, Node.js + Express backend, MySQL.
- Propósito: Sistema de gestión para panaderías — control de productos, insumos, inventario, órdenes, facturación, proveedores, clientes, empleados, reportes y notificaciones.

## Estructura principal (ubicaciones clave)
- Backend: [backend](backend) (entrada: [backend/server.js](backend/server.js#L1)).
- Frontend: [frontend](frontend) (entrada: [frontend/package.json](frontend/package.json#L1)).
- Scripts SQL / seeds: [backend/db](backend/db) (ver lista abajo).
- Orquestación Docker: [docker-compose.yml](docker-compose.yml).
- Documentación de despliegue: [README_DOCKER.md](README_DOCKER.md).

## Funcionalidades del Backend (APIs)
El backend expone rutas agrupadas por módulo bajo el prefijo `/api`.

- Autenticación y usuarios (`/api/auth`)
  - `POST /api/auth/login` — login con bcrypt + migración de contraseñas antiguas
  - `POST /api/auth/register` — crear usuario (hash de contraseña)
  - `POST /api/auth/change-password` — cambiar contraseña
  - `GET /api/auth/user/permissions` — obtener permisos del usuario (roles y permisos)
  - Archivo: [backend/routes/auth.js](backend/routes/auth.js#L1)

- Dashboard (`/api/dashboard`)
  - Estadísticas, gráficos, actividad y alertas del sistema.
  - Archivo: [backend/routes/dashboard.js](backend/routes/dashboard.js#L1)

- Productos (`/api/products`)
  - CRUD de productos, activar/desactivar, búsquedas y listado.
  - Archivo: [backend/routes/products.js](backend/routes/products.js#L1)

- Insumos / Supplies (`/api/supplies`) y Proveedores (`/api/suppliers`)
  - Gestión de insumos y proveedores, estado (`is_active`), categorías.
  - Archivos: [backend/routes/supplies.js](backend/routes/supplies.js#L1), [backend/routes/suppliers.js](backend/routes/suppliers.js#L1)

- Inventario (`/api/inventory`)
  - Consultas de stock, movimientos, ajustes y control de inventario.
  - Archivo: [backend/routes/inventory.js](backend/routes/inventory.js#L1)

- Órdenes (módulos varios)
  - Pedidos generales: [backend/routes/orders.js](backend/routes/orders.js#L1)
  - Órdenes de producción: [backend/routes/production-orders.js](backend/routes/production-orders.js#L1)
  - Órdenes de venta / ventas: [backend/routes/sales-orders.js](backend/routes/sales-orders.js#L1)

- Facturación (`/api/billing`)
  - Creación de facturas, filtros, vista de factura. Archivo: [backend/routes/billing.js](backend/routes/billing.js#L1)

- Clientes (`/api/customers`) y Empleados (`/api/employees`)
  - CRUD y gestión de relaciones con pedidos y facturas.
  - Archivos: [backend/routes/customers.js](backend/routes/customers.js#L1), [backend/routes/employees.js](backend/routes/employees.js#L1)

- Reportes (`/api/reports`)
  - Reportes de ventas, inventario, producción, resumen general. Archivo: [backend/routes/reports.js](backend/routes/reports.js#L1)

- Notificaciones (`/api/notifications`)
  - CRUD de notificaciones, marcar como leídas, conteo de no leídas.
  - El backend crea la tabla `notifications` si no existe y provee helper para crear notificaciones desde otros módulos.
  - Archivo: [backend/routes/notifications.js](backend/routes/notifications.js#L1)

- Caducidades / Expiry (`/api/expiry` + servicio)
  - Servicio que verifica productos e insumos próximos a vencer y crea alertas/entradas en `expiry_alerts` y `notifications`.
  - Funciones públicas: `checkExpiryDates(pool)` y `getExpirySummary(pool)` en [backend/routes/expiryService.js](backend/routes/expiryService.js#L1).

## Funcionalidades del Frontend
- Interfaz SPA en React (Vite) con rutas protegidas por JWT.
- Módulos principales en `frontend/src/components` incluyen:
  - Login, Dashboard, Productos, Insumos, Inventario, Órdenes, Producción, Proveedores, Clientes, Empleados, Reportes, Notificaciones, Ajustes.
- Comunicación con backend via `frontend/src/services/api.jsx` que usa `axios` y proxea a `/api` (espera que el servidor de producción exponga `/api` o que nginx lo proxee).

## Base de datos (scripts y seeds)
Los scripts SQL que están en `backend/db` se montan para inicializar MySQL en el primer arranque del contenedor. Archivos presentes:

- backend/db/init.sql
- backend/db/create_orders_tables.sql
- backend/db/create_supplies_tables.sql
- backend/db/seed_users.sql
- backend/db/seed_test_orders.sql
- backend/db/roles_permissions.sql
- backend/db/setup_role_permissions.sql
- backend/db/add_expiry_date.sql
- backend/db/add_must_change_password.sql
- backend/db/check_supplies_schema.sql
- backend/db/clean_images.sql

Nota: durante la inicialización del contenedor MySQL se detectó un error de sintaxis en `add_expiry_date.sql` (ver logs de `docker-compose logs db`). Revisar ese archivo antes de re-crear el volumen si se requiere.

## Autenticación y permisos
- Autenticación basada en JWT. Token generado en `auth/login` con `JWT_SECRET` (leer `process.env.JWT_SECRET`).
- Control de acceso a través de roles y permisos almacenados en tablas `roles`, `permissions`, `role_permissions` — se expone `GET /api/auth/user/permissions` para que el frontend cargue permisos.

## Gestión de archivos (uploads)
- El backend usa `multer` y sirve archivos estáticos desde la carpeta `uploads` (`app.use(express.static("uploads"))`).
- En Docker Compose, `./backend/uploads` se mapea al contenedor para persistencia.

## Notificaciones y tareas programadas
- El servidor configura tareas agendadas en `server.js`: comprobaciones periódicas (stock crítico, productos/insumos con stock bajo, caducidad) mediante funciones importadas de `notificationService.js` y `expiryService.js`.
- Las notificaciones se almacenan en la tabla `notifications` y se exponen via `/api/notifications`.

## Despliegue (Docker)
- Archivos creados: `Dockerfile` en `backend` y `frontend`, `nginx.conf` para servir el frontend y proxy `/api`, `docker-compose.yml` para orquestar `db`, `backend` y `frontend`. Ver: [docker-compose.yml](docker-compose.yml#L1) y [README_DOCKER.md](README_DOCKER.md#L1).
- Variables importantes (usar `.env` en la raíz):
  - `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `DB_PORT`, `PORT`.
- Notas:
  - Por seguridad y evitar conflictos, el `docker-compose.yml` por defecto no expone MySQL al host; el backend se conecta a la base por el nombre de servicio `db`.

## Cómo ejecutar localmente (rápido)
1. Copiar y ajustar variables: `cp .env.example .env` y editar según necesites.
2. Construir y levantar:
```bash
docker-compose up --build -d
```
3. Verificar:
```bash
docker-compose ps
docker-compose logs -f backend
```
4. Acceder:
  - Frontend: http://localhost:3000
  - Backend API: http://localhost:5000/api/health

## Notas de mantenimiento y problemas conocidos
- Error detectado: `add_expiry_date.sql` puede contener sintaxis no compatible con la versión de MySQL usada por la imagen oficial. Revisar y corregir antes de recrear el volumen `db_data`.
- Si necesitas reiniciar la BD limpia: `docker-compose down -v` (elimina volumen y datos).
- Logs útiles: `docker-compose logs -f db`, `docker-compose logs -f backend`.

## Dónde mirar el código
- Rutas backend: `backend/routes/` (módulos por responsabilidad)
- Inicialización y tareas programadas: `backend/server.js` ([backend/server.js](backend/server.js#L1))
- Servicios de notificaciones / caducidad: `backend/routes/notificationService.js`, `backend/routes/expiryService.js`.
- Frontend API wrapper: `frontend/src/services/api.jsx` ([frontend/src/services/api.jsx](frontend/src/services/api.jsx#L1)).

---

Si quieres, puedo:
- Generar una versión en inglés.
- Añadir un índice navegable (tabla de contenidos) y enlaces directos a endpoints concretos.
- Revisar y corregir el SQL problemático en `backend/db/add_expiry_date.sql` y volver a re-inicializar la BD en Docker.

Documento generado automáticamente para entrega técnica.
