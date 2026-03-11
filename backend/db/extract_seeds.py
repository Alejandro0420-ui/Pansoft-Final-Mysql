#!/usr/bin/env python3
"""
Extrae los INSERTs del dump pansoft_db.sql y los separa en archivos individuales por tabla.
Esto permite usar el schema de los scripts y la data del dump como seeders.

Usage:
  python backend/db/extract_seeds.py
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent
DUMP_FILE = ROOT / 'pansoft_db.sql'
SEEDS_DIR = ROOT / 'seeds'
SEEDS_DIR.mkdir(exist_ok=True)

# Tablas que tienen datos en el dump
TABLES_WITH_DATA = [
    'customers',
    'employees', 
    'inventory',
    'inventory_movements',
    'invoices',
    'notifications',
    'orders',
    'order_items',
    'permissions',
    'production_orders',
    'products',
    'roles',
    'role_permissions',
    'sales_orders',
    'sales_order_items',
    'sales_reports',
    'suppliers',
    'supplies',
    'users'
]

def extract_inserts(dump_content: str, table_name: str) -> str:
    """Extrae todos los INSERT para una tabla específica."""
    # Patrón para encontrar INSERT INTO tabla (...) VALUES ...;
    # Incluye el ; al final
    pattern = rf"INSERT INTO `{table_name}`.+?;"
    
    matches = re.findall(pattern, dump_content, re.IGNORECASE | re.DOTALL)
    
    if not matches:
        # Intentar sin comillas invertidas
        pattern2 = rf"INSERT INTO {table_name}.+?;"
        matches = re.findall(pattern2, dump_content, re.IGNORECASE | re.DOTALL)
    
    # Unir y limpiar duplicados de ;
    result = '\n\n'.join(matches)
    result = result.replace(';;', ';')
    return result

def main():
    if not DUMP_FILE.exists():
        print(f"ERROR: No se encontró {DUMP_FILE}")
        return
    
    print(f"Leyendo dump: {DUMP_FILE}")
    with open(DUMP_FILE, 'r', encoding='utf-8', errors='ignore') as f:
        dump_content = f.read()
    
    print(f"Extrayendo seeds para {len(TABLES_WITH_DATA)} tablas...\n")
    
    for table in TABLES_WITH_DATA:
        inserts = extract_inserts(dump_content, table)
        
        if inserts:
            output_file = SEEDS_DIR / f'{table}.sql'
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(f"-- Seed data for table: {table}\n")
                f.write(f"-- Extracted from: pansoft_db.sql\n\n")
                f.write(inserts.rstrip())  # Sin strip para mantener estructura, solo quitar espacios extra
            print(f"  ✓ {table}.sql")
        else:
            print(f"  ✗ {table}.sql (sin datos)")
    
    print(f"\n✓ Seeds extraídos en: {SEEDS_DIR}/")
    print("\nArchivos generados:")
    for f in sorted(SEEDS_DIR.glob('*.sql')):
        print(f"  - {f.name}")

if __name__ == '__main__':
    main()