-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 15-03-2026 a las 20:46:55
-- Versión del servidor: 8.0.44
-- Versión de PHP: 8.3.26

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
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `is_active`, `created_at`) VALUES
(1, 'Harinas', 1, '2026-03-15 20:15:10'),
(2, 'Endulzantes', 1, '2026-03-15 20:15:10'),
(3, 'Levaduras', 1, '2026-03-15 20:15:10'),
(4, 'Lácteos', 1, '2026-03-15 20:15:10'),
(5, 'Saborizantes', 1, '2026-03-15 20:15:10'),
(6, 'Condimentos', 1, '2026-03-15 20:15:10'),
(7, 'Frutas', 1, '2026-03-15 20:15:10'),
(8, 'Aceites', 1, '2026-03-15 20:15:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `address`, `city`, `country`, `customer_type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PanaderÃ­a La MansiÃ³n', 'info@lamansion.com', '+34-91-3333333', 'Calle Mayor 100', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(2, 'Supermercado El Centro', 'compras@elcentro.com', '+34-91-4444444', 'Avenida Central 250', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(3, 'CafeterÃ­a Premium', 'gerencia@cafepremo.com', '+34-91-5555555', 'Plaza del Sol 50', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(4, 'Restaurante Casa Luis', 'pedidos@casaluis.com', '+34-91-6666666', 'Calle Goya 75', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(5, 'Tienda Gourmet', 'ventas@tiendagourmet.com', '+34-91-7777777', 'Paseo Recoletos 42', 'Madrid', 'Spain', 'B2B', 'active', '2026-02-11 04:16:49', '2026-02-11 04:16:49'),
(6, 'Cliente Prueba', 'cliente@test.com', '123456', NULL, 'BogotÃ¡', NULL, NULL, 'active', '2026-03-02 18:34:50', '2026-03-02 18:34:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employees`
--

CREATE TABLE `employees` (
  `id` bigint UNSIGNED NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `employees`
--

INSERT INTO `employees` (`id`, `first_name`, `last_name`, `email`, `phone`, `position`, `department`, `hire_date`, `salary`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Juan2', 'Pérez', 'juan@test.com', '', 'panadero', NULL, '2026-03-11', NULL, 'active', '2026-03-11 17:37:16', '2026-03-11 19:39:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory`
--

CREATE TABLE `inventory` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` int DEFAULT NULL,
  `warehouse_location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `warehouse_location`, `quantity`, `last_updated`) VALUES
(1, 1, 'AlmacÃ©n Principal', 80, '2026-03-15 18:49:15'),
(7, 7, 'AlmacÃ©n Principal', 0, '2026-02-23 15:58:34'),
(8, 8, 'AlmacÃ©n Principal', 17, '2026-03-15 18:49:15'),
(11, 2, 'AlmacÃ©n Principal', 14, '2026-03-15 18:54:31'),
(14, 4, 'AlmacÃ©n Principal', 0, '2026-03-15 18:49:15'),
(15, 3, 'AlmacÃ©n Principal', 0, '2026-03-15 18:54:31'),
(16, 10, 'AlmacÃ©n Principal', 0, '2026-02-12 03:28:44'),
(17, 5, 'AlmacÃ©n Principal', 95, '2026-03-15 20:45:50'),
(18, 12, 'AlmacÃ©n Principal', 24, '2026-02-23 15:58:34'),
(19, 6, 'AlmacÃ©n Principal', 0, '2026-03-15 18:54:31'),
(20, 18, 'Almacén Principal', 100, '2026-03-15 15:49:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory_movements`
--

CREATE TABLE `inventory_movements` (
  `id` bigint NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `movement_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'ajuste',
  `quantity_change` int NOT NULL,
  `previous_quantity` int DEFAULT '0',
  `new_quantity` int DEFAULT '0',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventory_movements`
--

INSERT INTO `inventory_movements` (`id`, `product_id`, `movement_type`, `quantity_change`, `previous_quantity`, `new_quantity`, `reason`, `notes`, `user_id`, `created_at`) VALUES
(1, 5, 'salida', -20, 115, 95, '', 'Movimiento desde interfaz - 15/3/2026, 3:45:50 p. m.', 1, '2026-03-15 20:45:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint UNSIGNED NOT NULL,
  `invoice_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `issue_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `due_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT '0.00',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invoices`
--

INSERT INTO `invoices` (`id`, `invoice_number`, `order_id`, `customer_id`, `issue_date`, `due_date`, `total_amount`, `paid_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'FAC-202603151332', NULL, NULL, '2026-03-15 00:00:00', '2026-03-15 00:00:00', 10500.00, 0.00, 'paid', '2026-03-15 18:32:26', '2026-03-15 18:32:26'),
(3, 'FAC-202603151333', NULL, NULL, '2026-03-15 00:00:00', '2026-03-15 00:00:00', 6000.00, 0.00, 'paid', '2026-03-15 18:33:24', '2026-03-15 18:33:24'),
(4, 'FAC-202603151349', NULL, NULL, '2026-03-15 00:00:00', '2026-03-15 00:00:00', 47446.50, 0.00, 'paid', '2026-03-15 18:49:15', '2026-03-15 18:49:15'),
(5, 'FAC-202603151354', NULL, NULL, '2026-03-15 18:54:31', '2026-03-15 18:54:31', 5500.00, 0.00, 'paid', '2026-03-15 18:54:31', '2026-03-15 18:54:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int NOT NULL,
  `invoice_id` bigint UNSIGNED NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `product_id`, `product_name`, `quantity`, `unit_price`, `subtotal`, `created_at`) VALUES
(1, 5, 2, 'Pan Integral', 1, 3500.00, 3500.00, '2026-03-15 18:54:31'),
(2, 5, 3, 'Croissants', 1, 1200.00, 1200.00, '2026-03-15 18:54:31'),
(3, 5, 6, 'Galletas de Mantequilla', 1, 800.00, 800.00, '2026-03-15 18:54:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `title`, `message`, `icon`, `color`, `is_read`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-11 17:38:46', '2026-03-15 15:05:36'),
(2, 'warning', 'Stock crítico', 'Muffins de ArÃ¡ndanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-11 17:38:46', '2026-03-15 15:05:36'),
(3, 'warning', 'Stock crítico', 'Croissants tiene solo 5 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-11 17:38:46', '2026-03-15 15:05:36'),
(4, 'inventory', 'Producto con stock bajo', 'Donas Glaseadas tiene solo 15 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-11 17:39:16', '2026-03-15 15:05:36'),
(5, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-11 17:39:16', '2026-03-15 15:05:36'),
(6, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-11 17:39:16', '2026-03-15 15:05:36'),
(7, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-11 17:39:16', '2026-03-15 15:05:36'),
(8, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-11 20:47:00', '2026-03-15 15:05:36'),
(9, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 12:13:25', '2026-03-15 15:05:36'),
(10, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 12:13:26', '2026-03-15 15:05:36'),
(11, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 12:13:26', '2026-03-15 15:05:36'),
(12, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-12 17:41:24', '2026-03-15 15:05:36'),
(13, 'warning', 'Stock crítico', 'Croissants tiene solo 5 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-12 17:41:24', '2026-03-15 15:05:36'),
(14, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 18:56:24', '2026-03-15 15:05:36'),
(15, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 18:56:24', '2026-03-15 15:05:36'),
(16, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-12 18:56:24', '2026-03-15 15:05:36'),
(17, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-13 01:16:25', '2026-03-15 15:05:36'),
(18, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 01:16:55', '2026-03-15 15:05:36'),
(19, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 01:16:55', '2026-03-15 15:05:36'),
(20, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 01:16:55', '2026-03-15 15:05:36'),
(21, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 12:11:36', '2026-03-15 15:05:36'),
(22, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 12:11:36', '2026-03-15 15:05:36'),
(23, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 12:11:36', '2026-03-15 15:05:36'),
(24, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-13 18:09:35', '2026-03-15 15:05:36'),
(25, 'warning', 'Stock crítico', 'Croissants tiene solo 5 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-13 18:09:35', '2026-03-15 15:05:36'),
(26, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 18:54:35', '2026-03-15 15:05:36'),
(27, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 18:54:35', '2026-03-15 15:05:36'),
(28, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-13 18:54:35', '2026-03-15 15:05:36'),
(29, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-14 12:33:32', '2026-03-15 15:05:36'),
(30, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-14 12:34:02', '2026-03-15 15:05:36'),
(31, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-14 12:34:02', '2026-03-15 15:05:36'),
(32, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-14 12:34:02', '2026-03-15 15:05:36'),
(33, 'warning', 'Stock crítico', 'Galletas de Mantequilla tiene solo 0 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-15 14:06:36', '2026-03-15 15:05:36'),
(34, 'warning', 'Stock crítico', 'Muffins de Arándanos tiene solo 0 unidades (mínimo crítico: 25)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-15 14:06:36', '2026-03-15 15:05:36'),
(35, 'warning', 'Stock crítico', 'Croissants tiene solo 5 unidades (mínimo crítico: 30)', 'AlertTriangle', '#FF6B6B', 1, NULL, '2026-03-15 14:06:36', '2026-03-15 15:05:36'),
(36, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 20 unidades (mínimo: 50)', 'Package', '#FFD93D', 1, NULL, '2026-03-15 14:07:06', '2026-03-15 15:05:33'),
(37, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 18 unidades (mínimo: 40)', 'Package', '#FFD93D', 1, NULL, '2026-03-15 14:07:06', '2026-03-15 15:05:33'),
(38, 'inventory', 'Producto con stock bajo', 'Torta de Chocolate tiene solo 3 unidades (mínimo: 5)', 'Package', '#FFD93D', 1, NULL, '2026-03-15 14:07:06', '2026-03-15 15:05:30'),
(39, 'warning', 'Stock crítico', 'Torta de Chocolate tiene solo 0 unidades (mínimo crítico: 5)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-15 18:33:24', '2026-03-15 18:33:24'),
(40, 'warning', 'Stock crítico', 'Brownie de Chocolate tiene solo 0 unidades (mínimo crítico: 20)', 'AlertTriangle', '#FF6B6B', 0, NULL, '2026-03-15 18:33:24', '2026-03-15 18:33:24'),
(41, 'inventory', 'Producto con stock bajo', 'Empanadas de Pollo tiene solo 17 unidades (mínimo: 50)', 'Package', '#FFD93D', 0, NULL, '2026-03-15 20:24:11', '2026-03-15 20:24:11'),
(42, 'inventory', 'Producto con stock bajo', 'Pan Integral tiene solo 14 unidades (mínimo: 40)', 'Package', '#FFD93D', 0, NULL, '2026-03-15 20:24:11', '2026-03-15 20:24:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(11, 'orders.view', 'Ver Ã³rdenes', 'orders', 'read', '2026-02-25 18:54:01'),
(12, 'orders.create', 'Crear Ã³rdenes', 'orders', 'write', '2026-02-25 18:54:01'),
(13, 'orders.edit', 'Editar Ã³rdenes', 'orders', 'write', '2026-02-25 18:54:01'),
(14, 'orders.delete', 'Eliminar Ã³rdenes', 'orders', 'delete', '2026-02-25 18:54:01'),
(15, 'production_orders.view', 'Ver Ã³rdenes de producciÃ³n', 'production_orders', 'read', '2026-02-25 18:54:01'),
(16, 'production_orders.create', 'Crear Ã³rdenes de producciÃ³n', 'production_orders', 'write', '2026-02-25 18:54:01'),
(17, 'production_orders.edit', 'Editar Ã³rdenes de producciÃ³n', 'production_orders', 'write', '2026-02-25 18:54:01'),
(18, 'production_orders.delete', 'Eliminar Ã³rdenes de producciÃ³n', 'production_orders', 'delete', '2026-02-25 18:54:01'),
(19, 'sales_orders.view', 'Ver Ã³rdenes de venta', 'sales_orders', 'read', '2026-02-25 18:54:01'),
(20, 'sales_orders.create', 'Crear Ã³rdenes de venta', 'sales_orders', 'write', '2026-02-25 18:54:01'),
(21, 'sales_orders.edit', 'Editar Ã³rdenes de venta', 'sales_orders', 'write', '2026-02-25 18:54:01'),
(22, 'sales_orders.delete', 'Eliminar Ã³rdenes de venta', 'sales_orders', 'delete', '2026-02-25 18:54:01'),
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
(34, 'reports.production', 'Ver reportes de producciÃ³n', 'reports', 'read', '2026-02-25 18:54:01'),
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
(47, 'settings.view', 'Ver configuraciÃ³n', 'settings', 'read', '2026-02-25 18:54:01'),
(48, 'settings.edit', 'Editar configuraciÃ³n', 'settings', 'write', '2026-02-25 18:54:01'),
(49, 'users.manage', 'Gestionar usuarios', 'settings', 'write', '2026-02-25 18:54:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_orders`
--

CREATE TABLE `production_orders` (
  `id` int NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `responsible_employee_id` int DEFAULT NULL,
  `priority` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'normal',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `production_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `production_orders`
--

INSERT INTO `production_orders` (`id`, `order_number`, `product_id`, `quantity`, `status`, `responsible_employee_id`, `priority`, `order_date`, `production_date`, `due_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'PROD-2026-001', 18, 100, 'completada', 1, 'normal', '2026-03-11 18:32:26', NULL, '2026-03-12', NULL, '2026-03-11 18:32:26', '2026-03-15 15:49:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `production_order_insumos`
--

CREATE TABLE `production_order_insumos` (
  `id` int NOT NULL,
  `production_order_id` int NOT NULL,
  `insumo_id` int NOT NULL,
  `quantity_required` decimal(10,2) NOT NULL,
  `quantity_used` decimal(10,2) DEFAULT '0.00',
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT '0',
  `min_stock_level` int DEFAULT '10',
  `expiry_date` date DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `sku`, `description`, `category`, `price`, `stock_quantity`, `min_stock_level`, `expiry_date`, `image_url`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Pan Francés', 'PAN-001', '', 'Panadería', 15.50, 80, 10, '2026-04-04', NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:49:15'),
(2, 'Pan Integral', 'PAN-002', 'panoto', 'Panes', 3500.00, 14, 40, '2026-03-21', NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:54:31'),
(3, 'Croissants', 'PAS-001', '', 'Pastelería', 1200.00, 0, 30, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:54:31'),
(4, 'Torta de Chocolate', 'TOR-001', '', 'Tortas', 15000.00, 0, 5, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:49:15'),
(5, 'Donas Glaseadas', 'DON-001', NULL, 'Donas', 2.50, 95, 40, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 20:45:50'),
(6, 'Galletas de Mantequilla', 'GAL-001', NULL, 'Galletas', 800.00, 0, 30, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:54:31'),
(7, 'Muffins de Arándanos', 'MUF-001', '', 'Muffins', 1800.00, 0, 25, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-11 20:18:50'),
(8, 'Empanadas de Pollo', 'EMP-001', '', 'Salados', 800.00, 17, 50, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:49:15'),
(9, 'Brownie de Chocolate', 'BRO-001', '', 'Postres', 5000.00, 0, 20, NULL, NULL, 1, '2026-02-11 04:16:49', '2026-03-15 18:28:00'),
(10, 'Pan de chocolate', 'PAN-008', 'Pan artesanal relleno de chocolate', 'Panes', 15000.00, 10, 5, NULL, NULL, 0, '2026-02-11 04:16:49', '2026-02-16 21:04:20'),
(11, 'Pan de Arequipe', 'PAN-77', '', 'Panes', 2000.00, 50, 10, NULL, NULL, 0, '2026-02-12 19:39:19', '2026-02-12 19:39:56'),
(12, 'Solterita', 'SOL-001', '', 'Pastelería', 2500.00, 24, 20, NULL, NULL, 1, '2026-02-16 18:14:20', '2026-03-03 21:19:13'),
(13, 'Pan de queso', 'PAN-0010', 'pAN D', 'Panes', 2500.00, 60, 10, NULL, NULL, 1, '2026-02-16 21:14:56', '2026-02-16 21:14:56'),
(14, 'Pastel 3 leches', 'PAS-002', 'Pastel artesanal de 3 leches', 'Pastelería', 15000.00, 20, 10, NULL, '/images/image-1771352444859-131714232.jpg', 0, '2026-02-17 18:20:44', '2026-02-17 20:44:51'),
(15, 'Pan Agridulce', 'PAN-004', 'Pan artesanal Agridulce', 'Panes', 1000.00, 15, 5, NULL, NULL, 1, '2026-02-17 18:28:39', '2026-02-17 20:42:54'),
(16, 'Pan de maiz', 'PAN-003', 'Pan artesanal de maiz', 'Panes', 1500.00, 15, 5, NULL, NULL, 1, '2026-02-17 18:38:44', '2026-02-17 18:38:44'),
(17, 'Pastel de Bocadillo', 'PAN-005', 'Pan artesanal de arequipe', 'Pastelería', 1500.00, 20, 10, NULL, NULL, 1, '2026-02-17 18:43:50', '2026-02-17 18:43:50'),
(18, 'Pan de Aceite', 'PAN-ACEITE-001', NULL, 'Panadería', 5000.00, 100, 10, NULL, NULL, 1, '2026-03-02 18:34:50', '2026-03-15 15:49:09'),
(19, 'Test Producto', 'TST-999', NULL, 'Panes', 1500.00, 10, 5, NULL, NULL, 1, '2026-03-11 20:17:42', '2026-03-11 20:17:42'),
(20, 'Test Producto EDITADO', 'TST-001-JSON', 'Desc editada', 'Tortas', 2000.00, 20, 3, '2026-12-31', NULL, 0, '2026-03-11 20:17:54', '2026-03-11 20:18:08'),
(21, 'demo', 'de-123', '', 'Muffins', 123.00, 23, 2, '2026-04-04', NULL, 1, '2026-03-11 20:21:25', '2026-03-11 20:26:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Administrador General', 'Acceso total al sistema', '2026-03-11 17:32:55', '2026-03-11 17:32:55'),
(2, 'Supervisor de Stock', 'Responsable de inventario y suministros', '2026-03-11 17:32:55', '2026-03-11 17:32:55'),
(3, 'Encargado de Ventas', 'Encargado de ventas y facturaciÃ³n', '2026-03-11 17:32:55', '2026-03-11 17:32:55'),
(4, 'Panadero', 'Responsable de la producciÃ³n', '2026-03-11 17:32:55', '2026-03-11 17:32:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `id` int NOT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int DEFAULT NULL,
  `customer_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT '0.00',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales_orders`
--

INSERT INTO `sales_orders` (`id`, `order_number`, `customer_id`, `customer_name`, `order_date`, `delivery_date`, `total_amount`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'VNT-2026-001', 6, 'Cliente Prueba', '2026-03-11 18:26:42', NULL, 250000.00, 'pending', NULL, '2026-03-11 18:26:42', '2026-03-11 18:26:42'),
(2, 'VNT-2026-011', NULL, '22222', '2026-03-11 19:39:07', '2026-03-11', 2500.00, 'pending', NULL, '2026-03-11 19:39:07', '2026-03-11 19:39:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_order_insumos`
--

CREATE TABLE `sales_order_insumos` (
  `id` int NOT NULL,
  `sales_order_id` int NOT NULL,
  `insumo_id` int DEFAULT NULL,
  `quantity_required` decimal(10,2) DEFAULT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_order_items`
--

CREATE TABLE `sales_order_items` (
  `id` int NOT NULL,
  `sales_order_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales_order_items`
--

INSERT INTO `sales_order_items` (`id`, `sales_order_id`, `product_id`, `quantity`, `unit_price`, `total`, `created_at`) VALUES
(1, 2, 5, 1, 2500.00, 2500.00, '2026-03-11 19:39:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales_reports`
--

CREATE TABLE `sales_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `report_date` date DEFAULT NULL,
  `total_sales` decimal(10,2) DEFAULT NULL,
  `total_purchases` decimal(10,2) DEFAULT NULL,
  `product_category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity_sold` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint UNSIGNED NOT NULL,
  `company_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_terms` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `suppliers`
--

INSERT INTO `suppliers` (`id`, `company_name`, `contact_person`, `email`, `phone`, `address`, `city`, `country`, `payment_terms`, `category`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Molinos del Valle', 'Carlos Ruiz', 'carlos@molinosvalle.com', '3012121226', 'Carretera Valencia Km 5', 'Cartagena', 'Spain', 'Net 30', 'Esencias y Sabores', 0, '2026-02-10 19:31:16', '2026-02-19 19:03:48'),
(2, 'Azucar & Ci', 'Mari­a Santos', 'maria@azucarycia.com', '3102555654', 'Avda Industrial 120', 'Rionegro', 'Colombia', 'Net 60', 'Harinas y Granos', 1, '2026-02-10 19:31:16', '2026-03-15 15:49:59'),
(3, 'Insumos Panaderos', 'Juan Di­az', 'juan@insumospanaderos.com', '3114122545', 'Poli­gono Industrial 45', 'Cúcuta', 'Spain', 'Net 45', 'Lácteos', 0, '2026-02-10 19:31:16', '2026-03-15 15:52:53'),
(4, 'Lacteos Premium', 'Ana Moreno', 'ana@lacteospremo.com', '3102255665', 'Calle Ganaderia 78', 'Bogotá', 'Spain', 'Net 30', 'Lácteos', 0, '2026-02-10 19:31:16', '2026-03-15 15:52:48'),
(5, 'Granja El Porvenir', 'Pedro Lopez', 'pedro@granjaporvenir.com', '3145455632', 'Finca Rural 23', 'Medellín', 'Spain', 'Net 15', 'Frutas y Conservas', 0, '2026-02-10 19:31:16', '2026-03-15 15:50:23'),
(6, 'Chocolates Finos', 'Isabel Garci­a', 'isabel@chocolatefinos.com', '3112345688', 'Calle Cacao 56', 'Medellin', 'Colombia', 'Net 60', 'Esencias y Sabores', 1, '2026-02-10 19:31:16', '2026-03-15 15:51:38'),
(7, 'Distribuidora Central', 'Roberto Silva', 'roberto@distcentral.com', '3125645855', 'Centro Logi­stico 33', 'Bogota', 'Colombia', 'Net 45', 'Frutas y Conservas', 1, '2026-02-10 19:31:16', '2026-03-15 15:51:05'),
(8, 'SENA', 'Alejandro', 'alejandrob0420@gmail.com', '3135445977', 'calle xxxx #34 - 09', 'Rionegro', 'Colombia', '', 'Harinas y Granos', 1, '2026-02-12 19:42:47', '2026-03-10 23:28:16'),
(9, 'Distribuidora del oriente', 'Alex Mesa', 'AlexM@gmail.com', '3144566558', 'Calle 45 #23-21', 'Rionegro', '', '', 'Esencias y Sabores', 1, '2026-02-25 20:48:53', '2026-02-25 20:48:53'),
(10, 'JMEZA', '22', '2', '2', '2', 'Quibdó', '', '', 'Lácteos', 1, '2026-03-11 19:38:35', '2026-03-11 19:38:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplies`
--

CREATE TABLE `supplies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT '0',
  `min_stock_level` int DEFAULT '10',
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_id` bigint UNSIGNED DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `supplies`
--

INSERT INTO `supplies` (`id`, `name`, `sku`, `description`, `category_id`, `price`, `stock_quantity`, `min_stock_level`, `unit`, `image_url`, `supplier_id`, `expiry_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Harina de Trigo', 'SUP-001', 'Harina premium', 1, 4.50, 520, 100, 'kg', NULL, NULL, NULL, 1, '2026-03-15 20:15:10', '2026-03-15 20:36:57'),
(2, 'Azúcar Blanca', 'SUP-002', 'Azúcar refinada', 2, 3.20, 212, 80, 'kg', NULL, NULL, NULL, 1, '2026-03-15 20:15:10', '2026-03-15 20:37:23'),
(3, 'Mantequilla', 'SUP-004', 'Mantequilla premium', 4, 12.00, 80, 30, 'kg', NULL, NULL, NULL, 1, '2026-03-15 20:15:10', '2026-03-15 20:15:10'),
(4, 'Huevos Frescos', 'SUP-005', 'Huevos de granja', 4, 0.60, 500, 150, 'docena', NULL, NULL, NULL, 1, '2026-03-15 20:15:10', '2026-03-15 20:15:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplies_movements`
--

CREATE TABLE `supplies_movements` (
  `id` bigint UNSIGNED NOT NULL,
  `supply_id` bigint UNSIGNED NOT NULL,
  `movement_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'ajuste',
  `quantity_change` int NOT NULL,
  `previous_quantity` int DEFAULT '0',
  `new_quantity` int DEFAULT '0',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `supplies_movements`
--

INSERT INTO `supplies_movements` (`id`, `supply_id`, `movement_type`, `quantity_change`, `previous_quantity`, `new_quantity`, `reason`, `notes`, `user_id`, `created_at`) VALUES
(1, 1, 'entrada', 20, 500, 520, 'Test movimiento', '', 1, '2026-03-15 20:36:57'),
(2, 2, 'entrada', 12, 200, 212, '', 'Movimiento desde interfaz - 15/3/2026, 3:37:23 p. m.', 1, '2026-03-15 20:37:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role_id` int DEFAULT '1',
  `must_change_password` tinyint(1) DEFAULT '0',
  `reset_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reset_token_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `role`, `created_at`, `updated_at`, `role_id`, `must_change_password`, `reset_token`, `reset_token_expires`) VALUES
(4, 'admin', 'admin@pansoft.com', '$2b$10$v3WuKYF2jeoeVLvoM8OYNuSMYeXKGQg0EZbPKsSJh8L2ZQ2a/rrOG', 'Administrador', 'admin', '2026-02-15 21:47:36', '2026-02-25 19:09:47', 1, 0, NULL, NULL),
(5, 'user', 'user@pansoft.com', '$2b$10$ikG252.ATMOvPr8ws4xGKusxFF1oOnIor6ceq7omd.1cwu4KTLY1W', 'Usuario Test', 'user', '2026-02-15 21:47:36', '2026-02-15 21:47:36', 1, 0, NULL, NULL),
(6, 'vendedor', 'vendedor@pansoft.com', '$2b$10$bqxf9QHFoJbtXxnUCFbPeOprm7b9qtP64Jz62CnToCUZRSfz6Kt2K', 'Juan Vendedor', 'user', '2026-02-15 21:47:36', '2026-02-25 18:54:01', 3, 0, NULL, NULL),
(8, 'stock1', 'stock@pansoft.com', '$2b$10$fIAddY26rqkhSj84EKz2G.V3KgES112yGg.MDnzwe.QKAPaq8hl/m', NULL, 'user', '2026-02-25 18:54:01', '2026-02-25 19:09:47', 2, 0, NULL, NULL),
(10, 'panadero1', 'panadero@pansoft.com', '$2b$10$If7kraM9R6cQs31M/80NZ.4Uq.le.9zt2a3jlaewxIDuxnxxJCIpC', NULL, 'user', '2026-02-25 18:54:01', '2026-02-25 19:09:48', 4, 0, NULL, NULL),
(15, 'vendedor1', 'vendedor1@pansoft.com', '$2b$10$0tGVtxgM29RuqcEEfEoHZO/9r9cmayvC9St6xHwcdvDN3RtEUSknK', NULL, 'user', '2026-02-25 19:15:05', '2026-02-25 19:15:05', 3, 0, NULL, NULL),
(16, 'Carolina', 'caro76@gmail.com', '$2b$10$SKp0GQ8YopdDswr38g9tkuunavlIN.rQ0cxctpWCn40TaBXh1Q6yC', 'Carolina Cepeda', 'user', '2026-03-10 16:28:25', '2026-03-10 16:28:25', 4, 1, NULL, NULL),
(17, 'Laura', 'Laura@gmail.com', '$2b$10$/m9PbpITjHpf7fCv.Waa6uPjE8yokcZ6RnlVxHG14kTj9TUmujxoC', 'Laura Acosta', 'user', '2026-03-10 16:35:05', '2026-03-10 16:39:41', 4, 0, NULL, NULL),
(18, 'cata', 'cata@gmail.com', '$2b$10$lhb2kord.mnfQAM.xj/fY.RYEzkXE2hnr21vWMN8gnqDfHCrsavGq', 'Catalina Gomez', 'user', '2026-03-10 21:35:08', '2026-03-10 21:35:44', 4, 0, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_id` (`product_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indices de la tabla `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `invoice_number` (`invoice_number`);

--
-- Indices de la tabla `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_invoice_id` (`invoice_id`);

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
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`);

--
-- Indices de la tabla `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

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
  ADD UNIQUE KEY `order_number` (`order_number`);

--
-- Indices de la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_order_id` (`production_order_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

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
  ADD UNIQUE KEY `order_number` (`order_number`);

--
-- Indices de la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_order_id` (`sales_order_id`);

--
-- Indices de la tabla `sales_order_items`
--
ALTER TABLE `sales_order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sales_reports`
--
ALTER TABLE `sales_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indices de la tabla `supplies`
--
ALTER TABLE `supplies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `fk_supplies_category` (`category_id`),
  ADD KEY `fk_supplies_supplier` (`supplier_id`);

--
-- Indices de la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_movements_supply` (`supply_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `production_orders`
--
ALTER TABLE `production_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=358;

--
-- AUTO_INCREMENT de la tabla `sales_orders`
--
ALTER TABLE `sales_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sales_order_items`
--
ALTER TABLE `sales_order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `sales_reports`
--
ALTER TABLE `sales_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `supplies`
--
ALTER TABLE `supplies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventory_movements`
--
ALTER TABLE `inventory_movements`
  ADD CONSTRAINT `inventory_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `production_order_insumos`
--
ALTER TABLE `production_order_insumos`
  ADD CONSTRAINT `production_order_insumos_ibfk_1` FOREIGN KEY (`production_order_id`) REFERENCES `production_orders` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `sales_order_insumos`
--
ALTER TABLE `sales_order_insumos`
  ADD CONSTRAINT `sales_order_insumos_ibfk_1` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `supplies`
--
ALTER TABLE `supplies`
  ADD CONSTRAINT `fk_supplies_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_supplies_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `supplies_movements`
--
ALTER TABLE `supplies_movements`
  ADD CONSTRAINT `fk_movements_supply` FOREIGN KEY (`supply_id`) REFERENCES `supplies` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
