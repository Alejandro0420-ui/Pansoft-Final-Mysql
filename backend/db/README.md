# Base de Datos - Instrucciones de Instalación

## Estructura de Archivos

```
backend/db/
├── packaged/
│   └── full_schema.sql         # ✅ Schema completo (tablas + migraciones)
├── seeds/                      # ✅ Seeders (datos extraídos del dump)
│   ├── roles.sql
│   ├── permissions.sql
│   ├── users.sql
│   ├── customers.sql
│   ├── suppliers.sql
│   ├── employees.sql
│   ├── products.sql
│   ├── supplies.sql
│   ├── inventory.sql
│   ├── orders.sql
│   ├── order_items.sql
│   ├── sales_orders.sql
│   ├── sales_order_items.sql
│   ├── production_orders.sql
│   ├── invoices.sql
│   ├── notifications.sql
│   ├── role_permissions.sql
│   ├── inventory_movements.sql
│   └── sales_reports.sql
├── setup_db.sh                 # Script Linux/Mac para setup automático
├── setup_db.ps1                # Script Windows (PowerShell) para setup automático
└── Archivos de construcción:
    ├── 01_base_schema_mysql.sql         # Schema base MySQL (con tus modificaciones)
    ├── create_supplies_tables.sql       # Tabla supplies + supplies_movements
    ├── create_orders_tables.sql         # sales_orders + production_orders
    ├── roles_permissions.sql            # roles + permissions + relaciones
    ├── add_password_reset.sql           # Migración: reset_token
    ├── add_must_change_password.sql     # Migración: must_change_password
    ├── add_expiry_date.sql              # Migración: expiry_date + expiry_alerts
    ├── extract_seeds.py                 # Script para regenerar seeds desde pansoft_db.sql
    └── package_schema_and_seed.py       # Script para consolidar schema
```

---

## 🚀 Instalación Automática (RECOMENDADO)

### Linux/Mac:

```bash
# 1. Dale permisos de ejecución
chmod +x backend/db/setup_db.sh

# 2. Ejecuta el script (lee credenciales del .env automáticamente)
./backend/db/setup_db.sh
```

### Windows (PowerShell):

```powershell
# 1. Si es la primera vez, habilita scripts (ejecutar una sola vez)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 2. Ejecuta el script (lee credenciales del .env automáticamente)
.\backend\db\setup_db.ps1
```

El script:
- ✅ Lee BD, usuario, contraseña y host del `.env`
- ✅ Espera a que MySQL esté disponible
- ✅ Crea la BD y el usuario
- ✅ Aplica el schema completo
- ✅ Carga todos los seeds en orden
- ✅ Verifica que todo esté correcto

---

## 📋 Instalación Manual

Si prefieres hacerlo paso a paso:

```bash
# 1. Crear base de datos
mysql -u root -p -e "CREATE DATABASE pansoft_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 2. Ejecutar schema completo (todas las tablas + migraciones)
mysql -u root -p pansoft_db < backend/db/packaged/full_schema.sql

# 3. Cargar seeds en orden
cd backend/db/seeds

for file in roles.sql permissions.sql users.sql customers.sql suppliers.sql employees.sql products.sql supplies.sql inventory.sql orders.sql order_items.sql sales_orders.sql sales_order_items.sql production_orders.sql invoices.sql notifications.sql role_permissions.sql inventory_movements.sql sales_reports.sql; do
    echo "Cargando $file..."
    mysql -u root -p pansoft_db < "$file"
done
```

---

## 🔧 Características del Schema

- ✅ **Tabla users**: con `reset_token`, `reset_token_expires`, `must_change_password`, `role_id`
- ✅ **Tabla products**: con `expiry_date` e índice para búsquedas rápidas
- ✅ **Tabla supplies**: con `expiry_date`
- ✅ **Tabla expiry_alerts**: para alertas de caducidad
- ✅ **Roles y permisos**: sistema completo de control de acceso
- ✅ **Sales orders y production orders**: tablas separadas para pedidos
- ✅ **Índices**: optimizados para consultas comunes

---

## 🔄 Flujo de Actualización

### Caso 1: Agregar una nueva columna

Cuando necesites agregar una columna al schema (ej: agregar `deleted_at` a `users`):

```sql
-- 1. Crea un nuevo archivo de migración:
-- backend/db/06_add_soft_delete.sql

ALTER TABLE users ADD COLUMN deleted_at DATETIME NULL;

-- 2. Modifica 01_base_schema_mysql.sql directamente con los nuevos campos

-- 3. Regenera el schema consolidado
cd backend/db
python package_schema_and_seed.py

# 4. En producción, aplica solo esa migración:
mysql -u root -p pansoft_db < 06_add_soft_delete.sql

# O si es la primera instalación, ejecuta setup_db.sh (usará el schema actualizado)
```

### Caso 2: Modificar datos en el dump

Cuando hayas modificado datos en producción y quieras guardarlos como seeds:

```bash
# 1. Actualiza el dump con los datos nuevos
# (exporta desde tu base de datos en producción)

# 2. Regenera los seeds desde el dump
cd backend/db
python extract_seeds.py

# 3. Regenera el schema consolidado
python package_schema_and_seed.py

# 4. Commit cambios a git
git add seeds/ packaged/
git commit -m "Actualizar schema y seeds con nuevas modificaciones"
```

### Caso 3: Nueva instalación en servidor

```bash
# En Docker o servidor limpio:
cd backend/db

# 1. Asegúrate de que el schema consolidado está actualizado
python package_schema_and_seed.py

# 2. Ejecuta el setup
./setup_db.sh  # Linux/Mac
# o
.\setup_db.ps1 # Windows
```

---

## 🔌 Docker - Integración automática

### En `docker-compose.yml`:

```yaml
services:
  app:
    build: ./backend
    environment:
      - DB_HOST=db
      - DB_PORT=3306
      - DB_NAME=pansoft_db
      - DB_USER=pansoft_user
      - DB_PASSWORD=Pansoft@2026
      - MYSQL_ROOT_PASSWORD=Pansoft@2026
    depends_on:
      db:
        condition: service_healthy
    command: sh -c "backend/db/setup_db.sh && npm start"
    
  db:
    image: mysql:8.0
    environment:
      - MYSQL_DATABASE=pansoft_db
      - MYSQL_USER=pansoft_user
      - MYSQL_PASSWORD=Pansoft@2026
      - MYSQL_ROOT_PASSWORD=Pansoft@2026
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      timeout: 20s
      retries: 10
```

De esta forma, al levantar Docker automáticamente:
1. ✅ Se crea la BD
2. ✅ Se aplica el schema
3. ✅ Se cargan los seeds
4. ✅ Se inicia la aplicación

---

## 🐛 Troubleshooting

### Error: "MySQL no está disponible"
```bash
# Verifica que MySQL está corriendo
mysql -u root -p -e "SELECT 1"

# Si está en Docker
docker ps | grep mysql
```

### Error: "No se encontró full_schema.sql"
```bash
# Regenera el schema consolidado
cd backend/db
python package_schema_and_seed.py
```

### Error: "Foreign key constraint fails"
- Esto significa que el orden de los seeds es incorrecto
- Los scripts ya tienen el orden correcto, no cambies el orden

### Error: "Access denied for user"
```bash
# Verifica las credenciales en .env
cat .env | grep DB_

# Si estás en Docker, verifica docker-compose.yml
```

---

## 📊 Resumen de Scripts

| Archivo | Propósito |
|---------|-----------|
| `setup_db.sh` | Setup automático en Linux/Mac |
| `setup_db.ps1` | Setup automático en Windows |
| `package_schema_and_seed.py` | Consolidar scripts en `full_schema.sql` |
| `extract_seeds.py` | Extraer seeds del dump `pansoft_db.sql` |
| `01_base_schema_mysql.sql` | Schema base con tus modificaciones |
| `create_supplies_tables.sql` | Tablas de supplies |
| `create_orders_tables.sql` | Tablas de órdenes |
| `roles_permissions.sql` | Roles y permisos |
| `add_*.sql` | Migraciones (campos adicionales) |

---

## 📝 Notas Importantes

- Los **seeds contienen datos de producción** (extraídos del dump)
- El **orden de los seeds es crítico** por las foreign keys
- El schema incluye todas tus **modificaciones** (reset_token, must_change_password, expiry_date, role_id, etc.)
- Los **índices** están configurados para optimizar las búsquedas comunes
- **Siempre** regenera `full_schema.sql` después de modificar los scripts base
- **Siempre** extrae nuevos seeds después de trabajar con datos en producción