-- Seed data for table: orders
-- Extracted from: pansoft_db.sql

INSERT INTO `orders` (`id`, `order_number`, `customer_id`, `order_date`, `delivery_date`, `total_amount`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'ORD-2024-001', NULL, '2026-02-10 19:31:16', '2026-02-17', 2999.97, 'delivered', 'Entrega completada', '2026-02-10 19:31:16', '2026-02-10 19:31:16'),
(2, 'ORD-2024-002', NULL, '2026-02-10 19:31:16', '2026-02-15', 849.97, 'processing', 'En preparación', '2026-02-10 19:31:16', '2026-02-10 19:31:16'),
(3, 'ORD-2024-003', NULL, '2026-02-10 19:31:16', '2026-02-13', 3199.95, 'pending', 'Pendiente de pago', '2026-02-10 19:31:16', '2026-02-10 19:31:16');