Generar archivos consolidados de esquema y seed

Ejecuta este script para crear:

- `backend/db/packaged/full_schema.sql` — todas las instrucciones DDL ordenadas
- `backend/db/packaged/full_seed.sql` — todos los INSERTs/seeders concatenados

Comandos:

```bash
python backend/db/package_schema_and_seed.py
```

Revisa los archivos generados antes de aplicarlos en producción. Haz backup primero.
