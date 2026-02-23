# 🎨 Cambios de Colores según Psicología del Color

## Resumen

Se han actualizado todos los colores de alerta y estado en la aplicación siguiendo principios de **psicología del color** para mejorar la comunicación visual y la experiencia del usuario.

---

## 📋 Principios de Psicología del Color Aplicados

| Color                          | Significado                            | Uso                                     |
| ------------------------------ | -------------------------------------- | --------------------------------------- |
| 🟢 **Verde** (#10B981)         | Éxito, aprobación, correcto            | Completada, Entregada, Stock Suficiente |
| 🔵 **Azul** (#3B82F6, #0EA5E9) | Información, confianza, procesamiento  | En Proceso, Confirmada, Producción      |
| 🟡 **Ámbar** (#F59E0B)         | Advertencia, atención, requiere acción | Pendiente, Stock Bajo, Atención         |
| 🔴 **Rojo** (#EF4444)          | Crítico, cancelado, peligro            | Cancelada, Stock Crítico, Vencida       |
| ⚪ **Gris** (#6B7280)          | Inactivo, neutral                      | Deshabilitado                           |

---

## 🔄 Cambios Realizados

### 1. **Orders (Órdenes)**

📁 `frontend/src/components/orders/constants.js`

#### STATUS_COLORS actualizado:

| Estado         | Color Anterior | Color Nuevo | Psicología                 |
| -------------- | -------------- | ----------- | -------------------------- |
| Completada     | #EBCC83        | **#10B981** | Verde = éxito              |
| Pendiente      | #EBA94D        | **#F59E0B** | Ámbar = requiere atención  |
| En Proceso     | #EA7028        | **#3B82F6** | Azul = acción en curso     |
| Confirmada     | #3498DB        | **#0EA5E9** | Azul cielo = confirmación  |
| En Preparación | #EA7028        | **#3B82F6** | Azul = acción              |
| Lista          | #2ECC71        | **#10B981** | Verde = completada         |
| Entregada      | #27AE60        | **#059669** | Verde oscuro = completitud |
| Cancelada      | #6C757D        | **#EF4444** | Rojo = cancelación         |

---

### 2. **Reports (Reportes)**

📁 `frontend/src/components/reports/constants.js`

#### STATUS_COLORS:

| Estado     | Color Anterior | Color Nuevo |
| ---------- | -------------- | ----------- |
| Pendiente  | #ff9800        | **#F59E0B** |
| Completada | #4caf50        | **#10B981** |
| Cancelada  | #f44336        | **#EF4444** |
| Producción | #2196f3        | **#3B82F6** |

#### STOCK_STATUS_COLORS:

| Estado     | Color Anterior | Color Nuevo |
| ---------- | -------------- | ----------- |
| Bajo       | #f44336        | **#EF4444** |
| Medio      | #ff9800        | **#F59E0B** |
| Suficiente | #4caf50        | **#10B981** |

---

### 3. **Inventario (Productos y Supplies)**

📁 `frontend/src/components/inventory.jsx`
📁 `frontend/src/components/ProductsSection.jsx`
📁 `frontend/src/components/SuppliesSection.jsx`

#### getStatusBadge/getStockStatus:

| Estado    | Color Anterior | Color Nuevo |
| --------- | -------------- | ----------- |
| Crítico   | #DC3545        | **#EF4444** |
| Bajo      | #EBA94D        | **#F59E0B** |
| Normal/OK | #EBCC83        | **#10B981** |

#### Iconos de Stock Crítico:

- **Color anterior:** #EBCC83
- **Color nuevo:** #EF4444 (rojo)

---

### 4. **Facturas (Billing)**

📁 `frontend/src/components/billing/InvoiceTable.jsx`
📁 `frontend/src/components/billing/InvoiceViewModal.jsx`

#### Estado de Pago:

| Estado    | Color Anterior | Color Nuevo | Psicología                |
| --------- | -------------- | ----------- | ------------------------- |
| Pagada    | #EBA94D        | **#10B981** | Verde = pagada/completada |
| Pendiente | #EBCC83        | **#F59E0B** | Ámbar = requiere pago     |
| Vencida   | #EA7028        | **#EF4444** | Rojo = crítico/vencido    |

---

### 5. **Notificaciones**

📁 `frontend/src/components/notifications.jsx`

#### Colores de Tipos de Notificación:

| Tipo      | Color Anterior | Color Nuevo |
| --------- | -------------- | ----------- |
| Inventory | #FFD93D        | **#F59E0B** |
| Order     | #4ECDC4        | **#3B82F6** |
| Success   | #51CF66        | **#10B981** |
| Warning   | #FF6B6B        | **#EF4444** |
| Info      | #6C5CE7        | **#0EA5E9** |
| Default   | #95A5A6        | **#6B7280** |

---

## ✅ Beneficios de los Cambios

### Mejora en Experiencia del Usuario:

- ✓ **Consistencia visual:** Todos los estados siguen la misma lógica cromática
- ✓ **Accesibilidad:** Colores más vibrantes y fáciles de distinguir
- ✓ **Intuitividad:** Los usuarius reconocen inmediatamente el estado sin leer etiquetas
- ✓ **Psicología:** Comunica el "sentimiento" del estado (urgencia, éxito, etc.)

### Jerarquía Visual Clara:

- 🔴 **Rojo** = Acción inmediata requerida (Crítico, Vencido, Cancelado)
- 🟡 **Ámbar** = Atención necesaria (Bajo, Pendiente)
- 🟢 **Verde** = Bien, completado
- 🔵 **Azul** = En progreso, información

---

## 🎯 Paleta de Colores Estándar

```css
--color-success: #10b981; /* Verde - Éxito/Completado */
--color-warning: #f59e0b; /* Ámbar - Advertencia/Atención */
--color-danger: #ef4444; /* Rojo - Crítico/Cancelado */
--color-info: #3b82f6; /* Azul - Información/Procesando */
--color-info-light: #0ea5e9; /* Azul Claro - Confirmación */
--color-gray: #6b7280; /* Gris - Inactivo/Neutral */
```

---

## 📝 Recomendaciones Futuras

1. **Agregar a constantes globales:** Crear un archivo `frontend/src/styles/colorScheme.js` con todos estos colores
2. **Variables CSS:** Usar CSS variables para facilitar cambios futuros
3. **Tema oscuro:** Adaptar estos colores para modo oscuro (colores más claros)
4. **Accesibilidad:** Mantener suficiente contraste (WCAG AA mínimo)

---

## 📊 Cambios por Componente

### Archivos Modificados:

```
✅ frontend/src/components/orders/constants.js
✅ frontend/src/components/reports/constants.js
✅ frontend/src/components/inventory.jsx
✅ frontend/src/components/ProductsSection.jsx
✅ frontend/src/components/SuppliesSection.jsx
✅ frontend/src/components/billing/InvoiceTable.jsx
✅ frontend/src/components/billing/InvoiceViewModal.jsx
✅ frontend/src/components/notifications.jsx
```

**Total de cambios:** 8 archivos actualizados ✓

---

_Actualizado: Febrero 22, 2026_
