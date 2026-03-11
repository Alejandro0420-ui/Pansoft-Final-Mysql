-- Seed data for table: order_items
-- Extracted from: pansoft_db.sql

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `total`) VALUES
(1, 1, NULL, 2, 1.50, 3.00),
(2, 1, NULL, 5, 2.50, 12.50),
(3, 1, NULL, 10, 1.80, 18.00),
(4, 2, NULL, 2, 2.00, 4.00),
(5, 2, NULL, 3, 25.00, 75.00),
(6, 3, NULL, 2, 1.50, 3.00),
(7, 3, NULL, 1, 2.00, 2.00),
(8, 3, NULL, 25, 1.80, 45.00);