-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.21-MariaDB-1~jessie - mariadb.org binary distribution
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             9.4.0.5130
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para dhairline
DROP DATABASE IF EXISTS `dhairline`;
CREATE DATABASE IF NOT EXISTS `dhairline` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dhairline`;

-- Volcando estructura para tabla dhairline.aeropuerto
DROP TABLE IF EXISTS `aeropuerto`;
CREATE TABLE IF NOT EXISTS `aeropuerto` (
  `idAeropuerto` int(11) NOT NULL AUTO_INCREMENT,
  `iataAeropuerto` varchar(5) NOT NULL,
  `ciudadAeropuerto` varchar(20) NOT NULL,
  `paisAeropuerto` varchar(20) NOT NULL,
  PRIMARY KEY (`idAeropuerto`),
  UNIQUE KEY `iataAeropuerto` (`iataAeropuerto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.bebe
DROP TABLE IF EXISTS `bebe`;
CREATE TABLE IF NOT EXISTS `bebe` (
  `idBebe` int(11) NOT NULL AUTO_INCREMENT,
  `nombreBebe` varchar(50) DEFAULT NULL,
  `apellidosBebe` varchar(100) DEFAULT NULL,
  `dniBebe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idBebe`),
  UNIQUE KEY `dniBebe` (`dniBebe`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.bebe_back
DROP TABLE IF EXISTS `bebe_back`;
CREATE TABLE IF NOT EXISTS `bebe_back` (
  `idBebe` int(11) NOT NULL,
  `nombreBebe` varchar(50) NOT NULL,
  `apellidosBebe` varchar(100) NOT NULL,
  `dniBebe` varchar(50) NOT NULL,
  PRIMARY KEY (`idBebe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento dhairline.comprobarVuelos
DROP PROCEDURE IF EXISTS `comprobarVuelos`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `comprobarVuelos`(
	IN `ReservaID` INT



)
BEGIN
SELECT * INTO @idReserva, @vueloidaReserva, @vuelovueltaReserva, @codReserva, @pagadorReserva, @tarjetaReserva, @numViajerosReserva, @fechaReserva, @usuarioReserva, @precioReserva FROM reserva WHERE reserva.idReserva = ReservaID;
INSERT INTO reserva_back VALUES (@idReserva, @vueloidaReserva, @vuelovueltaReserva, @codReserva, @pagadorReserva, @tarjetaReserva, @numViajerosReserva, @fechaReserva, @usuarioReserva, @precioReserva);
IF @vuelovueltaReserva IS NOT NULL THEN
UPDATE reserva SET vueloidaReserva = NULL WHERE reserva.idReserva = @idReserva;
ELSE
DELETE FROM reserva WHERE reserva.idReserva = @idReserva;
END IF;
END//
DELIMITER ;

-- Volcando estructura para tabla dhairline.conexion
DROP TABLE IF EXISTS `conexion`;
CREATE TABLE IF NOT EXISTS `conexion` (
  `idConexion` int(11) NOT NULL AUTO_INCREMENT,
  `origenConexion` varchar(5) NOT NULL DEFAULT '0',
  `destinoConexion` varchar(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idConexion`),
  KEY `FK_ori.conexion_aeropuerto` (`origenConexion`),
  KEY `FK_des.conexion_aeropuerto` (`destinoConexion`),
  CONSTRAINT `FK_ori.conexion_aeropuerto` FOREIGN KEY (`origenConexion`) REFERENCES `aeropuerto` (`iataAeropuerto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.ocupacion
DROP TABLE IF EXISTS `ocupacion`;
CREATE TABLE IF NOT EXISTS `ocupacion` (
  `idOcupacion` int(11) NOT NULL AUTO_INCREMENT,
  `reservaOcupacion` int(11) NOT NULL,
  `pasajeroOcupacion` int(11) NOT NULL,
  `bebeOcupacion` int(11) DEFAULT NULL,
  `tipoOcupacion` varchar(50) NOT NULL,
  `asientoOcupacion` int(11) NOT NULL,
  `facturacionOcupacion` char(50) DEFAULT 'N',
  PRIMARY KEY (`idOcupacion`),
  KEY `FK_ocupacion_reserva` (`reservaOcupacion`),
  KEY `FK_ocupacion_pasajero` (`pasajeroOcupacion`),
  KEY `FK_ocupacion_bebe` (`bebeOcupacion`),
  CONSTRAINT `FK_ocupacion_bebe` FOREIGN KEY (`bebeOcupacion`) REFERENCES `bebe` (`idBebe`),
  CONSTRAINT `FK_ocupacion_pasajero` FOREIGN KEY (`pasajeroOcupacion`) REFERENCES `pasajero` (`idPasajero`),
  CONSTRAINT `FK_ocupacion_reserva` FOREIGN KEY (`reservaOcupacion`) REFERENCES `reserva` (`idReserva`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.ocupacion_back
DROP TABLE IF EXISTS `ocupacion_back`;
CREATE TABLE IF NOT EXISTS `ocupacion_back` (
  `idOcupacion` int(11) NOT NULL,
  `reservaOcupacion` int(11) NOT NULL,
  `pasajeroOcupacion` int(11) NOT NULL,
  `bebeOcupacion` int(11) DEFAULT NULL,
  `tipoOcupacion` varchar(50) NOT NULL,
  `asientoOcupacion` int(11) NOT NULL,
  `facturacionOcupacion` char(50) DEFAULT NULL,
  PRIMARY KEY (`idOcupacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.pagador
DROP TABLE IF EXISTS `pagador`;
CREATE TABLE IF NOT EXISTS `pagador` (
  `idPagador` int(11) NOT NULL AUTO_INCREMENT,
  `dniPagador` varchar(50) DEFAULT NULL,
  `nombrePagador` varchar(50) DEFAULT NULL,
  `apellidosPagador` varchar(50) DEFAULT NULL,
  `direccionPagador` varchar(100) DEFAULT NULL,
  `poblacionPagador` varchar(100) DEFAULT NULL,
  `usuarioPagador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPagador`),
  UNIQUE KEY `pasaportePagador` (`dniPagador`),
  KEY `FK_pagador_usuario` (`usuarioPagador`),
  CONSTRAINT `FK_pagador_usuario` FOREIGN KEY (`usuarioPagador`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.pasajero
DROP TABLE IF EXISTS `pasajero`;
CREATE TABLE IF NOT EXISTS `pasajero` (
  `idPasajero` int(11) NOT NULL AUTO_INCREMENT,
  `nombrePasajero` varchar(50) DEFAULT NULL,
  `apellidosPasajero` varchar(50) DEFAULT NULL,
  `pasaportePasajero` varchar(50) DEFAULT NULL,
  `cadpasaportePasajero` date DEFAULT NULL,
  `generoPasajero` varchar(10) DEFAULT NULL,
  `edadPasajero` varchar(50) DEFAULT NULL,
  `nacionalidadPasajero` varchar(50) DEFAULT NULL,
  `fechanacPasajero` date DEFAULT NULL,
  PRIMARY KEY (`idPasajero`),
  UNIQUE KEY `pasaportePasajero` (`pasaportePasajero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.pasajero_back
DROP TABLE IF EXISTS `pasajero_back`;
CREATE TABLE IF NOT EXISTS `pasajero_back` (
  `idPasajero` int(11) NOT NULL,
  `nombrePasajero` varchar(50) NOT NULL,
  `apellidosPasajero` varchar(50) NOT NULL,
  `pasaportePasajero` varchar(50) NOT NULL,
  `cadpasaportePasajero` date NOT NULL,
  `generoPasajero` varchar(10) NOT NULL,
  `edadPasajero` varchar(50) NOT NULL,
  `nacionalidadPasajero` varchar(50) NOT NULL,
  `fechanacPasajero` date NOT NULL,
  PRIMARY KEY (`idPasajero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.reserva
DROP TABLE IF EXISTS `reserva`;
CREATE TABLE IF NOT EXISTS `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `vueloidaReserva` int(11) DEFAULT NULL,
  `vuelovueltaReserva` int(11) DEFAULT NULL,
  `codReserva` varchar(50) NOT NULL,
  `pagadorReserva` int(11) NOT NULL,
  `tarjetaReserva` int(11) NOT NULL,
  `numviajerosReserva` int(11) NOT NULL,
  `fechaReserva` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuarioReserva` int(5) NOT NULL,
  `precioReserva` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  UNIQUE KEY `codReserva` (`codReserva`),
  KEY `FK_reserva_vuelo` (`vueloidaReserva`),
  KEY `FK_reserva_pagador` (`pagadorReserva`),
  KEY `FK_reserva_vuelo_vuelta` (`vuelovueltaReserva`),
  KEY `FK_reserva_usuario` (`usuarioReserva`),
  KEY `FK_reserva_tarjeta` (`tarjetaReserva`),
  CONSTRAINT `FK_reserva_pagador` FOREIGN KEY (`pagadorReserva`) REFERENCES `pagador` (`idPagador`),
  CONSTRAINT `FK_reserva_tarjeta` FOREIGN KEY (`tarjetaReserva`) REFERENCES `tarjeta` (`idTarjeta`),
  CONSTRAINT `FK_reserva_usuario` FOREIGN KEY (`usuarioReserva`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `FK_reserva_vuelo` FOREIGN KEY (`vueloidaReserva`) REFERENCES `vuelo` (`idVuelo`),
  CONSTRAINT `FK_reserva_vuelo_vuelta` FOREIGN KEY (`vuelovueltaReserva`) REFERENCES `vuelo` (`idVuelo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.reserva_back
DROP TABLE IF EXISTS `reserva_back`;
CREATE TABLE IF NOT EXISTS `reserva_back` (
  `idReserva` int(11) NOT NULL,
  `vueloidaReserva` int(11) NOT NULL,
  `vuelovueltaReserva` int(11) DEFAULT NULL,
  `codReserva` varchar(50) NOT NULL,
  `pagadorReserva` int(11) NOT NULL,
  `tarjetaReserva` int(11) NOT NULL,
  `numviajerosReserva` int(11) NOT NULL,
  `fechaReserva` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuarioReserva` int(5) NOT NULL,
  `precioReserva` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  UNIQUE KEY `codReserva` (`codReserva`),
  KEY `FK_reserva_pagador` (`pagadorReserva`),
  KEY `FK_reserva_usuario` (`usuarioReserva`),
  KEY `FK_reserva_tarjeta` (`tarjetaReserva`),
  CONSTRAINT `reserva_back_ibfk_1` FOREIGN KEY (`pagadorReserva`) REFERENCES `pagador` (`idPagador`),
  CONSTRAINT `reserva_back_ibfk_2` FOREIGN KEY (`tarjetaReserva`) REFERENCES `tarjeta` (`idTarjeta`),
  CONSTRAINT `reserva_back_ibfk_3` FOREIGN KEY (`usuarioReserva`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.servicio
DROP TABLE IF EXISTS `servicio`;
CREATE TABLE IF NOT EXISTS `servicio` (
  `idServicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombreServicio` varchar(20) DEFAULT NULL,
  `descripcionServicio` mediumtext,
  `precioServicio` int(11) DEFAULT NULL,
  PRIMARY KEY (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.servicioreserva
DROP TABLE IF EXISTS `servicioreserva`;
CREATE TABLE IF NOT EXISTS `servicioreserva` (
  `idRS` int(11) NOT NULL AUTO_INCREMENT,
  `ocupacionRS` int(11) DEFAULT NULL,
  `servicioRS` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRS`),
  KEY `FK_servicioreserva_ocupacion` (`ocupacionRS`),
  KEY `FK_servicioreserva_servicio` (`servicioRS`),
  CONSTRAINT `FK_servicioreserva_ocupacion` FOREIGN KEY (`ocupacionRS`) REFERENCES `ocupacion` (`idOcupacion`) ON DELETE CASCADE,
  CONSTRAINT `FK_servicioreserva_servicio` FOREIGN KEY (`servicioRS`) REFERENCES `servicio` (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.servicioreserva_back
DROP TABLE IF EXISTS `servicioreserva_back`;
CREATE TABLE IF NOT EXISTS `servicioreserva_back` (
  `idRS` int(11) NOT NULL,
  `ocupacionRS` int(11) DEFAULT NULL,
  `servicioRS` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRS`),
  KEY `FK_servicioreserva_servicio` (`servicioRS`),
  CONSTRAINT `servicioreserva_back_ibfk_1` FOREIGN KEY (`servicioRS`) REFERENCES `servicio` (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.tarjeta
DROP TABLE IF EXISTS `tarjeta`;
CREATE TABLE IF NOT EXISTS `tarjeta` (
  `idTarjeta` int(11) NOT NULL AUTO_INCREMENT,
  `usuarioTarjeta` int(11) NOT NULL,
  `numeroTarjeta` varchar(50) NOT NULL,
  `propietarioTarjeta` varchar(50) NOT NULL,
  `caducidadTarjeta` date NOT NULL,
  `codseguridadTarjeta` varchar(20) NOT NULL,
  `usosTarjeta` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idTarjeta`),
  UNIQUE KEY `numeroTarjeta` (`numeroTarjeta`),
  KEY `FK_tarjeta_pagador` (`usuarioTarjeta`),
  CONSTRAINT `FK_tarjeta_usuario` FOREIGN KEY (`usuarioTarjeta`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `emailUsuario` varchar(100) NOT NULL,
  `passUsuario` varchar(100) NOT NULL,
  `nombreUsuario` varchar(50) NOT NULL,
  `apellidosUsuario` varchar(100) NOT NULL,
  `telefonoUsuario` varchar(100) NOT NULL,
  `fechanacUsuario` date NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `emailUsuario` (`emailUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.vuelo
DROP TABLE IF EXISTS `vuelo`;
CREATE TABLE IF NOT EXISTS `vuelo` (
  `idVuelo` int(11) NOT NULL AUTO_INCREMENT,
  `conexionVuelo` int(11) NOT NULL DEFAULT '0',
  `numeroVuelo` varchar(50) DEFAULT '0',
  `fechaVuelo` date DEFAULT NULL,
  `horaSalidaVuelo` time DEFAULT NULL,
  `horaLlegadaVuelo` time DEFAULT NULL,
  `disponiblesVuelo` int(11) DEFAULT '0',
  `precioVuelo` int(11) DEFAULT '0',
  PRIMARY KEY (`idVuelo`),
  KEY `FK_vuelo_conexion` (`conexionVuelo`),
  CONSTRAINT `FK_vuelo_conexion` FOREIGN KEY (`conexionVuelo`) REFERENCES `conexion` (`idConexion`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla dhairline.vuelo_back
DROP TABLE IF EXISTS `vuelo_back`;
CREATE TABLE IF NOT EXISTS `vuelo_back` (
  `idVuelo` int(11) NOT NULL,
  `conexionVuelo` int(11) NOT NULL DEFAULT '0',
  `numeroVuelo` varchar(50) DEFAULT '0',
  `fechaVuelo` date DEFAULT NULL,
  `horaSalidaVuelo` time DEFAULT NULL,
  `horaLlegadaVuelo` time DEFAULT NULL,
  `disponiblesVuelo` int(11) DEFAULT '0',
  `precioVuelo` int(11) DEFAULT '0',
  PRIMARY KEY (`idVuelo`),
  KEY `FK_vuelo_conexion` (`conexionVuelo`),
  CONSTRAINT `vuelo_back_ibfk_1` FOREIGN KEY (`conexionVuelo`) REFERENCES `conexion` (`idConexion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para disparador dhairline.bebe_before_delete
DROP TRIGGER IF EXISTS `bebe_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `bebe_before_delete` BEFORE DELETE ON `bebe` FOR EACH ROW BEGIN
INSERT INTO bebe_back VALUES(old.idBebe, old.nombreBebe, old.apellidosBebe, old.dniBebe);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.ocupacion_after_delete
DROP TRIGGER IF EXISTS `ocupacion_after_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ocupacion_after_delete` AFTER DELETE ON `ocupacion` FOR EACH ROW BEGIN

SELECT COUNT(idOcupacion) INTO @cantidad FROM ocupacion WHERE pasajeroOcupacion = old.pasajeroOcupacion;
IF @cantidad = 0 THEN
DELETE FROM pasajero WHERE idPasajero = old.pasajeroOcupacion;
END IF;

SELECT COUNT(idOcupacion) INTO @cantidadbebe FROM ocupacion WHERE bebeOcupacion = old.bebeOcupacion;
IF @cantidadbebe = 0 THEN
DELETE FROM bebe WHERE idBebe = old.bebeOcupacion;
END IF;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.ocupacion_before_delete
DROP TRIGGER IF EXISTS `ocupacion_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `ocupacion_before_delete` BEFORE DELETE ON `ocupacion` FOR EACH ROW BEGIN
INSERT INTO ocupacion_back VALUES (old.idOcupacion, old.reservaOcupacion, old.pasajeroOcupacion, old.bebeOcupacion, old.tipoOcupacion, old.asientoOcupacion, old.facturacionOcupacion);
DELETE FROM servicioreserva WHERE ocupacionRS = old.idOcupacion;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.pasajero_before_delete
DROP TRIGGER IF EXISTS `pasajero_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `pasajero_before_delete` BEFORE DELETE ON `pasajero` FOR EACH ROW BEGIN
INSERT INTO pasajero_back VALUES(old.idPasajero, old.nombrePasajero, old.apellidosPasajero, old.pasaportePasajero, old.cadpasaportePasajero, old.generoPasajero, old.edadPasajero, old.nacionalidadPasajero, old.fechanacPasajero);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.reserva_before_delete
DROP TRIGGER IF EXISTS `reserva_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `reserva_before_delete` BEFORE DELETE ON `reserva` FOR EACH ROW BEGIN
DELETE FROM ocupacion WHERE reservaOcupacion = old.idReserva;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.servicioreserva_before_delete
DROP TRIGGER IF EXISTS `servicioreserva_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `servicioreserva_before_delete` BEFORE DELETE ON `servicioreserva` FOR EACH ROW BEGIN
INSERT INTO servicioreserva_back VALUES (old.idRS, old.ocupacionRS, old.servicioRS);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador dhairline.vuelo_before_delete_ida
DROP TRIGGER IF EXISTS `vuelo_before_delete_ida`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `vuelo_before_delete_ida` BEFORE DELETE ON `vuelo` FOR EACH ROW BLOCK1: BEGIN
DECLARE id1 INTEGER;

DECLARE fin1 INTEGER DEFAULT 0;

DECLARE cur1 CURSOR FOR SELECT idReserva FROM reserva WHERE reserva.vueloidaReserva = old.idVuelo;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin1 = 1;

INSERT INTO vuelo_back VALUES(old.idVuelo, old.conexionVuelo, old.numeroVuelo, old.fechaVuelo, old.horaSalidaVuelo, old.horaLlegadaVuelo, old.disponiblesVuelo, old.precioVuelo);


open cur1;
get_cur1: LOOP

	FETCH cur1 INTO id1;

	IF fin1 = 1 THEN
		LEAVE get_cur1;
	END IF;
	CALL comprobarVuelos(id1);

END LOOP get_cur1;

BLOCK2: BEGIN
DECLARE id2 INTEGER;


DECLARE fin2 INTEGER DEFAULT 0;

DECLARE cur2 CURSOR FOR SELECT idReserva FROM reserva WHERE reserva.vuelovueltaReserva = OLD.idVuelo;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin2 = 1;

open cur2;
get_cur2: LOOP

	FETCH cur2 INTO id2;

	IF fin2 = 1 THEN
		LEAVE get_cur2;
	END IF;
	DELETE FROM reserva WHERE reserva.idReserva = id2;

END LOOP get_cur2;
END BLOCK2;
	
	
END BLOCK1//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
