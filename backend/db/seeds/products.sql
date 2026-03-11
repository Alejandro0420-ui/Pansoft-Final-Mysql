-- Seed data for table: products
-- Extracted from: pansoft_db.sql

INSERT INTO `products` (`id`, `name`, `sku`, `description`, `category`, `price`, `stock_quantity`, `min_stock_level`, `image_url`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Pan Francés', 'PAN-001', '', 'Panes', 2500.00, 83, 50, NULL, 1, '2026-02-11 04:16:49', '2026-03-03 20:36:52'),
(2, 'Pan Integral', 'PAN-002', '', 'Panes', 3500.00, 18, 40, NULL, 1, '2026-02-11 04:16:49', '2026-02-25 19:48:06'),
(3, 'Croissants', 'PAS-001', '', 'Pastelería', 1200.00, 5, 30, NULL, 1, '2026-02-11 04:16:49', '2026-03-10 15:52:27'),
(4, 'Torta de Chocolate', 'TOR-001', '', 'Tortas', 15000.00, 3, 5, NULL, 1, '2026-02-11 04:16:49', '2026-02-23 15:58:34'),
(5, 'Donas Glaseadas', 'DON-001', '', 'Donas', 2500.00, 15, 40, NULL, 1, '2026-02-11 04:16:49', '2026-02-17 21:13:07'),
(6, 'Galletas de Mantequilla', 'GAL-001', NULL, 'Galletas', 800.00, 0, 30, NULL, 1, '2026-02-11 04:16:49', '2026-02-23 15:58:34'),
(7, 'Muffins de Arándanos', 'MUF-001', '', 'Muffins', 1800.00, 0, 25, NULL, 1, '2026-02-11 04:16:49', '2026-02-23 15:58:34'),
(8, 'Empanadas de Pollo', 'EMP-001', '', 'Salados', 800.00, 20, 50, NULL, 1, '2026-02-11 04:16:49', '2026-03-03 19:46:19'),
(9, 'Brownie de Chocolate', 'BRO-001', '', 'Postres', 5000.00, 60, 20, NULL, 1, '2026-02-11 04:16:49', '2026-02-12 18:43:30'),
(10, 'Pan de chocolate', 'PAN-008', 'Pan artesanal relleno de chocolate', 'Panes', 15000.00, 10, 5, NULL, 0, '2026-02-11 04:16:49', '2026-02-16 21:04:20'),
(11, 'Pan de Arequipe', 'PAN-77', '', 'Panes', 2000.00, 50, 10, NULL, 0, '2026-02-12 19:39:19', '2026-02-12 19:39:56'),
(12, 'Solterita', 'SOL-001', '', 'Pastelería', 2500.00, 24, 20, NULL, 1, '2026-02-16 18:14:20', '2026-03-03 21:19:13'),
(13, 'Pan de queso', 'PAN-0010', 'pAN D', 'Panes', 2500.00, 60, 10, NULL, 1, '2026-02-16 21:14:56', '2026-02-16 21:14:56'),
(14, 'Pastel 3 leches', 'PAS-002', 'Pastel artesanal de 3 leches', 'Pastelería', 15000.00, 20, 10, '/images/image-1771352444859-131714232.jpg', 0, '2026-02-17 18:20:44', '2026-02-17 20:44:51'),
(15, 'Pan Agridulce', 'PAN-004', 'Pan artesanal Agridulce', 'Panes', 1000.00, 15, 5, NULL, 1, '2026-02-17 18:28:39', '2026-02-17 20:42:54'),
(16, 'Pan de maiz', 'PAN-003', 'Pan artesanal de maiz', 'Panes', 1500.00, 15, 5, NULL, 1, '2026-02-17 18:38:44', '2026-02-17 18:38:44'),
(17, 'Pastel de Bocadillo', 'PAN-005', 'Pan artesanal de arequipe', 'Pastelería', 1500.00, 20, 10, NULL, 1, '2026-02-17 18:43:50', '2026-02-17 18:43:50'),
(18, 'Pan de Aceite', 'PAN-ACEITE-001', NULL, 'Panadería', 5000.00, 50, 10, NULL, 1, '2026-03-02 18:34:50', '2026-03-02 18:34:50');