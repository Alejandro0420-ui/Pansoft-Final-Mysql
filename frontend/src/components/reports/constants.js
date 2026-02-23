export const REPORT_TYPES = {
  SALES: "sales",
  SALES_ORDERS: "sales_orders",
  PRODUCTION_ORDERS: "production_orders",
  PRODUCTS: "products",
  EMPLOYEES: "employees",
  SUMMARY: "summary",
  INVENTORY: "inventory",
  CUSTOMERS: "customers",
};

export const STATUS_COLORS = {
  pendiente: "#F59E0B",
  completada: "#10B981",
  cancelada: "#EF4444",
  produccion: "#3B82F6",
};

export const STATUS_OPTIONS = [
  { value: "pendiente", label: "Pendiente" },
  { value: "completada", label: "Completada" },
  { value: "cancelada", label: "Cancelada" },
];

export const STOCK_STATUS_COLORS = {
  Bajo: "#EF4444",
  Medio: "#F59E0B",
  Suficiente: "#10B981",
};
