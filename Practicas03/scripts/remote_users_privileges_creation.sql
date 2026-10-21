-- =====================================================
-- ELIMINAR USUARIOS SI YA EXISTEN
-- =====================================================

DROP USER IF EXISTS 'marco.ramirez'@'%';
DROP USER IF EXISTS 'jhon.gonzalez'@'%';
DROP USER IF EXISTS 'pablo.martinez'@'%';
DROP USER IF EXISTS 'mayte.gutierrez'@'%';
DROP USER IF EXISTS 'rene.gonzalez'@'%';
DROP USER IF EXISTS 'sam.pil'@'%';
DROP USER IF EXISTS 'diego.g'@'%';
DROP USER IF EXISTS 'jenny.cm'@'%';
DROP USER IF EXISTS 'mario.banda'%'@';


-- =====================================================
-- CREAR USUARIOS
-- =====================================================

CREATE USER 'marco.ramirez'@'%'
IDENTIFIED BY 'qwerty123';

CREATE USER 'mario.banda'@'%';
IDENTIFIED BY '240597';

CREATE USER 'jhon.gonzalez'@'%'
IDENTIFIED BY '240080';

CREATE USER 'pablo.martinez'@'%'
IDENTIFIED BY '240701';

CREATE USER 'mayte.gutierrez'@'%'
IDENTIFIED BY '240174';

CREATE USER 'rene.gonzalez'@'%'
IDENTIFIED BY '240107';

CREATE USER 'sam.pil'@'%'
IDENTIFIED BY '240023';

CREATE USER 'diego.g'@'%'
IDENTIFIED BY '240709';

CREATE USER 'jenny.cm'@'%'
IDENTIFIED BY '240556';


-- =====================================================
-- ELIMINAR ROLES SI YA EXISTEN
-- =====================================================

DROP ROLE IF EXISTS 'admin';
DROP ROLE IF EXISTS 'seller';
DROP ROLE IF EXISTS 'buyer';
DROP ROLE IF EXISTS 'support';
DROP ROLE IF EXISTS 'usuario sin rol';


-- =====================================================
-- CREAR ROLES
-- =====================================================

CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'support';
CREATE ROLE 'usuario sin rol';


-- =====================================================
-- PRIVILEGIOS DEL ROL ADMIN
-- =====================================================

GRANT ALL PRIVILEGES
ON *.*
TO 'admin'
WITH GRANT OPTION;


-- =====================================================
-- PRIVILEGIOS DEL ROL SUPPORT
-- =====================================================

GRANT SELECT, INSERT, UPDATE
ON `db_test_7b`.`tb_users`
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON `db_test_7b`.`tb_products`
TO 'support';

GRANT SELECT, INSERT, UPDATE
ON `db_test_7b`.`tbd_products_categorias`
TO 'support';



-- =====================================================
-- PRIVILEGIOS DEL ROL SELLER
-- =====================================================

GRANT SELECT, INSERT, UPDATE
ON `db_test_7b`.`tb_products`
TO 'seller';


-- =====================================================
-- PRIVILEGIOS DEL ROL BUYER
-- =====================================================

GRANT SELECT
ON `db_test_7b`.`tb_products`
TO 'buyer';


-- =====================================================
-- PRIVILEGIOS DEL ROL USER_NOT_REGISTERED
-- =====================================================

GRANT SELECT
ON `db_test_7b`.`tb_products`
TO 'usuarion sin rol';


-- =====================================================
-- SUPER ADMIN DIRECTO PARA JHON
-- =====================================================

GRANT ALL PRIVILEGES
ON *.*
TO 'jhon.gonzalez'@'%'
WITH GRANT OPTION;


-- =====================================================
-- PRIVILEGIOS DIRECTOS PARA SAMUEL
-- =====================================================

GRANT SELECT, INSERT, UPDATE, DELETE 
ON `db_test_7b`.`tb_users` 
TO 'sam.pil'@'%';


-- =====================================================
-- PRIVILEGIOS DIRECTOS PARA PABLO
-- =====================================================

GRANT SELECT, INSERT, UPDATE, DELETE
ON `db_test_7b`.*
TO 'pablo.martinez'@'%';


-- =====================================================
-- PRIVILEGIOS DIRECTOS PARA RENE
-- =====================================================

GRANT SELECT, INSERT, UPDATE, DELETE
ON `db_test_7b`.*
TO 'rene.gonzalez'@'%';


-- =====================================================
-- ASIGNAR ROLES A USUARIOS
-- =====================================================

GRANT 'admin'
TO 'marco.ramirez'@'%';

GRANT 'support'
TO 'pablo.martinez'@'%';

GRANT 'seller' #2
TO 'rene.gonzalez'@'%';

GRANT 'seller' #1
TO 'jenny.cm'@'%';

GRANT 'seller'
TO 'diego.g'@'%';

GRANT 'seller'
TO 'sam.pil'@'%';


-- =====================================================
-- ACTIVAR ROLES POR DEFECTO
-- =====================================================

SET DEFAULT ROLE 'admin'
TO 'marco.ramirez'@'%';

SET DEFAULT ROLE 'support'
TO 'pablo.martinez'@'%';

SET DEFAULT ROLE 'seller'
TO 'rene.gonzalez'@'%';

SET DEFAULT ROLE 'seller'
TO 'jenny.cm'@'%';

SET DEFAULT ROLE 'seller'
TO 'diego.g'@'%';

SET DEFAULT ROLE 'seller'
TO 'sam.pil'@'%';


-- =====================================================
-- RECARGAR PRIVILEGIOS
-- =====================================================

FLUSH PRIVILEGES;