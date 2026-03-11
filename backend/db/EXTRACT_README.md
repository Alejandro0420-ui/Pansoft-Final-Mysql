Extract schema and seed SQL from pansoft_db.sql

1) Ejecutar el script para dividir el dump en dos archivos:

```bash
python backend/db/split_dump.py
```

Salida:
- `backend/db/extracted/schema.sql`  -> contiene DDL, ALTERs, índices, etc.
- `backend/db/extracted/seed.sql`    -> contiene todos los `INSERT INTO` extraídos

2) Recomendaciones antes de aplicar en servidor remoto
- Haz backup del estado actual de la base de datos.
- Si vas a reemplazar la BD completa, elimina el volumen/BD y aplica `schema.sql` primero.

3) Comandos de ejemplo (ajusta usuario/host/contendor según tu entorno):

Copiar archivos al contenedor (ejemplo con contenedor `panasoft-db-1`):

```bash
docker cp backend/db/extracted/schema.sql panasoft-db-1:/tmp/schema.sql
docker cp backend/db/extracted/seed.sql panasoft-db-1:/tmp/seed.sql
```

Importar (ejecutar dentro del contenedor MySQL):

```bash
docker exec -it panasoft-db-1 bash -c "mysql -u'$DB_USER' -p'$DB_PASSWORD' $DB_NAME < /tmp/schema.sql"
docker exec -it panasoft-db-1 bash -c "mysql -u'$DB_USER' -p'$DB_PASSWORD' $DB_NAME < /tmp/seed.sql"
```

Si prefieres no afectar la BD en producción, crea una base nueva y aplica allí primero.

Notas:
- El script es conservador: separa líneas que comienzan con `INSERT INTO`.
- Revisa manualmente `schema.sql` para eliminar duplicados si ya tienes migraciones en `backend/db/`.
