-- Seed data for table: suppliers
-- Extracted from: pansoft_db.sql

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