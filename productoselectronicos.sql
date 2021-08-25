-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-08-2021 a las 07:09:03
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `productoselectronicos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteproduct` (IN `pidproducto` INT)  BEGIN
declare pidfabricante int;

select Idfabricante from productos as p inner join direcciones as d on p.Idfabricante = d.Iddireccion where p.idproducto = pidproducto into pidfabricante;

delete from productos where idproducto = pidproducto;
delete from direcciones where Iddireccion = pidfabricante;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletetemporalprod` (IN `pidproducto` INT)  begin

update productos set Status = 0 where idproducto = pidproducto;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modifyproduct` (IN `pidproducto` INT, IN `pnombre` VARCHAR(60), IN `pfecha` DATE, IN `pcalle` VARCHAR(60), IN `pcolonia` VARCHAR(60), IN `pcodigopostal` INT, IN `pestado` VARCHAR(60), IN `ppais` VARCHAR(60))  BEGIN
declare piddireccion int;

update productos set Nombre = pnombre, Fecharegistro = pfecha  where idproducto = pidproducto;

select Idfabricante  from productos as p inner join direcciones as d on p.Idfabricante = d.Iddireccion where idproducto = pidproducto into piddireccion;

update direcciones set Calle = pcalle, Colonia = pcolonia, CodigoPostal = pcodigopostal, Estado = pestado, Pais = ppais where Iddireccion = piddireccion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registerproduct` (IN `pnombre` VARCHAR(60), IN `pfecha` DATE, IN `pcalle` VARCHAR(60), IN `pcolonia` VARCHAR(60), IN `pcodigopostal` INT, IN `pestado` VARCHAR(60), IN `ppais` VARCHAR(60))  BEGIN
declare idfabricante int;
insert into direcciones(Calle,Colonia,CodigoPostal,Estado,Pais) VALUES(pcalle,pcolonia,pcodigopostal,pestado,ppais);
SELECT LAST_INSERT_ID() INTO idfabricante;
insert into productos(Nombre,Fecharegistro,Idfabricante,Status) VALUES(pnombre,pfecha,idfabricante,1);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones`
--

CREATE TABLE `direcciones` (
  `Iddireccion` int(11) NOT NULL,
  `Calle` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Colonia` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `CodigoPostal` int(11) DEFAULT NULL,
  `Estado` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Pais` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `direcciones`
--

INSERT INTO `direcciones` (`Iddireccion`, `Calle`, `Colonia`, `CodigoPostal`, `Estado`, `Pais`) VALUES
(5, 'Jardines Mosos 23', 'Las Rosas', 85987, 'Morelos', 'México'),
(6, 'Las rosas 12', 'Las Rosas', 85987, 'Morelos', 'México'),
(7, 'Limones #32', 'Las Rosas', 85471, 'Campeche', 'Mexico'),
(9, 'Jardines 23', 'maratonar', 85987, 'Campeche', 'México');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL,
  `Nombre` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Fecharegistro` date DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `Idfabricante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproducto`, `Nombre`, `Fecharegistro`, `Status`, `Idfabricante`) VALUES
(2, 'Amd Ryzeb 3 3300x', '2021-08-24', 1, 5),
(3, 'Amd Ryzen 5 3400g', '2021-08-24', 1, 6),
(4, 'GTX 730', '2021-08-24', 0, 7),
(6, 'Intel core i9 11500k', '2021-08-25', 1, 9);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  ADD PRIMARY KEY (`Iddireccion`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `fk_direcciones_productos` (`Idfabricante`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `direcciones`
--
ALTER TABLE `direcciones`
  MODIFY `Iddireccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_direcciones_productos` FOREIGN KEY (`Idfabricante`) REFERENCES `direcciones` (`Iddireccion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
