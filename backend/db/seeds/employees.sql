-- Seed data for table: employees
-- Extracted from: pansoft_db.sql

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