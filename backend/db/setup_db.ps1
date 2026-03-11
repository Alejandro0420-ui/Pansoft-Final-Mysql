# =====================================================================
# SETUP DATABASE - PANSOFT (Windows/PowerShell)
# =====================================================================
# Script para instalar y configurar la base de datos
# Lee credenciales del archivo .env
#
# Uso (en PowerShell):
#   .\backend\db\setup_db.ps1
# 
# Nota: Asegúrate de ejecutar:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# =====================================================================

param(
    [string]$EnvFile = ".env"
)

# Colores
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"

Write-Host "================================================" -ForegroundColor $Yellow
Write-Host "  PANSOFT - Database Setup (Windows)" -ForegroundColor $Yellow
Write-Host "================================================" -ForegroundColor $Yellow

# =====================================================================
# 1. Leer variables del .env
# =====================================================================

if (-not (Test-Path $EnvFile)) {
    Write-Host "✗ Error: No se encontró $EnvFile en el directorio raíz" -ForegroundColor $Red
    exit 1
}

Write-Host "Leyendo configuración desde $EnvFile..." -ForegroundColor $Yellow

$env_vars = @{}
Get-Content $EnvFile | ForEach-Object {
    if ($_ -match '^\s*([^=]+)=(.*)$') {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        $env_vars[$key] = $value
    }
}

$DB_HOST = $env_vars["DB_HOST"] ?? "localhost"
$DB_PORT = $env_vars["DB_PORT"] ?? "3306"
$DB_NAME = $env_vars["DB_NAME"] ?? "pansoft_db"
$DB_USER = $env_vars["DB_USER"] ?? "pansoft_user"
$DB_PASSWORD = $env_vars["DB_PASSWORD"] ?? "Pansoft@2026"
$MYSQL_ROOT_PASSWORD = $env_vars["MYSQL_ROOT_PASSWORD"] ?? "Pansoft@2026"

Write-Host "✓ Configuración leída desde .env" -ForegroundColor $Green
Write-Host "  Host: $DB_HOST"
Write-Host "  Puerto: $DB_PORT"
Write-Host "  BD: $DB_NAME"
Write-Host "  Usuario: $DB_USER"

# =====================================================================
# 2. Verificar que MySQL esté disponible
# =====================================================================

Write-Host "`n`Verificando conexión con MySQL..." -ForegroundColor $Yellow

$max_attempts = 10
$attempt = 0

while ($attempt -lt $max_attempts) {
    try {
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection
        $connection.ConnectionString = "Server=$DB_HOST;Port=$DB_PORT;Uid=root;Pwd=$MYSQL_ROOT_PASSWORD;Connection Timeout=5"
        $connection.Open()
        $connection.Close()
        Write-Host "✓ MySQL está disponible" -ForegroundColor $Green
        break
    }
    catch {
        $attempt++
        Write-Host "  Intento $attempt/$max_attempts..."
        Start-Sleep -Seconds 2
    }
}

if ($attempt -eq $max_attempts) {
    Write-Host "✗ Error: No se puede conectar a MySQL en $DB_HOST`:$DB_PORT" -ForegroundColor $Red
    Write-Host "  Asegúrate de que MySQL esté ejecutándose" -ForegroundColor $Yellow
    exit 1
}

# =====================================================================
# 3. Crear base de datos y usuario
# =====================================================================

Write-Host "`nCreando base de datos y usuario..." -ForegroundColor $Yellow

$mysqlcmd = @"
CREATE DATABASE IF NOT EXISTS ``$DB_NAME`` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON ``$DB_NAME``.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
FLUSH PRIVILEGES;
"@

$mysqlcmd | mysql -h $DB_HOST -P $DB_PORT -u root -p"$MYSQL_ROOT_PASSWORD" 2>$null

Write-Host "✓ Base de datos creada" -ForegroundColor $Green

# =====================================================================
# 4. Ejecutar schema
# =====================================================================

Write-Host "`nEjecutando schema..." -ForegroundColor $Yellow

$schema_file = "backend\db\packaged\full_schema.sql"

if (-not (Test-Path $schema_file)) {
    Write-Host "✗ Error: No se encontró $schema_file" -ForegroundColor $Red
    Write-Host "  Ejecuta primero: python backend/db/package_schema_and_seed.py" -ForegroundColor $Yellow
    exit 1
}

Get-Content $schema_file | mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p"$DB_PASSWORD" $DB_NAME 2>$null

Write-Host "✓ Schema aplicado" -ForegroundColor $Green

# =====================================================================
# 5. Cargar seeds
# =====================================================================

Write-Host "`nCargando datos (seeds)..." -ForegroundColor $Yellow

$seeds_dir = "backend\db\seeds"
$seed_files = @(
    "roles.sql",
    "permissions.sql",
    "users.sql",
    "customers.sql",
    "suppliers.sql",
    "employees.sql",
    "products.sql",
    "supplies.sql",
    "inventory.sql",
    "orders.sql",
    "order_items.sql",
    "sales_orders.sql",
    "sales_order_items.sql",
    "production_orders.sql",
    "invoices.sql",
    "notifications.sql",
    "role_permissions.sql",
    "inventory_movements.sql",
    "sales_reports.sql"
)

foreach ($file in $seed_files) {
    $seed_file = Join-Path $seeds_dir $file
    if (Test-Path $seed_file) {
        Write-Host "  → Cargando $file..."
        Get-Content $seed_file | mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p"$DB_PASSWORD" $DB_NAME 2>$null
    }
    else {
        Write-Host "  ⚠ Seed no encontrado: $file" -ForegroundColor $Yellow
    }
}

Write-Host "✓ Seeds cargados" -ForegroundColor $Green

# =====================================================================
# 6. Mostrar resumen
# =====================================================================

Write-Host "`n================================================" -ForegroundColor $Green
Write-Host "✓ ¡BASE DE DATOS INSTALADA EXITOSAMENTE!" -ForegroundColor $Green
Write-Host "================================================" -ForegroundColor $Green
Write-Host ""
Write-Host "Conexión:"
Write-Host "  Host: $DB_HOST"
Write-Host "  Puerto: $DB_PORT"
Write-Host "  BD: $DB_NAME"
Write-Host "  Usuario: $DB_USER"
Write-Host ""
Write-Host "Proximospasos:"
Write-Host "  1. Inicia el backend: npm start"
Write-Host "  2. Inicia el frontend: npm run dev"
Write-Host "  3. Accede a: http://localhost:5173"
Write-Host ""
