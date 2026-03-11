-- Seed data for table: customers
-- Extracted from: pansoft_db.sql

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`, `city`, `country`, `customer_type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Panadería La Mansión', 'info@lamansion.com', '+34-91-3333333', 'Calle Mayor 100', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(2, 'Supermercado El Centro', 'compras@elcentro.com', '+34-91-4444444', 'Avenida Central 250', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'Cafetería Premium', 'gerencia@cafepremo.com', '+34-91-5555555', 'Plaza del Sol 50', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(4, 'Restaurante Casa Luis', 'pedidos@casaluis.com', '+34-91-6666666', 'Calle Goya 75', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(5, 'Tienda Gourmet', 'ventas@tiendagourmet.com', '+34-91-7777777', 'Paseo Recoletos 42', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'Cliente Prueba', 'cliente@test.com', '123456', NULL, 'Bogotá', NULL, NULL, 'active', '2026-03-02 18:34:50', '2026-03-02 18:34:50');