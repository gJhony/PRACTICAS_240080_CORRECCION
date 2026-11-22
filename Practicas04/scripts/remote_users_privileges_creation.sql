-- =====================================================
-- ELIMINAR USUARIOS SI YA EXISTEN
-- =====================================================

DROP USER IF EXISTS 'app_web'@'%';
DROP USER IF EXISTS 'app_mobile'@'%';
DROP USER IF EXISTS 'marco.ramirez'@'%';
DROP USER IF EXISTS 'jhon.gonzalez'@'%';
DROP USER IF EXISTS 'pablo.martinez'@'%';
DROP USER IF EXISTS 'mayte.gutierrez'@'%';
DROP USER IF EXISTS 'rene.gonzalez'@'%';
DROP USER IF EXISTS 'sam.pil'@'%';
DROP USER IF EXISTS 'diego.g'@'%';
DROP USER IF EXISTS 'jenny.cm'@'%';
DROP USER IF EXISTS 'mario.banda'@'%';

-- =====================================================
-- CREAR USUARIOS
-- =====================================================

CREATE USER 'app_web'@'%' IDENTIFIED BY 'web123';
CREATE USER 'app_mobile'@'%' IDENTIFIED BY 'mobile890';
CREATE USER 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER 'mario.banda'@'%' IDENTIFIED BY '240597';
CREATE USER 'jhon.gonzalez'@'%' IDENTIFIED BY '240080';
CREATE USER 'pablo.martinez'@'%' IDENTIFIED BY '240701';
CREATE USER 'mayte.gutierrez'@'%' IDENTIFIED BY '240174';
CREATE USER 'rene.gonzalez'@'%' IDENTIFIED BY '240107';
CREATE USER 'sam.pil'@'%' IDENTIFIED BY '240023';
CREATE USER 'diego.g'@'%' IDENTIFIED BY '240709';
CREATE USER 'jenny.cm'@'%' IDENTIFIED BY '240556';


-- =====================================================
-- ELIMINAR ROLES SI YA EXISTEN (Los 7 roles requeridos)
-- =====================================================

DROP ROLE IF EXISTS 'superadmin';
DROP ROLE IF EXISTS 'admin';
DROP ROLE IF EXISTS 'support';
DROP ROLE IF EXISTS 'seller';
DROP ROLE IF EXISTS 'buyer';
DROP ROLE IF EXISTS 'common_user';
DROP ROLE IF EXISTS 'user_not_registered';


-- =====================================================
-- CREAR LOS 7 ROLES DEL SISTEMA
-- =====================================================

CREATE ROLE 'superadmin';
CREATE ROLE 'admin';
CREATE ROLE 'support';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'common_user';
CREATE ROLE 'user_not_registered';


-- =====================================================
-- PRIVILEGIOS DE LOS ROLES SOBRE LAS TABLAS OPERATIVAS
-- =====================================================

-- 1. SUPERADMIN (Acceso total absoluto)
GRANT ALL PRIVILEGES ON *.* TO 'superadmin' WITH GRANT OPTION;

-- 2. ADMIN (Administración general)
GRANT ALL PRIVILEGES ON `db_test_7b`.* TO 'admin';

-- 3. SUPPORT (Soporte técnico y revisión)
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_users` TO 'support';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_products` TO 'support';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tbd_products_categories` TO 'support';

-- 4. SELLER (Gestión de productos propios)
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_products` TO 'seller';

-- 5. BUYER (Compra, pago, orden atendida y envío)
GRANT SELECT ON `db_test_7b`.`tb_products` TO 'buyer';
GRANT SELECT ON `db_test_7b`.`tb_users` TO 'buyer';
GRANT SELECT ON `db_test_7b`.`tb_people` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_carts` TO 'buyer';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.`tbd_carts_items` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_buyer_orders` TO 'buyer';
GRANT SELECT, INSERT ON `db_test_7b`.`tbd_order_items` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_user_addresses` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tbd_address_components` TO 'buyer';
GRANT SELECT ON `db_test_7b`.`tbc_payment_methods_types` TO 'buyer';
GRANT SELECT, INSERT ON `db_test_7b`.`tb_payment_methods` TO 'buyer';
GRANT SELECT, INSERT ON `db_test_7b`.`tbd_user_payment_methods` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_payments` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_payment_transactions` TO 'buyer';
GRANT SELECT ON `db_test_7b`.`tbc_shipping_carriers` TO 'buyer';
GRANT SELECT, INSERT, UPDATE ON `db_test_7b`.`tb_shipments` TO 'buyer';

-- 6. COMMON_USER (Usuario registrado general)
GRANT SELECT ON `db_test_7b`.`tb_products` TO 'common_user';
GRANT SELECT, UPDATE ON `db_test_7b`.`tb_users` TO 'common_user';

-- 7. USER_NOT_REGISTERED (Usuario no registrado, acceso limitado)

GRANT INSERT, SELECT ON `db_test_7b`.`tb_people` TO 'user_not_registered';
GRANT INSERT, SELECT ON `db_test_7b`.`tb_users` TO 'user_not_registered';
GRANT SELECT ON `db_test_7b`.`tb_products` TO 'user_not_registered';
GRANT INSERT, SELECT, UPDATE ON `db_test_7b`.`tb_carts` TO 'user_not_registered';
GRANT INSERT, SELECT, UPDATE, DELETE ON `db_test_7b`.`tbd_carts_items` TO 'user_not_registered';
GRANT INSERT, SELECT, UPDATE ON `db_test_7b`.`tb_buyer_orders` TO 'user_not_registered';
GRANT INSERT, SELECT ON `db_test_7b`.`tbd_order_items` TO 'user_not_registered';
GRANT INSERT, SELECT, UPDATE ON `db_test_7b`.`tb_user_addresses` TO 'user_not_registered';
GRANT INSERT, SELECT, UPDATE ON `db_test_7b`.`tbd_address_components` TO 'user_not_registered';
GRANT EXECUTE ON PROCEDURE `db_test_7b`.`sp_register_new_user` TO 'user_not_registered';
GRANT SELECT ON `db_test_7b`.`tbd_products_users_providers` TO 'user_not_registered';
FLUSH PRIVILEGES;

-- =====================================================
-- ASIGNACIÓN DE ROLES A CUENTAS DE USUARIO
-- =====================================================

-- Superadmin directo para Jhon
GRANT 'superadmin' TO 'jhon.gonzalez'@'%';

-- Admin para Marco
GRANT 'admin' TO 'marco.ramirez'@'%';

-- Support para Pablo
GRANT 'support' TO 'pablo.martinez'@'%';

-- Sellers para René, Jenny, Diego y Samuel
GRANT 'seller' TO 'rene.gonzalez'@'%';
GRANT 'seller' TO 'jenny.cm'@'%';
GRANT 'seller' TO 'diego.g'@'%';
GRANT 'seller' TO 'sam.pil'@'%';

-- Apps móviles y web con rol de usuario no registrado
GRANT 'user_not_registered' TO 'app_web'@'%';
GRANT 'user_not_registered' TO 'app_mobile'@'%';


-- =====================================================
-- CONFIGURAR ROLES QUE DEBERÁN ACTIVARSE POR DEFECTO
-- =====================================================

SET DEFAULT ROLE 'superadmin' TO 'jhon.gonzalez'@'%';
SET DEFAULT ROLE 'admin' TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'support' TO 'pablo.martinez'@'%';
SET DEFAULT ROLE 'seller' TO 'rene.gonzalez'@'%';
SET DEFAULT ROLE 'seller' TO 'jenny.cm'@'%';
SET DEFAULT ROLE 'seller' TO 'diego.g'@'%';
SET DEFAULT ROLE 'seller' TO 'sam.pil'@'%';
SET DEFAULT ROLE 'user_not_registered' TO 'app_web'@'%';
SET DEFAULT ROLE 'user_not_registered' TO 'app_mobile'@'%';




-- =====================================================
-- RECARGAR PRIVILEGIOS
-- =====================================================

FLUSH PRIVILEGES;