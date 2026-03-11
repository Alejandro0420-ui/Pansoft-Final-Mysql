-- Seed data for table: invoices
-- Extracted from: pansoft_db.sql

INSERT INTO `invoices` (`id`, `invoice_number`, `order_id`, `customer_id`, `issue_date`, `due_date`, `total_amount`, `paid_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 'INV-2024-001', 1, NULL, '2026-02-10', '2026-03-12', 2999.97, NULL, 'paid', '2026-02-10 19:31:16', '2026-02-10 21:14:33'),
(2, 'INV-2024-002', 2, NULL, '2026-02-10', '2026-03-12', 849.97, NULL, 'pending', '2026-02-10 19:31:16', '2026-02-10 20:54:48'),
(3, 'INV-2024-003', 3, NULL, '2026-02-10', '2026-03-12', 3199.95, NULL, 'paid', '2026-02-10 19:31:16', '2026-02-10 21:14:35'),
(4, 'FAC-1770758090294', NULL, NULL, '2026-02-10', '2026-02-10', 4500.00, 0.00, 'pending', '2026-02-10 21:15:39', '2026-02-10 21:15:39'),
(5, 'FAC-1770758149791', NULL, NULL, '2026-02-10', '2026-02-09', 450000.00, 0.00, 'pending', '2026-02-10 21:16:22', '2026-02-10 21:16:22');