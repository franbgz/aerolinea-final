-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.30-0ubuntu0.14.04.1 - (Ubuntu)
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             9.3.0.5078
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

-- Volcando datos para la tabla dhairline.aeropuerto: ~4 rows (aproximadamente)
DELETE FROM `aeropuerto`;
/*!40000 ALTER TABLE `aeropuerto` DISABLE KEYS */;
INSERT INTO `aeropuerto` (`idAeropuerto`, `iataAeropuerto`, `ciudadAeropuerto`, `paisAeropuerto`) VALUES
	(1, 'VLC', 'Valencia', 'España'),
	(2, 'CLJ', 'Cluj-Napoca', 'Rumania'),
	(3, 'DME', 'Moscu', 'Rusia'),
	(4, 'ARN', 'Estocolmo', 'Suecia');
/*!40000 ALTER TABLE `aeropuerto` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.bebe
DROP TABLE IF EXISTS `bebe`;
CREATE TABLE IF NOT EXISTS `bebe` (
  `idBebe` int(11) NOT NULL AUTO_INCREMENT,
  `nombreBebe` varchar(50) DEFAULT NULL,
  `apellidosBebe` varchar(100) DEFAULT NULL,
  `dniBebe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idBebe`),
  UNIQUE KEY `dniBebe` (`dniBebe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.bebe: ~0 rows (aproximadamente)
DELETE FROM `bebe`;
/*!40000 ALTER TABLE `bebe` DISABLE KEYS */;
/*!40000 ALTER TABLE `bebe` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.bebe_back
DROP TABLE IF EXISTS `bebe_back`;
CREATE TABLE IF NOT EXISTS `bebe_back` (
  `idBebe` int(11) NOT NULL,
  `nombreBebe` varchar(50) DEFAULT NULL,
  `apellidosBebe` varchar(100) DEFAULT NULL,
  `dniBebe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idBebe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla dhairline.bebe_back: ~0 rows (aproximadamente)
DELETE FROM `bebe_back`;
/*!40000 ALTER TABLE `bebe_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `bebe_back` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.conexion: ~12 rows (aproximadamente)
DELETE FROM `conexion`;
/*!40000 ALTER TABLE `conexion` DISABLE KEYS */;
INSERT INTO `conexion` (`idConexion`, `origenConexion`, `destinoConexion`) VALUES
	(1, 'VLC', 'CLJ'),
	(2, 'VLC', 'ARN'),
	(3, 'VLC', 'DME'),
	(4, 'CLJ', 'ARN'),
	(5, 'CLJ', 'DME'),
	(6, 'CLJ', 'VLC'),
	(7, 'ARN', 'CLJ'),
	(8, 'ARN', 'DME'),
	(9, 'ARN', 'VLC'),
	(10, 'DME', 'CLJ'),
	(11, 'DME', 'ARN'),
	(12, 'DME', 'VLC');
/*!40000 ALTER TABLE `conexion` ENABLE KEYS */;

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
  CONSTRAINT `FK_ocupacion_reserva` FOREIGN KEY (`reservaOcupacion`) REFERENCES `reserva` (`idReserva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.ocupacion: ~0 rows (aproximadamente)
DELETE FROM `ocupacion`;
/*!40000 ALTER TABLE `ocupacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocupacion` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.ocupacion_back: ~0 rows (aproximadamente)
DELETE FROM `ocupacion_back`;
/*!40000 ALTER TABLE `ocupacion_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocupacion_back` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.pagador: ~0 rows (aproximadamente)
DELETE FROM `pagador`;
/*!40000 ALTER TABLE `pagador` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagador` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.pasajero: ~0 rows (aproximadamente)
DELETE FROM `pasajero`;
/*!40000 ALTER TABLE `pasajero` DISABLE KEYS */;
/*!40000 ALTER TABLE `pasajero` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.pasajero_back
DROP TABLE IF EXISTS `pasajero_back`;
CREATE TABLE IF NOT EXISTS `pasajero_back` (
  `idPasajero` int(11) NOT NULL,
  `nombrePasajero` varchar(50) DEFAULT NULL,
  `apellidosPasajero` varchar(50) DEFAULT NULL,
  `pasaportePasajero` varchar(50) DEFAULT NULL,
  `cadpasaportePasajero` date DEFAULT NULL,
  `generoPasajero` varchar(10) DEFAULT NULL,
  `edadPasajero` varchar(50) DEFAULT NULL,
  `nacionalidadPasajero` varchar(50) DEFAULT NULL,
  `fechanacPasajero` date DEFAULT NULL,
  PRIMARY KEY (`idPasajero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Volcando datos para la tabla dhairline.pasajero_back: ~0 rows (aproximadamente)
DELETE FROM `pasajero_back`;
/*!40000 ALTER TABLE `pasajero_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `pasajero_back` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.reserva
DROP TABLE IF EXISTS `reserva`;
CREATE TABLE IF NOT EXISTS `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
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
  KEY `FK_reserva_vuelo` (`vueloidaReserva`),
  KEY `FK_reserva_pagador` (`pagadorReserva`),
  KEY `FK_reserva_vuelo_vuelta` (`vuelovueltaReserva`),
  KEY `FK_reserva_usuario` (`usuarioReserva`),
  KEY `FK_reserva_tarjeta` (`tarjetaReserva`),
  CONSTRAINT `FK_reserva_pagador` FOREIGN KEY (`pagadorReserva`) REFERENCES `pagador` (`idPagador`),
  CONSTRAINT `FK_reserva_tarjeta` FOREIGN KEY (`tarjetaReserva`) REFERENCES `tarjeta` (`idTarjeta`),
  CONSTRAINT `FK_reserva_usuario` FOREIGN KEY (`usuarioReserva`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `FK_reserva_vuelo_ida` FOREIGN KEY (`vueloidaReserva`) REFERENCES `vuelo` (`idVuelo`),
  CONSTRAINT `FK_reserva_vuelo_vuelta` FOREIGN KEY (`vuelovueltaReserva`) REFERENCES `vuelo` (`idVuelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.reserva: ~0 rows (aproximadamente)
DELETE FROM `reserva`;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.reserva_back: ~0 rows (aproximadamente)
DELETE FROM `reserva_back`;
/*!40000 ALTER TABLE `reserva_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva_back` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.servicio
DROP TABLE IF EXISTS `servicio`;
CREATE TABLE IF NOT EXISTS `servicio` (
  `idServicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombreServicio` varchar(20) DEFAULT NULL,
  `descripcionServicio` mediumtext,
  `precioServicio` int(11) DEFAULT NULL,
  PRIMARY KEY (`idServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.servicio: ~5 rows (aproximadamente)
DELETE FROM `servicio`;
/*!40000 ALTER TABLE `servicio` DISABLE KEYS */;
INSERT INTO `servicio` (`idServicio`, `nombreServicio`, `descripcionServicio`, `precioServicio`) VALUES
	(1, 'PC y pantalla', 'Servicio para poder facturar un bulto de 70x70x40cm donde poder guardar la torre y la pantalla.', 10),
	(2, 'Maleta adicional', 'Maleta adicional donde la suma del ancho, alto y profundo no puede superar los 158cm y los 32kg', 10),
	(3, 'Seguro de vuelo', 'Quedarás totalmente protegido ante retrasos o cancelaciones de vuelo', 10),
	(4, 'Bebe a bordo', 'Servicio para llevar a bordo y en el mismo asiento un bebe', 20),
	(5, 'Asiento amplio', 'Si necesitas viajar en un asiento especial mas amplio', 5);
/*!40000 ALTER TABLE `servicio` ENABLE KEYS */;

-- Volcando estructura para tabla dhairline.servicioreserva
DROP TABLE IF EXISTS `servicioreserva`;
CREATE TABLE IF NOT EXISTS `servicioreserva` (
  `idRS` int(11) NOT NULL AUTO_INCREMENT,
  `ocupacionRS` int(11) DEFAULT NULL,
  `servicioRS` int(11) DEFAULT NULL,
  PRIMARY KEY (`idRS`),
  KEY `FK_servicioreserva_ocupacion` (`ocupacionRS`),
  KEY `FK_servicioreserva_servicio` (`servicioRS`),
  CONSTRAINT `FK_servicioreserva_ocupacion` FOREIGN KEY (`ocupacionRS`) REFERENCES `ocupacion` (`idOcupacion`),
  CONSTRAINT `FK_servicioreserva_servicio` FOREIGN KEY (`servicioRS`) REFERENCES `servicio` (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.servicioreserva: ~0 rows (aproximadamente)
DELETE FROM `servicioreserva`;
/*!40000 ALTER TABLE `servicioreserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicioreserva` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.servicioreserva_back: ~0 rows (aproximadamente)
DELETE FROM `servicioreserva_back`;
/*!40000 ALTER TABLE `servicioreserva_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicioreserva_back` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.tarjeta: ~0 rows (aproximadamente)
DELETE FROM `tarjeta`;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dhairline.usuario: ~0 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.vuelo: ~24 rows (aproximadamente)
DELETE FROM `vuelo`;
/*!40000 ALTER TABLE `vuelo` DISABLE KEYS */;
INSERT INTO `vuelo` (`idVuelo`, `conexionVuelo`, `numeroVuelo`, `fechaVuelo`, `horaSalidaVuelo`, `horaLlegadaVuelo`, `disponiblesVuelo`, `precioVuelo`) VALUES
	(1, 1, '123062016', '2016-06-23', '07:30:00', '11:24:00', 8, 135),
	(2, 7, '723062016', '2016-06-23', '08:30:00', '11:37:00', 8, 195),
	(3, 10, '1023062016', '2016-06-23', '10:30:00', '11:37:00', 8, 215),
	(4, 4, '427062016', '2016-06-27', '08:00:00', '11:07:00', 8, 183),
	(5, 5, '527062016', '2016-06-27', '08:00:00', '11:03:00', 8, 192),
	(6, 6, '627062016', '2016-06-27', '08:00:00', '09:54:00', 8, 129),
	(7, 2, '230062016', '2016-06-30', '08:00:00', '11:27:00', 4, 171),
	(8, 4, '430062016', '2016-06-30', '08:00:00', '11:07:00', 8, 188),
	(9, 11, '1130062016', '2016-06-30', '11:30:00', '11:22:00', 8, 147),
	(10, 7, '704072016', '2016-07-04', '08:00:00', '11:07:00', 8, 190),
	(11, 8, '804072016', '2016-07-04', '08:00:00', '11:52:00', 8, 128),
	(12, 9, '904072016', '2016-07-04', '08:00:00', '11:27:00', 6, 140),
	(13, 3, '307072016', '2016-07-07', '07:00:00', '13:27:00', 7, 162),
	(14, 5, '507072016', '2016-07-07', '08:30:00', '11:33:00', 8, 197),
	(15, 8, '807072016', '2016-07-07', '08:00:00', '11:52:00', 8, 133),
	(16, 10, '1011072016', '2016-07-11', '08:00:00', '09:03:00', 8, 210),
	(17, 11, '1111072016', '2016-07-11', '08:00:00', '07:52:00', 8, 142),
	(18, 12, '1211072016', '2016-07-11', '08:00:00', '10:21:00', 8, 172),
	(19, 6, '614072016', '2016-07-14', '10:00:00', '11:54:00', 8, 134),
	(20, 9, '914072016', '2016-07-14', '08:00:00', '11:27:00', 6, 145),
	(21, 12, '1214072016', '2016-07-14', '09:00:00', '11:21:00', 8, 177),
	(22, 1, '118072016', '2016-07-18', '08:00:00', '11:54:00', 8, 130),
	(23, 2, '218072016', '2016-07-18', '08:00:00', '11:27:00', 8, 166),
	(24, 3, '318072016', '2016-07-18', '08:00:00', '14:21:00', 8, 157);
/*!40000 ALTER TABLE `vuelo` ENABLE KEYS */;

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

-- Volcando datos para la tabla dhairline.vuelo_back: ~0 rows (aproximadamente)
DELETE FROM `vuelo_back`;
/*!40000 ALTER TABLE `vuelo_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `vuelo_back` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
