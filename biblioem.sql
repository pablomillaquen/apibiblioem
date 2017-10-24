-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 24-10-2017 a las 10:58:23
-- Versión del servidor: 5.7.20-0ubuntu0.17.04.1
-- Versión de PHP: 5.6.31-6+ubuntu17.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioem`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AUTH_Sel` (IN `email` VARCHAR(60), IN `pass` VARCHAR(200))  NO SQL
BEGIN
  SELECT
    `EMP_id` as id,
    `EMP_nombre` as nombre,
    `EMP_apellido` as apellido,
    `EMP_email` as email,
    `EMP_acceso` as acceso,
    `EMP_user`as usuario
  FROM `pm_empleado`
  WHERE `EMP_email` = email
  AND `EMP_pass`= pass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EMPLEADO_del` (IN `id` INT)  BEGIN
  UPDATE `pm_empleado` SET
    `EMP_estado` = 0
  WHERE 
    (`EMP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EMPLEADO_ins` (IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(30), IN `email` VARCHAR(60), IN `acceso` INT, IN `usuario` VARCHAR(45), IN `pass` VARCHAR(200), IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_empleado`
  (
    `EMP_nombre`,
    `EMP_apellido`,
    `EMP_email`,
    `EMP_acceso`,
    `EMP_user`,
    `EMP_pass`,
    `EMP_fechacreacion`,
    `EMP_fechamodificacion`,
    `EMP_estado`
  )
  VALUES 
  (
    nombre,
    apellido,
    email, 
    acceso,
    usuario,
    pass,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EMPLEADO_sel` ()  BEGIN
  SELECT
    `EMP_id`as id,
    `EMP_nombre` as nombre,
    `EMP_apellido` as apellido,
    `EMP_email` as correo,
    `EMP_acceso` as acceso,
    `EMP_user`as usuario
  FROM `pm_empleado`
  WHERE `EMP_estado` = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EMPLEADO_upd` (IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(30), IN `email` VARCHAR(60), IN `acceso` INT, IN `usuario` VARCHAR(45), IN `pass` VARCHAR(200), IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_empleado` SET
    `EMP_nombre` = nombre,
    `EMP_apellido` = apellido,
    `EMP_email` = email,
    `EMP_acceso` = acceso,
    `EMP_user` = usuario,
    `EMP_pass` = pass,
    `EMP_fechamodificacion` = fechamodificacion,
    `EMP_estado` = 1
  WHERE 
    (`EMP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EMPLEADO_UpdSP` (IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(30), IN `email` VARCHAR(60), IN `acceso` INT, IN `usuario` VARCHAR(45), IN `fechamodificacion` DATETIME, IN `id` INT)  NO SQL
BEGIN
  UPDATE `pm_empleado` SET
    `EMP_nombre` = nombre,
    `EMP_apellido` = apellido,
    `EMP_email` = email,
    `EMP_acceso` = acceso,
    `EMP_user` = usuario,
    `EMP_fechamodificacion` = fechamodificacion,
    `EMP_estado` = 1
  WHERE `EMP_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MANUAL_del` (IN `id` INT)  BEGIN
  UPDATE `pm_manual` SET
    `MAN_estado` = 0
  WHERE 
    (`MAN_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MANUAL_ins` (IN `nombre` VARCHAR(45), IN `ubicacion` VARCHAR(45), IN `url` VARCHAR(200), IN `idModelo` INT, IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_manual`
  (
    `MAN_nombre`,
    `MAN_ubicacion`,
    `MAN_url`,
    `MOD_id`,
    `MAN_fechacreacion`,
    `MAN_fechamodificacion`,
    `MAN_estado`
  )
  VALUES 
  (
    nombre,
    ubicacion,
    url,
    idModelo,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MANUAL_sel` ()  BEGIN
  SELECT
    ma.`MAN_id` as id,
    ma.`MAN_nombre` as nombre,
    ma.`MAN_ubicacion` as ubicacion,
    ma.`MAN_url` as url,
    ma.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_manual` as ma
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=ma.`Mod_id`
  WHERE `MAN_estado` = 1
  ORDER BY `MAN_nombre` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MANUAL_selxmodelo` (IN `idModelo` INT)  NO SQL
BEGIN
  SELECT
    ma.`MAN_id` as id,
    ma.`MAN_nombre` as nombre,
    ma.`MAN_ubicacion` as ubicacion,
    ma.`MAN_url` as url,
    ma.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_manual` as ma
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=ma.`Mod_id`
  WHERE ma.`MAN_estado` = 1
  AND ma.`MOD_id` = idModelo
  ORDER BY ma.`MAN_nombre` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MANUAL_upd` (IN `nombre` VARCHAR(45), IN `ubicacion` VARCHAR(45), IN `url` VARCHAR(200), IN `idModelo` INT, IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_manual` SET
    `MAN_nombre` = nombre,
    `MAN_ubicacion` = ubicacion,
    `MAN_url` = url,
    `MOD_id` = idModelo,
    `MAN_fechamodificacion` = fechamodificacion,
    `MAN_estado` = 1
  WHERE 
    (`MAN_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MARCA_del` (IN `id` INT)  BEGIN
  UPDATE `pm_marca` SET
    `MAR_estado` = 0
  WHERE 
    (`MAR_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MARCA_ins` (IN `nombre` VARCHAR(80), IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_marca`
  (
    `MAR_nombre`,
    `MAR_fechacreacion`,
    `MAR_fechamodificacion`,
    `MAR_estado`
  )
  VALUES 
  (
    nombre,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MARCA_sel` ()  BEGIN
  SELECT
	`MAR_id` as id,
    `MAR_nombre`as nombre  	
  FROM `pm_marca`
  WHERE `MAR_estado` = 1
  ORDER BY `MAR_nombre` asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MARCA_sel1` (IN `id` INT)  NO SQL
BEGIN
  SELECT * FROM `pm_marca`
  WHERE     
    (`MAR_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MARCA_upd` (IN `id` INT, IN `nombre` VARCHAR(80), IN `fechamodificacion` DATETIME)  BEGIN
  UPDATE `pm_marca` SET
    `MAR_nombre` = nombre,
    `MAR_fechamodificacion` = fechamodificacion,
    `MAR_estado` = 1
  WHERE 
    (`MAR_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_del` (IN `id` INT)  BEGIN
  UPDATE `pm_modelo` SET
    `MOD_estado` = 0
  WHERE 
    (`MOD_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_ins` (IN `nombre` VARCHAR(50), IN `idTipo` INT, IN `idMarca` INT, IN `foto` VARCHAR(250), IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_modelo`
  (
    `MOD_nombre`,
    `TIP_id`,
    `MAR_id`,
    `MOD_foto`,
    `MOD_fechacreacion`,
    `MOD_fechamodificacion`,
    `MOD_estado`
  )
  VALUES 
  (
    nombre,
    idTipo,
    idMarca,
    foto,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_sel` ()  BEGIN
  SELECT
    mo.`MOD_id` as id,
    mo.`MOD_nombre` as nombre,
    mo.`TIP_id` as idTipo,
    ti.`TIP_nombre` as tipoequipo,
    mo.`MAR_id` as idMarca,
    ma.`MAR_nombre` as marca,
    mo.`MOD_foto` as foto,
    (SELECT COUNT(*)
	FROM `pm_manual`
	WHERE `MOD_id`=id) as numManuales,
    (SELECT COUNT(*)
	FROM `pm_protocolo`
	WHERE `MOD_id`=id) as numProtocolos,
    (SELECT COUNT(*)
	FROM `pm_torpedo`
	WHERE `MOD_id`=id) as numTorpedos,
    (SELECT COUNT(*)
	FROM `pm_mod_rep`
	WHERE `MOD_id`=id) as numRepuestos
  FROM `pm_modelo` as mo
  INNER JOIN `pm_marca` as ma
  ON mo.`MAR_id`=ma.`MAR_id`
  INNER JOIN `pm_tipoequipo` as ti
  ON mo.`TIP_id`=ti.`TIP_id`
 WHERE mo.`MOD_estado` = 1
 ORDER BY `MOD_nombre` asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_sel1` (IN `id` INT)  NO SQL
BEGIN
	SELECT 
    	mo.`MOD_id` as id,
        mo.`MOD_nombre` as nombre,
        mo.`TIP_id` as idTipo,
        ti.`TIP_nombre` as tipoequipo,
        mo.`MAR_id` as idMarca,
        ma.`MAR_nombre` as marca,
        mo.`MOD_foto` as foto
        FROM `pm_modelo` as mo
    INNER JOIN `pm_marca` as ma
  	ON mo.`MAR_id`=ma.`MAR_id`
  	INNER JOIN `pm_tipoequipo` as ti
  	ON mo.`TIP_id`=ti.`TIP_id`
 	WHERE mo.`MOD_estado` = 1
    AND mo.`MOD_id`= id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_upd` (IN `nombre` VARCHAR(50), IN `idTipo` INT, IN `idMarca` INT, IN `foto` VARCHAR(250), IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_modelo` SET
    `MOD_nombre` = nombre,
    `TIP_id` = idTipo,
    `MAR_id` = idMarca,
    `MOD_foto` = foto,
    `MOD_fechamodificacion` = fechamodificacion,
    `MOD_estado` = 1
  WHERE 
    (`MOD_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOD_REP_del` (IN `idModelo` INT, IN `idRepuesto` INT)  BEGIN
  UPDATE `pm_mod_rep` SET
    `MOD_REP_estado` = 0
  WHERE     
    (`MOD_id` = idModelo) AND    
    (`REP_id` = idRepuesto);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOD_REP_ins` (IN `idModelo` INT, IN `idRepuesto` INT, IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_mod_rep`
  (
    `MOD_id`,
    `REP_id`,
    `MOD_REP_fechacreacion`,
    `MOD_REP_fechamodificacion`,
    `MOD_REP_estado`
  )
  VALUES 
  (
    idModelo,
    idRepuesto,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOD_REP_selxmodelo` (IN `id` INT)  BEGIN
  SELECT
    mr.`MOD_id`,
    mr.`REP_id`,
    re.`REP_nombre`,
    re.`REP_referencia`,
    re.`REP_foto`,
    re.`REP_descripcion`
  FROM `pm_mod_rep` as mr
  INNER JOIN `pm_repuesto` as re 
  ON mr.`REP_id`=re.`REP_id`
  WHERE mr.`MOD_REP_estado`=1
  AND mr.`MOD_id`=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOD_REP_upd` (IN `idModeloorg` INT, IN `idRepuestoorg` INT, IN `idModelocam` INT, IN `idReferenciacam` INT, IN `fechamodificacion` DATETIME)  BEGIN
  UPDATE `pm_mod_rep` SET
    `MOD_id` = idModelocam,
    `REP_id` = idReferenciacam,
    `MOD_REP_fechamodificacion` = fechamodificacion
  WHERE 
    (`MOD_id` = idModeloorg) AND
    (`REP_id` = idRepuestoorg);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PROTOCOLO_del` (IN `id` INT)  NO SQL
BEGIN
  UPDATE `pm_protocolo` SET
    `PRO_estado` = 0
  WHERE 
    (`PRO_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PROTOCOLO_ins` (IN `nombre` VARCHAR(50), IN `url` VARCHAR(250), IN `idModelo` INT, IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  NO SQL
BEGIN
  INSERT INTO `pm_protocolo`
  (
    `PRO_nombre`,
    `PRO_url`,
    `MOD_id`,
    `PRO_fechacreacion`,
    `PRO_fechamodificacion`,
    `PRO_estado`
  )
  VALUES 
  (
    nombre,
    url,
    idModelo,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PROTOCOLO_sel` ()  NO SQL
BEGIN
  SELECT
    pr.`PRO_id` as id,
    pr.`PRO_nombre` as nombre,
    pr.`PRO_url` as url,
    pr.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_protocolo` as pr
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=pr.`MOD_id`
  WHERE `PRO_estado` = 1
  ORDER BY `PRO_nombre` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PROTOCOLO_selxmodelo` (IN `idModelo` INT)  NO SQL
BEGIN
  SELECT
    pr.`PRO_id` as id,
    pr.`PRO_nombre` as nombre,
    pr.`PRO_url` as url,
    pr.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_protocolo` as pr
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=pr.`MOD_id`
  WHERE pr.`PRO_estado` = 1
  AND pr.`MOD_id` = idModelo
  ORDER BY pr.`PRO_nombre` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PROTOCOLO_upd` (IN `nombre` VARCHAR(50), IN `url` VARCHAR(250), IN `idModelo` INT, IN `fechamodificacion` DATETIME, IN `id` INT)  NO SQL
BEGIN
  UPDATE `pm_protocolo` SET
    `PRO_nombre` = nombre,
    `PRO_url` = url,
    `MOD_id` = idModelo,
    `PRO_fechamodificacion` = fechamodificacion,
    `PRO_estado` = 1
  WHERE 
    (`PRO_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPUESTO_del` (IN `id` INT)  BEGIN
  UPDATE `pm_repuesto` SET
    `REP_estado` = 0
  WHERE 
    (`REP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPUESTO_ins` (IN `nombre` VARCHAR(45), IN `referencia` VARCHAR(50), IN `descripcion` LONGTEXT, IN `foto` VARCHAR(100), IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_repuesto`
  (
    `REP_nombre`,
    `REP_referencia`,
    `REP_descripcion`,
    `REP_foto`,
    `REP_fechacreacion`,
    `REP_fechamodificacion`,
    `REP_estado`
  )
  VALUES 
  (
    nombre,
    referencia,
    descripcion,
    foto,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPUESTO_sel` ()  BEGIN
  SELECT
    `REP_id` as id,
    `REP_nombre` as nombre,
    `REP_referencia` as referencia,
    `REP_descripcion` as descripcion,
    `REP_foto` as foto
  FROM `pm_repuesto`
  ORDER BY `REP_nombre` asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPUESTO_selxmodelo` (IN `id` INT)  NO SQL
BEGIN
  SELECT
    re.`REP_id` as id,
    re.`REP_nombre` as nombre,
    re.`REP_referencia` as referencia,
    re.`REP_descripcion` as descripcion,
    re.`REP_foto` as foto,
    mr.`MOD_id` as idModelo,
    mr.`REP_id` as idRepuesto
  FROM `pm_mod_rep` as mr
  INNER JOIN `pm_repuesto` as re
  ON mr.`REP_id`=re.`REP_id`
  WHERE mr.`MOD_REP_estado` = 1
  AND mr.`REP_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPUESTO_upd` (IN `nombre` VARCHAR(45), IN `referencia` VARCHAR(50), IN `descripcion` LONGTEXT, IN `foto` VARCHAR(100), IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_repuesto` SET
    `REP_nombre` = nombre,
    `REP_referencia` = referencia,
    `REP_descripcion` = descripcion,
    `REP_foto` = foto,
    `REP_fechamodificacion` = fechamodificacion,
    `REP_estado` = 1
  WHERE 
    (`REP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TIPOEQUIPO_del` (IN `id` INT)  BEGIN
  UPDATE `pm_tipoequipo` SET
    `TIP_estado` = 0
  WHERE 
    (`TIP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TIPOEQUIPO_ins` (IN `nombre` VARCHAR(150), IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_tipoequipo`
  (
    `TIP_nombre`,
    `TIP_fechacreacion`,
    `TIP_fechamodificacion`,
    `TIP_estado`
  )
  VALUES 
  (
    nombre,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TIPOEQUIPO_sel` ()  BEGIN
  SELECT
    `TIP_id`as id,
    `TIP_nombre` as nombre
  FROM `pm_tipoequipo`
   WHERE `TIP_estado` = 1
  ORDER BY `TIP_nombre` asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TIPOEQUIPO_sel1` (IN `id` INT)  NO SQL
BEGIN
  SELECT * FROM `pm_tipoequipo`
  WHERE     
    (`TIP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TIPOEQUIPO_upd` (IN `nombre` VARCHAR(150), IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_tipoequipo` SET
    `TIP_nombre` = nombre,
    `TIP_fechamodificacion` = fechamodificacion,
    `TIP_estado` = 1
  WHERE 
    (`TIP_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_del` (IN `id` INT)  BEGIN
  UPDATE `pm_torpedo` SET
    `TOR_estado` = 0
  WHERE 
    (`TOR_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_ins` (IN `titulo` VARCHAR(45), IN `descripcion` LONGTEXT, IN `url` VARCHAR(100), IN `idModelo` INT, IN `fechacreacion` DATETIME, IN `fechamodificacion` DATETIME)  BEGIN
  INSERT INTO `pm_torpedo`
  (
    `TOR_titulo`,
    `TOR_descripcion`,
    `TOR_url`,
    `MOD_id`,
    `TOR_fechacreacion`,
    `TOR_fechamodificacion`,
    `TOR_estado`
  )
  VALUES 
  (
    titulo,
    descripcion,
    url,
    idModelo,
    fechacreacion,
    fechamodificacion,
    1
  );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_sel` ()  BEGIN
  SELECT
    tor.`TOR_id` as id,
    tor.`TOR_titulo` as titulo,
    tor.`TOR_descripcion` as descripcion,
    tor.`TOR_url` as url,
    tor.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_torpedo` as tor
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=tor.`Mod_id`
  WHERE `TOR_estado` = 1
  ORDER BY `TOR_titulo` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_sel1` (IN `id` INT)  NO SQL
BEGIN
  SELECT * FROM `pm_torpedo`
  WHERE     
    (`TOR_id` = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_selxmodelo` (IN `idModelo` INT)  NO SQL
BEGIN
  SELECT
    tor.`TOR_id` as id,
    tor.`TOR_titulo` as titulo,
    tor.`TOR_descripcion` as descripcion,
    tor.`TOR_url` as url,
    tor.`MOD_id` as idModelo,
    mo.`MOD_nombre` as modelo
  FROM `pm_torpedo` as tor
  INNER JOIN `pm_modelo` as mo
  ON mo.`MOD_id`=tor.`MOD_id`
  WHERE tor.`TOR_estado` = 1
  AND tor.`MOD_id` = idModelo
  ORDER BY tor.`TOR_titulo` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TORPEDO_upd` (IN `titulo` VARCHAR(45), IN `descripcion` LONGTEXT, IN `url` VARCHAR(100), IN `idModelo` INT, IN `fechamodificacion` DATETIME, IN `id` INT)  BEGIN
  UPDATE `pm_torpedo` SET
    `TOR_titulo` = titulo,
    `TOR_descripcion` = descripcion,
    `TOR_url` = url,
    `MOD_id` = idModelo,
    `TOR_fechamodificacion` = fechamodificacion
  WHERE 
    (`TOR_id` = id);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_empleado`
--

CREATE TABLE `pm_empleado` (
  `EMP_id` int(11) NOT NULL,
  `EMP_nombre` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EMP_apellido` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EMP_email` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EMP_acceso` int(11) DEFAULT NULL,
  `EMP_user` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EMP_pass` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `EMP_fechacreacion` datetime DEFAULT NULL,
  `EMP_fechamodificacion` datetime DEFAULT NULL,
  `EMP_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_empleado`
--

INSERT INTO `pm_empleado` (`EMP_id`, `EMP_nombre`, `EMP_apellido`, `EMP_email`, `EMP_acceso`, `EMP_user`, `EMP_pass`, `EMP_fechacreacion`, `EMP_fechamodificacion`, `EMP_estado`) VALUES
(1, 'pablo', 'millaquén', 'pablo@pablo.cl', 1, 'pablo', '02293f42fd94989f555b30e02c22fd3b1a2809e6', '2017-10-16 00:00:00', '2017-10-20 16:51:24', 1),
(2, 'Roberto', 'García', 'roberto@biomedica.cl', 0, 'roberto', 'b02e2275ba3df935a2a711b0297e74db8c4d56a4', '2017-10-20 16:52:27', '2017-10-20 16:52:44', 1),
(3, 'Yanko', 'Jaramillo', 'janko@ruso.cl', 0, 'janko', '8175a6556ca7aedc632c32cb6d4555d508893fbf', '2017-10-20 16:54:04', '2017-10-20 16:54:04', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_manual`
--

CREATE TABLE `pm_manual` (
  `MAN_id` int(11) NOT NULL,
  `MAN_nombre` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `MAN_ubicacion` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `MAN_url` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `MOD_id` int(11) NOT NULL,
  `MAN_fechacreacion` datetime DEFAULT NULL,
  `MAN_fechamodificacion` datetime DEFAULT NULL,
  `MAN_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_manual`
--

INSERT INTO `pm_manual` (`MAN_id`, `MAN_nombre`, `MAN_ubicacion`, `MAN_url`, `MOD_id`, `MAN_fechacreacion`, `MAN_fechamodificacion`, `MAN_estado`) VALUES
(1, 'Manual Servicio', 'M-68', 'manual-1507660709-M1031914-02_CC5_MANUAL DE SERVICIO.pdf', 2, '2017-10-10 20:38:31', '2017-10-10 20:59:04', 1),
(2, 'Manual Servicio', 'R-261', 'manual-1507841252-ATL HDI 5000 Service Manual.pdf', 3, '2017-10-12 22:47:34', '2017-10-12 22:47:34', 1),
(3, 'Manual Entrenamiento', '', 'manual-1507841252-ATL HDI 5000 Service Manual.pdf', 3, '2017-10-12 22:48:28', '2017-10-12 22:48:28', 1),
(4, 'Manual Referencia', '', 'manual-1507841331-ATL HDI 5000 Reference Manual.pdf', 3, '2017-10-12 22:48:53', '2017-10-12 22:48:53', 1),
(5, 'Listado Errores', '', 'manual-1507841388-86304542-Philips-HDI-5000-Errors (1).pdf', 3, '2017-10-12 22:49:51', '2017-10-12 22:49:51', 1),
(6, 'Hoja datos técnicos', '', 'manual-1507841426-ATL HDI 5000 Data Sheet.pdf', 3, '2017-10-12 22:50:28', '2017-10-12 22:50:28', 1),
(7, 'Manual Usuario', '', 'manual-1507841456-Manual usuario HDI500.pdf', 3, '2017-10-12 22:50:58', '2017-10-12 22:50:58', 1),
(8, 'Uso de desinfectantes y gel', '', 'manual-1507841585-HDI5000 Uso de desinfectantes y gel.pdf', 3, '2017-10-12 22:53:08', '2017-10-12 22:53:08', 1),
(9, 'Comandos VX Works', '', 'manual-1507841612-HDI5000 VXWorks Commands.pdf', 3, '2017-10-12 22:53:34', '2017-10-12 22:53:34', 1),
(10, 'Manual Servicio', '', 'manual-1507918898-BV Endura Service Manual.pdf', 6, '2017-10-13 20:21:40', '2017-10-13 20:21:40', 1),
(11, 'Manual Servicio Avanzado', '', 'manual-1508557232-LOGIQ_9_Proprietary_Manual.pdf', 7, '2017-10-21 00:20:26', '2017-10-21 00:40:32', 1),
(12, 'Nuevo manual', '', NULL, 7, '2017-10-21 00:28:26', '2017-10-21 00:32:04', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_marca`
--

CREATE TABLE `pm_marca` (
  `MAR_id` int(11) NOT NULL,
  `MAR_nombre` varchar(80) COLLATE utf8_spanish_ci DEFAULT NULL,
  `MAR_fechacreacion` datetime DEFAULT NULL,
  `MAR_fechamodificacion` datetime DEFAULT NULL,
  `MAR_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_marca`
--

INSERT INTO `pm_marca` (`MAR_id`, `MAR_nombre`, `MAR_fechacreacion`, `MAR_fechamodificacion`, `MAR_estado`) VALUES
(1, 'Drager', '2017-09-27 15:02:46', '2017-09-27 15:02:46', 1),
(2, 'General Electric', '2017-09-28 20:05:21', '2017-10-02 17:06:54', 1),
(3, 'Mindray', '2017-09-29 17:48:32', '2017-09-29 17:48:32', 1),
(4, 'Aesculap', '2017-09-29 17:48:35', '2017-09-29 17:48:35', 1),
(5, 'Philips', '2017-09-29 18:03:02', '2017-09-29 18:03:02', 1),
(6, 'Braun', '2017-09-29 18:17:46', '2017-09-29 18:17:46', 1),
(7, 'Trumpf', '2017-09-29 18:21:36', '2017-09-29 18:21:36', 1),
(8, 'Ohmeda', '2017-09-29 18:33:43', '2017-09-29 18:33:43', 1),
(9, 'Stryker', '2017-09-29 19:41:33', '2017-09-29 19:41:33', 1),
(10, 'Medela', '2017-09-29 19:42:39', '2017-09-29 19:42:39', 1),
(11, 'Karl Storz', '2017-09-29 19:58:39', '2017-09-29 19:58:39', 1),
(12, 'Masimo', '2017-09-29 20:06:05', '2017-09-29 20:06:05', 1),
(13, 'Nihon Kohden', '2017-09-29 20:07:24', '2017-09-29 20:07:24', 1),
(14, 'Midmark', '2017-09-29 20:14:07', '2017-09-29 20:14:07', 1),
(15, 'Pitec', '2017-09-29 20:16:39', '2017-10-02 17:07:09', 1),
(16, 'Zoll', '2017-09-29 20:17:11', '2017-09-29 20:17:11', 1),
(17, 'Mortara', '2017-09-29 20:24:56', '2017-09-29 20:24:56', 1),
(18, 'Arquimed', '2017-09-29 20:25:59', '2017-09-29 20:25:59', 1),
(19, 'Criticare', '2017-09-29 20:27:06', '2017-09-29 20:27:06', 1),
(20, 'Martin', '2017-09-29 20:48:28', '2017-09-29 20:48:28', 1),
(21, 'Lorad', '2017-09-29 20:49:43', '2017-09-29 20:49:43', 1),
(22, 'Cadwell', '2017-09-29 21:15:27', '2017-09-29 21:15:27', 1),
(23, 'Joson Care', '2017-09-29 21:22:46', '2017-09-29 21:22:46', 1),
(24, 'Covidien', '2017-09-29 21:25:43', '2017-09-29 21:25:43', 1),
(25, 'Carefusion', '2017-09-29 21:26:07', '2017-09-29 21:26:07', 1),
(26, 'Gemco', '2017-09-29 21:33:26', '2017-09-29 21:33:26', 1),
(27, 'Fisher and Paykel', '2017-09-29 21:33:54', '2017-09-29 21:33:54', 1),
(28, 'Agfa', '2017-10-10 15:36:20', '2017-10-10 15:36:20', 1),
(29, 'APC', '2017-10-10 15:36:29', '2017-10-10 15:36:29', 1),
(30, 'Andes Medical', '2017-10-10 15:36:37', '2017-10-10 15:36:37', 1),
(31, 'Arigmed', '2017-10-10 15:36:44', '2017-10-10 15:36:44', 1),
(32, 'Bistos', '2017-10-10 15:36:57', '2017-10-10 15:36:57', 1),
(33, 'Brainlab', '2017-10-10 15:37:11', '2017-10-10 15:37:11', 1),
(34, 'Datamedica', '2017-10-10 15:37:45', '2017-10-10 15:37:45', 1),
(35, 'Doctor Choice', '2017-10-10 15:38:01', '2017-10-10 15:38:01', 1),
(36, 'Fluke', '2017-10-10 15:38:36', '2017-10-10 15:38:36', 1),
(37, 'Helmer', '2017-10-10 15:38:51', '2017-10-10 15:38:51', 1),
(38, 'Hamilton', '2017-10-10 15:38:59', '2017-10-10 15:38:59', 1),
(39, 'Indura', '2017-10-10 15:39:13', '2017-10-10 15:39:13', 1),
(40, 'Interacoustic', '2017-10-10 15:39:29', '2017-10-10 15:39:29', 1),
(41, 'Intelect', '2017-10-10 15:39:36', '2017-10-10 15:39:36', 1),
(42, 'LG', '2017-10-10 15:39:42', '2017-10-10 15:39:42', 1),
(43, 'Logict', '2017-10-10 15:39:51', '2017-10-10 15:39:51', 1),
(44, 'Maquet', '2017-10-10 15:40:01', '2017-10-10 15:40:01', 1),
(45, 'Medcom', '2017-10-10 15:40:17', '2017-10-10 15:40:17', 1),
(46, 'Medix', '2017-10-10 15:40:42', '2017-10-10 15:40:42', 1),
(47, 'Medtronic', '2017-10-10 15:40:47', '2017-10-10 15:40:47', 1),
(48, 'Minrad', '2017-10-10 15:41:02', '2017-10-10 15:41:02', 1),
(49, 'Nellcor', '2017-10-10 15:41:16', '2017-10-10 15:41:16', 1),
(50, 'Nonin', '2017-10-10 15:41:30', '2017-10-10 15:41:30', 1),
(51, 'Olympus', '2017-10-10 15:41:41', '2017-10-10 15:41:41', 1),
(52, 'Pentafarma', '2017-10-10 15:41:49', '2017-10-10 15:41:49', 1),
(53, 'Sonosite', '2017-10-10 15:42:15', '2017-10-10 15:42:15', 1),
(54, 'SpaceLab', '2017-10-10 15:42:30', '2017-10-10 15:42:30', 1),
(55, 'SLE', '2017-10-10 15:42:37', '2017-10-10 15:42:37', 1),
(56, 'Thermo', '2017-10-10 15:42:49', '2017-10-10 15:42:49', 1),
(57, 'Toshiba', '2017-10-10 15:43:03', '2017-10-10 15:43:03', 1),
(58, 'Valleylab', '2017-10-10 15:43:13', '2017-10-10 15:43:13', 1),
(59, 'Carl Zeiss', '2017-10-10 15:43:27', '2017-10-10 15:43:27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_modelo`
--

CREATE TABLE `pm_modelo` (
  `MOD_id` int(11) NOT NULL,
  `MOD_nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `TIP_id` int(11) NOT NULL,
  `MAR_id` int(11) NOT NULL,
  `MOD_foto` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `MOD_fechacreacion` datetime NOT NULL,
  `MOD_fechamodificacion` datetime NOT NULL,
  `MOD_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_modelo`
--

INSERT INTO `pm_modelo` (`MOD_id`, `MOD_nombre`, `TIP_id`, `MAR_id`, `MOD_foto`, `MOD_fechacreacion`, `MOD_fechamodificacion`, `MOD_estado`) VALUES
(1, 'Fabius GS Premium', 7, 1, 'image-1507577929-fabius.jpg', '2017-10-03 00:00:00', '2017-10-09 23:48:51', 1),
(2, 'Cardiocap 5', 1, 2, 'image-1507576435-cardiocap5.jpg', '2017-10-09 16:13:56', '2017-10-09 23:48:45', 1),
(3, 'HDI5000', 3, 5, 'image-1507841124-hdi_5000_lg.jpg', '2017-10-09 20:43:54', '2017-10-12 22:45:26', 1),
(4, 'B650', 1, 2, 'image-1507593266-b650.jpg', '2017-10-09 20:46:54', '2017-10-09 23:48:38', 1),
(5, 'M-Series', 5, 16, 'image-1507643996-zollm.jpg', '2017-10-10 15:59:00', '2017-10-10 15:59:59', 1),
(6, 'Endura BV', 9, 5, 'image-1507924868-70721-104851.jpg', '2017-10-13 20:21:03', '2017-10-13 22:01:10', 1),
(7, 'Logic9', 3, 2, 'image-1508555363-logic9-thumb.jpg', '2017-10-21 00:09:23', '2017-10-21 00:09:23', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_mod_rep`
--

CREATE TABLE `pm_mod_rep` (
  `MOD_id` int(11) NOT NULL,
  `REP_id` int(11) NOT NULL,
  `MOD_REP_fechacreacion` datetime NOT NULL,
  `MOD_REP_fechamodificacion` datetime NOT NULL,
  `MOD_REP_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_mod_rep`
--

INSERT INTO `pm_mod_rep` (`MOD_id`, `REP_id`, `MOD_REP_fechacreacion`, `MOD_REP_fechamodificacion`, `MOD_REP_estado`) VALUES
(1, 1, '2017-10-15 22:49:21', '2017-10-15 22:49:21', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_protocolo`
--

CREATE TABLE `pm_protocolo` (
  `PRO_id` int(11) NOT NULL,
  `PRO_nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `PRO_url` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `MOD_id` int(11) NOT NULL,
  `PRO_fechacreacion` datetime NOT NULL,
  `PRO_fechamodificacion` datetime NOT NULL,
  `PRO_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_protocolo`
--

INSERT INTO `pm_protocolo` (`PRO_id`, `PRO_nombre`, `PRO_url`, `MOD_id`, `PRO_fechacreacion`, `PRO_fechamodificacion`, `PRO_estado`) VALUES
(1, 'Protocolo Acreditación', 'manual-1507736908-Protocolo Interno Monitor.xlsx', 2, '2017-10-11 17:48:31', '2017-10-11 17:52:51', 1),
(2, 'Protocolo Mantenimiento', 'manual-1507747411-Monitor Multiparametro.doc', 2, '2017-10-11 20:43:33', '2017-10-11 20:43:33', 1),
(3, 'Protocolo Mantenimiento', 'protocolo-1507919028-PROTOCOLO DE MANTENIMIENTO_ARCO_C (1).docx', 6, '2017-10-13 20:23:16', '2017-10-13 20:23:51', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_repuesto`
--

CREATE TABLE `pm_repuesto` (
  `REP_id` int(11) NOT NULL,
  `REP_nombre` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `REP_referencia` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `REP_descripcion` longtext COLLATE utf8_spanish_ci,
  `REP_foto` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `REP_fechacreacion` datetime DEFAULT NULL,
  `REP_fechamodificacion` datetime DEFAULT NULL,
  `REP_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_repuesto`
--

INSERT INTO `pm_repuesto` (`REP_id`, `REP_nombre`, `REP_referencia`, `REP_descripcion`, `REP_foto`, `REP_fechacreacion`, `REP_fechamodificacion`, `REP_estado`) VALUES
(1, 'Sensor oxígeno - Drager', '6850645', 'Sensor oxígeno, para máquina de anestesia', 'repuesto-1508154948-MT-423-2002.jpg', '2017-10-13 16:54:46', '2017-10-16 13:55:50', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_tipoequipo`
--

CREATE TABLE `pm_tipoequipo` (
  `TIP_id` int(11) NOT NULL,
  `TIP_nombre` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `TIP_fechacreacion` datetime DEFAULT NULL,
  `TIP_fechamodificacion` datetime DEFAULT NULL,
  `TIP_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_tipoequipo`
--

INSERT INTO `pm_tipoequipo` (`TIP_id`, `TIP_nombre`, `TIP_fechacreacion`, `TIP_fechamodificacion`, `TIP_estado`) VALUES
(1, 'Monitor Multiparámetros', '2017-10-09 23:32:55', '2017-10-09 23:35:13', 1),
(2, 'Ventilador Mecánico', '2017-10-09 23:36:41', '2017-10-09 23:36:41', 1),
(3, 'Ecotomógrafo', '2017-10-09 23:36:51', '2017-10-09 23:36:51', 1),
(4, 'Monitor Signos Vitales', '2017-10-09 23:37:01', '2017-10-09 23:37:01', 1),
(5, 'Desfibrilador', '2017-10-09 23:37:08', '2017-10-09 23:37:08', 1),
(6, 'Refrigerador', '2017-10-09 23:37:14', '2017-10-09 23:37:14', 1),
(7, 'Máquina Anestesia', '2017-10-09 23:37:31', '2017-10-09 23:37:31', 1),
(8, 'Microscopio', '2017-10-12 18:29:06', '2017-10-12 18:29:21', 1),
(9, 'RX Portátil', '2017-10-13 20:20:27', '2017-10-13 20:20:27', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pm_torpedo`
--

CREATE TABLE `pm_torpedo` (
  `TOR_id` int(11) NOT NULL,
  `TOR_titulo` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `TOR_descripcion` longtext COLLATE utf8_spanish_ci,
  `TOR_url` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `MOD_id` int(11) NOT NULL,
  `TOR_fechacreacion` datetime DEFAULT NULL,
  `TOR_fechamodificacion` datetime DEFAULT NULL,
  `TOR_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pm_torpedo`
--

INSERT INTO `pm_torpedo` (`TOR_id`, `TOR_titulo`, `TOR_descripcion`, `TOR_url`, `MOD_id`, `TOR_fechacreacion`, `TOR_fechamodificacion`, `TOR_estado`) VALUES
(1, 'Clave Instalación/Servicio', 'Instalación (16-4-34), Servicio (26-23-8).', '', 2, '2017-10-12 16:57:56', '2017-10-12 17:04:13', 1),
(2, 'Método solucionar error 008', 'abcdefg', 'apuntes-1507896374-Error 0008.txt', 3, '2017-10-13 00:58:09', '2017-10-13 14:06:17', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pm_empleado`
--
ALTER TABLE `pm_empleado`
  ADD PRIMARY KEY (`EMP_id`);

--
-- Indices de la tabla `pm_manual`
--
ALTER TABLE `pm_manual`
  ADD PRIMARY KEY (`MAN_id`),
  ADD KEY `fk_PM_MANual_PM_MODelo1_idx` (`MOD_id`);

--
-- Indices de la tabla `pm_marca`
--
ALTER TABLE `pm_marca`
  ADD PRIMARY KEY (`MAR_id`);

--
-- Indices de la tabla `pm_modelo`
--
ALTER TABLE `pm_modelo`
  ADD PRIMARY KEY (`MOD_id`);

--
-- Indices de la tabla `pm_mod_rep`
--
ALTER TABLE `pm_mod_rep`
  ADD PRIMARY KEY (`MOD_id`,`REP_id`),
  ADD KEY `fk_PM_MODelo_has_PM_REPuesto_PM_REPuesto1_idx` (`REP_id`),
  ADD KEY `fk_PM_MODelo_has_PM_REPuesto_PM_MODelo1_idx` (`MOD_id`);

--
-- Indices de la tabla `pm_protocolo`
--
ALTER TABLE `pm_protocolo`
  ADD PRIMARY KEY (`PRO_id`);

--
-- Indices de la tabla `pm_repuesto`
--
ALTER TABLE `pm_repuesto`
  ADD PRIMARY KEY (`REP_id`);

--
-- Indices de la tabla `pm_tipoequipo`
--
ALTER TABLE `pm_tipoequipo`
  ADD PRIMARY KEY (`TIP_id`);

--
-- Indices de la tabla `pm_torpedo`
--
ALTER TABLE `pm_torpedo`
  ADD PRIMARY KEY (`TOR_id`),
  ADD KEY `fk_PM_TORpedo_PM_MODelo1_idx` (`MOD_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pm_empleado`
--
ALTER TABLE `pm_empleado`
  MODIFY `EMP_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `pm_manual`
--
ALTER TABLE `pm_manual`
  MODIFY `MAN_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `pm_marca`
--
ALTER TABLE `pm_marca`
  MODIFY `MAR_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT de la tabla `pm_modelo`
--
ALTER TABLE `pm_modelo`
  MODIFY `MOD_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `pm_protocolo`
--
ALTER TABLE `pm_protocolo`
  MODIFY `PRO_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `pm_repuesto`
--
ALTER TABLE `pm_repuesto`
  MODIFY `REP_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `pm_tipoequipo`
--
ALTER TABLE `pm_tipoequipo`
  MODIFY `TIP_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `pm_torpedo`
--
ALTER TABLE `pm_torpedo`
  MODIFY `TOR_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pm_manual`
--
ALTER TABLE `pm_manual`
  ADD CONSTRAINT `fk_PM_MANual_PM_MODelo1` FOREIGN KEY (`MOD_id`) REFERENCES `pm_modelo` (`MOD_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pm_mod_rep`
--
ALTER TABLE `pm_mod_rep`
  ADD CONSTRAINT `fk_PM_MODelo_has_PM_REPuesto_PM_MODelo1` FOREIGN KEY (`MOD_id`) REFERENCES `pm_modelo` (`MOD_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PM_MODelo_has_PM_REPuesto_PM_REPuesto1` FOREIGN KEY (`REP_id`) REFERENCES `pm_repuesto` (`REP_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pm_torpedo`
--
ALTER TABLE `pm_torpedo`
  ADD CONSTRAINT `fk_PM_TORpedo_PM_MODelo1` FOREIGN KEY (`MOD_id`) REFERENCES `pm_modelo` (`MOD_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
