-- Seed data for table: sales_orders
-- Extracted from: pansoft_db.sql

INSERT INTO `sales_orders` (`id`, `order_number`, `customer_id`, `customer_name`, `order_date`, `delivery_date`, `total_amount`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'VNT-2024-0001', 1, 'Panadería La Mansión', '2026-02-06 04:16:49', '2026-02-12', 185.50, 'completada', 'Entrega en progreso', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(2, 'VNT-2024-0002', 2, 'Supermercado El Centro', '2026-02-08 04:16:49', '2026-02-14', 425.75, 'pendiente', 'Esperando confirmación', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'VNT-2024-0003', NULL, 'Cafetería Premium', '2026-02-11 04:16:49', NULL, 230.00, 'completada', 'Nueva orden', '2026-02-11 04:16:49', '2026-02-12 19:57:17'),
(4, 'VNT-2024-0004', 4, 'Restaurante Casa Luis', '2026-02-10 04:16:49', '2026-02-11', 95.00, 'completada', 'Entregada', '2026-02-11 04:16:49', '2026-02-11 19:12:34'),
(5, 'VNT-2024-0005', 5, 'Tienda Gourmet', '2026-02-09 04:16:49', '2026-02-15', 750.25, 'completada', 'Aceptada', '2026-02-11 04:16:49', '2026-02-12 03:28:44'),
(6, 'VNT-2026-001', NULL, 'alejo', '2026-02-11 20:42:28', NULL, 8700.00, 'cancelada', NULL, '2026-02-11 20:42:28', '2026-02-12 15:18:13'),
(7, 'VNT-2026-011', NULL, 'Maria', '2026-02-12 15:34:50', '2026-02-12', 7500.00, 'cancelada', NULL, '2026-02-12 15:34:50', '2026-02-12 19:57:12'),
(8, 'VNT-2026-111', NULL, 'Santiago', '2026-02-12 19:46:49', '2026-02-12', 56000.00, 'completada', NULL, '2026-02-12 19:46:49', '2026-02-12 19:47:18'),
(9, 'VNT-2026-20241', NULL, 'Alexander', '2026-02-19 17:43:13', '2026-02-19', 11400.00, 'pending', NULL, '2026-02-19 17:43:13', '2026-02-19 17:43:13'),
(10, 'VNT-2026-202411', NULL, 'Thiago', '2026-02-25 20:31:26', '2026-02-25', 16300.00, 'pending', NULL, '2026-02-25 20:31:26', '2026-02-25 20:31:26'),
(11, 'VNT-2026-2024111', NULL, 'Mauricio', '2026-03-03 21:03:05', NULL, 89900.00, 'pending', NULL, '2026-03-03 21:03:05', '2026-03-03 21:15:33');