-- Seed data for table: inventory_movements
-- Extracted from: pansoft_db.sql

INSERT INTO `inventory_movements` (`id`, `product_id`, `movement_type`, `quantity_change`, `previous_quantity`, `new_quantity`, `reason`, `notes`, `user_id`, `created_at`) VALUES
(18, 5, 'entrada', 20, 0, 20, 'Orden de producción #11 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-02-12 15:19:48'),
(19, 2, 'entrada', 9, 95, 104, 'Orden de producción #12 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-02-12 15:36:25'),
(20, 3, 'entrada', 6, 0, 6, 'Orden de producción #13 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-02-12 15:36:53'),
(21, 2, 'entrada', 4, 104, 108, 'Orden de producción #10 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-02-12 15:37:29'),
(22, 1, 'entrada', -158, 235, 77, 'Compra a proveedor', 'Movimiento desde interfaz - 12/2/2026, 2:35:20 p. m.', 1, '2026-02-12 19:35:20'),
(23, 1, 'salida', -4, 77, 73, 'Orden de venta #8 completada', 'Orden de venta \"8\" completada - Reducción de inventario', NULL, '2026-02-12 19:47:18'),
(24, 4, 'salida', -2, 7, 5, 'Orden de venta #8 completada', 'Orden de venta \"8\" completada - Reducción de inventario', NULL, '2026-02-12 19:47:18'),
(25, 1, 'entrada', 25, 73, 98, '', 'Movimiento desde interfaz - 15/2/2026, 7:37:49 p. m.', 1, '2026-02-16 00:37:49'),
(26, 2, 'salida', -105, 108, 3, 'Venta', 'Movimiento desde interfaz - 16/2/2026, 1:53:24 p. m.', 1, '2026-02-16 18:53:24'),
(27, 12, 'entrada', 25, 0, 25, 'Compra a proveedor\n', 'Movimiento desde interfaz - 16/2/2026, 14:52:51', 1, '2026-02-16 19:52:51'),
(28, 6, 'entrada', 2, 0, 2, 'Orden de producción #9 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-02-17 20:35:39'),
(29, 2, 'entrada', 20, 1, 21, '', 'Movimiento desde interfaz - 19/2/2026, 11:03:45 a. m.', 1, '2026-02-19 16:03:45'),
(30, 3, 'salida', -5, 5, 0, '', 'Movimiento desde interfaz - 22/2/2026, 4:13:01 p. m.', 1, '2026-02-22 21:13:01'),
(31, 2, 'salida', -1, 19, 18, 'Venta', 'Movimiento desde interfaz - 25/2/2026, 2:48:06 p. m.', 1, '2026-02-25 19:48:06'),
(32, 8, 'entrada', 20, 0, 20, 'Orden de producción #7 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-03-03 19:46:19'),
(33, 3, 'entrada', 5, 0, 5, 'Orden de producción #15 completada', 'Orden de producción finalizada - Entrada de inventario por producción completada', NULL, '2026-03-10 15:52:27');