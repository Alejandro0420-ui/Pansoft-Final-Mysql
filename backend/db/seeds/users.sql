-- Seed data for table: users
-- Extracted from: pansoft_db.sql

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