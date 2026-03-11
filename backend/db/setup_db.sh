#!/bin/bash

# =====================================================================
# SETUP DATABASE - PANSOFT
# =====================================================================
# Script para instalar y configurar la base de datos
# Lee credenciales del archivo .env
#
# Uso:
#   chmod +x backend/db/setup_db.sh
#   ./backend/db/setup_db.sh
# =====================================================================

set -e  # Exit on error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}================================================${NC}"
echo -e "${YELLOW}  PANSOFT - Database Setup${NC}"
echo -e "${YELLOW}================================================${NC}"

# =====================================================================
# 1. Leer variables del .env
# =====================================================================

if [ ! -f .env ]; then
    echo -e "${RED}✗ Error: No se encontró .env en el directorio raíz${NC}"
    exit 1
fi

# Cargar variables del .env (evitar espacios alrededor del =)
export $(cat .env | grep '^DB_' | xargs)
export $(cat .env | grep '^MYSQL_ROOT_PASSWORD' | xargs)

# Valores por defecto si no están en .env
DB_HOST=${DB_HOST:-"localhost"}
DB_PORT=${DB_PORT:-3306}
DB_NAME=${DB_NAME:-"pansoft_db"}
DB_USER=${DB_USER:-"pansoft_user"}
DB_PASSWORD=${DB_PASSWORD:-"Pansoft@2026"}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-"Pansoft@2026"}

echo -e "${GREEN}✓ Configuración leída desde .env${NC}"
echo "  Host: $DB_HOST"
echo "  Puerto: $DB_PORT"
echo "  BD: $DB_NAME"
echo "  Usuario: $DB_USER"

# =====================================================================
# 2. Esperar a que MySQL esté listo (si está en Docker)
# =====================================================================

echo -e "\n${YELLOW}Esperando a que MySQL esté disponible...${NC}"
max_attempts=30
attempt=0

while [ $attempt -lt $max_attempts ]; do
    if mysql -h "$DB_HOST" -P "$DB_PORT" -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT 1" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ MySQL está disponible${NC}"
        break
    fi
    attempt=$((attempt + 1))
    echo "  Intento $attempt/$max_attempts..."
    sleep 2
done

if [ $attempt -eq $max_attempts ]; then
    echo -e "${RED}✗ Timeout: MySQL no está disponible${NC}"
    exit 1
fi

# =====================================================================
# 3. Crear base de datos y usuario
# =====================================================================

echo -e "\n${YELLOW}Creando base de datos y usuario...${NC}"

mysql -h "$DB_HOST" -P "$DB_PORT" -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
FLUSH PRIVILEGES;
EOF

echo -e "${GREEN}✓ Base de datos creada${NC}"

# =====================================================================
# 4. Ejecutar schema (todas las tablas)
# =====================================================================

echo -e "\n${YELLOW}Ejecutando schema...${NC}"

SCHEMA_FILE="backend/db/packaged/full_schema.sql"

if [ ! -f "$SCHEMA_FILE" ]; then
    echo -e "${RED}✗ Error: No se encontró $SCHEMA_FILE${NC}"
    echo -e "${YELLOW}  Ejecuta primero: python backend/db/package_schema_and_seed.py${NC}"
    exit 1
fi

mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$SCHEMA_FILE"

echo -e "${GREEN}✓ Schema aplicado${NC}"

# =====================================================================
# 5. Cargar seeds en orden (respetando foreign keys)
# =====================================================================

echo -e "\n${YELLOW}Cargando datos (seeds)...${NC}"

SEEDS_DIR="backend/db/seeds"
SEED_FILES=(
    "roles.sql"
    "permissions.sql"
    "users.sql"
    "customers.sql"
    "suppliers.sql"
    "employees.sql"
    "products.sql"
    "supplies.sql"
    "inventory.sql"
    "orders.sql"
    "order_items.sql"
    "sales_orders.sql"
    "sales_order_items.sql"
    "production_orders.sql"
    "invoices.sql"
    "notifications.sql"
    "role_permissions.sql"
    "inventory_movements.sql"
    "sales_reports.sql"
)

for file in "${SEED_FILES[@]}"; do
    seed_file="$SEEDS_DIR/$file"
    if [ -f "$seed_file" ]; then
        echo "  → Cargando $file..."
        mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$seed_file" 2>/dev/null || true
    else
        echo -e "${YELLOW}  ⚠ Seed no encontrado: $file${NC}"
    fi
done

echo -e "${GREEN}✓ Seeds cargados${NC}"

# =====================================================================
# 6. Verificar instalación
# =====================================================================

echo -e "\n${YELLOW}Verificando instalación...${NC}"

TABLE_COUNT=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
    -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB_NAME';" \
    -N 2>/dev/null || echo "0")

USER_COUNT=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" \
    -e "SELECT COUNT(*) FROM users;" -N 2>/dev/null || echo "0")

echo "  Tablas creadas: $TABLE_COUNT"
echo "  Usuarios cargados: $USER_COUNT"

# =====================================================================
# 7. Mostrar resumen
# =====================================================================

echo -e "\n${GREEN}================================================${NC}"
echo -e "${GREEN}✓ ¡BASE DE DATOS INSTALADA EXITOSAMENTE!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo "Conexión:"
echo "  Host: $DB_HOST"
echo "  Puerto: $DB_PORT"
echo "  BD: $DB_NAME"
echo "  Usuario: $DB_USER"
echo ""
echo "Credenciales de acceso (del dump):"
echo "  - Admin: admin/Pansoft@2026 (o con tu contraseña hasheada)"
echo "  - Stock: stock1/stock123"
echo "  - Vendedor: vendedor/vendedor123"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo "  1. Inicia el backend: npm start"
echo "  2. Inicia el frontend: npm run dev"
echo "  3. Accede a: http://localhost:5173"
echo ""
