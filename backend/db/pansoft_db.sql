-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-03-2026 a las 00:51:33
-- Versión del servidor: 9.6.0
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pansoft_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`, `city`, `country`, `customer_type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Panadería La Mansión', 'info@lamansion.com', '+34-91-3333333', 'Calle Mayor 100', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(2, 'Supermercado El Centro', 'compras@elcentro.com', '+34-91-4444444', 'Avenida Central 250', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'Cafetería Premium', 'gerencia@cafepremo.com', '+34-91-5555555', 'Plaza del Sol 50', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(4, 'Restaurante Casa Luis', 'pedidos@casaluis.com', '+34-91-6666666', 'Calle Goya 75', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(5, 'Tienda Gourmet', 'ventas@tiendagourmet.com', '+34-91-7777777', 'Paseo Recoletos 42', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'Cliente Prueba', 'cliente@test.com', '123456', NULL, 'Bogotá', NULL, NULL, 'active', '2026-03-02 18:34:50', '2026-03-02 18:34:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `first_name`, `last_name`, `email`, `phone`, `position`, `department`, `hire_date`, `salary`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Juan', 'Rodríguez', 'juan@pansoft.com', '3102122523', 'panadero', 'Producción', '2023-01-15', 0.00, NULL, '2026-02-11 04:16:49', '2026-02-16 18:55:09'),
(2, 'María', 'García', 'maria@pansoft.com', '3122255652', 'panadero', NULL, '2023-02-20', NULL, 'active', '2026-02-11 04:16:49', '2026-03-10 15:54:12'),
(3, 'Carlos', 'López', 'carlos@pansoft.com', '+34-91-3333333', 'encargado_ventas', 'Producción', '2023-03-10', 0.00, NULL, '2026-02-11 04:16:49', '2026-02-17 20:45:43'),
(4, 'Ana', 'Martínez', 'ana@pansoft.com', '3152254555', 'encargado_ventas', NULL, '2023-04-05', NULL, 'active', '2026-02-11 04:16:49', '2026-03-10 15:37:26'),
(5, 'Pedro', 'Sánchez', 'pedro@pansoft.com', '3102254589', 'encargado_ventas', NULL, '2022-06-01', NULL, 'active', '2026-02-11 04:16:49', '2026-03-10 15:41:31'),
(8, 'Alejandro', 'Buritica', 'alejandrob0420@gmail.com', '313544597', 'supervisor_stock', NULL, '2026-02-12', NULL, 'active', '2026-02-12 19:16:48', '2026-03-10 15:41:53'),
(10, 'Juan', 'Pérez', 'juan@test.com', NULL, 'Panadero', 'Producción', NULL, NULL, 'active', '2026-03-09 21:27:00', '2026-03-09 21:27:00'),
(11, 'Orlando ', 'Duque', 'Orland@gmail.com', '3112522456', 'supervisor_stock', NULL, '2026-04-20', NULL, 'active', '2026-03-10 15:59:01', '2026-03-10 15:59:01'),
(12, 'Carolina', 'Cepeda', 'caro76@gmail.com', '3102544787', 'encargado_ventas', NULL, '2026-04-02', NULL, 'active', '2026-03-10 16:28:25', '2026-03-10 16:28:25'),
(13, 'Laura', 'Acosta', 'Laura@gmail.com', '3012124554', 'encargado_ventas', NULL, '2026-03-01', NULL, 'active', '2026-03-10 16:35:05', '2026-03-10 16:35:05'),
(14, 'Catalina', 'Gomez', 'cata@gmail.com', '315569658', 'encargado_ventas', NULL, '2026-04-20', NULL, 'active', '2026-03-10 21:35:08', '2026-03-10 21:35:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'kg',
  `stock_quantity` decimal(10,2) DEFAULT '0.00',
  `min_stock_level` decimal(10,2) DEFAULT '10.00',
  `unit_price` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory`
--

CREATE TABLE `inventory` (
  `id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `warehouse_location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `warehouse_location`, `quantity`, `last_updated`) VALUES
(1, 1, 'Almacén Principal', 83, '2026-03-03 20:36:52'),
(7, 7, 'Almacén Principal', 0, '2026-02-23 15:58:34'),
(8, 8, 'Almacén Principal', 20, '2026-03-03 19:46:19'),
(11, 2, 'Almacén Principal', 18, '2026-02-25 19:48:06'),
(14, 4, 'Almacén Principal', 3, '2026-02-23 15:58:34'),
(15, 3, 'Almacén Principal', 5, '2026-03-10 15:52:27'),
(16, 10, 'Almacén Principal', 0, '2026-02-12 03:28:44'),
(17, 5, 'Almacén Principal', 15, '2026-02-17 21:13:07'),
(18, 12, 'Almacén Principal', 24, '2026-02-23 15:58:34'),
(19, 6, 'Almacén Principal', 0, '2026-02-23 15:58:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory_movements`
--

CREATE TABLE `inventory_movements` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `movement_type` enum('entrada','salida','ajuste','devolución') DEFAULT 'ajuste',
  `quantity_change` int NOT NULL,
  `previous_quantity` int DEFAULT NULL,
  `new_quantity` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `notes` longtext,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `inventory_movements`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoices`
--

CREATE TABLE `invoices` (
  `id` int NOT NULL,
  `invoice_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT '0.00',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invoices`
--

INSERT INTO `invoices` (`id`, `invoice_number`, `order_id`, `customer_id`, `issue_date`, `due_date`, `total_amount`, `paid_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'INV-2024-001', 1, NULL, '2026-02-10', '2026-03-12', 2999.97, NULL, 'paid', '2026-02-10 19:31:16', '2026-02-10 21:14:33'),
(2, 'INV-2024-002', 2, NULL, '2026-02-10', '2026-03-12', 849.97, NULL, 'pending', '2026-02-10 19:31:16', '2026-02-10 20:54:48'),
(3, 'INV-2024-003', 3, NULL, '2026-02-10', '2026-03-12', 3199.95, NULL, 'paid', '2026-02-10 19:31:16', '2026-02-10 21:14:35'),
(4, 'FAC-1770758090294', NULL, NULL, '2026-02-10', '2026-02-10', 4500.00, 0.00, 'pending', '2026-02-10 21:15:39', '2026-02-10 21:15:39'),
(5, 'FAC-1770758149791', NULL, NULL, '2026-02-10', '2026-02-09', 450000.00, 0.00, 'pending', '2026-02-10 21:16:22', '2026-02-10 21:16:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `title`, `message`, `icon`, `color`, `is_read`, `user_id`, `created_at`, `updated_at`) VALUES
(241, 'inventory', 'Producto con stock bajo', 'Donas Glaseadas tiene solo 15 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(242, 'warning', 'Stock crítico', 'Croissants tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(244, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(245, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(247, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(248, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-04 20:33:29', '2026-03-04 20:33:29'),
(249, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 0, NULL, '2026-03-04 20:33:30', '2026-03-04 20:33:30'),
(251, 'warning', 'Stock crítico', 'Croissants tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-09 18:15:51', '2026-03-09 18:15:51'),
(252, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-09 18:15:51', '2026-03-09 18:15:51'),
(253, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-09 18:15:51', '2026-03-09 18:15:51'),
(254, 'inventory', 'Producto con stock bajo', 'Donas Glaseadas tiene solo 15 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-09 18:16:21', '2026-03-09 18:16:21'),
(255, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 0, NULL, '2026-03-09 18:16:21', '2026-03-09 18:16:21'),
(256, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-09 18:16:21', '2026-03-09 18:16:21'),
(257, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 0, NULL, '2026-03-09 18:16:21', '2026-03-09 18:16:21'),
(262, 'inventory', 'Producto con stock bajo', 'Donas Glaseadas tiene solo 15 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 15:32:56', '2026-03-10 15:32:56'),
(263, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 15:32:56', '2026-03-10 15:32:56'),
(264, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 15:32:56', '2026-03-10 15:32:56'),
(265, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 15:32:56', '2026-03-10 15:32:56'),
(270, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-10 18:17:35', '2026-03-10 18:17:35'),
(271, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-10 18:17:35', '2026-03-10 18:17:35'),
(272, 'warning', 'Stock crítico', 'Croissants tiene solo 5 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-10 18:17:35', '2026-03-10 18:17:35'),
(273, 'inventory', 'Producto con stock bajo', 'Donas Glaseadas tiene solo 15 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 21:32:56', '2026-03-10 21:32:56'),
(274, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 21:32:56', '2026-03-10 21:32:56'),
(275, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 21:32:56', '2026-03-10 21:32:56'),
(276, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 0, NULL, '2026-03-10 21:32:56', '2026-03-10 21:32:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `notes` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `customer_id`, `order_date`, `delivery_date`, `total_amount`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'ORD-2024-001', NULL, '2026-02-10 19:31:16', '2026-02-17', 2999.97, 'delivered', 'Entrega completada', '2026-02-10 19:31:16', '2026-02-10 19:31:16'),
(2, 'ORD-2024-002', NULL, '2026-02-10 19:31:16', '2026-02-15', 849.97, 'processing', 'En preparación', '2026-02-10 19:31:16', '2026-02-10 19:31:16'),
(3, 'ORD-2024-003', NULL, '2026-02-10 19:31:16', '2026-02-13', 3199.95, 'pending', 'Pendiente de pago', '2026-02-10 19:31:16', '2026-02-10 19:31:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_items`
--

CREATE TABLE `order_items` (
  `id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `total`) VALUES
(1, 1, NULL, 2, 1.50, 3.00),
(2, 1, NULL, 5, 2.50, 12.50),
(3, 1, NULL, 10, 1.80, 18.00),
(4, 2, NULL, 2, 2.00, 4.00),
(5, 2, NULL, 3, 25.00, 75.00),
(6, 3, NULL, 2, 1.50, 3.00),
(7, 3, NULL, 1, 2.00, 2.00),
(8, 3, NULL, 25, 1.80, 45.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `description`, `module`, `action`, `created_at`) VALUES
(1, 'dashboard.view', 'Ver dashboard', 'dashboard', 'read', '2026-02-25 18:54:01'),
(2, 'dashboard.export', 'Exportar datos del dashboard', 'dashboard', 'write', '2026-02-25 18:54:01'),
(3, 'inventory.view', 'Ver inventario', 'inventory', 'read', '2026-02-25 18:54:01'),
(4, 'inventory.create', 'Crear movimientos de inventario', 'inventory', 'write', '2026-02-25 18:54:01'),
(5, 'inventory.edit', 'Editar movimientos', 'inventory', 'write', '2026-02-25 18:54:01'),
(6, 'inventory.delete', 'Eliminar movimientos', 'inventory', 'delete', '2026-02-25 18:54:01'),
(7, 'products.view', 'Ver productos', 'products', 'read', '2026-02-25 18:54:01'),
(8, 'products.create', 'Crear productos', 'products', 'write', '2026-02-25 18:54:01'),
(9, 'products.edit', 'Editar productos', 'products', 'write', '2026-02-25 18:54:01'),
(10, 'products.delete', 'Eliminar productos', 'products', 'delete', '2026-02-25 18:54:01'),
(11, 'orders.view', 'Ver órdenes', 'orders', 'read', '2026-02-25 18:54:01'),
(12, 'orders.create', 'Crear órdenes', 'orders', 'write', '2026-02-25 18:54:01'),
(13, 'orders.edit', 'Editar órdenes', 'orders', 'write', '2026-02-25 18:54:01'),
(14, 'orders.delete', 'Eliminar órdenes', 'orders', 'delete', '2026-02-25 18:54:01'),
(15, 'production_orders.view', 'Ver órdenes de producción', 'production_orders', 'read', '2026-02-25 18:54:01'),
(16, 'production_orders.create', 'Crear órdenes de producción', 'production_orders', 'write', '2026-02-25 18:54:01'),
(17, 'production_orders.edit', 'Editar órdenes de producción', 'production_orders', 'write', '2026-02-25 18:54:01'),
(18, 'production_orders.delete', 'Eliminar órdenes de producción', 'production_orders', 'delete', '2026-02-25 18:54:01'),
(19, 'sales_orders.view', 'Ver órdenes de venta', 'sales_orders', 'read', '2026-02-25 18:54:01'),
(20, 'sales_orders.create', 'Crear órdenes de venta', 'sales_orders', 'write', '2026-02-25 18:54:01'),
(21, 'sales_orders.edit', 'Editar órdenes de venta', 'sales_orders', 'write', '2026-02-25 18:54:01'),
(22, 'sales_orders.delete', 'Eliminar órdenes de venta', 'sales_orders', 'delete', '2026-02-25 18:54:01'),
(23, 'billing.view', 'Ver facturas', 'billing', 'read', '2026-02-25 18:54:01'),
(24, 'billing.create', 'Crear facturas', 'billing', 'write', '2026-02-25 18:54:01'),
(25, 'billing.edit', 'Editar facturas', 'billing', 'write', '2026-02-25 18:54:01'),
(26, 'billing.delete', 'Eliminar facturas', 'billing', 'delete', '2026-02-25 18:54:01'),
(27, 'billing.pay', 'Registrar pagos', 'billing', 'write', '2026-02-25 18:54:01'),
(28, 'employees.view', 'Ver empleados', 'employees', 'read', '2026-02-25 18:54:01'),
(29, 'employees.create', 'Crear empleados', 'employees', 'write', '2026-02-25 18:54:01'),
(30, 'employees.edit', 'Editar empleados', 'employees', 'write', '2026-02-25 18:54:01'),
(31, 'employees.delete', 'Eliminar empleados', 'employees', 'delete', '2026-02-25 18:54:01'),
(32, 'reports.view', 'Ver reportes', 'reports', 'read', '2026-02-25 18:54:01'),
(33, 'reports.export', 'Exportar reportes', 'reports', 'write', '2026-02-25 18:54:01'),
(34, 'reports.production', 'Ver reportes de producción', 'reports', 'read', '2026-02-25 18:54:01'),
(35, 'reports.sales', 'Ver reportes de ventas', 'reports', 'read', '2026-02-25 18:54:01'),
(36, 'reports.inventory', 'Ver reportes de inventario', 'reports', 'read', '2026-02-25 18:54:01'),
(37, 'suppliers.view', 'Ver proveedores', 'suppliers', 'read', '2026-02-25 18:54:01'),
(38, 'suppliers.create', 'Crear proveedores', 'suppliers', 'write', '2026-02-25 18:54:01'),
(39, 'suppliers.edit', 'Editar proveedores', 'suppliers', 'write', '2026-02-25 18:54:01'),
(40, 'suppliers.delete', 'Eliminar proveedores', 'suppliers', 'delete', '2026-02-25 18:54:01'),
(41, 'supplies.view', 'Ver suministros', 'supplies', 'read', '2026-02-25 18:54:01'),
(42, 'supplies.create', 'Crear suministros', 'supplies', 'write', '2026-02-25 18:54:01'),
(43, 'supplies.edit', 'Editar suministros', 'supplies', 'write', '2026-02-25 18:54:01'),
(44, 'supplies.delete', 'Eliminar suministros', 'supplies', 'delete', '2026-02-25 18:54:01'),
(45, 'notifications.view', 'Ver notificaciones', 'notifications', 'read', '2026-02-25 18:54:01'),
(46, 'notifications.manage', 'Gestionar notificaciones', 'notifications', 'write', '2026-02-25 18:54:01'),
(47, 'settings.view', 'Ver configuración', 'settings', 'read', '2026-02-25 18:54:01'),
(48, 'settings.edit', 'Editar configuración', 'settings', 'write', '2026-02-25 18:54:01'),
(49, 'users.manage', 'Gestionar usuarios', 'settings', 'write', '2026-02-25 18:54:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_orders`
--

CREATE TABLE `production_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `responsible_employee_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `due_date` date DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pendiente',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `production_orders`
--

INSERT INTO `production_orders` (`id`, `order_number`, `product_id`, `quantity`, `responsible_employee_id`, `order_date`, `due_date`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'PROD-001', 1, 100, 3, '2026-02-09 04:16:49', NULL, 'completada', NULL, '2026-02-11 04:16:49', '2026-03-03 19:46:55'),
(2, 'PROD-002', 3, 80, 2, '2026-02-10 04:16:49', '2026-02-12', 'completada', 'Croissants listos', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'PROD-003', 4, 10, 3, '2026-02-11 04:16:49', '2026-02-13', 'completada', 'Torta de Chocolate en proceso', '2026-02-11 04:16:49', '2026-02-12 03:11:24'),
(4, 'PROD-004', 2, 50, 1, '2026-02-11 04:16:49', '2026-02-11', 'completada', 'Pan Integral programado', '2026-02-11 04:16:49', '2026-02-12 03:12:09'),
(5, 'PROD-005', 7, 60, 2, '2026-02-10 04:16:49', '2026-02-10', 'completada', 'Muffins finalizados', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'PROD-006', 3, 33, 5, '2026-02-11 04:16:49', NULL, 'pendiente', NULL, '2026-02-11 04:16:49', '2026-02-12 03:21:03'),
(7, 'PROD-007', 8, 20, 3, '2026-02-12 14:27:59', NULL, 'cancelada', NULL, '2026-02-12 14:27:59', '2026-03-03 19:46:20'),
(8, 'PROD-008', 9, 20, 1, '2026-02-12 14:28:21', NULL, 'cancelada', NULL, '2026-02-12 14:28:21', '2026-03-03 21:00:53'),
(9, 'PROD-009', 6, 2, 4, '2026-02-12 14:28:42', NULL, 'completada', NULL, '2026-02-12 14:28:42', '2026-02-17 20:35:39'),
(10, 'PROD-010', 2, 4, 1, '2026-02-12 15:18:53', NULL, 'completada', NULL, '2026-02-12 15:18:53', '2026-02-12 15:37:29'),
(11, 'PROD-011', 5, 20, 3, '2026-02-12 15:19:07', NULL, 'completada', NULL, '2026-02-12 15:19:07', '2026-02-12 15:19:48'),
(12, 'PROD-012', 2, 9, 4, '2026-02-12 15:35:30', NULL, 'completada', NULL, '2026-02-12 15:35:30', '2026-02-12 15:36:25'),
(13, 'PROD-013', 3, 6, 4, '2026-02-12 15:35:57', NULL, 'completada', NULL, '2026-02-12 15:35:57', '2026-02-12 15:36:53'),
(14, 'PROD-131', 1, 5, 8, '2026-03-03 20:57:44', NULL, 'pendiente', NULL, '2026-03-03 20:57:44', '2026-03-10 15:44:34'),
(15, 'PROD-1311', 3, 5, 2, '2026-03-10 15:48:15', NULL, 'completada', NULL, '2026-03-10 15:48:15', '2026-03-10 15:52:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_order_insumos`
--

CREATE TABLE `production_order_insumos` (
  `id` bigint NOT NULL,
  `production_order_id` bigint UNSIGNED NOT NULL,
  `insumo_id` int NOT NULL,
  `quantity_required` decimal(10,2) DEFAULT NULL,
  `quantity_used` decimal(10,2) DEFAULT '0.00',
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT '0',
  `min_stock_level` int DEFAULT '10',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product_recipes`
--

CREATE TABLE `product_recipes` (
  `id` int NOT NULL,
  `product_id` int NOT NULL,
  `insumo_id` int NOT NULL,
  `quantity_per_unit` decimal(10,2) DEFAULT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Administrador General', 'Acceso total al sistema', '2026-02-25 18:54:01', '2026-02-25 18:54:01'),
(2, 'Supervisor de Stock', 'Responsable de inventario y suministros', '2026-02-25 18:54:01', '2026-02-25 18:54:01'),
(3, 'Encargado de Ventas', 'Encargado de ventas y facturación', '2026-02-25 18:54:01', '2026-02-25 18:54:01'),
(4, 'Panadero', 'Responsable de la producción', '2026-02-25 18:54:01', '2026-02-25 18:54:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_id`, `created_at`) VALUES
(129, 1, 24, '2026-03-10 16:27:03'),
(130, 1, 26, '2026-03-10 16:27:03'),
(131, 1, 25, '2026-03-10 16:27:03'),
(132, 1, 27, '2026-03-10 16:27:03'),
(133, 1, 23, '2026-03-10 16:27:03'),
(134, 1, 2, '2026-03-10 16:27:03'),
(135, 1, 1, '2026-03-10 16:27:03'),
(136, 1, 29, '2026-03-10 16:27:03'),
(137, 1, 31, '2026-03-10 16:27:03'),
(138, 1, 30, '2026-03-10 16:27:03'),
(139, 1, 28, '2026-03-10 16:27:03'),
(140, 1, 4, '2026-03-10 16:27:03'),
(141, 1, 6, '2026-03-10 16:27:03'),
(142, 1, 5, '2026-03-10 16:27:03'),
(143, 1, 3, '2026-03-10 16:27:03'),
(144, 1, 46, '2026-03-10 16:27:03'),
(145, 1, 45, '2026-03-10 16:27:03'),
(146, 1, 12, '2026-03-10 16:27:03'),
(147, 1, 14, '2026-03-10 16:27:03'),
(148, 1, 13, '2026-03-10 16:27:03'),
(149, 1, 11, '2026-03-10 16:27:03'),
(150, 1, 16, '2026-03-10 16:27:03'),
(151, 1, 18, '2026-03-10 16:27:03'),
(152, 1, 17, '2026-03-10 16:27:03'),
(153, 1, 15, '2026-03-10 16:27:03'),
(154, 1, 8, '2026-03-10 16:27:03'),
(155, 1, 10, '2026-03-10 16:27:03'),
(156, 1, 9, '2026-03-10 16:27:03'),
(157, 1, 7, '2026-03-10 16:27:03'),
(158, 1, 33, '2026-03-10 16:27:03'),
(159, 1, 36, '2026-03-10 16:27:03'),
(160, 1, 34, '2026-03-10 16:27:03'),
(161, 1, 35, '2026-03-10 16:27:03'),
(162, 1, 32, '2026-03-10 16:27:03'),
(163, 1, 20, '2026-03-10 16:27:03'),
(164, 1, 22, '2026-03-10 16:27:03'),
(165, 1, 21, '2026-03-10 16:27:03'),
(166, 1, 19, '2026-03-10 16:27:03'),
(167, 1, 48, '2026-03-10 16:27:03'),
(168, 1, 47, '2026-03-10 16:27:03'),
(169, 1, 38, '2026-03-10 16:27:03'),
(170, 1, 40, '2026-03-10 16:27:03'),
(171, 1, 39, '2026-03-10 16:27:03'),
(172, 1, 37, '2026-03-10 16:27:03'),
(173, 1, 42, '2026-03-10 16:27:03'),
(174, 1, 44, '2026-03-10 16:27:03'),
(175, 1, 43, '2026-03-10 16:27:03'),
(176, 1, 41, '2026-03-10 16:27:03'),
(177, 1, 49, '2026-03-10 16:27:03'),
(192, 2, 1, '2026-03-10 16:27:03'),
(193, 2, 2, '2026-03-10 16:27:03'),
(194, 2, 3, '2026-03-10 16:27:03'),
(195, 2, 4, '2026-03-10 16:27:03'),
(196, 2, 5, '2026-03-10 16:27:03'),
(197, 2, 6, '2026-03-10 16:27:03'),
(198, 2, 7, '2026-03-10 16:27:03'),
(199, 2, 8, '2026-03-10 16:27:03'),
(200, 2, 9, '2026-03-10 16:27:03'),
(201, 2, 10, '2026-03-10 16:27:03'),
(202, 2, 11, '2026-03-10 16:27:03'),
(203, 2, 12, '2026-03-10 16:27:03'),
(204, 2, 13, '2026-03-10 16:27:03'),
(205, 2, 14, '2026-03-10 16:27:03'),
(206, 2, 15, '2026-03-10 16:27:03'),
(207, 2, 16, '2026-03-10 16:27:03'),
(208, 2, 17, '2026-03-10 16:27:03'),
(209, 2, 18, '2026-03-10 16:27:03'),
(210, 2, 19, '2026-03-10 16:27:03'),
(211, 2, 20, '2026-03-10 16:27:03'),
(212, 2, 21, '2026-03-10 16:27:03'),
(213, 2, 22, '2026-03-10 16:27:03'),
(214, 2, 23, '2026-03-10 16:27:03'),
(215, 2, 24, '2026-03-10 16:27:03'),
(216, 2, 25, '2026-03-10 16:27:03'),
(217, 2, 26, '2026-03-10 16:27:03'),
(218, 2, 27, '2026-03-10 16:27:03'),
(219, 2, 37, '2026-03-10 16:27:03'),
(220, 2, 38, '2026-03-10 16:27:03'),
(221, 2, 39, '2026-03-10 16:27:03'),
(222, 2, 40, '2026-03-10 16:27:03'),
(223, 2, 41, '2026-03-10 16:27:03'),
(224, 2, 42, '2026-03-10 16:27:03'),
(225, 2, 43, '2026-03-10 16:27:03'),
(226, 2, 44, '2026-03-10 16:27:03'),
(227, 2, 45, '2026-03-10 16:27:03'),
(228, 2, 46, '2026-03-10 16:27:03'),
(229, 2, 47, '2026-03-10 16:27:03'),
(230, 2, 48, '2026-03-10 16:27:03'),
(231, 2, 49, '2026-03-10 16:27:03'),
(255, 3, 1, '2026-03-10 16:27:03'),
(256, 3, 2, '2026-03-10 16:27:03'),
(257, 3, 3, '2026-03-10 16:27:03'),
(258, 3, 4, '2026-03-10 16:27:03'),
(259, 3, 5, '2026-03-10 16:27:03'),
(260, 3, 6, '2026-03-10 16:27:03'),
(261, 3, 7, '2026-03-10 16:27:03'),
(262, 3, 8, '2026-03-10 16:27:03'),
(263, 3, 9, '2026-03-10 16:27:03'),
(264, 3, 10, '2026-03-10 16:27:03'),
(265, 3, 11, '2026-03-10 16:27:03'),
(266, 3, 12, '2026-03-10 16:27:03'),
(267, 3, 13, '2026-03-10 16:27:03'),
(268, 3, 14, '2026-03-10 16:27:03'),
(269, 3, 15, '2026-03-10 16:27:03'),
(270, 3, 16, '2026-03-10 16:27:03'),
(271, 3, 17, '2026-03-10 16:27:03'),
(272, 3, 18, '2026-03-10 16:27:03'),
(273, 3, 19, '2026-03-10 16:27:03'),
(274, 3, 20, '2026-03-10 16:27:03'),
(275, 3, 21, '2026-03-10 16:27:03'),
(276, 3, 22, '2026-03-10 16:27:03'),
(277, 3, 23, '2026-03-10 16:27:03'),
(278, 3, 24, '2026-03-10 16:27:03'),
(279, 3, 25, '2026-03-10 16:27:03'),
(280, 3, 26, '2026-03-10 16:27:03'),
(281, 3, 27, '2026-03-10 16:27:03'),
(282, 3, 37, '2026-03-10 16:27:03'),
(283, 3, 38, '2026-03-10 16:27:03'),
(284, 3, 39, '2026-03-10 16:27:03'),
(285, 3, 40, '2026-03-10 16:27:03'),
(286, 3, 41, '2026-03-10 16:27:03'),
(287, 3, 42, '2026-03-10 16:27:03'),
(288, 3, 43, '2026-03-10 16:27:03'),
(289, 3, 44, '2026-03-10 16:27:03'),
(290, 3, 45, '2026-03-10 16:27:03'),
(291, 3, 46, '2026-03-10 16:27:03'),
(292, 3, 47, '2026-03-10 16:27:03'),
(293, 3, 48, '2026-03-10 16:27:03'),
(294, 3, 49, '2026-03-10 16:27:03'),
(318, 4, 1, '2026-03-10 16:27:03'),
(319, 4, 2, '2026-03-10 16:27:03'),
(320, 4, 3, '2026-03-10 16:27:03'),
(321, 4, 4, '2026-03-10 16:27:03'),
(322, 4, 5, '2026-03-10 16:27:03'),
(323, 4, 6, '2026-03-10 16:27:03'),
(324, 4, 7, '2026-03-10 16:27:03'),
(325, 4, 8, '2026-03-10 16:27:03'),
(326, 4, 9, '2026-03-10 16:27:03'),
(327, 4, 10, '2026-03-10 16:27:03'),
(328, 4, 11, '2026-03-10 16:27:03'),
(329, 4, 12, '2026-03-10 16:27:03'),
(330, 4, 13, '2026-03-10 16:27:03'),
(331, 4, 14, '2026-03-10 16:27:03'),
(332, 4, 15, '2026-03-10 16:27:03'),
(333, 4, 16, '2026-03-10 16:27:03'),
(334, 4, 17, '2026-03-10 16:27:03'),
(335, 4, 18, '2026-03-10 16:27:03'),
(336, 4, 19, '2026-03-10 16:27:03'),
(337, 4, 20, '2026-03-10 16:27:03'),
(338, 4, 21, '2026-03-10 16:27:03'),
(339, 4, 22, '2026-03-10 16:27:03'),
(340, 4, 23, '2026-03-10 16:27:03'),
(341, 4, 24, '2026-03-10 16:27:03'),
(342, 4, 25, '2026-03-10 16:27:03'),
(343, 4, 26, '2026-03-10 16:27:03'),
(344, 4, 27, '2026-03-10 16:27:03'),
(345, 4, 37, '2026-03-10 16:27:03'),
(346, 4, 38, '2026-03-10 16:27:03'),
(347, 4, 39, '2026-03-10 16:27:03'),
(348, 4, 40, '2026-03-10 16:27:03'),
(349, 4, 41, '2026-03-10 16:27:03'),
(350, 4, 42, '2026-03-10 16:27:03'),
(351, 4, 43, '2026-03-10 16:27:03'),
(352, 4, 44, '2026-03-10 16:27:03'),
(353, 4, 45, '2026-03-10 16:27:03'),
(354, 4, 46, '2026-03-10 16:27:03'),
(355, 4, 47, '2026-03-10 16:27:03'),
(356, 4, 48, '2026-03-10 16:27:03'),
(357, 4, 49, '2026-03-10 16:27:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_orders`
--

CREATE TABLE `sales_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int DEFAULT NULL,
  `customer_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales_orders`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_order_insumos`
--

CREATE TABLE `sales_order_insumos` (
  `id` bigint NOT NULL,
  `sales_order_id` bigint UNSIGNED NOT NULL,
  `insumo_id` int NOT NULL,
  `quantity_required` decimal(10,2) DEFAULT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_order_items`
--

CREATE TABLE `sales_order_items` (
  `id` bigint NOT NULL,
  `sales_order_id` bigint UNSIGNED NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales_order_items`
--

INSERT INTO `sales_order_items` (`id`, `sales_order_id`, `product_id`, `quantity`, `unit_price`, `total`) VALUES
(1, 1, 1, 20, 2.50, 50.00),
(2, 1, 3, 15, 3.50, 52.50),
(3, 1, 5, 30, 1.80, 54.00),
(4, 2, 2, 10, 3.00, 30.00),
(5, 2, 4, 5, 28.00, 140.00),
(6, 2, 6, 25, 10.00, 250.00),
(7, 3, 1, 25, 2.50, 62.50),
(8, 3, 7, 20, 4.00, 80.00),
(9, 3, 8, 25, 3.50, 87.50),
(10, 4, 9, 10, 4.50, 45.00),
(11, 4, 5, 20, 2.00, 40.00),
(12, 5, 1, 50, 2.50, 125.00),
(13, 5, 2, 30, 3.00, 90.00),
(14, 5, 3, 40, 3.50, 140.00),
(15, 5, 10, 5, 15.00, 75.00),
(16, 5, 4, 3, 28.00, 84.00),
(17, 7, 1, 5, 1500.00, 7500.00),
(18, 8, 1, 4, 1500.00, 6000.00),
(19, 8, 4, 2, 25000.00, 50000.00),
(20, 9, 2, 3, 2000.00, 6000.00),
(21, 9, 5, 3, 1800.00, 5400.00),
(22, 10, 6, 1, 800.00, 800.00),
(23, 10, 9, 1, 5000.00, 5000.00),
(24, 10, 2, 3, 3500.00, 10500.00),
(25, 11, 5, 1, 2500.00, 2500.00),
(26, 11, 18, 1, 5000.00, 5000.00),
(27, 11, 10, 1, 15000.00, 15000.00),
(28, 11, 9, 1, 5000.00, 5000.00),
(29, 11, 8, 3, 800.00, 2400.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_reports`
--

CREATE TABLE `sales_reports` (
  `id` int NOT NULL,
  `report_date` date DEFAULT NULL,
  `total_sales` decimal(10,2) DEFAULT NULL,
  `total_purchases` decimal(10,2) DEFAULT NULL,
  `product_category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_sold` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales_reports`
--

INSERT INTO `sales_reports` (`id`, `report_date`, `total_sales`, `total_purchases`, `product_category`, `quantity_sold`, `created_at`) VALUES
(1, '2026-02-10', 342.50, 0.00, 'Panes', 150, '2026-02-10 19:31:16'),
(2, '2026-02-10', 150.00, 0.00, 'Pastelería', 60, '2026-02-10 19:31:16'),
(3, '2026-02-09', 275.00, 0.00, 'Insumos', 120, '2026-02-10 19:31:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int NOT NULL,
  `company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_person` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_terms` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Sin categoría',
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `suppliers`
--

INSERT INTO `suppliers` (`id`, `company_name`, `contact_person`, `email`, `phone`, `address`, `city`, `country`, `payment_terms`, `created_at`, `updated_at`, `category`, `is_active`) VALUES
(1, 'Molinos del Valle', 'Carlos Ruiz', 'carlos@molinosvalle.com', '3012121226', 'Carretera Valencia Km 5', 'Cartagena', 'Spain', 'Net 30', '2026-02-10 19:31:16', '2026-02-19 19:03:48', 'Esencias y Sabores', 0),
(2, 'Azúcar & Cía', 'María Santos', 'maria@azucarycia.com', '3102555654', 'Avda Industrial 120', 'Rionegro', 'Colombia', 'Net 60', '2026-02-10 19:31:16', '2026-02-17 19:26:43', 'Harinas y Granos', 1),
(3, 'Insumos Panaderos', 'Juan Díaz', 'juan@insumospanaderos.com', '3114122545', 'Polígono Industrial 45', 'Cúcuta', 'Spain', 'Net 45', '2026-02-10 19:31:16', '2026-02-19 19:02:59', 'Lácteos', 0),
(4, 'Lácteos Premium', 'Ana Moreno', 'ana@lacteospremo.com', '3102255665', 'Calle Ganadería 78', 'Bogotá', 'Spain', 'Net 30', '2026-02-10 19:31:16', '2026-02-19 19:03:24', 'Lácteos', 0),
(5, 'Granja El Porvenir', 'Pedro López', 'pedro@granjaporvenir.com', '3145455632', 'Finca Rural 23', 'Medellín', 'Spain', 'Net 15', '2026-02-10 19:31:16', '2026-02-19 19:02:36', 'Frutas y Conservas', 0),
(6, 'Chocolates Finos', 'Isabel García', 'isabel@chocolatefinos.com', '3112345688', 'Calle Cacao 56', 'Medellin', 'Colombia', 'Net 60', '2026-02-10 19:31:16', '2026-02-16 18:50:41', 'Esencias y Sabores', 1),
(7, 'Distribuidora Central', 'Roberto Silva', 'roberto@distcentral.com', '3125645855', 'Centro Logístico 33', 'Bogota', 'Colombia', 'Net 45', '2026-02-10 19:31:16', '2026-02-17 20:32:58', 'Frutas y Conservas', 1),
(8, 'SENA', 'Alejandro', 'alejandrob0420@gmail.com', '3135445977', 'calle xxxx #34 - 09', 'Rionegro', 'Colombia', '', '2026-02-12 19:42:47', '2026-03-10 23:28:16', 'Harinas y Granos', 1),
(9, 'Distribuidora del oriente', 'Alex Mesa', 'AlexM@gmail.com', '3144566558', 'Calle 45 #23-21', 'Rionegro', '', '', '2026-02-25 20:48:53', '2026-02-25 20:48:53', 'Esencias y Sabores', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplies`
--

CREATE TABLE `supplies` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT '0',
  `min_stock_level` int DEFAULT '10',
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `supplies`
--

INSERT INTO `supplies` (`id`, `name`, `sku`, `description`, `category`, `price`, `stock_quantity`, `min_stock_level`, `unit`, `supplier_id`, `image_url`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Harina de Trigo', 'SUP-001', 'Harina de trigo premium', 'Harinas', 4.50, 500, 100, 'kg', NULL, NULL, 0, '2026-02-11 04:16:49', '2026-02-17 21:25:22'),
(2, 'Azúcar Blanca', 'SUP-002', 'Azúcar blanca refinada', 'Endulzantes', 3.20, 200, 80, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'Levadura Seca', 'SUP-003', 'Levadura seca instantánea', 'Levaduras', 18.00, 30, 15, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(4, 'Mantequilla', 'SUP-004', 'Mantequilla de calidad premium', 'Lácteos', 12.00, 80, 30, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(5, 'Huevos Frescos', 'SUP-005', 'Huevos frescos de granja', 'Lácteos', 0.60, 500, 150, 'docena', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'Chocolate en Polvo', 'SUP-006', 'Chocolate en polvo premium', 'Saborizantes', 22.00, 40, 15, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(7, 'Sal Fina', 'SUP-007', 'Sal fina para panadería', 'Condimentos', 1.80, 100, 40, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(8, 'Vainilla Pura', 'SUP-008', 'Extracto de vainilla pura', 'Saborizantes', 35.00, 15, 5, 'l', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-12 18:56:48'),
(9, 'Arándanos Secos', 'SUP-009', 'Arándanos deshidratados', 'Frutas', NULL, 20, 8, 'kg', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-19 18:40:30'),
(10, 'Aceite de Oliva', 'SUP-010', 'Aceite de oliva virgen extra', 'Aceites', NULL, 30, 10, 'l', NULL, NULL, 1, '2026-02-11 04:16:49', '2026-02-19 18:40:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplies_inventory`
--

CREATE TABLE `supplies_inventory` (
  `id` int NOT NULL,
  `supply_id` int DEFAULT NULL,
  `warehouse_location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplies_movements`
--

CREATE TABLE `supplies_movements` (
  `id` int NOT NULL,
  `supply_id` int NOT NULL,
  `movement_type` enum('entrada','salida','ajuste','devolución') DEFAULT 'ajuste',
  `quantity_change` int NOT NULL,
  `previous_quantity` int DEFAULT NULL,
  `new_quantity` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `notes` longtext,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role_id` int DEFAULT '1',
  `must_change_password` tinyint(1) DEFAULT '0'
) ;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `role`, `created_at`, `updated_at`, `role_id`, `must_change_password`) VALUES
(4, 'admin', 'admin@pansoft.com', '$2b$10$gXGiJFWiZd4nnXirKhnQIe0fJc6gFL8EknYh9Cjwg9CEtsSJR6XxW', 'Administrador', 'admin', '2026-02-15 21:47:36', '2026-02-25 19:09:47', 1, 0),
(5, 'user', 'user@pansoft.com', '$2b$10$ikG252.ATMOvPr8ws4xGKusxFF1oOnIor6ceq7omd.1cwu4KTLY1W', 'Usuario Test', 'user', '2026-02-15 21:47:36', '2026-02-15 21:47:36', 1, 0),
(6, 'vendedor', 'vendedor@pansoft.com', '$2b$10$bqxf9QHFoJbtXxnUCFbPeOprm7b9qtP64Jz62CnToCUZRSfz6Kt2K', 'Juan Vendedor', 'user', '2026-02-15 21:47:36', '2026-02-25 18:54:01', 3, 0),
(8, 'stock1', 'stock@pansoft.com', '$2b$10$fIAddY26rqkhSj84EKz2G.V3KgES112yGg.MDnzwe.QKAPaq8hl/m', NULL, 'user', '2026-02-25 18:54:01', '2026-02-25 19:09:47', 2, 0),
(10, 'panadero1', 'panadero@pansoft.com', '$2b$10$If7kraM9R6cQs31M/80NZ.4Uq.le.9zt2a3jlaewxIDuxnxxJCIpC', NULL, 'user', '2026-02-25 18:54:01', '2026-02-25 19:09:48', 4, 0),
(15, 'vendedor1', 'vendedor1@pansoft.com', '$2b$10$0tGVtxgM29RuqcEEfEoHZO/9r9cmayvC9St6xHwcdvDN3RtEUSknK', NULL, 'user', '2026-02-25 19:15:05', '2026-02-25 19:15:05', 3, 0),
(16, 'Carolina', 'caro76@gmail.com', '$2b$10$SKp0GQ8YopdDswr38g9tkuunavlIN.rQ0cxctpWCn40TaBXh1Q6yC', 'Carolina Cepeda', 'user', '2026-03-10 16:28:25', '2026-03-10 16:28:25', 4, 1),
(17, 'Laura', 'Laura@gmail.com', '$2b$10$/m9PbpITjHpf7fCv.Waa6uPjE8yokcZ6RnlVxHG14kTj9TUmujxoC', 'Laura Acosta', 'user', '2026-03-10 16:35:05', '2026-03-10 16:39:41', 4, 0),
(18, 'cata', 'cata@gmail.com', '$2b$10$lhb2kord.mnfQAM.xj/fY.RYEzkXE2hnr21vWMN8gnqDfHCrsavGq', 'Catalina Gomez', 'user', '2026-03-10 21:35:08', '2026-03-10 21:35:44', 4, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_employees_department` (`department`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_insumos_stock` (`stock_quantity`);

--
-- Indices de la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product` (`product_id`),
  ADD KEY `idx_date` (`created_at`);

--
-- Indices de la tabla `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `idx_invoices_customer` (`customer_id`),
  ADD KEY `idx_invoices_status` (`status`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_orders_customer` (`customer_id`),
  ADD KEY `idx_orders_status` (`status`);

--
-- Indices de la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `production_orders`
--
ALTER TABLE `production_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_production_orders_product` (`product_id`),
  ADD KEY `idx_production_orders_status` (`status`),
  ADD KEY `idx_production_orders_responsible` (`responsible_employee_id`);

--
-- Indices de la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_order_id` (`production_order_id`),
  ADD KEY `insumo_id` (`insumo_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `idx_products_category` (`category`),
  ADD KEY `idx_products_sku` (`sku`);

--
-- Indices de la tabla `product_recipes`
--
ALTER TABLE `product_recipes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`insumo_id`),
  ADD KEY `insumo_id` (`insumo_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_role_permission` (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`);

--
-- Indices de la tabla `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_sales_orders_customer` (`customer_id`),
  ADD KEY `idx_sales_orders_status` (`status`),
  ADD KEY `idx_sales_orders_customer_name` (`customer_name`);

--
-- Indices de la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_order_id` (`sales_order_id`),
  ADD KEY `insumo_id` (`insumo_id`);

--
-- Indices de la tabla `sales_order_items`
--
ALTER TABLE `sales_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_order_id` (`sales_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indices de la tabla `sales_reports`
--
ALTER TABLE `sales_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `supplies`
--
ALTER TABLE `supplies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `idx_supplies_category` (`category`),
  ADD KEY `idx_supplies_sku` (`sku`),
  ADD KEY `idx_supplies_status` (`is_active`);

--
-- Indices de la tabla `supplies_inventory`
--
ALTER TABLE `supplies_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supply_id` (`supply_id`);

--
-- Indices de la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_supply` (`supply_id`),
  ADD KEY `idx_date` (`created_at`),
  ADD KEY `idx_supplies_movements_supply` (`supply_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_username` (`username`),
  ADD KEY `fk_users_role_id` (`role_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT de la tabla `production_orders`
--
ALTER TABLE `production_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `product_recipes`
--
ALTER TABLE `product_recipes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=381;

--
-- AUTO_INCREMENT de la tabla `sales_orders`
--
ALTER TABLE `sales_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sales_order_items`
--
ALTER TABLE `sales_order_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `sales_reports`
--
ALTER TABLE `sales_reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `supplies`
--
ALTER TABLE `supplies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `supplies_inventory`
--
ALTER TABLE `supplies_inventory`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD CONSTRAINT `inventory_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `production_orders`
--
ALTER TABLE `production_orders`
  ADD CONSTRAINT `production_orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `production_orders_ibfk_2` FOREIGN KEY (`responsible_employee_id`) REFERENCES `employees` (`id`);

--
-- Filtros para la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  ADD CONSTRAINT `production_order_insumos_ibfk_1` FOREIGN KEY (`production_order_id`) REFERENCES `production_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `production_order_insumos_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`id`);

--
-- Filtros para la tabla `product_recipes`
--
ALTER TABLE `product_recipes`
  ADD CONSTRAINT `product_recipes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_recipes_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`id`);

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD CONSTRAINT `sales_orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Filtros para la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  ADD CONSTRAINT `sales_order_insumos_ibfk_1` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_order_insumos_ibfk_2` FOREIGN KEY (`insumo_id`) REFERENCES `insumos` (`id`);

--
-- Filtros para la tabla `sales_order_items`
--
ALTER TABLE `sales_order_items`
  ADD CONSTRAINT `sales_order_items_ibfk_1` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Filtros para la tabla `supplies_inventory`
--
ALTER TABLE `supplies_inventory`
  ADD CONSTRAINT `supplies_inventory_ibfk_1` FOREIGN KEY (`supply_id`) REFERENCES `supplies` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  ADD CONSTRAINT `supplies_movements_ibfk_1` FOREIGN KEY (`supply_id`) REFERENCES `supplies` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
