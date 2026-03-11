# Despliegue con Docker (Pansoft)

Resumen rápido:

- El stack consiste en: MySQL, Backend (Node/Express) y Frontend (React build servido por nginx).
- Ejecutar: `docker-compose up --build` desde la raíz del repo.

Pasos detallados:

1) Preparar variables de entorno

  - Copiar `.env.example` a `.env` y ajustar si es necesario.

2) Construir y levantar servicios

  - Asegurarse Docker y Docker Compose están activos.
  - Ejecutar:

```bash
docker-compose up --build -d
```

3) Puntos de acceso

  - Frontend: http://localhost:3000
  - Backend API: http://localhost:5000 (el frontend proxeará `/api` automáticamente)
  - MySQL: puerto 3306 (credenciales en `.env` o en docker-compose)

4) Inicialización de la Base de Datos

  - Los scripts SQL ubicados en `backend/db` se montan en `/docker-entrypoint-initdb.d` de MySQL y se ejecutan solo la primera vez que se crea el volumen de datos.
  - El backend también ejecuta migraciones/alteraciones adicionales al arrancar.

5) Persistencia

  - Subidas/imagenes están mapeadas a `./backend/uploads` para persistir archivos.
  - Datos de MySQL persisten en el volumen `db_data`.

Notas y ajustes comunes:

- Si necesita cambiar el puerto público, editar `docker-compose.yml`.
- Si desea que el backend sirva el `dist` del frontend en la misma imagen, hay que copiar la carpeta `frontend/dist` dentro de `backend/dist` y ajustar la configuración — la configuración actual separa frontend y backend para mayor claridad.

Problemas frecuentes:

- Si MySQL no inicia por uso previo del volumen, limpiar volumen con `docker-compose down -v` (pierde datos).
- Revisar logs con `docker-compose logs -f backend` y `docker-compose logs -f db`.
