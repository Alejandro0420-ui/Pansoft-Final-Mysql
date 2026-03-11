# GUÍA RÁPIDA - Workflow de cambios en la BD

## 🎯 Escenarios Comunes

### 1️⃣ Agregar una nueva columna a una tabla

```bash
# 1. Modifica el archivo de schema correspondiente
#    Ejemplo: agregar deleted_at a users
#    Abre: backend/db/01_base_schema_mysql.sql

# 2. Agrega la columna en la definición de CREATE TABLE
# ALTER TABLE users ADD COLUMN deleted_at DATETIME NULL;

# 3. Regenera el schema consolidado
cd backend/db
python package_schema_and_seed.py

# 4. En local, aplica manualmente (dev)
mysql -u root -p pansoft_db < 01_base_schema_mysql.sql

# 5. Commit y push
git add 01_base_schema_mysql.sql packaged/full_schema.sql
git commit -m "feat: agregar deleted_at a tabla users"
git push
```

**En servidor (Docker):**
- El `setup_db.sh` automáticamente usará el schema actualizado
- O aplica la migración en vivo:
  ```bash
  docker exec pansoft-db mysql -u root -p$MYSQL_ROOT_PASSWORD pansoft_db < 06_add_soft_delete.sql
  ```

---

### 2️⃣ Cambiar un tipo de dato (INT a BIGINT)

```bash
# 1. Modifica el archivo base
# backend/db/01_base_schema_mysql.sql

# Cambia de:
# id INT AUTO_INCREMENT PRIMARY KEY

# A:
# id BIGINT AUTO_INCREMENT PRIMARY KEY

# 2. Regenera
cd backend/db
python package_schema_and_seed.py

# 3. En local
mysql -u root -p pansoft_db < 01_base_schema_mysql.sql

# 4. Commit
git add .
git commit -m "refactor: cambiar id a BIGINT en tabla products"
```

---

### 3️⃣ Guardar nuevos datos como seeds (después de trabajar en prod)

```bash
# 1. Exporta el dump de producción
# (desde tu hosting/servidor)

# 2. Copia pansoft_db.sql a backend/db/

# 3. Regenera los seeds
cd backend/db
python extract_seeds.py

# 4. Regenera schema
python package_schema_and_seed.py

# 5. Verifica qué cambió
git diff seeds/

# 6. Commit
git add seeds/ packaged/full_schema.sql
git commit -m "data: actualizar seeds con datos de producción"
git push
```

---

### 4️⃣ Agregar una tabla completamente nueva

```bash
# 1. Crea un nuevo archivo
# backend/db/07_add_notifications_table.sql

CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  action VARCHAR(50),
  table_name VARCHAR(50),
  record_id INT,
  old_values JSON,
  new_values JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 2. O agrégalo directamente a 01_base_schema_mysql.sql

# 3. Si necesitas seed data inicial, crea seeds/audit_logs.sql

# 4. Regenera
cd backend/db
python package_schema_and_seed.py

# 5. Commit
git add backend/db/
git commit -m "feat: agregar tabla audit_logs"
```

---

### 5️⃣ Renombrar una columna

```bash
# En MySQL, combina DROP + ADD para renombrar

# 1. Modifica el schema
# Abre: backend/db/01_base_schema_mysql.sql

# Opción 1: RENAME COLUMN (MySQL 8.0+)
ALTER TABLE products RENAME COLUMN old_name TO new_name;

# Opción 2: DROP + ADD (compatible con versiones antiguas)
ALTER TABLE products DROP COLUMN old_name;
ALTER TABLE products ADD COLUMN new_name VARCHAR(100);

# 2. Regenera
cd backend/db
python package_schema_and_seed.py

# 3. Aplica y commit
```

---

## ✅ Checklist para cambios en BD

- [ ] Edité el archivo `.sql` correcto (01_base_schema_mysql.sql o create_xxx.sql)
- [ ] Ejecuté `python package_schema_and_seed.py`
- [ ] Verifiqué el cambio en `packaged/full_schema.sql`
- [ ] Probé localmente: `mysql -u root -p pansoft_db < packaged/full_schema.sql`
- [ ] Hice commit con mensaje descriptivo
- [ ] Hice push a git
- [ ] En servidor/Docker, el `setup_db.sh` lo aplicará automáticamente

---

## 🚨 Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| "Can't create table" | Foreign key antes de crear tabla referenciada | Verifica el orden en `01_base_schema_mysql.sql` |
| "Duplicate column" | Correr script dos veces | Usa `IF NOT EXISTS` en los CREATE TABLE |
| "Constraint fails" | Seeds en orden incorrecto | No cambies el orden en `setup_db.sh` |
| "Unknown column" | Schema antiguo | Ejecuta `python package_schema_and_seed.py` |

---

## 📌 Archivos que NO debes modificar directamente

- `packaged/full_schema.sql` ← Se regenera automáticamente
- `seeds/*.sql` ← Se regeneran con `extract_seeds.py`

## 📝 Archivos que SÍ debes modificar

- `01_base_schema_mysql.sql` ← Schema base
- `create_supplies_tables.sql` ← Tablas de supplies
- `create_orders_tables.sql` ← Tablas de órdenes
- `roles_permissions.sql` ← Roles y permisos
- `add_*.sql` ← Migraciones específicas
