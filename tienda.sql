/*
Url:
http://localhost/phpmyadmin/



Basic database example:
-Create database storage
-create table client(
pk_client smallint not null primary key AUTO_INCREMENT,
name varchar(50) not null,
surname varchar(30) not null,
age smallint not null,
gender char(1) not null,
status smallint not null
);



Triggers:
1
CREATE TRIGGER bit_pod
AFTER INSERT ON producto
FOR EACH ROW
INSERT INTO bitacora_producto VALUES(NULL,'Reg',NEW.pk_producto,CURRENT_DATE); 
2
CREATE TRIGGER bit_fab
AFTER INSERT ON fabricante
FOR EACH ROW
INSERT INTO bitacora_fabricante VALUES(NULL,'Reg',NEW.pk_fabricante,CURRENT_DATE);
3
CREATE TRIGGER stock 
AFTER INSERT ON detalle_venta
FOR EACH ROW
UPDATE producto SET stock=stock-NEW.cantidad WHERE pk_producto=NEW.fk_producto



Procedures:
1
DELIMITER $$
CREATE PROCEDURE show_info() 
BEGIN
SELECT CONCAT(nombre,' ',apellidos) AS 'Client' FROM cliente;
END $$
CALL show_info();
2
DELIMITER $$
CREATE PROCEDURE nam_cli() 
BEGIN
SELECT CONCAT(nombre,' ',apellidos) AS 'Client' FROM cliente c INNER JOIN venta v ON c.pk_cliente=v.fk_cliente;
END $$
Call nam_cli() 
3
DELIMITER $$
CREATE PROCEDURE insert_data(IN nombre VARCHAR(35), apellidos varchar(35))
BEGIN
INSERT INTO cliente VALUES(NULL, nombre, apellidos);
END $$
CALL insert_data("Roger","Miller");
*/

-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 19-07-2022 a las 16:11:17
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora_fabricante`
--

CREATE TABLE `bitacora_fabricante` (
  `pk_bitacora_fabricante` smallint(6) NOT NULL,
  `evento` text COLLATE utf8_spanish_ci NOT NULL,
  `fk_fabricante` smallint(6) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora_producto`
--

CREATE TABLE `bitacora_producto` (
  `pk_bitacora_producto` smallint(6) NOT NULL,
  `evento` text COLLATE utf8_spanish_ci NOT NULL,
  `fk_producto` smallint(6) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `pk_cliente` smallint(6) NOT NULL,
  `nombre` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(35) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `pk_detalle_venta` smallint(6) NOT NULL,
  `fk_producto` smallint(6) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fk_venta` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fabricante`
--

CREATE TABLE `fabricante` (
  `pk_fabricante` smallint(6) NOT NULL,
  `nom_fabricante` varchar(75) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `pk_producto` smallint(6) NOT NULL,
  `nom_prod` varchar(75) COLLATE utf8_spanish_ci NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `fk_fabricante` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `pk_venta` smallint(6) NOT NULL,
  `codigo_venta` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `iva` decimal(10,2) NOT NULL DEFAULT 0.00,
  `fk_cliente` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacora_fabricante`
--
ALTER TABLE `bitacora_fabricante`
  ADD PRIMARY KEY (`pk_bitacora_fabricante`),
  ADD KEY `fk_fabricante` (`fk_fabricante`);

--
-- Indices de la tabla `bitacora_producto`
--
ALTER TABLE `bitacora_producto`
  ADD PRIMARY KEY (`pk_bitacora_producto`),
  ADD KEY `fk_producto` (`fk_producto`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`pk_cliente`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`pk_detalle_venta`),
  ADD KEY `fk_producto` (`fk_producto`),
  ADD KEY `fk_venta` (`fk_venta`);

--
-- Indices de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`pk_fabricante`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`pk_producto`),
  ADD KEY `fk_fabricante` (`fk_fabricante`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`pk_venta`),
  ADD KEY `fk_cliente` (`fk_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacora_fabricante`
--
ALTER TABLE `bitacora_fabricante`
  MODIFY `pk_bitacora_fabricante` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bitacora_producto`
--
ALTER TABLE `bitacora_producto`
  MODIFY `pk_bitacora_producto` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `pk_cliente` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `pk_detalle_venta` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  MODIFY `pk_fabricante` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `pk_producto` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `pk_venta` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bitacora_fabricante`
--
ALTER TABLE `bitacora_fabricante`
  ADD CONSTRAINT `bitacora_fabricante_ibfk_1` FOREIGN KEY (`fk_fabricante`) REFERENCES `fabricante` (`pk_fabricante`);

--
-- Filtros para la tabla `bitacora_producto`
--
ALTER TABLE `bitacora_producto`
  ADD CONSTRAINT `bitacora_producto_ibfk_1` FOREIGN KEY (`fk_producto`) REFERENCES `producto` (`pk_producto`),
  ADD CONSTRAINT `bitacora_producto_ibfk_2` FOREIGN KEY (`fk_producto`) REFERENCES `producto` (`pk_producto`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`fk_producto`) REFERENCES `producto` (`pk_producto`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`fk_venta`) REFERENCES `venta` (`pk_venta`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`fk_fabricante`) REFERENCES `fabricante` (`pk_fabricante`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`fk_cliente`) REFERENCES `cliente` (`pk_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
