-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-03-2018 a las 19:18:32
-- Versión del servidor: 10.1.19-MariaDB
-- Versión de PHP: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
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
	WHERE `MOD_id`=id
    AND `MAN_estado` = 1) as numManuales,
    (SELECT COUNT(*)
	FROM `pm_protocolo`
	WHERE `MOD_id`=id
    AND `PRO_estado` = 1) as numProtocolos,
    (SELECT COUNT(*)
	FROM `pm_torpedo`
	WHERE `MOD_id`=id
    AND `TOR_estado` = 1) as numTorpedos,
    (SELECT COUNT(*)
	FROM `pm_mod_rep`
	WHERE `MOD_id`=id
    AND `MOD_REP_estado` = 1) as numRepuestos
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
        mo.`MOD_foto` as foto,
        (SELECT COUNT(*)
	FROM `pm_manual`
	WHERE `MOD_id`=id
    AND `MAN_estado` = 1) as numManuales,
    (SELECT COUNT(*)
	FROM `pm_protocolo`
	WHERE `MOD_id`=id
    AND `PRO_estado` = 1) as numProtocolos,
    (SELECT COUNT(*)
	FROM `pm_torpedo`
	WHERE `MOD_id`=id
    AND `TOR_estado` = 1) as numTorpedos,
    (SELECT COUNT(*)
	FROM `pm_mod_rep`
	WHERE `MOD_id`=id
    AND `MOD_REP_estado` = 1) as numRepuestos
        FROM `pm_modelo` as mo
    INNER JOIN `pm_marca` as ma
  	ON mo.`MAR_id`=ma.`MAR_id`
  	INNER JOIN `pm_tipoequipo` as ti
  	ON mo.`TIP_id`=ti.`TIP_id`
 	WHERE mo.`MOD_estado` = 1
    AND mo.`MOD_id`= id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MODELO_seldrop` ()  NO SQL
BEGIN
  SELECT
    mo.`MOD_id` as id,
    mo.`MOD_nombre` as name
  FROM `pm_modelo` as mo
  WHERE mo.`MOD_estado` = 1
  ORDER BY `MOD_nombre` asc;
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
    mr.`MOD_id` as idMod,
    mr.`REP_id` as idRep,
    re.`REP_nombre` as nombre,
    re.`REP_referencia` as referencia,
    re.`REP_foto` as foto,
    re.`REP_descripcion` as descripcion
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
  AND mr.`MOD_id` = id;
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
(2, 'Roberto', 'García', 'roberto@bicicleta.cl', 0, 'roberto', 'b02e2275ba3df935a2a711b0297e74db8c4d56a4', '2017-10-20 16:52:27', '2017-10-20 16:52:44', 1),
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
(13, 'Manual Referencia Técnica', 'M-68', 'manual-1509624041-M1031914-02_CC5_MANUAL DE SERVICIO.pdf', 2, '2017-10-24 16:18:47', '2017-12-22 18:01:15', 1),
(14, 'Manual Servicio', '', 'manual-1508854759-manual-1507841252-ATL HDI 5000 Service Manual.pdf', 3, '2017-10-24 16:19:20', '2017-10-24 16:19:20', 1),
(15, 'Manual Referencia', '', 'manual-1508854786-manual-1507841331-ATL HDI 5000 Reference Manual.pdf', 3, '2017-10-24 16:19:47', '2017-10-24 16:19:47', 1),
(16, 'Códigos Errores', '', 'manual-1508854816-manual-1507841388-86304542-Philips-HDI-5000-Errors (1).pdf', 3, '2017-10-24 16:20:17', '2017-10-24 16:20:17', 1),
(17, 'Especificaciones Técnicas', '', 'manual-1508854842-manual-1507841426-ATL HDI 5000 Data Sheet.pdf', 3, '2017-10-24 16:20:43', '2017-10-24 16:20:43', 1),
(18, 'Manual de Usuario', '', 'manual-1508854868-manual-1507841456-Manual usuario HDI500.pdf', 3, '2017-10-24 16:21:09', '2017-10-24 16:21:09', 1),
(19, 'Uso de Desinfectantes y Gel', '', 'manual-1508854893-manual-1507841585-HDI5000 Uso de desinfectantes y gel.pdf', 3, '2017-10-24 16:21:35', '2017-10-24 16:21:35', 1),
(20, 'VxWorks Commands', '', 'manual-1508854920-manual-1507841612-HDI5000 VXWorks Commands.pdf', 3, '2017-10-24 16:22:01', '2017-10-24 16:22:01', 1),
(21, 'Manual Servicio Reparación', '', 'manual-1508854970-manual-1507918898-BV Endura Service Manual.pdf', 6, '2017-10-24 16:22:51', '2017-10-24 16:22:51', 1),
(22, 'Manual de instalación', '', 'manual-1508856143-manual-1508762325-2922 D ES PP Drystar 5300-A4.pdf', 8, '2017-10-24 16:23:12', '2017-10-24 16:42:24', 1),
(23, 'Manual Servicio Avanzado', '', 'manual-1508863001-manual-1508761763-LOGIQ_9_Proprietary_Manual.pdf', 20, '2017-10-24 18:36:43', '2017-10-24 18:36:43', 1),
(24, 'Manual de Uso', '', 'manual-1508863044-manual-1508762295-2921 D ES UM Drystar 5300.pdf', 8, '2017-10-24 18:37:25', '2017-10-24 18:37:25', 1),
(25, 'Manual de Referencia', '', 'manual-1508863077-manual-1508762529-2920 D EN RM Drystar 5300.pdf', 8, '2017-10-24 18:37:58', '2017-10-24 18:37:58', 1),
(26, 'Manual de Referencia', '', 'manual-1508863112-manual-1508762669-2900 H EN RM Drystar 5500.pdf', 9, '2017-10-24 18:38:33', '2017-10-24 18:38:33', 1),
(27, 'Manual de Uso', '', 'manual-1508863128-manual-1508762687-2901 H ES UM Drystar 5500.pdf', 9, '2017-10-24 18:38:49', '2017-10-24 18:38:49', 1),
(28, 'Manual de Instalación', '', 'manual-1508863158-manual-1508762712-2903 Q ES PP Drystar 5500-A4.pdf', 9, '2017-10-24 18:39:19', '2017-10-24 18:39:19', 1),
(29, 'Manual de Instalación', '', 'manual-1508863358-manual-1508762933-2851 B ES PP Drystar AXYS-A4.pdf', 10, '2017-10-24 18:42:39', '2017-10-24 18:42:39', 1),
(30, 'Manual de Uso', '', 'manual-1508863387-manual-1508762948-2852 B ES UM Drystar AXYS.pdf', 10, '2017-10-24 18:43:08', '2017-10-24 18:43:08', 1),
(31, 'Manual de Uso', '', 'manual-1508863431-manual-1508763871-190730361-Accurus-Operator-Manual.pdf', 14, '2017-10-24 18:43:52', '2017-10-24 18:43:52', 1),
(32, 'Manual de Servicio', '', 'manual-1508863457-manual-1508764610-GN300-ServiceManual_26906.pdf', 18, '2017-10-24 18:44:18', '2017-10-24 18:44:18', 1),
(33, 'Manual de Usuario - Parte 1', '', 'manual-1508863482-manual-1508772754-1009-0309a.pdf', 15, '2017-10-24 18:44:43', '2017-10-24 18:44:43', 1),
(34, 'Manual de Usuario - Parte 2', '', 'manual-1508863496-manual-1508772773-1009-0310a.pdf', 15, '2017-10-24 18:44:57', '2017-10-24 18:44:57', 1),
(35, 'Manual de Referencia Técnica', '', 'manual-1508863522-manual-1508773030-1009-0356A.pdf', 15, '2017-10-24 18:45:23', '2017-10-24 18:45:23', 1),
(36, 'Manual Técnico Ventilador 7100', '', 'manual-1508863574-manual-1508773056-1006-0836B.pdf', 15, '2017-10-24 18:46:15', '2017-10-24 18:46:15', 1),
(37, 'Manual Servicio', '', 'manual-1508863600-manual-1508781498-Cardinal_Alaris_-_Service_Manual.pdf', 23, '2017-10-24 18:46:41', '2017-10-24 18:46:41', 1),
(38, 'Manual de Uso', '', 'manual-1508863622-manual-1508787326-1000DF00385.pdf', 23, '2017-10-24 18:47:04', '2017-10-24 18:47:04', 1),
(39, 'Manual de Servicio', '', 'manual-1508863659-manual-1508789142-Alcon_Phaco_machine_Series_20000_Legacy_-_Service_manual.pdf', 13, '2017-10-24 18:47:40', '2017-10-24 18:47:40', 1),
(40, 'Manual de Operador', '', 'manual-1508863682-manual-1508789173-Alcon OcuScan RxP Ophthamic Ultrasound System - User manual.pdf', 22, '2017-10-24 18:48:03', '2017-10-24 18:48:03', 1),
(41, 'Manual de Servicio', '', 'manual-1508863702-manual-1508789200-Alcon Infiniti Ophthalmic Surgical Instrument - Service manual.pdf', 19, '2017-10-24 18:48:23', '2017-10-24 18:48:23', 1),
(42, 'Manual del Operador', '', 'manual-1508863737-manual-1508789217-Alcon Infiniti - Operator\'s manual.pdf', 19, '2017-10-24 18:48:58', '2017-10-24 18:48:58', 1),
(43, 'Procedimiento Test de Servicio', '', 'manual-1508863769-manual-1508789259-4097-7225.pdf', 19, '2017-10-24 18:49:30', '2017-10-24 18:49:30', 1),
(44, 'Especificaciones Técnicas', '', 'manual-1508863804-manual-1508791901-Alice 5.pdf', 16, '2017-10-24 18:50:05', '2017-10-24 18:50:05', 1),
(45, 'Guía Técnicos Paramédicos', '', 'manual-1508863831-manual-1508791941-Guía técnicos PSG_MGM.pdf', 16, '2017-10-24 18:50:32', '2017-10-24 18:50:32', 1),
(46, 'Manual Software Sleepware', '', 'manual-1508863853-manual-1508791974-SleepwareManual_es.pdf', 16, '2017-10-24 18:50:54', '2017-10-24 18:50:54', 1),
(47, 'Modos de Configuración', '', 'manual-1508863879-manual-1508791995-MODOS DE CONFIGURACIÓN ALICE 5.doc', 16, '2017-10-24 18:51:21', '2017-10-24 18:51:21', 1),
(48, 'Modos Alice 5 (Portugués)', '', 'manual-1508863905-manual-1508792043-Manual Alice 5 (portuguÃ©s).pdf', 16, '2017-10-24 18:51:47', '2017-10-24 18:51:47', 1),
(49, 'Manual Uso', '', 'manual-1508863933-manual-1508792395-Pierneras Allen (PAL Pro).pdf', 17, '2017-10-24 18:52:14', '2017-10-24 18:52:14', 1),
(50, 'Manual Usuario', '', 'manual-1508877944-20100304095506698.pdf', 25, '2017-10-24 22:45:46', '2017-10-24 22:45:46', 1),
(51, 'Medidas físicas', '', 'manual-1508950088-200699.pdf', 26, '2017-10-25 18:48:10', '2017-10-25 18:48:10', 1),
(52, 'Manual de Uso', '', 'manual-1508950127-201175-G-01-03.pdf', 26, '2017-10-25 18:48:48', '2017-10-25 18:48:48', 1),
(53, 'Manual Servicio - Parte 1 - Datos Técnicos', '', 'manual-1508950195-201177-F-00-20.pdf', 26, '2017-10-25 18:49:56', '2017-10-25 18:49:56', 1),
(54, 'Manual Servicio - Parte 2 - Instalación', '', 'manual-1508950229-201178-B-00-20.pdf', 26, '2017-10-25 18:50:30', '2017-10-25 18:50:30', 1),
(55, 'Manual Servicio - Parte 3 - Reemplazo', '', 'manual-1508950252-201179-A-00-20.pdf', 26, '2017-10-25 18:50:53', '2017-10-25 18:50:53', 1),
(56, 'Manual Servicio - Parte 4 - Ajustes', '', 'manual-1508950279-201180-B-00-20.pdf', 26, '2017-10-25 18:51:21', '2017-10-25 18:51:21', 1),
(57, 'Manual Servicio - Parte 7 - Lista de Partes', '', 'manual-1508950318-201183-E-00-20.pdf', 26, '2017-10-25 18:51:59', '2017-10-25 18:51:59', 1),
(58, 'Manual Servicio - Parte 9 - Mantención Planif', '', 'manual-1508950348-201185-A-00-20.pdf', 26, '2017-10-25 18:52:29', '2017-10-25 18:52:29', 1),
(60, 'Manual Usuario/Servicio Monitor LCD NL', '', 'manual-1509371000-NL_LCD_MONITOR.pdf', 26, '2017-10-30 14:43:21', '2017-10-30 14:43:21', 1),
(61, 'Manual Grabador Medical USB200', '', 'manual-1509371057-MediCap_USB200_User_Guide.pdf', 26, '2017-10-30 14:44:18', '2017-10-30 14:44:18', 1),
(62, 'Manual de usuario', '', 'manual-1509371584-UP-990AD_UP-970AD EN.pdf', 27, '2017-10-30 14:53:05', '2017-10-30 14:53:05', 1),
(63, 'Manual de usuario', '', 'manual-1509371613-UP-990AD_UP-970AD EN.pdf', 28, '2017-10-30 14:53:34', '2017-10-30 14:53:34', 1),
(64, 'Manual Servicio', '', 'manual-1509372362-3M Bair Hugger Therapy Model 505 Service Manual English.pdf', 29, '2017-10-30 15:06:03', '2017-10-30 15:06:03', 1),
(65, 'Manual Servicio', '', 'manual-1509372393-Bair Hugger Model 750 Service Manual English.pdf', 30, '2017-10-30 15:06:34', '2017-10-30 15:06:34', 1),
(66, 'Manual del Operador', '', 'manual-1509372443-200742-ES.pdf', 30, '2017-10-30 15:07:24', '2017-10-30 15:07:24', 1),
(67, 'Manual del Operador', '', 'manual-1509372474-200977-ES.pdf', 29, '2017-10-30 15:07:55', '2017-10-30 15:07:55', 1),
(68, 'Manual de Servicio', '', 'manual-1509373200-Seca_374,375,376_-_Service_manual.pdf', 31, '2017-10-30 15:20:02', '2017-10-30 15:20:02', 1),
(70, 'Especificaciones Técnicas', '', 'manual-1509374655-Especificacion Diapact español.pdf', 32, '2017-10-30 15:44:16', '2017-10-30 15:44:16', 1),
(71, 'Brochure', '', 'manual-1509374680-Folleto Diapact Español 2.pdf', 32, '2017-10-30 15:44:41', '2017-10-30 15:44:41', 1),
(72, 'Manual Uso', '', 'manual-1509374708-Manual Español Diapact CRRT.pdf', 32, '2017-10-30 15:45:09', '2017-10-30 15:45:09', 1),
(73, 'Guía Referencia', '', 'manual-1509374792-Diapact+Flip+Chart.pdf', 32, '2017-10-30 15:46:33', '2017-10-30 15:46:33', 1),
(74, 'Manual de Uso', '', 'manual-1509375339-Infusomat P, Manual de Uso.pdf', 33, '2017-10-30 15:55:39', '2017-10-30 15:55:39', 1),
(75, 'Manual Uso', '', 'manual-1509375512-Manual Uso Perfusor Space J.pdf', 34, '2017-10-30 15:58:32', '2017-10-30 15:58:32', 1),
(76, 'Conexión para Polisomniografía', '', 'manual-1509375746-18947_Capnocheck Plus Sleep Carbon Dioxide Detector capnograph.pdf', 35, '2017-10-30 16:02:26', '2017-10-30 16:02:26', 1),
(77, 'Listado Accesorios', '', 'manual-1509375765-SM196414EN_LR.pdf', 35, '2017-10-30 16:02:45', '2017-10-30 16:02:45', 1),
(78, 'Manual de Usuario', '', 'manual-1509376086-Manual en español M8000A.pdf', 36, '2017-10-30 16:08:06', '2017-10-30 16:08:06', 1),
(79, 'Manual de Servicio', '', 'manual-1509376100-M8000A＆M9000A service manual.pdf', 36, '2017-10-30 16:08:20', '2017-10-30 16:08:20', 1),
(80, 'Manual Usuario', '', 'manual-1509379762-BT400 (Español) Manual Usuario.pdf', 37, '2017-10-30 17:09:22', '2017-10-30 17:09:22', 1),
(81, 'Manual Servicio', '', 'manual-1509379775-MANUAL SERVICIO  BT-400 ESP.pdf', 37, '2017-10-30 17:09:35', '2017-10-30 17:09:35', 1),
(82, 'Manual Operación', '', 'manual-1509380500-070-0089_1.01_BISVIEW_operatingmanual_ENGLISH.pdf', 38, '2017-10-30 17:21:40', '2017-10-30 17:21:40', 1),
(83, 'Manual Servicio', '', 'manual-1509380512-SM_EN_Bisview_075-100020Rev201.00.pdf', 38, '2017-10-30 17:21:52', '2017-10-30 17:21:52', 1),
(84, 'Manual de Operación y Técnico', '', 'manual-1509381084-Manual Técnico version 56201-Y.pdf', 39, '2017-10-30 17:31:24', '2017-10-30 17:31:24', 1),
(85, 'Manual Servicio Técnico', '', 'manual-1509381988-Hospira_Plum_A+_Infusion_System_-_Service_manual.pdf', 41, '2017-10-30 17:46:28', '2017-10-30 17:46:28', 1),
(86, 'Manual Usuario', '', 'manual-1509382006-Abbott-Hospira-Plum-A-116-Manual.pdf', 41, '2017-10-30 17:46:46', '2017-10-30 17:46:46', 1),
(87, 'Manual Usuario', '', 'manual-1509382397-Optima MS User Manual.pdf', 40, '2017-10-30 17:53:17', '2017-10-30 17:53:17', 1),
(88, 'Manual Técnico', '', 'manual-1509382423-Optima MS Service Manual.pdf', 40, '2017-10-30 17:53:43', '2017-10-30 17:53:43', 1),
(89, 'Manual Servicio Técnico', '', 'manual-1509382666-Injectomat_Agilia_en.pdf', 42, '2017-10-30 17:57:46', '2017-10-30 17:57:46', 1),
(90, 'Manual de uso', '', 'manual-1509383019-6101-3642.pdf', 43, '2017-10-30 18:03:39', '2017-10-30 18:03:39', 1),
(91, 'Manual Operador', '', 'manual-1509393684-100840-620 Easy III Operator\'s Manual Version 3.12.pdf', 44, '2017-10-30 21:01:24', '2017-10-30 21:01:24', 1),
(92, 'Guía de configuración', '', 'manual-1509393707-100840-933 Easy III Setup Guide Rev6.pdf', 44, '2017-10-30 21:01:47', '2017-10-30 21:01:47', 1),
(94, 'Configuración Windows para Easy III', '', 'manual-1509394085-369031-630 Configuring Windows 7 for Easy III.pdf', 44, '2017-10-30 21:08:05', '2017-10-30 21:08:05', 1),
(95, 'Release Notes', '', 'manual-1509394105-369031-810 Easy III v3.12 Release Notes.pdf', 44, '2017-10-30 21:08:25', '2017-10-30 21:08:25', 1),
(96, 'Instrucciones instalación', '', 'manual-1509394133-369031-934 Easy III Ver 312 Installation and Upgrade Instructions.pdf', 44, '2017-10-30 21:08:53', '2017-10-30 21:08:53', 1),
(97, 'Guía rápida', '', 'manual-1509394314-Guía Rápida.pdf', 44, '2017-10-30 21:11:54', '2017-10-30 21:11:54', 1),
(98, 'Manual Usuario', '', 'manual-1509395458-1453796964.pdf', 45, '2017-10-30 21:30:58', '2017-10-30 21:30:58', 1),
(99, 'Información de Seguridad', '', 'manual-1509395514-1453799375.pdf', 45, '2017-10-30 21:31:54', '2017-10-30 21:31:54', 1),
(100, 'Manual Referencia del Usuario', '', 'manual-1509623980-CC5 AnesRefMnl 6-347C.pdf', 2, '2017-11-02 12:57:05', '2017-11-02 12:59:41', 1),
(101, 'Guía del Usuario', '', 'manual-1509623849-CC5 AnesUG-SP 6-357E.pdf', 2, '2017-11-02 12:57:30', '2017-11-02 12:57:30', 1),
(102, 'Manual Usuario', '', 'manual-1509624260-30_1716_v4_0_es_VARIO 700_Manual Usuario.pdf', 47, '2017-11-02 13:04:22', '2017-11-02 13:04:22', 1),
(103, 'Manual Usuario', '', 'manual-1509625067-30-1384 opmi pico - Manual Usuario.pdf', 48, '2017-11-02 13:17:48', '2017-11-02 13:17:48', 1),
(104, 'Manual Servicio Sistema Suspensión', '', 'manual-1509628050-sm_30_0030_e_opmi_pico_stative_s100_v3_0.pdf', 48, '2017-11-02 13:19:44', '2017-11-02 14:07:31', 1),
(105, 'Instalación Módulo Enfoque Externo', '', 'manual-1509629837-SM_30_8005_76_en OPMI Movena1.pdf', 51, '2017-11-02 13:35:53', '2017-11-02 14:37:18', 1),
(106, 'Instrucciones de Servicio', '', 'manual-1509627887-SM_30_0028_a1_en OPMI VARIO.pdf', 47, '2017-11-02 14:04:49', '2017-11-02 14:04:49', 1),
(107, 'Instrucciones de Servicio', '', 'manual-1509628214-SM_30_0032_A3_en OPMI Sensera.pdf', 50, '2017-11-02 14:10:15', '2017-11-02 14:10:15', 1),
(108, 'Instrucciones de Servicio', '', 'manual-1509628664-SM_30_0032_A8_en OPMI Movena.pdf', 51, '2017-11-02 14:17:45', '2017-11-02 14:17:45', 1),
(109, 'Instrucciones Base', '', 'manual-1509628711-SM_30_0032_A11_en Estativo S 7.pdf', 51, '2017-11-02 14:18:33', '2017-11-02 14:18:33', 1),
(110, 'Instrucciones Instalación Superlux 180', '', 'manual-1509628880-SM_30_0032_A12_en Superlux 180 - S7.pdf', 51, '2017-11-02 14:21:21', '2017-11-02 14:21:21', 1),
(111, 'Manual Usuario', '', 'manual-1509639400-CP-1200, 1000 _OP_Manual_.pdf', 52, '2017-11-02 17:16:41', '2017-11-02 17:16:41', 1),
(112, 'Manual Servicio', '', 'manual-1509639415-Service Manual CP-1000.pdf', 52, '2017-11-02 17:16:56', '2017-11-02 17:16:56', 1),
(113, 'Manual Usuario', '', 'manual-1509649832-905-051-015.02 Virtua Users Manual.pdf', 53, '2017-11-02 20:10:33', '2017-11-02 20:10:33', 1),
(114, 'Manual Usuario Virtua E', '', 'manual-1509649860-905-056-006.01 Virtua E Users Manual.pdf', 53, '2017-11-02 20:11:02', '2017-11-02 20:11:02', 1),
(115, 'Manual Usuario Virtua C', '', 'manual-1509649873-905-057-007.01 Virtua C Users Manual.pdf', 53, '2017-11-02 20:11:14', '2017-11-02 20:11:14', 1),
(116, 'Instalación Software', '', 'manual-1509649936-901-152-003.01 Software Installation.pdf', 53, '2017-11-02 20:12:17', '2017-11-02 20:12:17', 1),
(117, 'Firewall y Seguridad', '', 'manual-1509650013-901-160-002.a Firewall and Security.pdf', 53, '2017-11-02 20:13:34', '2017-11-02 20:13:34', 1),
(118, 'Calidad de impresión y Selección de Tinta', '', 'manual-1509650064-901-168-003.01 Print Quality and Ink Selection.pdf', 53, '2017-11-02 20:14:25', '2017-11-02 20:14:25', 1),
(119, 'Grabado automático', '', 'manual-1509650602-901-169-001.b Auto-Record Trigger.pdf', 53, '2017-11-02 20:23:23', '2017-11-02 20:23:23', 1),
(120, 'Perfiles de trabajo', '', 'manual-1509650632-901-170-001.b Speed-Optimized Job Profiles.pdf', 53, '2017-11-02 20:23:53', '2017-11-02 20:23:53', 1),
(121, 'Archivo', '', 'manual-1509650683-901-172-001.b Scheduled Archive.pdf', 53, '2017-11-02 20:24:44', '2017-11-02 20:24:44', 1),
(122, 'Reportes HL7', '', 'manual-1509650699-901-173-004.01 HL7 Reports.pdf', 53, '2017-11-02 20:25:00', '2017-11-02 20:25:00', 1),
(123, 'Cliente recuperación de consultas', '', 'manual-1509650744-901-178-002.02 Query Retrieve.pdf', 53, '2017-11-02 20:25:45', '2017-11-02 20:25:45', 1),
(124, 'Compresión DICOM', '', 'manual-1509650759-901-183-001.01 DICOM JPEG Compression.pdf', 53, '2017-11-02 20:26:00', '2017-11-02 20:26:00', 1),
(125, 'Reportes estructurados DICOM', '', 'manual-1509650780-901-184-002.01 DICOM Structured Reports.pdf', 53, '2017-11-02 20:26:21', '2017-11-02 20:26:21', 1),
(126, 'Seleccionar visores DICOM', '', 'manual-1509650802-901-186-002.01 Selecting DICOM Viewers.pdf', 53, '2017-11-02 20:26:43', '2017-11-02 20:26:43', 1),
(127, 'Guía referencia Virtua E', '', 'manual-1509651138-900-431-001.01 Virtua E Reference Guide.pdf', 53, '2017-11-02 20:26:59', '2017-11-02 20:32:19', 1),
(129, 'Guia referencia Virtua C', '', 'manual-1509651265-900-430-002.01 Virtua C Reference Guide.pdf', 53, '2017-11-02 20:34:26', '2017-11-02 20:34:26', 1),
(130, 'Guia referencia Virtua', '', 'manual-1509651297-900-567-001.01 Virtua Reference Guide.pdf', 53, '2017-11-02 20:34:58', '2017-11-02 20:34:58', 1),
(131, 'Framework de conectividad DICOM', '', 'manual-1509651326-900-332-007.01 Virtua DICOM Conformance Statement.pdf', 53, '2017-11-02 20:35:27', '2017-11-02 20:35:27', 1),
(133, 'Integración IHE', '', 'manual-1509651383-900-404-001.01 Virtua IHE Integration Statement.pdf', 53, '2017-11-02 20:36:24', '2017-11-02 20:36:24', 1),
(134, 'Especificaciones técnicas', '', 'manual-1509651687-Lforceez.pdf', 54, '2017-11-02 20:41:28', '2017-11-02 20:41:28', 1),
(135, 'Especificaciones técnicas', '', 'manual-1509651701-Lforcefx.pdf', 55, '2017-11-02 20:41:42', '2017-11-02 20:41:42', 1),
(136, 'Manual Usuario', '', 'manual-1509651815-1013155 UG_es.pdf', 54, '2017-11-02 20:43:36', '2017-11-02 20:43:36', 1),
(137, 'Manual Servicio', '', 'manual-1509651835-1013084 SM_en.pdf', 54, '2017-11-02 20:43:56', '2017-11-02 20:43:56', 1),
(138, 'Manual Usuario', '', 'manual-1509651935-1013749 UG_es.pdf', 55, '2017-11-02 20:45:36', '2017-11-02 20:45:36', 1),
(139, 'Manual Servicio', '', 'manual-1509651949-1013100 SM_en.pdf', 55, '2017-11-02 20:45:50', '2017-11-02 20:45:50', 1),
(140, 'Manual Usuario', '', 'manual-1509652748-N65_Ops_Spanish.pdf', 56, '2017-11-02 20:57:47', '2017-11-02 20:59:09', 1),
(141, 'Manual Servicio', '', 'manual-1509652684-N65_Service_English.pdf', 56, '2017-11-02 20:58:05', '2017-11-02 20:58:05', 1),
(142, 'Instrucciones de Servicio 160/210', '', 'manual-1509653334-Manual de servicio Opmi_Visu_160_210.pdf', 49, '2017-11-02 21:08:56', '2017-11-02 21:08:56', 1),
(143, 'Instrucciones de Servicio 140', '', 'manual-1509653380-SM_30_0037_A1_en Visu 140.pdf', 49, '2017-11-02 21:09:41', '2017-11-02 21:09:41', 1),
(144, 'Manual Servicio', '', 'manual-1509653717-REGIUS 110HQ Service Manual_0404IA01EN03.pdf', 57, '2017-11-02 21:15:18', '2017-11-02 21:15:18', 1),
(145, 'Lista de partes', '', 'manual-1509653736-REGIUS 110HQ Parts List_0404KA01ZZ03.pdf', 57, '2017-11-02 21:15:37', '2017-11-02 21:15:37', 1),
(146, 'Manual Servicio', '', 'manual-1509653921-Criticare506DN Service_manual.pdf', 58, '2017-11-02 21:18:42', '2017-11-02 21:18:42', 1),
(147, 'Manual Usuario', '', 'manual-1509653936-39184B005 Op Manual 506DN-CN Spanish R1.pdf', 58, '2017-11-02 21:18:57', '2017-11-02 21:18:57', 1),
(148, 'Accesorios espirometría', '', 'manual-1509654500-Accesorios Espirometría.pdf', 2, '2017-11-02 21:28:21', '2017-11-02 21:28:21', 1),
(149, 'Manual Referencia Usuario', '', 'manual-1509654739-Datex_S5_Light_Operator.pdf', 59, '2017-11-02 21:32:20', '2017-11-02 21:32:20', 1),
(150, 'Manual Referencia Técnica', '', 'manual-1509654835-Lightmonitor Technical Manual.pdf', 59, '2017-11-02 21:33:56', '2017-11-02 21:33:56', 1),
(151, 'Manual Operador', '', 'manual-1510062292-Manual Op Desfibriladores NK TEC-5500.pdf', 60, '2017-11-07 14:44:53', '2017-11-07 14:44:53', 1),
(152, 'Manual Servicio', '', 'manual-1510062363-Service Manual TEC5531.pdf', 60, '2017-11-07 14:46:04', '2017-11-07 14:46:04', 1),
(153, 'Manual Usuario', '', 'manual-1510065888-Nihon_Kohden_Cardiolife_TEC-7100,7200_-_User_manual.pdf', 61, '2017-11-07 15:44:49', '2017-11-07 15:44:49', 1),
(154, 'Manual Servicio', '', 'manual-1510065907-Nihon_Kohden_Cardiolife_TEC-7100-7300_-_Service_manual.pdf', 61, '2017-11-07 15:45:08', '2017-11-07 15:45:08', 1),
(155, 'Manual Servicio', '', 'manual-1510066095-Nihon-Kohden_TEC-7500_Defibrillator_-_Service_manual.pdf', 62, '2017-11-07 15:48:16', '2017-11-07 15:48:16', 1),
(156, 'Guía de configuración', '', 'manual-1510066396-Guia configuración Rev. K.pdf', 63, '2017-11-07 15:53:17', '2017-11-07 15:53:17', 1),
(157, 'Guía consulta rápida', '', 'manual-1510066417-Guia Consulta Rápida.pdf', 63, '2017-11-07 15:53:38', '2017-11-07 15:53:38', 1),
(158, 'Guía del Operador', '', 'manual-1510066449-Guia del Operador.pdf', 63, '2017-11-07 15:54:10', '2017-11-07 15:54:10', 1),
(159, 'Manual Servicio', '', 'manual-1510066498-R Series Service Manual.pdf', 63, '2017-11-07 15:54:59', '2017-11-07 15:54:59', 1),
(160, 'Guía batería Surepack', '', 'manual-1510066531-SurePower Battery Pack Guide.pdf', 63, '2017-11-07 15:55:32', '2017-11-07 15:55:32', 1),
(161, 'Instrucciones de prueba', '', 'manual-1510242701-Babylog 8000 PMS l.pdf', 64, '2017-11-09 16:51:42', '2017-11-09 16:51:42', 1),
(162, 'Reemplazo kit 6 años', '', 'manual-1510242736-Babylog 8000, 6-yearly.pdf', 64, '2017-11-09 16:52:17', '2017-11-09 16:52:17', 1),
(163, 'Códigos de error', '', 'manual-1510242761-Babylog codigos de error.pdf', 64, '2017-11-09 16:52:42', '2017-11-09 16:52:42', 1),
(164, 'Instrucciones de reparación', '', 'manual-1510242788-bloque esp babylog.pdf', 64, '2017-11-09 16:53:09', '2017-11-09 16:53:09', 1),
(165, 'Carta de pruebas', '', 'manual-1510242835-Carta de prueba CP.pdf', 64, '2017-11-09 16:53:56', '2017-11-09 16:53:56', 1),
(166, 'Catálogo de sensores', '', 'manual-1510242910-Katalog_2_Sensors_ES_2013_02.pdf', 64, '2017-11-09 16:55:11', '2017-11-09 16:55:11', 1),
(167, 'Modo Servicio', '', 'manual-1510242943-Modo Servicio Babylog.pdf', 64, '2017-11-09 16:55:44', '2017-11-09 16:55:44', 1),
(168, 'Instrucciones de Uso', '', 'manual-1510243067-BabyLog8000Plus.pdf', 64, '2017-11-09 16:57:48', '2017-11-09 16:57:48', 1),
(169, 'Manual servicio', '', 'manual-1510244047-Babyteherm 8004 service.pdf', 65, '2017-11-09 17:14:08', '2017-11-09 17:14:08', 1),
(170, 'Manual de uso', '', 'manual-1510244145-baby8004user.pdf', 65, '2017-11-09 17:15:46', '2017-11-09 17:15:46', 1),
(171, 'Manual Servicio', '', 'manual-1510244731-Drager_Fabius_-_Service_manual.pdf', 66, '2017-11-09 17:25:32', '2017-11-09 17:25:32', 1),
(172, 'Manual Usuario', '', 'manual-1510244748-Manual Usuario Fabius_CE.pdf', 66, '2017-11-09 17:25:50', '2017-11-09 17:25:50', 1),
(173, 'Manual Servicio', '', 'manual-1510256268-Fabius_GS_ServMan_4117104_Rev_K.pdf', 1, '2017-11-09 20:37:49', '2017-11-09 20:37:49', 1),
(174, 'Manual Usuario', '', 'manual-1510344449-9038927_es.pdf', 1, '2017-11-09 20:38:39', '2017-11-10 21:07:29', 1),
(175, 'Instrucciones de uso', '', 'manual-1510257022-Fabius_Plus.pdf', 67, '2017-11-09 20:50:23', '2017-11-09 20:50:23', 1),
(176, 'Guía de usuario', '', 'manual-1510257376-vistaxl.pdf', 24, '2017-11-09 20:56:17', '2017-11-09 20:56:17', 1),
(177, 'Lista de accesorios', '', 'manual-1510258047-9049482_IICS-90_140507.pdf', 68, '2017-11-09 21:07:28', '2017-11-09 21:07:28', 1),
(178, 'Listado de accesorios', '', 'manual-1510259073-9049484_Isolette C2000_16.03.2007 K2.pdf', 69, '2017-11-09 21:24:34', '2017-11-09 21:24:34', 1),
(179, 'Listado de accesorios', '', 'manual-1510259252-9049486_Isolette TI500_140507.pdf', 70, '2017-11-09 21:27:33', '2017-11-09 21:27:33', 1),
(180, 'Listado de accesorios', '', 'manual-1510260282-9049516_Isolette C450_140507.pdf', 71, '2017-11-09 21:44:43', '2017-11-09 21:44:43', 1),
(181, 'Listado de accesorios', '', 'manual-1510260507-9050991_Babylog 150507.pdf', 64, '2017-11-09 21:48:28', '2017-11-09 21:48:28', 1),
(182, 'Listado de accesorios', '', 'manual-1510260911-9050992_BabyTherm_140507.pdf', 65, '2017-11-09 21:55:13', '2017-11-09 21:55:13', 1),
(183, 'Listado de accesorios', '', 'manual-1510337457-9050993_Caleo_140507.pdf', 72, '2017-11-10 19:10:58', '2017-11-10 19:10:58', 1),
(184, 'Modos ventilatorios', '', 'manual-1510337571-Babylog_8000plus_spanish[1].pdf', 64, '2017-11-10 19:12:52', '2017-11-10 19:12:52', 1),
(185, 'Especificaciones Técnicas', '', 'manual-1510337881-br_pc_therapwarm_Resuscitaire_en.pdf', 73, '2017-11-10 19:18:02', '2017-11-10 19:18:02', 1),
(186, 'Especificaciones técnicas', '', 'manual-1510338466-Isolette_C2000_Cabinet_Stand_english.pdf', 69, '2017-11-10 19:27:47', '2017-11-10 19:27:47', 1),
(187, 'Especificaciones técnicas', '', 'manual-1510339974-9051663_Delta_DeltaXL_ES_fin.pdf', 74, '2017-11-10 19:52:54', '2017-11-10 19:52:54', 1),
(188, 'Ficha técnica', '', 'manual-1510340372-Ficha Técnica Oxylog 3000 plus.pdf', 75, '2017-11-10 19:59:32', '2017-11-10 19:59:32', 1),
(189, 'Instrucciones de uso', '', 'manual-1510340389-Manual Oxylog 3000 plus.pdf', 75, '2017-11-10 19:59:49', '2017-11-10 19:59:49', 1),
(190, 'Listado accesorios', '', 'manual-1510340613-Accesorios Primus.pdf', 76, '2017-11-10 20:03:33', '2017-11-10 20:03:33', 1),
(191, 'Instrucciones de uso', '', 'manual-1510343850-Vista_XL.pdf', 24, '2017-11-10 20:57:30', '2017-11-10 20:57:30', 1),
(192, 'Manual Servicio', '', 'manual-1510344554-Air-Shields_Resuscitaire_Infant_Warmer_Service_manual.pdf', 73, '2017-11-10 21:09:14', '2017-11-10 21:09:14', 1),
(193, 'Instrucciones de uso', '', 'manual-1510344640-C400 & C450.pdf', 71, '2017-11-10 21:10:40', '2017-11-10 21:10:40', 1),
(194, 'Manual de Usuario', '', 'manual-1510344860-C2000 espanol.pdf', 69, '2017-11-10 21:13:28', '2017-11-10 21:14:20', 1),
(195, 'Catálogo de partes', '', 'manual-1510345023-catalogo de partes Isolette 8000.pdf', 77, '2017-11-10 21:17:03', '2017-11-10 21:17:03', 1),
(196, 'Manual usuario', '', 'manual-1510345100-Dräger Caleo Incubator - User manual (es).pdf', 72, '2017-11-10 21:18:20', '2017-11-10 21:18:20', 1),
(197, 'Manual Servicio', '', 'manual-1510345121-Drager_Caleo_Incubator_-_Service_manual.pdf', 72, '2017-11-10 21:18:41', '2017-11-10 21:18:41', 1),
(198, 'Instrucciones de uso', '', 'manual-1510345378-Drager_Incubator_8000SC_-_User_manual.pdf', 78, '2017-11-10 21:22:58', '2017-11-10 21:22:58', 1),
(199, 'Manual Servicio', '', 'manual-1510346006-Drager_Isolette_C-2000_Incubator_-_Service_manual.pdf', 69, '2017-11-10 21:33:26', '2017-11-10 21:33:26', 1),
(200, 'Manual de Uso', '', 'manual-1510579223-IICS 90 espanol.pdf', 68, '2017-11-13 14:19:30', '2017-11-13 14:20:24', 1),
(201, 'Instrucciones de Servicio', '', 'manual-1510579317-instrucciones de servicio Incubadora 8000.pdf', 78, '2017-11-13 14:21:58', '2017-11-13 14:21:58', 1),
(202, 'Manual Servicio', '', 'manual-1510580419-MANUAL SERVICIO TD_IPM_Delta__Delta_XL_es.pdf', 74, '2017-11-13 14:40:20', '2017-11-13 14:40:20', 1),
(203, 'Manual de Uso', '', 'manual-1510581137-MANUAL USO Delta-Delta XL-Kappa VF8 espa.pdf', 74, '2017-11-13 14:40:38', '2017-11-13 14:52:18', 1),
(204, 'Manual de Uso', '', 'manual-1510580763-manual uso Isolette 8000.pdf', 77, '2017-11-13 14:46:04', '2017-11-13 14:46:04', 1),
(205, 'Manual de Servicio', '', 'manual-1510581301-Vista XL - Siemens_SC7000-9000XL_-_Service_Manual.pdf', 24, '2017-11-13 14:49:13', '2017-11-13 14:55:02', 1),
(206, 'Instrucciones de Uso', '', 'manual-1510581080-Resuscitaire espanol.pdf', 73, '2017-11-13 14:49:51', '2017-11-13 14:51:21', 1),
(207, 'Manual Servicio', '', 'manual-1510582393-453561429952a_Online.pdf', 80, '2017-11-13 14:58:26', '2017-11-13 15:13:14', 1),
(208, 'Manual Usuario iU22', '', 'manual-1510582158-iU22 Manual Usuario Philips Abril 2012.pdf', 80, '2017-11-13 15:07:26', '2017-11-13 15:09:19', 1),
(209, 'Manual Usuario iE33', '', 'manual-1510582304-iE33 Manual Usuario Philips Abril 2012.pdf', 80, '2017-11-13 15:11:45', '2017-11-13 15:11:45', 1),
(210, 'Manual Servicio', '', 'manual-1510602336-Edge_Service_Manual_P15644-01B_e (1).pdf', 82, '2017-11-13 20:45:38', '2017-11-13 20:45:38', 1),
(211, 'Manual Usuario', '', 'manual-1510602382-Edge_UG_SPA_P15205-01B_e.pdf', 82, '2017-11-13 20:46:23', '2017-11-13 20:46:23', 1),
(212, 'Corrección Manual Usuario', '', 'manual-1510602413-Edge_UG_Errata_14Lgs_P15199-02B_e.pdf', 82, '2017-11-13 20:46:54', '2017-11-13 20:46:54', 1),
(213, 'Suplemento Guía de Usuario', '', 'manual-1510602445-Edge_M-Turbo_SSeries_UGSup_14Lgs_P15653-04A_e.pdf', 82, '2017-11-13 20:47:27', '2017-11-13 20:47:27', 1),
(214, 'Manual de Usuario', '', 'manual-1510602503-M-Turbo_UG_SPA_P08157-03B_e.pdf', 83, '2017-11-13 20:48:24', '2017-11-13 20:48:24', 1),
(215, 'Suplemento Manual de Usuario', '', 'manual-1510602526-M-Turbo_Supps.pdf', 83, '2017-11-13 20:48:47', '2017-11-13 20:48:47', 1),
(216, 'Manual Servicio', '', 'manual-1510602546-M-Turbo_Service_Manual.pdf', 83, '2017-11-13 20:49:07', '2017-11-13 20:49:07', 1),
(217, 'Guía Sistema M-MSK', '', 'manual-1510602682-M-MSK_UG_P13919-01B_e.pdf', 83, '2017-11-13 20:51:24', '2017-11-13 20:51:24', 1),
(218, 'Suplemento Guía Usuario', '', 'manual-1510602816-Edge_M-Turbo_SSeries_UGSup_14Lgs_P15653-04A_e.pdf', 83, '2017-11-13 20:53:38', '2017-11-13 20:53:38', 1),
(219, 'Manual Servicio', '', 'manual-1510603289-Alsa_Alsatom_SU_MPC_-_Service_manual.pdf', 84, '2017-11-13 21:01:31', '2017-11-13 21:01:31', 1),
(220, 'Manual Usuario', '', 'manual-1510603503-UES 40 Instruction Manual.pdf', 85, '2017-11-13 21:05:04', '2017-11-13 21:05:04', 1),
(222, 'Manual Servicio', '', 'manual-1510604455-840.pdf', 86, '2017-11-13 21:20:56', '2017-11-13 21:20:56', 1),
(223, 'Manual del operador', '', 'manual-1510604474-manual_840.pdf', 86, '2017-11-13 21:21:15', '2017-11-13 21:21:15', 1),
(224, 'Manual Servicio', '', 'manual-1510604850-1037893 SM_en.pdf', 87, '2017-11-13 21:27:31', '2017-11-13 21:27:31', 1),
(225, 'Guía de Usuario', '', 'manual-1510604874-1035873 UG_es.pdf', 87, '2017-11-13 21:27:55', '2017-11-13 21:27:55', 1),
(226, 'Manual de operación', '', 'manual-1510605244-tensmed_s84.pdf', 88, '2017-11-13 21:34:05', '2017-11-13 21:34:05', 1),
(227, 'Manual de Usuario', '', 'manual-1510605495-Manual_es-ES.pdf', 89, '2017-11-13 21:38:16', '2017-11-13 21:38:16', 1),
(228, 'Manual de Uso', '', 'manual-1510662076-Manual del usuario.pdf', 90, '2017-11-14 13:20:18', '2017-11-14 13:21:17', 1),
(229, 'Manual de Funcionamiento', '', 'manual-1510662768-UI-185044467-ES.pdf', 91, '2017-11-14 13:32:49', '2017-11-14 13:32:49', 1),
(230, 'Manual Servicio', '', 'manual-1510662814-Manual Tecnico IW900.pdf', 91, '2017-11-14 13:33:35', '2017-11-14 13:33:35', 1),
(231, 'Instrucciones de Funcionamiento', '', 'manual-1510663065-UI-185041729-h.pdf', 92, '2017-11-14 13:37:46', '2017-11-14 13:37:46', 1),
(232, 'Manual Técnico', '', 'manual-1510663097-Neopuff Technical Manual - English.pdf', 92, '2017-11-14 13:38:18', '2017-11-14 13:38:18', 1),
(233, 'Información de Servicio', '', 'manual-1510663154-Service Section - Spanish.pdf', 92, '2017-11-14 13:39:15', '2017-11-14 13:39:15', 1),
(234, 'Manual Operación', '', 'manual-1510663907-UI-185044956_c.pdf', 93, '2017-11-14 13:47:14', '2017-11-14 13:51:48', 1),
(235, 'Manual de Servicio', '', 'manual-1510663793-PTM-185045090_b.pdf', 93, '2017-11-14 13:47:48', '2017-11-14 13:49:54', 1),
(236, 'Manual de Uso', '', 'manual-1510664570-ESA612__umspa0100.pdf', 94, '2017-11-14 14:02:51', '2017-11-14 14:02:51', 1),
(237, 'Manual plugin Ansur ESA612', '', 'manual-1510665348-ansur612umeng0400.pdf', 94, '2017-11-14 14:15:49', '2017-11-14 14:15:49', 1),
(238, 'Manual de Uso', '', 'manual-1510668896-287_289_umspa0100.pdf', 95, '2017-11-14 15:14:57', '2017-11-14 15:14:57', 1),
(239, 'Guía rápida', '', 'manual-1510668920-287_289_gsspa0000.pdf', 95, '2017-11-14 15:15:21', '2017-11-14 15:15:21', 1),
(240, 'Instrucciones de operación', '', 'manual-1510669330-ADM08ABM_OP_en_03_05_00.pdf', 96, '2017-11-14 15:22:11', '2017-11-14 15:22:11', 1),
(241, 'Manual Técnico', '', 'manual-1510669349-ADM08ABM08_TM_en_02_02_01.pdf', 96, '2017-11-14 15:22:30', '2017-11-14 15:22:30', 1),
(242, 'Manual de operación', '', 'manual-1510669860-S2-10_VP4450HD_202B1262006__110204.pdf', 97, '2017-11-14 15:31:01', '2017-11-14 15:31:01', 1),
(243, 'Manual de operación', '', 'manual-1510670191-S2-10_XL4450_202B1262020__110114.pdf', 98, '2017-11-14 15:36:32', '2017-11-14 15:36:32', 1),
(244, 'Manual Operación EC-530W', '', 'manual-1510670967-S10_EC530WM.pdf', 99, '2017-11-14 15:49:28', '2017-11-14 15:49:28', 1),
(245, 'Manual Operación EC-530D', '', 'manual-1510671025-S10_EG530D.pdf', 101, '2017-11-14 15:50:26', '2017-11-14 16:04:26', 1),
(246, 'Manual Operación EC-530FP', '', 'manual-1510671043-S10_EG530FP.pdf', 101, '2017-11-14 15:50:45', '2017-11-14 16:04:50', 1),
(247, 'Manual Operación EC-530WR', '', 'manual-1510671075-S10_EG530WR.pdf', 101, '2017-11-14 15:51:16', '2017-11-14 16:05:16', 1),
(248, 'Manual Operación EG-590ZW', '', 'manual-1510672504-S10_EG590ZW.pdf', 102, '2017-11-14 16:15:05', '2017-11-14 16:15:05', 1),
(249, 'Manual Operación FB-120P', '', 'manual-1510672578-S20_FB120P.pdf', 46, '2017-11-14 16:16:19', '2017-11-14 16:16:19', 1),
(251, 'Manual de Operación EC-590ZW', '', 'manual-1510675141-S10_EC590ZW.pdf', 100, '2017-11-14 16:59:02', '2017-11-14 16:59:02', 1),
(252, 'Manual Usuario', '', 'manual-1511188166-B40B20 User\'s Reference Manual.pdf', 103, '2017-11-20 15:29:28', '2017-11-20 15:29:28', 1),
(253, 'Manual Referencia Técnica', '', 'manual-1511188192-B40B20 Technical Reference Manual.pdf', 103, '2017-11-20 15:29:53', '2017-11-20 15:29:53', 1),
(254, 'Manual Usuario', '', 'manual-1511188540-M1211818_002.pdf', 4, '2017-11-20 15:35:41', '2017-11-20 15:35:41', 1),
(255, 'Manual Servicio', '', 'manual-1511192519-2062973-002_B650-01_v2_TM.pdf', 4, '2017-11-20 16:06:38', '2017-11-20 16:42:00', 1),
(256, 'Listado accesorios', '', 'manual-1511190692-M1211832_001.pdf', 4, '2017-11-20 16:11:33', '2017-11-20 16:11:33', 1),
(257, 'Opciones de Montaje', '', 'manual-1511190767-M1219541_001.pdf', 4, '2017-11-20 16:12:48', '2017-11-20 16:12:48', 1),
(258, 'Manual Usuario - Addendum', '', 'manual-1511190854-SPA_M1241597_B650_Addendum_for_1_1_10_SW_2nd_ed.pdf', 4, '2017-11-20 16:14:15', '2017-11-20 16:14:15', 1),
(259, 'Manual Información Adicional', '', 'manual-1511190945-M1213025_001.pdf', 4, '2017-11-20 16:15:46', '2017-11-20 16:15:46', 1),
(260, 'Manual Servicio Módulo Paciente (PDM)', '', 'manual-1511191143-2030047-011A.pdf', 4, '2017-11-20 16:19:05', '2017-11-20 16:19:05', 1),
(261, 'Manual Técnico Módulos', '', 'manual-1511191270-ModulesTM_M1146860_2nd_ed_s.pdf', 4, '2017-11-20 16:21:11', '2017-11-20 16:21:11', 1),
(262, 'Manual Servicio - Addendum', '', 'manual-1511192380-2062973_012_B650_TM_Addendum.pdf', 4, '2017-11-20 16:39:42', '2017-11-20 16:39:42', 1),
(263, 'Checklist', '', 'manual-1511192870-SPA_2084033-001_Check_Forms.pdf', 4, '2017-11-20 16:47:51', '2017-11-20 16:47:51', 1),
(264, 'Manual Servicio', '', 'manual-1511206775-2000966-542C.pdf', 105, '2017-11-20 16:50:49', '2017-11-20 20:39:36', 1),
(265, 'Manual Usuario', '', 'manual-1511193081-2000966-569A.pdf', 105, '2017-11-20 16:51:22', '2017-11-20 16:51:22', 1),
(266, 'Especificaciones Técnicas', '', 'manual-1511193112-2000966-478B.pdf', 105, '2017-11-20 16:51:53', '2017-11-20 16:51:53', 0),
(267, 'Manual Usuario', '', 'manual-1511193288-enCORE.pdf', 106, '2017-11-20 16:54:49', '2017-11-20 16:54:49', 1),
(268, 'Suplemento composición corporal', '', 'manual-1511193332-composition_reference_data.pdf', 106, '2017-11-20 16:55:34', '2017-11-20 16:55:34', 1),
(269, 'Suplemento datos pediátricos', '', 'manual-1511193357-pediatric_reference_data.pdf', 106, '2017-11-20 16:55:58', '2017-11-20 16:55:58', 1),
(270, 'Documentación de seguridad', '', 'manual-1511193381-ProductSecurity.pdf', 106, '2017-11-20 16:56:22', '2017-11-20 16:56:22', 1),
(271, 'Datos de referencia', '', 'manual-1511193405-ReferenceData.pdf', 106, '2017-11-20 16:56:46', '2017-11-20 16:56:46', 1),
(272, 'Especificaciones Técnicas y Seguridad', '', 'manual-1511193438-SafetyAndSpecification.pdf', 106, '2017-11-20 16:57:19', '2017-11-20 16:57:19', 1),
(273, 'Manual Técnico Docking Station', '', 'manual-1511193529-2000966-540B.pdf', 105, '2017-11-20 16:58:50', '2017-11-20 16:58:50', 1),
(274, 'Manual Servicio', '', 'manual-1511193655-GINC TRM v103.pdf', 107, '2017-11-20 17:00:58', '2017-11-20 17:00:58', 1),
(275, 'Manual Usuario', '', 'manual-1511193873-155546902-Manual-Usuario-Omnibed.pdf', 107, '2017-11-20 17:04:34', '2017-11-20 17:04:34', 1),
(276, 'Manual Servicio Básico', '', 'manual-1511194344-Twin_BSM_5370626_1_00.pdf', 108, '2017-11-20 17:12:24', '2017-11-20 17:12:24', 1),
(277, 'Manual Servicio Básico', '', 'manual-1511194344-Twin_BSM_5370626_1_00.pdf', 81, '2017-11-20 17:12:26', '2017-11-20 17:12:26', 1),
(278, 'Manual Usuario - Apéndice', '', 'manual-1511195580-L9_Add_2389047_0_06.pdf', 20, '2017-11-20 17:33:02', '2017-11-20 17:33:02', 1),
(279, 'Manual Referencia Avanzado', '', 'manual-1511195617-L9_ARM_2309835_2_00.pdf', 20, '2017-11-20 17:33:39', '2017-11-20 17:33:39', 1),
(280, 'Manual Servicio Básico', '', 'manual-1511195655-L9_BSM_2294853_14_00.pdf', 20, '2017-11-20 17:34:16', '2017-11-20 17:34:16', 1),
(281, 'Manual Básico del operador', '', 'manual-1511196328-L9_BUM_5140804_3_06.pdf', 20, '2017-11-20 17:34:44', '2017-11-20 17:45:29', 1),
(282, 'Checklist', '', 'manual-1511196357-L9_Cklist_2399069_1_00.pdf', 20, '2017-11-20 17:45:58', '2017-11-20 17:45:58', 1),
(283, 'Datos técnicos', '', 'manual-1511196397-L9_Datasheet_3_00.pdf', 20, '2017-11-20 17:46:38', '2017-11-20 17:46:38', 1),
(284, 'Instrucciones de instalación', '', 'manual-1511196442-L9_INT_2361715_1_00.pdf', 20, '2017-11-20 17:47:23', '2017-11-20 17:47:23', 1),
(285, 'Habilitación opción Dongle', '', 'manual-1511196478-L9_OPT_2328821_0_00.pdf', 20, '2017-11-20 17:47:59', '2017-11-20 17:47:59', 1),
(286, 'Instrucciones instalación periféricos', '', 'manual-1511196640-L9_PER_2341053_2_00.pdf', 20, '2017-11-20 17:50:41', '2017-11-20 17:50:41', 1),
(287, 'Guía rápida', '', 'manual-1511196728-L9_QG_2309820_1_06.pdf', 20, '2017-11-20 17:51:32', '2017-11-20 17:52:09', 1),
(288, 'Guía Rápida Usuario', '', 'manual-1511197378-2032589-006.pdf', 110, '2017-11-20 18:03:01', '2017-11-20 18:03:01', 1),
(289, 'Manual Servicio', '', 'manual-1511197398-2036039-001B.pdf', 110, '2017-11-20 18:03:19', '2017-11-20 18:03:19', 1),
(290, 'Manual Usuario', '', 'manual-1511200847-5371341.pdf', 21, '2017-11-20 19:00:49', '2017-11-20 19:00:49', 1),
(291, 'Manual Servicio', '', 'manual-1511200867-Manual de Servicio MAC 500.pdf', 21, '2017-11-20 19:01:08', '2017-11-20 19:01:08', 1),
(292, 'Manual Servicio', '', 'manual-1511201021-2047426-002_E_MAC_600_SM.pdf', 111, '2017-11-20 19:03:42', '2017-11-20 19:03:42', 1),
(293, 'Manual Referencia Técnica', '', 'manual-1511202322-GE_TruSat_Pulse_Oximeter_-_Technical_Reference_Manual.pdf', 112, '2017-11-20 19:25:24', '2017-11-20 19:25:24', 1),
(294, 'Manual Usuario', '', 'manual-1511202342-Trusat-Pulse-Oximeter-User-Manual.pdf', 112, '2017-11-20 19:25:43', '2017-11-20 19:25:43', 1),
(295, 'Manual Servicio', '', 'manual-1511202517-5396805_VS6_VS8_BSM_Rev3.pdf', 113, '2017-11-20 19:28:38', '2017-11-20 19:28:38', 1),
(296, 'Manual Operador', '', 'manual-1511202681-2048723-020A.pdf', 114, '2017-11-20 19:31:22', '2017-11-20 19:31:22', 1),
(297, 'Manual Servicio', '', 'manual-1511202698-GE Carescape V100 Service Manual.pdf', 114, '2017-11-20 19:31:39', '2017-11-20 19:31:39', 1),
(298, 'Manual Usuario', '', 'manual-1511203261-Viq_UM_5432770_6_06_ESP.pdf', 109, '2017-11-20 19:41:03', '2017-11-20 19:41:03', 1),
(299, 'Manual MPEGVue', '', 'manual-1511204295-MPEGVue_UM_2419089_2_06_ES.pdf', 109, '2017-11-20 19:41:54', '2017-11-20 19:58:16', 1),
(300, 'Manual Referencia', '', 'manual-1511203350-Viq_RM_5432772_4_00.pdf', 109, '2017-11-20 19:42:31', '2017-11-20 19:42:31', 1),
(301, 'Notas de revisión', '', 'manual-1511203457-Viq_RN_5432771_4_06_SP-LA_M5.pdf', 109, '2017-11-20 19:44:18', '2017-11-20 19:44:18', 1),
(302, 'Manual Servicio', '', 'manual-1511203561-Vi_Vq_SVC_R2423164_13_00_Basic.pdf', 109, '2017-11-20 19:46:02', '2017-11-20 19:46:02', 1),
(303, 'Notas de versión', '', 'manual-1511204025-Viq_S56_RN_EAC-5653768_2_00-ENG.pdf', 115, '2017-11-20 19:53:47', '2017-11-20 19:53:47', 1),
(304, 'Manual Usuario', '', 'manual-1511204059-VS56_UM_5432774_4_06_ESP.pdf', 115, '2017-11-20 19:54:20', '2017-11-20 19:54:20', 1),
(305, 'Traslado del equipo', '', 'manual-1511204238-VS56_RN_R2424025_2_06_ES.pdf', 115, '2017-11-20 19:57:19', '2017-11-20 19:57:19', 1),
(306, 'Manual MPEGVue', '', 'manual-1511204271-MPEGVue_UM_2419089_2_06_ES.pdf', 115, '2017-11-20 19:57:52', '2017-11-20 19:57:52', 0),
(307, 'Manual MPEGVue', '', 'manual-1511204383-MPEGVue_UM_2419089_2_06_ES.pdf', 115, '2017-11-20 19:59:44', '2017-11-20 19:59:44', 1),
(308, 'Manual Referencia', '', 'manual-1511204537-VS56_RM_5432776_3_00.pdf', 115, '2017-11-20 20:02:18', '2017-11-20 20:02:18', 1),
(309, 'Manual Servicio', '', 'manual-1511204567-VS56_SVC_2421482_14_00_Basic.pdf', 115, '2017-11-20 20:02:48', '2017-11-20 20:02:48', 1),
(310, 'Manual Servicio', '', 'manual-1511205286-Voluson_730_P_SM.pdf', 116, '2017-11-20 20:14:48', '2017-11-20 20:14:48', 1),
(311, 'Manual Usuario', '', 'manual-1511206038-H48651FT_V730_P_BT08_6_ES.pdf', 116, '2017-11-20 20:27:20', '2017-11-20 20:27:20', 1),
(312, 'Manual Básico Usuario', '', 'manual-1511206373-H48651DY_6_V730_E_BT08_ES.pdf', 117, '2017-11-20 20:32:54', '2017-11-20 20:32:54', 1),
(313, 'Manual Servicio', '', 'manual-1511206607-KTI105989_4_V730Expert_svc.pdf', 117, '2017-11-20 20:36:48', '2017-11-20 20:36:48', 1),
(314, 'Especificaciones técnicas', '', 'manual-1511206717-2000966-455B.pdf', 105, '2017-11-20 20:38:39', '2017-11-20 20:38:39', 1),
(315, 'Manual Servicio', '', 'manual-1511206963-GEHC-Service-Manual_Dash-2000-Patient-Monitor-RevD-v3-2004.pdf', 118, '2017-11-20 20:42:44', '2017-11-20 20:42:44', 1),
(316, 'Guía Rápida', '', 'manual-1511207076-GEHealthcare-LOGIQ-e-Quick-Card-ProductSpec.pdf', 81, '2017-11-20 20:44:37', '2017-11-20 20:44:37', 1),
(317, 'Manual Básico de usuario', '', 'manual-1511207679-Le_BUM_5118586_2_06.pdf', 81, '2017-11-20 20:54:42', '2017-11-20 20:54:42', 1),
(318, 'Manual Servicio', '', 'manual-1511207797-LE9_BSM_5180263_3_00.pdf', 119, '2017-11-20 20:56:38', '2017-11-20 20:56:38', 1),
(319, 'Manual básico de usuario', '', 'manual-1511207896-LE9_BUM_5335626_1_06.pdf', 119, '2017-11-20 20:58:17', '2017-11-20 20:58:17', 1),
(320, 'Guía de usuario', '', 'manual-1511207931-LE9_UG_5335632_1_06.pdf', 119, '2017-11-20 20:58:52', '2017-11-20 20:58:52', 1),
(321, 'Manual Básico de usuario', '', 'manual-1511208171-Logiq book user manual.pdf', 120, '2017-11-20 21:02:52', '2017-11-20 21:02:52', 1),
(322, 'Manual Usuario y Servicio', '', 'manual-1511208893-Manual Audioscreener español.pdf', 121, '2017-11-20 21:14:56', '2017-11-20 21:14:56', 1),
(323, 'Manual de Uso', '', 'manual-1511209418-Manual usuario HYC260-360.pdf', 122, '2017-11-20 21:23:39', '2017-11-20 21:23:39', 1),
(324, 'Manual Funcionamiento', '', 'manual-1511209654-Refrigerador de Farmacia HYC-1378.pdf', 123, '2017-11-20 21:27:36', '2017-11-20 21:27:36', 1),
(325, 'Manual Servicio', '', 'manual-1511209894-Servicio C1 62433801.pdf', 124, '2017-11-20 21:31:35', '2017-11-20 21:31:35', 1),
(326, 'Manual Servicio', '', 'manual-1511210186-P360097-1 Rev F Thawer Service Manual.pdf', 125, '2017-11-20 21:36:27', '2017-11-20 21:36:27', 1),
(327, 'Manual Operación', '', 'manual-1511210206-P360094-1 Rev I Thawer Operation Manual.pdf', 125, '2017-11-20 21:36:47', '2017-11-20 21:36:47', 1),
(328, 'Manual Usuario', '', 'manual-1511210313-P360012-1 Rev H Digital Thermometer Manual.pdf', 126, '2017-11-20 21:38:35', '2017-11-20 21:38:35', 1),
(329, 'Manual de operaciones', '', 'manual-1511267407-070-1225-00RevA[2].pdf', 127, '2017-11-21 13:30:09', '2017-11-21 13:30:09', 1),
(330, 'Manual Operador', '', 'manual-1511267695-3100B.pdf', 128, '2017-11-21 13:34:56', '2017-11-21 13:34:56', 1),
(331, 'Manual Operador', '', 'manual-1511268014-L2786-105_ES.pdf', 11, '2017-11-21 13:40:16', '2017-11-21 13:40:16', 1),
(332, 'Manual Servicio', '', 'manual-1511268036-Viasys_Avea_-_Service_manual.pdf', 11, '2017-11-21 13:40:37', '2017-11-21 13:40:37', 1),
(333, 'Manual Operación', '', 'manual-1511268353-Manual Usuario Viasys Vela.pdf', 129, '2017-11-21 13:45:54', '2017-11-21 13:45:54', 1),
(334, 'Manual Servicio', '', 'manual-1511268377-Viasys_Vela_-_Service_manual.pdf', 129, '2017-11-21 13:46:18', '2017-11-21 13:46:18', 1),
(335, 'Instrucciones de uso', '', 'manual-1511268745-Manual de Usuario Mobil-o-Graph.pdf', 130, '2017-11-21 13:52:27', '2017-11-21 13:52:27', 1),
(336, 'Guía corta software datos', '', 'manual-1511268790-Guía corta Software HMS Client-Server.pdf', 130, '2017-11-21 13:53:12', '2017-11-21 13:53:12', 1),
(337, 'Procedimiento de limpieza', '', 'manual-1511271848-INTEGRA SP2 LIMPIEZA.pdf', 131, '2017-11-21 14:44:10', '2017-11-21 14:44:10', 1),
(338, 'Manual Servicio', '', 'manual-1511271876-Integra SP2 Man Serv Esp INDU .pdf', 131, '2017-11-21 14:44:37', '2017-11-21 14:44:37', 1),
(339, 'Manual Servicio', '', 'manual-1511272743-AV-S Man Serv Esp INDU .pdf', 132, '2017-11-21 14:59:05', '2017-11-21 14:59:05', 1),
(340, 'Manual Servicio', '', 'manual-1511273022-A 200 SP Man Serv Esp INDU .pdf', 133, '2017-11-21 15:03:43', '2017-11-21 15:03:43', 1),
(341, 'Manual Usuario', '', 'manual-1511277582-A 200 SP Man Usuar Esp ORIG.pdf', 133, '2017-11-21 16:19:45', '2017-11-21 16:19:45', 1),
(342, 'Manual Usuario', '', 'manual-1511277607-AV-S Man Usuar Esp ORIG.pdf', 132, '2017-11-21 16:20:08', '2017-11-21 16:20:08', 1),
(343, 'Manual Usuario', '', 'manual-1511277675-Integra SP2 Man Usuar Esp ORIG.pdf', 131, '2017-11-21 16:21:16', '2017-11-21 16:21:16', 1),
(344, 'Manual Servicio', '', 'manual-1511277898-Star 50 II Man Serv ESP III .pdf', 134, '2017-11-21 16:24:59', '2017-11-21 16:24:59', 1),
(345, 'Manual Usuario', '', 'manual-1511277931-Star 50 II 3º Man Usuar ESP ORIG.pdf', 134, '2017-11-21 16:25:32', '2017-11-21 16:25:32', 1),
(346, 'Manual Técnico', '', 'manual-1511355849-mpm-1.pdf', 135, '2017-11-22 14:03:40', '2017-11-22 14:04:10', 1),
(347, 'Cambio de batería', '', 'manual-1511365818-27455 BATTERY MOD Spanish.pdf', 136, '2017-11-22 16:50:20', '2017-11-22 16:50:20', 1),
(348, 'Manual Carro de Sistema', '', 'manual-1511365841-27455 CART Spanish.pdf', 136, '2017-11-22 16:50:42', '2017-11-22 16:50:42', 1),
(349, 'Módulo de láser', '', 'manual-1511365890-27455 LASER Spanish.pdf', 136, '2017-11-22 16:51:32', '2017-11-22 16:51:32', 1),
(350, 'Manual Control remoto', '', 'manual-1511365992-27455 REMOTE Spanish.pdf', 136, '2017-11-22 16:53:14', '2017-11-22 16:53:14', 1),
(351, 'Manual Módulo SEMG', '', 'manual-1511366078-27455 SEMG Spanish.pdf', 136, '2017-11-22 16:54:39', '2017-11-22 16:54:39', 1),
(352, 'Manual de usuario', '', 'manual-1511366129-27455 Therapy System Spanish.pdf', 136, '2017-11-22 16:55:30', '2017-11-22 16:55:30', 1),
(353, 'Manual módulo electrodo de vacío', '', 'manual-1511366174-27455 VAC ELECTRODE Spanish.pdf', 136, '2017-11-22 16:56:15', '2017-11-22 16:56:15', 1),
(354, 'Manual Ultrasonido', '', 'manual-1511366225-Mobile Ultrasound.pdf', 136, '2017-11-22 16:57:06', '2017-11-22 16:57:06', 1),
(355, 'Manual de operación Software Otoread', '', 'manual-1511440019-operation_manual_otoread_module.pdf', 137, '2017-11-23 13:27:01', '2017-11-23 13:27:01', 1),
(356, 'Manual de uso clínico', '', 'manual-1511440112-operation_manual_standard-clinical_otoread_en.pdf', 137, '2017-11-23 13:28:33', '2017-11-23 13:28:33', 1),
(357, 'Manual de uso', '', 'manual-1511783749-80694305 CE VRA201.pdf', 138, '2017-11-27 12:55:51', '2017-11-27 12:55:51', 1),
(358, 'Manual de operación', '', 'manual-1511783785-OM Titan 01D International.pdf', 139, '2017-11-27 12:56:26', '2017-11-27 12:56:26', 1),
(359, 'Manual de instrucciones', '', 'manual-1511783813-OM_ AA220.pdf', 140, '2017-11-27 12:56:54', '2017-11-27 12:56:54', 1),
(360, 'Manual de operación', '', 'manual-1511783836-OM_ AA222.pdf', 141, '2017-11-27 12:57:17', '2017-11-27 12:57:17', 1),
(361, 'Manual de operación', '', 'manual-1511783873-OM_ AC33.pdf', 142, '2017-11-27 12:57:54', '2017-11-27 12:57:54', 1),
(362, 'Manual de operación', '', 'manual-1511783893-OM_ AD226.pdf', 143, '2017-11-27 12:58:14', '2017-11-27 12:58:14', 1),
(363, 'Manual de operación', '', 'manual-1511783916-OM_ AD229b.pdf', 144, '2017-11-27 12:58:37', '2017-11-27 12:58:37', 1),
(364, 'Manual de operación', '', 'manual-1511783935-OM_ AD229e.pdf', 145, '2017-11-27 12:58:56', '2017-11-27 12:58:56', 1),
(365, 'Manual de operación', '', 'manual-1511783960-OM_ AT235.pdf', 146, '2017-11-27 12:59:21', '2017-11-27 12:59:21', 1),
(366, 'Manual de operación', '', 'manual-1511783994-OM_ AT235h.pdf', 147, '2017-11-27 12:59:55', '2017-11-27 12:59:55', 1),
(367, 'Manual de operación', '', 'manual-1511784013-OM_ MT10.pdf', 148, '2017-11-27 13:00:14', '2017-11-27 13:00:14', 1),
(368, 'Manual instalación', '', 'manual-1511784097-OM_ Otoread Screener.pdf', 137, '2017-11-27 13:01:38', '2017-11-27 13:01:38', 1),
(369, 'Manual base de datos', '', 'manual-1511784117-OM_ OtoReadDatabase.pdf', 137, '2017-11-27 13:01:58', '2017-11-27 13:01:58', 1),
(370, 'Manual de operación', '', 'manual-1511784934-OM_AA222-1058.pdf', 141, '2017-11-27 13:15:36', '2017-11-27 13:15:36', 1),
(371, 'Manual de operación', '', 'manual-1511784958-OM_AC40.pdf', 149, '2017-11-27 13:16:00', '2017-11-27 13:16:00', 1),
(372, 'Manual de operación', '', 'manual-1511784985-OM_AS216.pdf', 150, '2017-11-27 13:16:27', '2017-11-27 13:16:27', 1),
(373, 'Manual de operación', '', 'manual-1511785153-OM_PA5.pdf', 152, '2017-11-27 13:19:14', '2017-11-27 13:19:14', 1),
(374, 'Manual de operación', '', 'manual-1511785689-OM_AS608+AS608e.pdf', 156, '2017-11-27 13:28:11', '2017-11-27 13:28:11', 1),
(375, 'Manual de operación', '', 'manual-1511785727-OM_Rotary Chair Nydiag 200.pdf', 153, '2017-11-27 13:28:48', '2017-11-27 13:28:48', 1),
(376, 'Manual de operación', '', 'manual-1511785756-OM_TBS25.pdf', 154, '2017-11-27 13:29:17', '2017-11-27 13:29:17', 1),
(377, 'Manual de operación', '', 'manual-1511785778-OM_VF405.pdf', 155, '2017-11-27 13:29:39', '2017-11-27 13:29:39', 1),
(378, 'Manual de servicio', '', 'manual-1511785909-SM_AA220_80653104.pdf', 140, '2017-11-27 13:31:50', '2017-11-27 13:31:50', 1),
(379, 'Manual de servicio', '', 'manual-1511785948-SM_AA222_80653108.pdf', 141, '2017-11-27 13:32:29', '2017-11-27 13:32:29', 1),
(380, 'Manual de servicio', '', 'manual-1511785986-SM_AC33_80662101.pdf', 142, '2017-11-27 13:33:07', '2017-11-27 13:33:07', 1);
INSERT INTO `pm_manual` (`MAN_id`, `MAN_nombre`, `MAN_ubicacion`, `MAN_url`, `MOD_id`, `MAN_fechacreacion`, `MAN_fechamodificacion`, `MAN_estado`) VALUES
(381, 'Manual de servicio', '', 'manual-1511786019-SM_AC40_80661103.pdf', 149, '2017-11-27 13:33:40', '2017-11-27 13:33:40', 1),
(382, 'Manual de servicio', '', 'manual-1511786076-SM_AD226_80671106.pdf', 143, '2017-11-27 13:34:37', '2017-11-27 13:34:37', 1),
(383, 'Manual de servicio', '', 'manual-1511786383-SM_AD229b_80673107.pdf', 144, '2017-11-27 13:39:45', '2017-11-27 13:39:45', 1),
(384, 'Manual de servicio', '', 'manual-1511786402-SM_AD229e_80672107.pdf', 145, '2017-11-27 13:40:03', '2017-11-27 13:40:03', 1),
(385, 'Manual de servicio', '', 'manual-1511786576-SM_AS208_80692102.pdf', 157, '2017-11-27 13:42:58', '2017-11-27 13:42:58', 1),
(386, 'Manual de servicio', '', 'manual-1511786632-SM_AS216_80693104.pdf', 150, '2017-11-27 13:43:53', '2017-11-27 13:43:53', 1),
(387, 'Manual de servicio', '', 'manual-1511786719-SM_AS608_80696103.pdf', 156, '2017-11-27 13:45:20', '2017-11-27 13:45:20', 1),
(388, 'Manual de servicio', '', 'manual-1511786761-SM_AT235_80650107.pdf', 146, '2017-11-27 13:46:02', '2017-11-27 13:46:02', 1),
(389, 'Manual de servicio', '', 'manual-1511786832-SM_AT235h_80651107.pdf', 147, '2017-11-27 13:47:13', '2017-11-27 13:47:13', 1),
(390, 'Manual de servicio', '', 'manual-1511789535-SM_AZ26_80654102.pdf', 158, '2017-11-27 14:32:17', '2017-11-27 14:32:17', 1),
(391, 'Manual de servicio', '', 'manual-1511789599-SM_MT10_80640103.pdf', 148, '2017-11-27 14:33:20', '2017-11-27 14:33:20', 1),
(392, 'Manual de servicio - Interfaz Impresora', '', 'manual-1511789639-SM_MTP10_80641102.pdf', 148, '2017-11-27 14:34:00', '2017-11-27 14:34:00', 1),
(393, 'Manual de servicio', '', 'manual-1511789677-SM_OtoRead_80620103.pdf', 137, '2017-11-27 14:34:38', '2017-11-27 14:34:38', 1),
(394, 'Manual de servicio', '', 'manual-1511789707-SM_PA5_80691102.pdf', 152, '2017-11-27 14:35:08', '2017-11-27 14:35:08', 1),
(395, 'Manual de servicio', '', 'manual-1511789737-SM_Rotary_chair_Nydiag_200_80705501.pdf', 153, '2017-11-27 14:35:38', '2017-11-27 14:35:38', 1),
(396, 'Manual de servicio', '', 'manual-1511789781-SM_Titan_80655103.pdf', 139, '2017-11-27 14:36:22', '2017-11-27 14:36:22', 1),
(397, 'Manual de servicio', '', 'manual-1511789829-SM_VF415_80705152.pdf', 155, '2017-11-27 14:37:10', '2017-11-27 14:37:10', 1),
(398, 'Manual de servicio', '', 'manual-1511790049-SM_VO25_80703103.pdf', 159, '2017-11-27 14:40:50', '2017-11-27 14:40:50', 1),
(399, 'Manual de servicio', '', 'manual-1511790086-SM_VRA201.pdf', 138, '2017-11-27 14:41:27', '2017-11-27 14:41:27', 1),
(400, 'Manual Software', '', 'manual-1511794746-SM_VO425_80705102.pdf', 159, '2017-11-27 15:59:08', '2017-11-27 15:59:08', 1),
(401, 'Especificaciones Técnicas', '', 'manual-1511794814-Spec_AA220.doc', 140, '2017-11-27 16:00:15', '2017-11-27 16:00:15', 1),
(402, 'Especificaciones Técnicas', '', 'manual-1511794830-Spec_AA222.doc', 141, '2017-11-27 16:00:31', '2017-11-27 16:00:31', 1),
(403, 'Especificaciones Técnicas', '', 'manual-1511794846-Spec_AC33.doc', 142, '2017-11-27 16:00:47', '2017-11-27 16:00:47', 1),
(404, 'Especificaciones Técnicas', '', 'manual-1511795053-Spec_AC40.doc', 149, '2017-11-27 16:04:14', '2017-11-27 16:04:14', 1),
(405, 'Especificaciones Técnicas', '', 'manual-1511795152-Spec_AD226.doc', 143, '2017-11-27 16:05:53', '2017-11-27 16:05:53', 1),
(406, 'Especificaciones Técnicas', '', 'manual-1511795184-Spec_AD229b.doc', 144, '2017-11-27 16:06:26', '2017-11-27 16:06:26', 1),
(407, 'Especificaciones Técnicas', '', 'manual-1511795222-Spec_AD229e.doc', 145, '2017-11-27 16:07:03', '2017-11-27 16:07:03', 1),
(408, 'Especificaciones Técnicas', '', 'manual-1511795251-Spec_AS216.doc', 150, '2017-11-27 16:07:32', '2017-11-27 16:07:32', 1),
(409, 'Especificaciones Técnicas', '', 'manual-1511795345-Spec_AS608.doc', 156, '2017-11-27 16:09:06', '2017-11-27 16:09:06', 1),
(410, 'Especificaciones Técnicas', '', 'manual-1511795367-Spec_AT235.doc', 146, '2017-11-27 16:09:29', '2017-11-27 16:09:29', 1),
(411, 'Especificaciones Técnicas', '', 'manual-1511795384-Spec_AT235h.doc', 147, '2017-11-27 16:09:45', '2017-11-27 16:09:45', 1),
(412, 'Especificaciones Técnicas', '', 'manual-1511795477-Spec_MT10.doc', 148, '2017-11-27 16:11:18', '2017-11-27 16:11:18', 1),
(413, 'Especificaciones Técnicas', '', 'manual-1511795755-Spec_OtoRead.doc', 137, '2017-11-27 16:15:56', '2017-11-27 16:15:56', 1),
(414, 'Especificaciones Técnicas', '', 'manual-1511796128-Spec_PA5.doc', 152, '2017-11-27 16:22:11', '2017-11-27 16:22:11', 1),
(415, 'Especificaciones Técnicas', '', 'manual-1511796161-Spec_TBS25.doc', 154, '2017-11-27 16:22:42', '2017-11-27 16:22:42', 1),
(416, 'Especificaciones Técnicas', '', 'manual-1511796188-Spec_Titan.doc', 139, '2017-11-27 16:23:09', '2017-11-27 16:23:09', 1),
(417, 'Especificaciones Técnicas - Software', '', 'manual-1511796237-Spec_VO425.doc', 159, '2017-11-27 16:23:58', '2017-11-27 16:23:58', 1),
(418, 'Especificaciones Técnicas', '', 'manual-1511796264-Spec_VRA201.doc', 138, '2017-11-27 16:24:25', '2017-11-27 16:24:25', 1),
(419, 'Manual Operador', '', 'manual-1514293195-13099F_EN_OcuSLSLx.pdf', 161, '2017-12-26 13:59:56', '2017-12-26 13:59:56', 1),
(420, 'Manual de Usuario', '', 'manual-1514293822-calcusplit.pdf', 162, '2017-12-26 14:10:23', '2017-12-26 14:10:23', 1),
(421, 'Manual Usuario', '', 'manual-1514293974-Manual fuente de luz Storz 20161120.pdf', 163, '2017-12-26 14:12:55', '2017-12-26 14:12:55', 1),
(422, 'Manual de Operación y Servicio', '', 'manual-1514294306-Bomba Nutricion Enteral.pdf', 164, '2017-12-26 14:18:27', '2017-12-26 14:18:27', 1),
(423, 'Manual Usuario', '', 'manual-1514304430-Labconco_Manual.pdf', 165, '2017-12-26 17:07:11', '2017-12-26 17:07:11', 1),
(424, 'Manual Usuario', '', 'manual-1514305157-3848310 Rev A Logic+ A2 Users Manual.pdf', 166, '2017-12-26 17:19:18', '2017-12-26 17:19:18', 1),
(425, 'Manual Usuario', '', 'manual-1514305342-3848311 Rev B Logic+ PuriCare Procedure Station Users Manual.pdf', 167, '2017-12-26 17:22:23', '2017-12-26 17:22:23', 1),
(426, 'Manual Usuario Clase II Tipo B2', '', 'manual-1514305615-3848313 Rev B Logic+ B2 Users Manual.pdf', 166, '2017-12-26 17:26:56', '2017-12-26 17:26:56', 1),
(427, 'Manual Usuario Purifier Cell A2', '', 'manual-1514305822-4028910 Rev A Cell Logic+ A2 Users Manual.pdf', 166, '2017-12-26 17:29:41', '2017-12-26 17:30:24', 1),
(428, 'Manual Usuario Purifier Cell B2', '', 'manual-1514305861-4028911 Rev A Cell Logic+ B2 Users Manual.pdf', 166, '2017-12-26 17:31:03', '2017-12-26 17:31:03', 1),
(429, 'Instrucciones de uso', '', 'manual-1514315128-GA_marLED_E9_E9i_E15_12_EN_01.pdf', 168, '2017-12-26 20:05:29', '2017-12-26 20:05:29', 1),
(430, 'Manual de servicio', '', 'manual-1514315395-Manual de Sevicio-ML702HX-vario_502X.pdf', 169, '2017-12-26 20:09:56', '2017-12-26 20:09:56', 1),
(431, 'Especificaciones Técnicas', '', 'manual-1514315421-ESPECIFICACIONES ML702 ML502.pdf', 169, '2017-12-26 20:10:22', '2017-12-26 20:10:22', 1),
(432, 'Catálogo Series ML', '', 'manual-1514315505-Catalogo Lamparas ML 702-502HX.pdf', 169, '2017-12-26 20:11:47', '2017-12-26 20:11:47', 1),
(433, 'Instrucciones de uso', '', 'manual-1514316264-MAC EMS IFU.pdf', 170, '2017-12-26 20:24:25', '2017-12-26 20:24:25', 1),
(434, 'Manual de uso', '', 'manual-1514316540-GA113112es02.pdfMANUAL USUARIO BETA.pdf', 171, '2017-12-26 20:29:01', '2017-12-26 20:29:01', 1),
(435, 'Manual dispositivo extensiones 1409.01', '', 'manual-1514316878-ga141901es03.pdf', 171, '2017-12-26 20:34:39', '2017-12-26 20:34:39', 1),
(436, 'Catálogo extensiones', '', 'manual-1514316963-1 4 1 9.pdf', 171, '2017-12-26 20:36:04', '2017-12-26 20:36:04', 1),
(437, 'Manual de servicio', '', 'manual-1514317467-manual affinity II.pdf', 172, '2017-12-26 20:44:28', '2017-12-26 20:44:28', 1),
(438, 'Manual Usuario', '', 'manual-1515070105-U_VIVO30_003820_ENUS_A-1e.pdf', 175, '2018-01-04 13:48:26', '2018-01-04 13:48:26', 1),
(439, 'Manual Servicio', 'V-94', 'manual-1515070152-manual_service_vivo40_eng.pdf', 175, '2018-01-04 13:49:13', '2018-01-04 13:49:13', 1),
(440, 'Manual Operación', '', 'manual-1515074302-Axiostar_plus_Transmitted_Light_Microscope_e.pdf', 176, '2018-01-04 14:58:23', '2018-01-04 14:58:23', 1),
(441, 'Manual de Servicio', '', 'manual-1515170673-6543230Rev03_MANUAL SERVICIO SERVOi Rev03.pdf', 177, '2018-01-05 17:44:35', '2018-01-05 17:44:35', 1),
(442, 'Manual del usuario', '', 'manual-1515170737-Servo i Manual Usuario Español 3.0.pdf', 177, '2018-01-05 17:45:38', '2018-01-05 17:45:38', 1),
(443, 'Manual instalación Carro portatubos', '', 'manual-1515671760-6543214 Servo-i Gas trolley.pdf', 177, '2018-01-11 12:56:02', '2018-01-11 12:56:02', 1),
(444, 'Manual Instalación', '', 'manual-1515671947-Instalaci_n Servoi.pdf', 177, '2018-01-11 12:59:08', '2018-01-11 12:59:08', 1),
(445, 'Instalación nebulizador Servo Ultra', '', 'manual-1515672035-Servo Ultranebulizer Servo i.pdf', 177, '2018-01-11 13:00:36', '2018-01-11 13:00:36', 1),
(446, 'Manual Instalación de software', '', 'manual-1515672070-Servoi Software Installation.pdf', 177, '2018-01-11 13:01:11', '2018-01-11 13:01:11', 1),
(447, 'Manual referencia Emulador interfase en compu', '', 'manual-1515672697-Servoi, Computer Interface Emulator.pdf', 177, '2018-01-11 13:11:38', '2018-01-11 13:11:38', 1),
(448, 'Presentación Servo-i', '', 'manual-1515674164-Servo-i_PresToTextbook010326AT.pdf', 177, '2018-01-11 13:36:05', '2018-01-11 13:36:05', 1),
(449, 'Manual de planificación', '', 'manual-1515674444-Planungshandbuch_marLED_30_en_01a.pdf', 168, '2018-01-11 13:40:46', '2018-01-11 13:40:46', 1),
(450, 'Manual Servicio', '', 'manual-1515674466-sh_marLED_E9_E15_10_en_01_k.pdf', 168, '2018-01-11 13:41:07', '2018-01-11 13:41:07', 1),
(451, 'Manual del operador', '', 'manual-1515674715-Radical 7.pdf', 178, '2018-01-11 13:45:16', '2018-01-11 13:45:16', 1),
(452, 'Manual Servicio', '', 'manual-1515674740-Radical-7 Color Service Manual.pdf', 178, '2018-01-11 13:45:41', '2018-01-11 13:45:41', 1),
(453, 'Manual Servicio', '', 'manual-1515675541-Dominant50_Service_Manual[1].pdf', 179, '2018-01-11 13:59:02', '2018-01-11 13:59:02', 1),
(454, 'Manual Servicio', '', 'manual-1515676017-72523C-PC305-Manual de Serv. Tecnico_CE_version2002.3.pdf', 180, '2018-01-11 14:06:07', '2018-01-11 14:06:58', 1),
(455, 'Manual Usuario', '', 'manual-1515675995-72526D-PC305-Manual de Usuario_cast_CE_version2002.3.pdf', 180, '2018-01-11 14:06:36', '2018-01-11 14:06:36', 1),
(456, 'Manual de usuario', '', 'manual-1515676174-72610B-SM401-AMERICA- Manual de Usuario.pdf', 181, '2018-01-11 14:09:35', '2018-01-11 14:09:35', 1),
(457, 'Manual de Servicio', '', 'manual-1515676197-72612-SM-401 AMERICA-Manual de Serv. Tecnico.pdf', 181, '2018-01-11 14:09:58', '2018-01-11 14:09:58', 1),
(458, 'Manual de operación', '', 'manual-1515676634-H57814-30 Spanish.pdf', 182, '2018-01-11 14:17:15', '2018-01-11 14:17:15', 1),
(459, 'Manual Servicio', '', 'manual-1515676756-Service_Manual.pdf', 183, '2018-01-11 14:19:17', '2018-02-05 17:10:17', 1),
(460, 'Manual Servicio', '', 'manual-1515677117-538-30.pdf', 184, '2018-01-11 14:25:18', '2018-01-11 14:25:18', 1),
(461, 'Manual Usuario', '', 'manual-1515677326-M3A_Operators.pdf', 185, '2018-01-11 14:28:47', '2018-01-11 14:28:47', 1),
(462, 'Manual Usuario', '', 'manual-1515677445-Manual Usuario.pdf', 186, '2018-01-11 14:30:46', '2018-01-11 14:30:46', 1),
(463, 'Manual Servicio', '', 'manual-1515677463-Manual Servicio.pdf', 186, '2018-01-11 14:31:04', '2018-01-11 14:31:04', 1),
(464, 'Manual Usuario', '', 'manual-1515677994-MANUAL DE USUARIO ELI_250.pdf', 187, '2018-01-11 14:39:55', '2018-01-11 14:39:55', 1),
(465, 'Manual Servicio', '', 'manual-1515679305-Mortata_ELI-210,250_-_Service_manual.pdf', 187, '2018-01-11 15:01:46', '2018-01-11 15:01:46', 1),
(466, 'Manual de Servicio', '', 'manual-1516103843-MANUAL DE SERVICIO ELI 10.pdf', 188, '2018-01-16 12:57:24', '2018-01-16 12:57:24', 1),
(467, 'Manual Usuario', '', 'manual-1516103957-9515-170-50-SPA_REV_A1 ELI 10 UM.pdf', 188, '2018-01-16 12:59:18', '2018-01-16 12:59:18', 1),
(468, 'Manual Software ELI Link', '', 'manual-1516104034-9515-166-50-ENG_REV_F1 ELI Link UM.pdf', 187, '2018-01-16 13:00:34', '2018-01-16 13:00:34', 1),
(469, 'Manual Software ELI Link', '', 'manual-1516104034-9515-166-50-ENG_REV_F1 ELI Link UM.pdf', 188, '2018-01-16 13:00:35', '2018-01-16 13:00:35', 1),
(470, 'Guía médica de análisis computarizado de ECG ', '', 'manual-1516104117-9501-001-50_REV_H1 Physicians Guide.pdf', 187, '2018-01-16 13:01:57', '2018-01-16 13:01:57', 1),
(471, 'Guía médica de análisis computarizado de ECG ', '', 'manual-1516104117-9501-001-50_REV_H1 Physicians Guide.pdf', 188, '2018-01-16 13:01:58', '2018-01-16 13:01:58', 1),
(472, 'Manual Módulo inalámbrico WAM', '', 'manual-1516104352-9515-174-50-SPA_REV_A1 WAM UM.pdf', 187, '2018-01-16 13:05:52', '2018-01-16 13:05:52', 1),
(473, 'Manual Módulo inalámbrico WAM', '', 'manual-1516104352-9515-174-50-SPA_REV_A1 WAM UM.pdf', 188, '2018-01-16 13:05:54', '2018-01-16 13:05:54', 1),
(474, 'Manual Usuario', '', 'manual-1516104647-MANUAL DE USUARIO Ambulo_2400.pdf', 189, '2018-01-16 13:10:49', '2018-01-16 13:10:49', 1),
(475, 'Manual Servicio', '', 'manual-1516104671-MANUAL SERVICIO Ambulo 2400.pdf', 189, '2018-01-16 13:11:12', '2018-01-16 13:11:12', 1),
(476, 'Manual Usuario', '', 'manual-1516104911-MANUAL DE USUARIO H3+.pdf', 190, '2018-01-16 13:15:12', '2018-01-16 13:15:12', 1),
(477, 'Manual Servicio', '', 'manual-1516104931-MANUAL SERVICIO H3+.pdf', 190, '2018-01-16 13:15:32', '2018-01-16 13:15:32', 1),
(478, 'Manual usuario software H-Scribe', '', 'manual-1516105185-MANUAL DE USUARIO H-Scribe.pdf', 190, '2018-01-16 13:19:46', '2018-01-16 13:19:46', 1),
(479, 'Manual Servicio software H-Scribe', '', 'manual-1516105216-MANUAL SERVICIO H-Scribe.pdf', 190, '2018-01-16 13:20:17', '2018-01-16 13:20:17', 1),
(480, 'Guía Clínica para análisis de holter', '', 'manual-1516105817-9515-184-51-ENG_REV_B1 HScribe Clinicians Guide V5_01.pdf', 190, '2018-01-16 13:30:18', '2018-01-16 13:30:18', 1),
(481, 'Manual Admin Scribe', '', 'manual-1516105877-9515-185-51-ENG_REV_B1 Scribe Data Exchange Admin Manual.pdf', 190, '2018-01-16 13:31:18', '2018-01-16 13:31:18', 1),
(482, 'Manual de Servicio', '', 'manual-1516106340-MANUAL SERVICIO X-Scribe.pdf', 191, '2018-01-16 13:39:01', '2018-01-16 13:39:01', 1),
(483, 'Manual Usuario', '', 'manual-1516106396-9515-185-50-SPA_REV_A1 XScribe 5 UM.pdf', 191, '2018-01-16 13:39:57', '2018-01-16 13:39:57', 1),
(484, 'Manual Admin Scribe', '', 'manual-1516106454-9515-185-51-ENG_REV_B1 Scribe Data Exchange Admin Manual.pdf', 191, '2018-01-16 13:40:55', '2018-01-16 13:40:55', 1),
(485, 'Guía para interpretación de ECG', '', 'manual-1516106719-9515-001-52-ENG_REV_A1 PHY GUIDE Adult and Pediatrics UM.pdf', 191, '2018-01-16 13:45:20', '2018-01-16 13:45:20', 1),
(486, 'Manual Usuario Holter arritmia X12+', '', 'manual-1516107044-9515-164-50-SPA_REV_A1 X12+ UM.pdf', 191, '2018-01-16 13:50:45', '2018-01-16 13:50:45', 1),
(487, 'Manual software ECG R-Scribe', '', 'manual-1516107302-9515-186-50-SPA_REV_A1 RScribe 5 UM.pdf', 187, '2018-01-16 13:55:02', '2018-01-16 13:55:02', 1),
(488, 'Manual software ECG R-Scribe', '', 'manual-1516107302-9515-186-50-SPA_REV_A1 RScribe 5 UM.pdf', 188, '2018-01-16 13:55:03', '2018-01-16 13:55:03', 1),
(489, 'Guía física para análisis de ECG', '', 'manual-1516107355-9515-001-51-ENG_REV_A1 PHY GUIDE Adult and Pediatric_V7.pdf', 187, '2018-01-16 13:55:55', '2018-01-16 13:55:55', 1),
(490, 'Guía física para análisis de ECG', '', 'manual-1516107355-9515-001-51-ENG_REV_A1 PHY GUIDE Adult and Pediatric_V7.pdf', 188, '2018-01-16 13:55:56', '2018-01-16 13:55:56', 1),
(491, 'Guía Admin Scribe', '', 'manual-1516107403-9515-185-51-ENG_REV_B1 Scribe Data Exchange Admin Manual.pdf', 187, '2018-01-16 13:56:43', '2018-01-16 13:56:43', 1),
(492, 'Guía Admin Scribe', '', 'manual-1516107403-9515-185-51-ENG_REV_B1 Scribe Data Exchange Admin Manual.pdf', 188, '2018-01-16 13:56:44', '2018-01-16 13:56:44', 1),
(493, 'Manual Servicio', '', 'manual-1516111444-Manual de Servicio NPB395.pdf', 192, '2018-01-16 15:04:05', '2018-01-16 15:04:05', 1),
(494, 'Manual Operación', '', 'manual-1516111778-OPRHT70plus-2-Sp-RevA-final draft.pdf', 193, '2018-01-16 15:09:39', '2018-01-16 15:09:39', 1),
(495, 'Manual Usuario', '', 'manual-1516112154-Manual de Usuario BSM-2300K.pdf', 194, '2018-01-16 15:15:55', '2018-01-16 15:15:55', 1),
(496, 'Manual de Servicio', '', 'manual-1516112262-SMBSM2300.pdf', 194, '2018-01-16 15:17:43', '2018-01-16 15:17:43', 1),
(497, 'Manual Usuario', '', 'manual-1516114269-Manual_de_Usuario_BSM-5100K.pdf', 195, '2018-01-16 15:51:10', '2018-01-16 15:51:10', 1),
(498, 'Manual Servicio', '', 'manual-1516114386-BSM5100.PDF', 195, '2018-01-16 15:53:08', '2018-01-16 15:53:08', 1),
(499, 'Manual Servicio', '', 'manual-1516201516-ECG9620 SM-E.pdf', 199, '2018-01-17 16:05:17', '2018-01-17 16:05:17', 1),
(500, 'Manual Usuario', '', 'manual-1516201645-Nihon Kohden Cardiofax 9620 UM.pdf', 199, '2018-01-17 16:07:26', '2018-01-17 16:07:26', 1),
(501, 'Manual usuario', '', 'manual-1516205321-Manual de Usuario BSM-3000.pdf', 197, '2018-01-17 17:08:42', '2018-01-17 17:08:42', 1),
(502, 'Manual Operador', '', 'manual-1516207184-BSM6000 UG Part I-Q.pdf', 200, '2018-01-17 17:32:54', '2018-01-17 17:39:45', 1),
(503, 'Guía del Administrador', '', 'manual-1516206900-BSM6000 AG-R.pdf', 200, '2018-01-17 17:35:01', '2018-01-17 17:35:01', 1),
(504, 'Manual del operador', '', 'manual-1516206934-BSM6000 OM-R.pdf', 200, '2018-01-17 17:35:35', '2018-01-17 17:35:35', 0),
(505, 'Manual Servicio', '', 'manual-1516206984-BSM6000 SM-J.pdf', 200, '2018-01-17 17:36:25', '2018-01-17 17:36:25', 1),
(506, 'Guía de Usuario - Parte 1', '', 'manual-1516207171-BSM6000 UG Part I-Q.pdf', 200, '2018-01-17 17:39:32', '2018-01-17 17:39:32', 1),
(507, 'Guía de Usuario - Parte 2', '', 'manual-1516207209-BSM6000 UG Part II-Q.pdf', 200, '2018-01-17 17:40:10', '2018-01-17 17:40:10', 1),
(508, 'Guía Usuario Interpretación ECG', '', 'manual-1516207242-ECAPS12C BSM UG-A.pdf', 200, '2018-01-17 17:40:43', '2018-01-17 17:40:43', 1),
(509, 'Guía programa EssCO', '', 'manual-1516207317-QP033P034P OM-E.pdf', 200, '2018-01-17 17:41:58', '2018-01-17 17:41:58', 1),
(510, 'Manual Usuario', '', 'manual-1516207694-Manual de Usuario PVM-2700.pdf', 196, '2018-01-17 17:48:15', '2018-01-17 17:48:15', 1),
(511, 'Guía del Administrador', '', 'manual-1516207718-PVM2700 AG-B.pdf', 196, '2018-01-17 17:48:39', '2018-01-17 17:48:39', 1),
(512, 'Manual Servicio', '', 'manual-1516207755-PVM2700 SM-B.pdf', 196, '2018-01-17 17:49:16', '2018-01-17 17:49:16', 1),
(513, 'Guía de Usuario completa', '', 'manual-1516207797-PVM2700 UG-B.pdf', 196, '2018-01-17 17:49:58', '2018-01-17 17:49:58', 1),
(514, 'Manual Servicio', '', 'manual-1516208192-TEC7600_7700SM.pdf', 201, '2018-01-17 17:56:33', '2018-01-17 17:56:33', 1),
(515, 'Manual Servicio', '', 'manual-1516215027-Nihon_Kohden_EEG-9100-9200_-_Service_manual.pdf', 202, '2018-01-17 19:50:28', '2018-01-17 19:50:28', 1),
(516, 'Manual Usuario', '', 'manual-1516215523-Manual de Usuario CNS-9701E.pdf', 203, '2018-01-17 19:58:44', '2018-01-17 19:58:44', 1),
(517, 'Manual Usuario 2500', '', 'manual-1516217577-5667-105-02_2500A_SPA.pdf', 204, '2018-01-17 20:31:46', '2018-01-17 20:32:58', 1),
(518, 'Manual Usuario 2500A', '', 'manual-1516217566-5667-105-02_2500A_SPA.pdf', 204, '2018-01-17 20:32:47', '2018-01-17 20:32:47', 1),
(519, 'Manual Usuario Soporte de carga', '', 'manual-1516217625-5667-205-01_2500C_SPA.pdf', 204, '2018-01-17 20:33:46', '2018-01-17 20:33:46', 1),
(520, 'Instrucciones de uso', '', 'manual-1516217829-8339-005-04_9590 IFU_SPA.pdf', 205, '2018-01-17 20:37:11', '2018-01-17 20:37:11', 1),
(521, 'Manual Técnico', '', 'manual-1516218404-8131-5259.pdf', 206, '2018-01-17 20:46:45', '2018-01-17 20:46:45', 1),
(522, 'Instrucciones de uso', '', 'manual-1516218422-pace101h_ifu.pdf', 206, '2018-01-17 20:47:03', '2018-01-17 20:47:03', 1),
(523, 'Manual Servicio', '', 'manual-1516220842-1483-4104.pdf', 207, '2018-01-17 21:27:23', '2018-01-17 21:27:23', 1),
(524, 'Manual Servicio', '', 'manual-1516276044-Respironics Trilogy Service Manual.pdf', 208, '2018-01-18 12:47:25', '2018-01-18 12:47:25', 1),
(525, 'Manual Clínico', '', 'manual-1516276169-Trilogy200-Clinical-Manual.pdf', 208, '2018-01-18 12:49:30', '2018-01-18 12:49:30', 1),
(526, 'Manual Servicio', '', 'manual-1516278559-EPIQ_Service_Manual.pdf', 209, '2018-01-18 13:29:20', '2018-01-18 13:29:20', 1),
(527, 'Manual Entrenamiento', '', 'manual-1516278588-epiq_5.pdf', 209, '2018-01-18 13:29:49', '2018-01-18 13:29:49', 1),
(528, 'Guía de servicio', '', 'manual-1516290448-VS3 Service Guide_A.02.pdf', 210, '2018-01-18 16:47:29', '2018-01-18 16:47:29', 1),
(529, 'Guía de exportación de datos', '', 'manual-1516290475-VS3 Data Export Guide_A.02.pdf', 210, '2018-01-18 16:47:56', '2018-01-18 16:47:56', 1),
(530, 'Guía de instalación inalámbrica Wireless', '', 'manual-1516290593-VS3 802.11 Wireless Installation and Setup Gd_A.02.pdf', 210, '2018-01-18 16:49:54', '2018-01-18 16:49:54', 1),
(531, 'Guía de Servicio', '', 'manual-1516290872-S-453564043781-5_rA.pdf', 211, '2018-01-18 16:54:33', '2018-01-18 16:54:33', 1),
(532, 'Instrucciones de uso', '', 'manual-1516299373-Spanish_Instructions_for_use.pdf', 212, '2018-01-18 19:16:14', '2018-01-18 19:16:14', 1),
(533, 'Manual Servicio', '', 'manual-1516299680-Physiomed_Physiotherm-S_-_Service_manual.pdf', 213, '2018-01-18 19:21:21', '2018-01-18 19:21:21', 1),
(534, 'Manual Operación y Mantención', '', 'manual-1516363547-REF100 Manual.pdf', 214, '2018-01-19 13:05:48', '2018-01-19 13:05:48', 1),
(535, 'Manual Servicio', '', 'manual-1516737813-sm_30_0044_e_v1_opmi_vario_700.pdf', 47, '2018-01-23 21:03:35', '2018-01-23 21:03:35', 1),
(536, 'Manual Servicio', '', 'manual-1516979820-Medtronic_Lifepak_20_-_Service_manual.pdf', 215, '2018-01-26 16:17:02', '2018-01-26 16:17:02', 1),
(537, 'Manual de instalación', '', 'manual-1516998793-LUCEA_50_100_SERVINSTALLINSTR_0174401_ES_ALL.pdf', 216, '2018-01-26 21:33:14', '2018-01-26 21:33:14', 1),
(538, 'Manual de usuario', '', 'manual-1517847091-Manual-de-Usuario-D6.pdf', 183, '2018-02-05 17:11:32', '2018-02-05 17:11:32', 1),
(539, 'Manual de operación y servicio', '', 'manual-1518036849-213_215_omeng0000.pdf', 217, '2018-02-07 21:54:10', '2018-02-07 21:54:10', 1),
(540, 'Manual Servicio', '', 'manual-1520352560-1006-0836-000-0203_MANUAL SERVICIO VENTILADOR 7100.pdf', 218, '2018-03-06 17:09:21', '2018-03-06 17:09:21', 1),
(541, 'Manual Servicio', '', 'manual-1520352875-9650-0450-01 Rev P_MANUAL DE SERVICIO ZOLL SERIE M.pdf', 219, '2018-03-06 17:14:36', '2018-03-06 17:14:36', 1),
(542, 'Manual Servicio', '', 'manual-1520354849-1015010rev060403_MANUAL DE SERVICIO BIPAP VISION.pdf', 220, '2018-03-06 17:47:30', '2018-03-06 17:47:30', 1);

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
(40, 'Interacoustics', '2017-10-10 15:39:29', '2017-11-24 20:19:32', 1),
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
(54, 'SpaceLabs', '2017-10-10 15:42:30', '2017-11-21 13:31:51', 1),
(55, 'SLE', '2017-10-10 15:42:37', '2017-10-10 15:42:37', 1),
(56, 'Thermo', '2017-10-10 15:42:49', '2017-10-10 15:42:49', 1),
(57, 'Toshiba', '2017-10-10 15:43:03', '2017-10-10 15:43:03', 1),
(58, 'Valleylab', '2017-10-10 15:43:13', '2017-10-10 15:43:13', 1),
(59, 'Carl Zeiss', '2017-10-10 15:43:27', '2017-10-10 15:43:27', 1),
(60, 'Datex-Ohmeda', '2017-10-24 16:27:16', '2017-10-24 16:27:16', 1),
(61, 'Alcon', '2017-10-24 16:32:14', '2017-10-24 16:32:14', 1),
(62, 'Allen', '2017-10-24 16:32:32', '2017-10-24 16:32:32', 1),
(63, 'Respironics', '2017-10-24 16:34:19', '2017-10-24 16:34:19', 1),
(64, 'Maxtec', '2017-10-24 22:42:41', '2017-10-24 22:42:41', 1),
(65, 'Villa Sistemi Medicali', '2017-10-24 22:52:45', '2017-10-24 22:52:45', 1),
(66, 'Medicapture', '2017-10-30 14:46:36', '2017-10-30 14:46:36', 1),
(67, 'Sony', '2017-10-30 14:46:49', '2017-10-30 14:46:49', 1),
(68, '3M', '2017-10-30 14:59:26', '2017-10-30 14:59:26', 1),
(69, 'Seca', '2017-10-30 15:13:47', '2017-10-30 15:13:47', 1),
(70, 'BCI', '2017-10-30 16:00:11', '2017-10-30 16:00:11', 1),
(71, 'Biolight', '2017-10-30 16:05:05', '2017-10-30 16:05:05', 1),
(72, 'BIS', '2017-10-30 17:18:33', '2017-10-30 17:18:33', 1),
(73, 'Cincinatti Sub-Zero', '2017-10-30 17:27:52', '2017-10-30 17:27:52', 1),
(74, 'Fresenius Kabi', '2017-10-30 17:38:05', '2017-10-30 17:38:05', 1),
(75, 'Fresenius Vial', '2017-10-30 17:38:13', '2017-10-30 17:38:13', 1),
(76, 'Hospira', '2017-10-30 17:43:30', '2017-10-30 17:43:30', 1),
(77, 'Byron Medical', '2017-10-30 18:01:06', '2017-10-30 18:01:06', 1),
(78, 'Integra', '2017-10-30 21:28:21', '2017-10-30 21:28:21', 1),
(79, 'Fujinon', '2017-10-30 21:36:34', '2017-10-30 21:36:34', 1),
(80, 'Charmcare', '2017-11-02 14:48:04', '2017-11-02 14:48:04', 1),
(81, 'Codonics', '2017-11-02 20:08:13', '2017-11-02 20:08:13', 1),
(82, 'Konica Minolta', '2017-11-02 21:13:24', '2017-11-02 21:13:24', 1),
(83, 'Alsa', '2017-11-13 20:59:15', '2017-11-13 20:59:15', 1),
(84, 'Puritan Benett', '2017-11-13 21:19:14', '2017-11-13 21:19:14', 1),
(85, 'Enraf Nonius', '2017-11-13 21:32:02', '2017-11-13 21:32:02', 1),
(86, 'NDD', '2017-11-13 21:36:08', '2017-11-13 21:36:08', 1),
(87, 'Ethicon', '2017-11-14 13:19:13', '2017-11-14 13:19:13', 1),
(88, 'Fresenius', '2017-11-14 15:20:26', '2017-11-14 15:20:26', 1),
(89, 'GSI', '2017-11-20 21:13:39', '2017-11-20 21:13:39', 1),
(90, 'Haier', '2017-11-20 21:21:52', '2017-11-20 21:21:52', 1),
(91, 'Sensormedics', '2017-11-21 13:31:44', '2017-11-21 13:31:44', 1),
(92, 'I.E.M.', '2017-11-21 13:50:27', '2017-11-21 13:50:27', 1),
(93, 'Penlon', '2017-11-21 14:46:29', '2017-11-21 14:46:29', 1),
(94, 'Chattanooga', '2017-11-22 16:47:04', '2017-11-22 16:47:04', 1),
(95, 'Iridex', '2017-12-26 13:52:58', '2017-12-26 13:52:58', 1),
(96, 'Kendall', '2017-12-26 14:17:02', '2017-12-26 14:17:02', 1),
(97, 'Labconco', '2017-12-26 15:09:56', '2017-12-26 15:09:56', 1),
(98, 'System One', '2017-12-26 19:38:13', '2017-12-26 19:38:13', 1),
(99, 'McGrath', '2017-12-26 20:21:37', '2017-12-26 20:23:33', 1),
(100, 'Hill-Rom', '2017-12-26 20:38:24', '2017-12-26 20:38:24', 1),
(101, 'Breas', '2018-01-04 13:46:05', '2018-01-04 13:46:05', 1),
(102, 'Datascope', '2018-01-11 14:21:18', '2018-01-11 14:21:18', 1),
(103, 'Edan', '2018-01-11 14:27:30', '2018-01-11 14:27:30', 1),
(104, 'Medrad', '2018-01-11 14:29:24', '2018-01-11 14:29:24', 1),
(105, 'Newport', '2018-01-16 15:06:58', '2018-01-16 15:06:58', 1),
(106, 'Quantum', '2018-01-17 13:27:02', '2018-01-17 13:27:02', 1),
(107, 'Oscor', '2018-01-17 20:40:52', '2018-01-17 20:40:52', 1),
(108, 'Physiomed', '2018-01-18 19:19:52', '2018-01-18 19:19:52', 1),
(109, 'Dynatech Nevada', '2018-02-07 21:52:35', '2018-02-07 21:52:35', 1);

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
(5, 'M-Series', 5, 16, 'image-1507643996-zollm.jpg', '2017-10-10 15:59:00', '2017-10-10 15:59:59', 0),
(6, 'Endura BV', 9, 5, 'image-1507924868-70721-104851.jpg', '2017-10-13 20:21:03', '2017-10-13 22:01:10', 1),
(7, 'M-Series', 5, 16, 'image-1508855393-zollm.jpg', '2017-10-21 00:09:23', '2017-10-24 16:29:54', 0),
(8, 'Drystar 5300', 10, 28, 'image-1508855114-5300.jpg', '2017-10-24 16:25:16', '2017-10-24 16:25:16', 1),
(9, 'Drystar 5500', 10, 28, 'image-1508855133-5500.jpg', '2017-10-24 16:25:34', '2017-10-24 16:25:34', 1),
(10, 'Drystar AXYS', 10, 28, 'image-1508855149-axys.jpg', '2017-10-24 16:25:50', '2017-10-24 16:25:50', 1),
(11, 'Avea', 2, 25, 'image-1508855177-avea.jpg', '2017-10-24 16:26:18', '2017-10-24 16:26:18', 1),
(12, 'Cardioserv', 5, 60, 'image-1508855265-cardioserv.jpg', '2017-10-24 16:27:46', '2017-10-24 16:27:46', 1),
(13, 'Legacy 2000 Series', 12, 61, 'image-1508855595-2000legacy.jpg', '2017-10-24 16:33:16', '2017-10-24 16:33:16', 1),
(14, 'Accurus', 11, 61, 'image-1508855610-accurus.jpg', '2017-10-24 16:33:32', '2017-10-24 16:33:32', 1),
(15, 'Aespire S/5', 7, 60, 'image-1508855640-aespire.jpg', '2017-10-24 16:34:01', '2017-10-24 16:34:01', 1),
(16, 'Alice 5', 15, 63, 'image-1508855691-alice_5.jpg', '2017-10-24 16:34:52', '2017-10-24 16:34:52', 1),
(17, 'Pal PRO', 16, 62, 'image-1508855710-allen.jpg', '2017-10-24 16:35:11', '2017-10-24 16:35:11', 1),
(18, 'GN300', 13, 4, 'image-1508855729-gn300.jpg', '2017-10-24 16:35:32', '2017-10-24 16:35:32', 1),
(19, 'Infiniti', 12, 61, 'image-1508855745-infiniti.jpg', '2017-10-24 16:35:46', '2017-10-24 16:35:46', 1),
(20, 'Logiq 9', 3, 2, 'image-1508855858-logic9.jpg', '2017-10-24 16:37:39', '2017-11-20 17:08:50', 1),
(21, 'MAC500', 18, 60, 'image-1511197329-919660.jpg', '2017-10-24 16:38:43', '2017-11-20 18:02:10', 1),
(22, 'Ocuscan', 17, 61, 'image-1508855940-ocuscan.jpg', '2017-10-24 16:39:01', '2017-10-24 16:39:01', 1),
(23, 'Alaris Tiva', 14, 25, 'image-1508855968-tiva.jpg', '2017-10-24 16:39:29', '2017-10-24 16:39:29', 1),
(24, 'Infinity Vista', 1, 1, 'image-1508855990-vista.jpg', '2017-10-24 16:39:51', '2017-10-24 16:39:51', 1),
(25, 'OM-25AE', 19, 64, 'image-1508877902-Maxtec-OM-25AE1.jpg', '2017-10-24 22:45:04', '2017-10-24 22:45:04', 1),
(26, 'Arcovis 3000', 20, 65, 'image-1508878484-arcovis3000.jpg', '2017-10-24 22:54:11', '2017-10-24 22:54:45', 1),
(27, 'UP-970AD', 21, 67, 'image-1509371482-sony-up970ad.jpg', '2017-10-30 14:51:23', '2017-10-30 14:51:23', 1),
(28, 'UP-990AD', 21, 67, 'image-1509371540-301060.jpeg', '2017-10-30 14:52:21', '2017-10-30 14:52:21', 1),
(29, 'Bair Hugger 505', 22, 68, 'image-1509373949-505.jpg', '2017-10-30 14:59:57', '2017-10-30 15:32:31', 1),
(30, 'Bair Hugger 750', 22, 68, 'image-1509373962-750.jpg', '2017-10-30 15:00:05', '2017-10-30 15:32:43', 1),
(31, 'Serie 300', 26, 69, 'image-1509373161-seca_376.jpg', '2017-10-30 15:19:22', '2017-10-30 15:19:22', 1),
(32, 'Diapact CRRT', 27, 6, 'image-1509374569-0000000000000001000114837__7106510_web.jpg', '2017-10-30 15:42:50', '2017-10-30 15:42:50', 1),
(33, 'Infusomat P', 28, 6, 'image-1509375311-infusomat-p.jpg', '2017-10-30 15:55:11', '2017-10-30 15:55:11', 1),
(34, 'Perfusor Space', 14, 6, 'image-1509375472-perfusor-space.jpeg', '2017-10-30 15:57:52', '2017-10-30 15:57:52', 1),
(35, 'Capnocheck Plus', 29, 70, 'image-1509375700-capnocheck.jpg', '2017-10-30 16:01:40', '2017-10-30 16:01:40', 1),
(36, 'M8000A', 1, 71, 'image-1509376044-mnitor-multiparametro-m8000a-biolight.jpg', '2017-10-30 16:07:24', '2017-10-30 16:07:24', 1),
(37, 'BT400', 30, 32, 'image-1509379640-phototherapy-bt-400.jpg', '2017-10-30 17:07:20', '2017-10-30 17:07:20', 1),
(38, 'BIS View', 31, 72, 'image-1509380462-bis.jpg', '2017-10-30 17:21:02', '2017-10-30 17:21:02', 1),
(39, 'Blanketrol III', 32, 73, 'image-1509381004-blanketrol.jpg', '2017-10-30 17:30:04', '2017-10-30 17:30:04', 1),
(40, 'Optima MS', 28, 75, 'image-1509381582-optima.jpg', '2017-10-30 17:39:42', '2017-10-30 17:39:42', 1),
(41, 'Plum A+', 28, 76, 'image-1509381927-hospirapluma+.png', '2017-10-30 17:45:27', '2017-10-30 17:45:27', 1),
(42, 'Injectomat Agilia', 14, 74, 'image-1509382632-76198-8208684.jpg', '2017-10-30 17:56:57', '2017-10-30 17:57:12', 1),
(43, 'PSI-TEC III', 33, 77, 'image-1509382988-1943313.jpg', '2017-10-30 18:03:08', '2017-10-30 18:03:08', 1),
(44, 'Easy III', 34, 22, 'image-1509393631-1466043.jpg', '2017-10-30 21:00:31', '2017-10-30 21:00:31', 1),
(45, 'Camino ICP', 35, 78, 'image-1509395410-camino-icp-monitor1.jpg', '2017-10-30 21:30:10', '2017-10-30 21:30:10', 1),
(46, 'FB-120P', 36, 79, 'image-1509395983-fb-120p.mth11683_200_200.jpg', '2017-10-30 21:39:43', '2017-10-30 21:39:43', 1),
(47, 'Opmi Vario 700', 8, 59, 'image-1509624226-ov700.jpg', '2017-11-02 13:03:47', '2017-11-02 13:03:47', 1),
(48, 'Opmi Pico', 8, 59, 'image-1509625036-opmipico.jpeg', '2017-11-02 13:17:18', '2017-11-02 13:17:18', 1),
(49, 'Opmi Visu', 8, 59, 'image-1509625412-VISU210.jpg', '2017-11-02 13:23:34', '2017-11-02 13:23:34', 1),
(50, 'Opmi Sensera', 8, 59, 'image-1509628174-sensera.jpg', '2017-11-02 14:09:35', '2017-11-02 14:09:35', 1),
(51, 'Opmi Movena', 8, 59, 'image-1509628631-movena.jpg', '2017-11-02 14:17:12', '2017-11-02 14:17:12', 1),
(52, 'VP-1000/VP-1200', 1, 80, 'image-1507592634-default.jpg', '2017-11-02 14:48:42', '2017-11-02 14:48:42', 1),
(53, 'Virtua', 41, 81, 'image-1509649770-04.jpg', '2017-11-02 20:08:39', '2017-11-02 20:09:31', 1),
(54, 'Force EZ', 13, 58, 'image-1509651587-force ez_lg.jpg', '2017-11-02 20:39:48', '2017-11-02 20:39:48', 1),
(55, 'Force FX', 13, 58, 'image-1509651653-Valleylab-Force-Fx.jpg', '2017-11-02 20:40:54', '2017-11-02 20:40:54', 1),
(56, 'Oximax N65', 42, 49, 'image-1509652611-NellcorN65_0-1.jpg', '2017-11-02 20:56:52', '2017-11-02 20:56:52', 1),
(57, 'Regius 110HQ', 43, 82, 'image-1509653673-76584-6531381.jpg', '2017-11-02 21:14:34', '2017-11-02 21:14:34', 1),
(58, '506dn', 4, 19, 'image-1509653880-506dn.jpg', '2017-11-02 21:18:01', '2017-11-02 21:18:01', 1),
(59, 'S5', 1, 2, 'image-1509654652-datex-ohmeda-s5.jpg', '2017-11-02 21:30:53', '2017-11-02 21:30:53', 1),
(60, 'TEC-5521K / TEC-5531K', 5, 13, 'image-1510062192-5531.png', '2017-11-07 14:43:13', '2017-11-07 14:43:13', 1),
(61, 'TEC-7100', 5, 13, 'image-1510065822-909443.jpg', '2017-11-07 15:43:43', '2017-11-07 15:43:43', 1),
(62, 'TEC-7500', 5, 13, 'image-1510066014-tec7500.jpg', '2017-11-07 15:46:55', '2017-11-07 15:49:01', 1),
(63, 'Serie R', 5, 16, 'image-1510066279-serier.jpg', '2017-11-07 15:51:20', '2017-11-07 15:51:20', 1),
(64, 'Babylog 8000', 2, 1, 'image-1510242644-D-19678-2015.jpg', '2017-11-09 16:50:45', '2017-11-09 16:50:45', 1),
(65, 'Babytherm 8004', 44, 1, 'image-1510244004-Babytherm_8004.jpg', '2017-11-09 17:13:25', '2017-11-09 17:13:25', 1),
(66, 'Fabius CE', 7, 1, 'image-1510244693-900750.jpg', '2017-11-09 17:24:54', '2017-11-09 17:24:54', 1),
(67, 'Fabius Plus', 7, 1, 'image-1510256982-Fabius_Plus_0.jpg', '2017-11-09 20:49:43', '2017-11-09 20:49:43', 1),
(68, 'IICS-90', 44, 1, 'image-1510257987-airshields_iics90.jpg', '2017-11-09 21:06:28', '2017-11-09 21:06:28', 1),
(69, 'Isolette C2000', 45, 1, 'image-1510258418-29.jpg', '2017-11-09 21:13:39', '2017-11-09 21:13:39', 1),
(70, 'TI-500', 46, 1, 'image-1510259182-TI500-Globetrotter1.jpg', '2017-11-09 21:26:23', '2017-11-09 21:26:23', 1),
(71, 'C450', 45, 1, 'image-1510260158-1879784.jpg', '2017-11-09 21:42:39', '2017-11-09 21:42:39', 1),
(72, 'Caleo', 45, 1, 'image-1510337407-drager_caleo_1.jpg', '2017-11-10 19:10:08', '2017-11-10 19:10:08', 1),
(73, 'Resuscitaire', 5, 1, 'image-1510337812-rescucitaire.jpg', '2017-11-10 19:16:53', '2017-11-10 19:16:53', 1),
(74, 'Infinity Delta', 1, 1, 'image-1510339293-delta_mt-8846-2006.jpg', '2017-11-10 19:41:33', '2017-11-10 19:41:33', 1),
(75, 'Oxylog 3000 Plus', 47, 1, 'image-1510340335-oxylog-3000.jpg', '2017-11-10 19:58:55', '2017-11-10 19:58:55', 1),
(76, 'Primus/Primus Infinity Empowered', 7, 1, 'image-1510340580-Primus.jpg', '2017-11-10 20:03:00', '2017-11-10 20:03:00', 1),
(77, 'Isolette 8000', 45, 1, 'image-1510344980-isolette-8000.jpg', '2017-11-10 21:16:20', '2017-11-10 21:16:20', 1),
(78, 'Incubator 8000', 45, 1, 'image-1510345337-654946.jpg', '2017-11-10 21:22:17', '2017-11-10 21:22:17', 1),
(79, 'Fluoro-lite', 30, 1, 'image-1510580909-DRAGER_FLUORO.jpg', '2017-11-13 14:48:30', '2017-11-13 14:48:30', 1),
(80, 'iU22/iE33', 3, 5, 'image-1510581435-iu221.jpg', '2017-11-13 14:57:16', '2017-11-13 14:57:16', 1),
(81, 'Logiq E/Vivid E', 3, 2, 'image-1510601190-LOGIQE.jpg', '2017-11-13 20:26:31', '2017-11-20 17:30:06', 1),
(82, 'Edge', 3, 53, 'image-1510602212-s-l300.jpg', '2017-11-13 20:43:33', '2017-11-13 20:43:33', 1),
(83, 'M-Turbo', 3, 53, 'image-1510602282-product_guide_mturbo.jpg', '2017-11-13 20:44:43', '2017-11-13 20:44:43', 1),
(84, 'Alsatom SU Series', 13, 83, 'image-1510603248-120202_114.jpg', '2017-11-13 21:00:49', '2017-11-13 21:01:48', 1),
(85, 'UES-40', 13, 51, 'image-1510603466-1683957.jpg', '2017-11-13 21:04:28', '2017-11-13 21:04:28', 1),
(86, '840', 2, 84, 'image-1510604426-840.jpg', '2017-11-13 21:20:27', '2017-11-13 21:20:27', 1),
(87, 'Force Triad', 13, 58, 'image-1510604802-Covidien-Force-Traid.jpg', '2017-11-13 21:26:43', '2017-11-13 21:26:43', 1),
(88, 'TensMed S84', 48, 85, 'image-1510605192-tensmed-s84.jpg', '2017-11-13 21:33:13', '2017-11-13 21:33:13', 1),
(89, 'Easy One ProLab', 49, 86, 'image-1510605454-a1.jpg', '2017-11-13 21:37:36', '2017-11-13 21:37:36', 1),
(90, 'G11', 50, 87, 'image-1510661986-6534820483-0_600.jpg', '2017-11-14 13:19:47', '2017-11-14 13:19:47', 1),
(91, 'IW900 Series', 51, 27, 'image-1510662709-warming_products3.jpg', '2017-11-14 13:31:50', '2017-11-14 13:33:04', 1),
(92, 'Neopuff', 52, 27, 'image-1510663028-1616484.jpg', '2017-11-14 13:37:09', '2017-11-14 13:37:09', 1),
(93, '900IW230', 53, 27, 'image-1510663593-iw900.jpg', '2017-11-14 13:46:34', '2017-11-14 13:46:34', 1),
(94, 'ESA612', 54, 36, 'image-1510664535-esa612_200p.jpg', '2017-11-14 14:02:16', '2017-11-14 14:02:16', 1),
(95, '287', 55, 36, 'image-1510668832-Fluke-287-Multimeter-360a.jpg', '2017-11-14 15:13:53', '2017-11-14 15:13:53', 1),
(96, 'ADM08/ABM08', 27, 88, 'image-1510669277-2238837.jpg', '2017-11-14 15:21:18', '2017-11-14 15:21:18', 1),
(97, 'VP4450HD', 56, 79, 'image-1510670080-68536-9542888.jpg', '2017-11-14 15:30:14', '2017-11-14 15:34:41', 1),
(98, 'Xl4450HD', 57, 79, 'image-1510670040-2380308_1.jpg', '2017-11-14 15:34:01', '2017-11-14 15:34:01', 1),
(99, 'EC-530', 40, 79, 'image-1510670876-EC530.jpg', '2017-11-14 15:47:57', '2017-11-14 16:12:00', 1),
(100, 'EC-590ZW', 40, 79, 'image-1510671714-FUJINON EC-590 WI Colonoscope2.jpg', '2017-11-14 16:01:55', '2017-11-14 16:11:47', 1),
(101, 'EG-530', 39, 79, 'image-1510671841-Fujinon-EG-530WR_fulltIdu.jpg', '2017-11-14 16:04:02', '2017-11-14 16:12:18', 1),
(102, 'EG-590', 39, 79, 'image-1510672186-s-l225.jpg', '2017-11-14 16:09:48', '2017-11-14 16:09:48', 1),
(103, 'B20', 1, 2, 'image-1511188125-B20-600x491.png', '2017-11-20 15:28:47', '2017-11-20 15:28:47', 1),
(104, 'B650', 1, 2, 'image-1511188315-general-electric-b650-510x399.jpg', '2017-11-20 15:31:56', '2017-11-20 15:31:56', 0),
(105, 'Dash 3000/Dash 4000', 1, 2, 'image-1511193012-GE-Dash-4000-Patient-Monitor.jpg', '2017-11-20 16:50:14', '2017-11-20 16:50:14', 1),
(106, 'Lunar', 58, 2, 'image-1511193255-lunar.jpg', '2017-11-20 16:54:16', '2017-11-20 16:54:16', 1),
(107, 'Giraffe', 45, 2, 'image-1511193619-i-giraffe-340x340.jpg', '2017-11-20 17:00:21', '2017-11-20 17:01:13', 1),
(108, 'Vivid e', 3, 2, 'image-1511194279-tnw800-Vivid e.jpg', '2017-11-20 17:11:21', '2017-11-20 17:11:21', 0),
(109, 'Vivid i', 3, 2, 'image-1511195310-18508_.jpg', '2017-11-20 17:28:32', '2017-11-20 17:28:32', 1),
(110, 'MAC400', 18, 2, 'image-1511197170-1326692910_Mac400.jpg', '2017-11-20 17:59:33', '2017-11-20 17:59:33', 1),
(111, 'MAC600', 18, 2, 'image-1511200985-ge-mac-600.jpg', '2017-11-20 19:03:07', '2017-11-20 19:03:07', 1),
(112, 'Trusat', 59, 2, 'image-1511202266-GE_TRUSAT-2.jpg', '2017-11-20 19:24:28', '2017-11-20 19:24:28', 1),
(113, 'Voluson S6/S8', 3, 2, 'image-1511202480-volusons8-01.jpg', '2017-11-20 19:28:01', '2017-11-20 19:28:01', 1),
(114, 'V100', 4, 2, 'image-1511202648-GE-CARESCAPE-V100-Patient-Monitor_400x400.jpg', '2017-11-20 19:30:49', '2017-11-20 19:30:49', 1),
(115, 'Vivid S5/S6', 3, 2, 'image-1511203945-ge-vivid-s5-side-view.jpg', '2017-11-20 19:52:28', '2017-11-20 19:52:28', 1),
(116, 'Voluson 730 Pro', 3, 2, 'image-1511205199-ge-voluson-730-pro-1.jpg', '2017-11-20 20:13:20', '2017-11-20 20:13:20', 1),
(117, 'Voluson 730 Expert', 3, 2, 'image-1511206316-Voluson-730-Expert-2.jpg', '2017-11-20 20:31:58', '2017-11-20 20:31:58', 1),
(118, 'Dash 2000', 1, 2, 'image-1511206931-tnw800-64-GE_Marquette_Dash_2000-6.jpg', '2017-11-20 20:42:14', '2017-11-20 20:42:14', 1),
(119, 'Logiq E9', 3, 2, 'image-1511207761-Logiq-E9_011.jpg', '2017-11-20 20:56:03', '2017-11-20 20:56:03', 1),
(120, 'Logiq Book', 3, 2, 'image-1511208098-GE-Logiq-Book-XP.jpg', '2017-11-20 21:01:39', '2017-11-20 21:02:16', 1),
(121, 'Audioscreener', 60, 89, 'image-1511208860-gsi-audioscreener-accessories-2.png', '2017-11-20 21:14:22', '2017-11-20 21:14:22', 1),
(122, 'HYC-260', 6, 90, 'image-1511209357-haier.jpg', '2017-11-20 21:22:38', '2017-11-20 21:22:38', 1),
(123, 'HYC-1378', 6, 90, 'image-1511209618-hyc1378.png', '2017-11-20 21:27:00', '2017-11-20 21:27:00', 1),
(124, 'Hamilton-C1', 2, 38, 'image-1511209865-C1_360deg Rotation_0000.jpg', '2017-11-20 21:31:06', '2017-11-20 21:31:06', 1),
(125, 'Quickthaw', 61, 37, 'image-1511210150-11094-8617.jpg', '2017-11-20 21:35:51', '2017-11-20 21:35:51', 1),
(126, 'DT1', 62, 37, 'image-1511210284-dt1.jpg', '2017-11-20 21:38:06', '2017-11-20 21:38:06', 1),
(127, 'Ultraview SL', 1, 54, 'image-1511267355-spacelabs-sl2200.jpg', '2017-11-21 13:28:53', '2017-11-21 13:29:16', 1),
(128, '3100B', 2, 91, 'image-1511267599-3100b.png', '2017-11-21 13:33:20', '2017-11-21 13:33:20', 1),
(129, 'Vela', 2, 25, 'image-1511268274-size.jpg', '2017-11-21 13:44:36', '2017-11-21 13:44:36', 1),
(130, 'Mobil-O-Graph', 63, 92, 'image-1511268709-mobilOGraphNew.jpg', '2017-11-21 13:51:50', '2017-11-21 13:51:50', 1),
(131, 'SP2/3', 7, 39, 'image-1511271778-sp2.png', '2017-11-21 14:43:00', '2017-11-21 14:43:00', 1),
(132, 'AV-S', 2, 93, 'image-1511272049-avs.JPG', '2017-11-21 14:47:30', '2017-11-21 15:00:16', 1),
(133, 'A200SP', 66, 93, 'image-1511272986-penlon_a200sp_lg.jpg', '2017-11-21 15:02:56', '2017-11-21 15:03:07', 1),
(134, 'Star 50', 1, 39, 'image-1511277825-845051.jpg', '2017-11-21 16:23:47', '2017-11-21 16:23:47', 1),
(135, 'Camino MPM-1', 35, 78, 'image-1511355771-1244863.jpg', '2017-11-22 14:02:54', '2017-11-22 14:02:54', 1),
(136, 'Intelect 27455', 67, 94, 'image-1511365737-id_2765cs_angle_24.jpg', '2017-11-22 16:48:59', '2017-11-22 16:48:59', 1),
(137, 'Otoread', 68, 40, 'image-1511439779-70798-166451.jpg', '2017-11-23 13:23:01', '2017-11-23 13:23:01', 1),
(138, 'VRA201', 69, 40, 'image-1511550794-VRA201.png', '2017-11-24 20:13:16', '2017-11-24 20:13:16', 1),
(139, 'Titan', 70, 40, 'image-1511550916-titan.png', '2017-11-24 20:15:18', '2017-11-24 20:15:18', 1),
(140, 'AA220', 71, 40, 'image-1511551228-mp_img_208736.jpg', '2017-11-24 20:20:29', '2017-11-24 20:20:29', 1),
(141, 'AA222', 71, 40, 'image-1511551304-70798-166239.jpg', '2017-11-24 20:21:45', '2017-11-24 20:21:45', 1),
(142, 'AC33', 72, 40, 'image-1511551486-1306210.jpg', '2017-11-24 20:24:47', '2017-11-24 20:24:47', 1),
(143, 'AD226', 73, 40, 'image-1511551607-ad226.png', '2017-11-24 20:26:49', '2017-11-24 20:26:49', 1),
(144, 'AD229b', 73, 40, 'image-1511551680-interacoustics-ad229b.jpg', '2017-11-24 20:28:01', '2017-11-24 20:28:01', 1),
(145, 'AD229e', 73, 40, 'image-1511551734-1508428.jpg', '2017-11-24 20:28:55', '2017-11-24 20:28:55', 1),
(146, 'AT235', 70, 40, 'image-1511551925-interacoustics-at235-2015.png', '2017-11-24 20:32:06', '2017-11-24 20:32:06', 1),
(147, 'AT235h', 70, 40, 'image-1511551986-interacoustics-at235-2015.png', '2017-11-24 20:33:07', '2017-11-24 20:33:07', 1),
(148, 'MT10', 74, 40, 'image-1511552591-interacoustics-mt10.png', '2017-11-24 20:43:13', '2017-11-24 20:43:13', 1),
(149, 'AC40', 72, 40, 'image-1511552685-ac40.jpg', '2017-11-24 20:44:46', '2017-11-24 20:44:46', 1),
(150, 'AS216', 73, 40, 'image-1511552799-113553.jpeg', '2017-11-24 20:46:40', '2017-11-24 20:46:40', 1),
(151, 'AT235/AT235h', 70, 40, 'image-1511552975-interacoustics-at235-2015.png', '2017-11-24 20:47:43', '2017-11-24 20:49:37', 0),
(152, 'PA5', 75, 40, 'image-1511553095-pa5.jpg', '2017-11-24 20:51:36', '2017-11-24 20:51:36', 1),
(153, 'Nydiag200', 76, 40, 'image-1511553211-InteracousticsNydiag200_01.jpg', '2017-11-24 20:53:34', '2017-11-24 20:53:34', 1),
(154, 'TBS25', 77, 40, 'image-1511553273-interacoustics-tbs25.png', '2017-11-24 20:54:34', '2017-11-24 20:54:34', 1),
(155, 'VF405', 78, 40, 'image-1511553393-70798-8970638.jpg', '2017-11-24 20:56:34', '2017-11-24 20:56:34', 1),
(156, 'AS608/AS608e', 73, 40, 'image-1511785576-InteracousticsAudiometreAS608_01.jpg', '2017-11-27 13:26:18', '2017-11-27 13:26:18', 1),
(157, 'AS208', 73, 40, 'image-1511786538-as208.mth8293_200_200.jpg', '2017-11-27 13:42:20', '2017-11-27 13:42:20', 1),
(158, 'AZ26', 70, 40, 'image-1511786940-AZ26.jpg', '2017-11-27 13:49:01', '2017-11-27 13:49:01', 1),
(159, 'VO25', 78, 40, 'image-1511789995-1628-1987-m.jpg', '2017-11-27 14:39:57', '2017-11-27 14:39:57', 1),
(160, 'AD28', 73, 40, 'image-1511959554-ad-28.jpg', '2017-11-29 13:45:56', '2017-11-29 13:45:56', 1),
(161, 'Oculight SLx', 79, 95, 'image-1514293034-i41002l_448x398.jpg', '2017-12-26 13:57:15', '2017-12-26 13:57:15', 1),
(162, 'Calcusplit', 80, 11, 'image-1514293778-442.jpg', '2017-12-26 14:09:39', '2017-12-26 14:09:39', 1),
(163, 'Led Nova 100 twin', 57, 11, 'image-1514293937-storz-led-nova-twin-100.png', '2017-12-26 14:12:19', '2017-12-26 14:12:19', 1),
(164, 'Kangaroo ePump', 81, 96, 'image-1514294265-Kangaroo-ePump-Enteral-Feeding-Pump-560273-MEDIUM_IMAGE.jpg', '2017-12-26 14:17:46', '2017-12-26 14:17:46', 1),
(165, 'Logic', 82, 97, 'image-1514303973-41zYOHgYyZL._SX342_.jpg', '2017-12-26 16:59:34', '2017-12-26 16:59:34', 1),
(166, 'Logic+', 82, 97, 'image-1514304580-logic_plus_a2_w_stand_cob_layered.png', '2017-12-26 17:09:41', '2017-12-26 17:09:41', 1),
(167, 'Puricare', 82, 97, 'image-1514305312-F308091_p.eps-650.jpg', '2017-12-26 17:21:53', '2017-12-26 17:21:53', 1),
(168, 'marLED E9 / E9i / E15', 83, 20, 'image-1514315075-OP_Leuchten_800x400_02.jpg', '2017-12-26 20:04:36', '2017-12-26 20:04:36', 1),
(169, 'ML502x / ML702hx', 83, 20, 'image-1514315364-xml-702.mth17601_200_200.jpg.pagespeed.ic.kh-ZZ_PEt2.jpg', '2017-12-26 20:09:25', '2017-12-26 20:09:25', 1),
(170, 'Mac EMS', 84, 99, 'image-1514316198-mcgrath mac ems.jpg', '2017-12-26 20:23:19', '2017-12-26 20:23:19', 1),
(171, 'Betastar', 85, 44, 'image-1514316502-betastar-primary.jpg', '2017-12-26 20:28:23', '2017-12-26 20:28:23', 1),
(172, 'Affinity II', 86, 100, 'image-1514317253-affinityii.jpg', '2017-12-26 20:40:54', '2017-12-26 20:40:54', 1),
(173, 'Centra', 87, 100, 'image-1514317604-hill-rom_centra_1060_lg.jpg', '2017-12-26 20:46:45', '2017-12-26 20:46:45', 1),
(174, 'Century CC', 87, 100, 'image-1514317650-hill-rom_895_century_cc_lg.jpg', '2017-12-26 20:47:31', '2017-12-26 20:47:31', 1),
(175, 'Vivo 30/40', 88, 101, 'image-1515070006-vivo30.jpg', '2018-01-04 13:46:47', '2018-01-04 13:46:47', 1),
(176, 'Axiostar Plus', 8, 59, 'image-1515073089-axiomatplus.jpg', '2018-01-04 14:38:10', '2018-01-04 14:38:10', 1),
(177, 'Servo-I', 2, 44, 'image-1515170632-Maquet_Servo_I_Ventilator__45431.1476389208.jpg', '2018-01-05 17:43:54', '2018-01-05 17:43:54', 1),
(178, 'Radical 7', 59, 12, 'image-1515674682-radical-7.png', '2018-01-11 13:44:43', '2018-01-11 13:44:43', 1),
(179, 'Dominant 50', 89, 10, 'image-1515675508-dominant.jpg', '2018-01-11 13:58:30', '2018-01-11 13:58:30', 1),
(180, 'PC305', 45, 46, 'image-1515676141-medix.jpg', '2018-01-11 14:01:37', '2018-01-11 14:09:02', 1),
(181, 'SM401', 45, 46, 'image-1515676116-MEDIX SM-401.jpg', '2018-01-11 14:08:38', '2018-01-11 14:08:38', 1),
(182, 'MEC-1200', 1, 3, 'image-1515676582-MEC-1200-500x500.gif', '2018-01-11 14:16:23', '2018-01-11 14:16:23', 1),
(183, 'Beneheart D6', 5, 3, 'image-1515676731-d6.jpg', '2018-01-11 14:18:52', '2018-01-11 14:18:52', 1),
(184, 'Accuttor Plus', 4, 102, 'image-1515676920-mo-d-aplus.jpg', '2018-01-11 14:22:01', '2018-01-11 14:22:01', 1),
(185, 'M3A', 4, 103, 'image-1515677279-edan.jpg', '2018-01-11 14:28:01', '2018-01-11 14:28:01', 1),
(186, 'Veris', 1, 104, 'image-1515677415-Veris_main.jpg', '2018-01-11 14:30:16', '2018-01-11 14:30:16', 1),
(187, 'ELI250/ELI250c', 18, 17, 'image-1515677955-tnw800-336- Mortara ELI 250_7.jpg', '2018-01-11 14:39:17', '2018-01-11 14:39:17', 1),
(188, 'ELI10', 18, 17, 'image-1516103798-Mortara-ELI-10-EKG.jpg', '2018-01-16 12:56:39', '2018-01-16 12:56:39', 1),
(189, 'Ambulo 2400', 63, 17, 'image-1516104604-ambulo.jpg', '2018-01-16 13:10:05', '2018-01-16 13:10:05', 1),
(190, 'H3+', 64, 17, 'image-1516104860-h3+.jpg', '2018-01-16 13:14:22', '2018-01-16 13:14:22', 1),
(191, 'X-Scribe', 90, 17, 'image-1516106301-12312.jpeg', '2018-01-16 13:38:22', '2018-01-16 13:38:22', 1),
(192, 'N-395', 59, 49, 'image-1516111411-MO-N-395.JPG', '2018-01-16 15:03:32', '2018-01-16 15:03:32', 1),
(193, 'HT70', 47, 105, 'image-1516111730-ht70.jpg', '2018-01-16 15:08:51', '2018-01-16 15:08:51', 1),
(194, 'BSM-2300K Lifescope i-L', 1, 13, 'image-1516112114-lifescopei.jpg', '2018-01-16 15:15:15', '2018-01-16 15:15:15', 1),
(195, 'BSM-5100K Lifescope-A', 1, 13, 'image-1516112735-5100k.png', '2018-01-16 15:25:36', '2018-01-16 15:25:36', 1),
(196, 'PVM-2700 Vismo', 1, 13, 'image-1516114518-vismo.jpg', '2018-01-16 15:55:19', '2018-01-16 15:55:19', 1),
(197, 'BSM-3000 Lifescope-VS', 1, 13, 'image-1516131635-BSM-3000_6.png', '2018-01-16 20:40:36', '2018-01-16 20:40:36', 1),
(198, 'QG500', 91, 106, 'image-1516192087-quantum.jpg', '2018-01-17 13:28:08', '2018-01-17 13:28:08', 1),
(199, 'Cardiofax ECG-9620', 18, 13, 'image-1516201470-9620.jpg', '2018-01-17 16:04:31', '2018-01-17 16:05:39', 1),
(200, 'BSM-6000K Lifescope TR', 1, 13, 'image-1516206703-6000.jpg', '2018-01-17 17:31:44', '2018-01-17 17:33:18', 1),
(201, 'TEC-7600K / TEC-7700K', 5, 13, 'image-1516208140-tec7700.jpeg', '2018-01-17 17:55:41', '2018-01-17 17:55:41', 1),
(202, 'EEG-9100 / EEG-9200', 34, 13, 'image-1516214945-eeg9200.jpg', '2018-01-17 19:49:06', '2018-01-17 19:49:06', 1),
(203, 'CNS-9700', 92, 13, 'image-1516215343-remotemonitoring.jpg', '2018-01-17 19:55:45', '2018-01-17 19:55:45', 1),
(204, '2500', 59, 50, 'image-1516217448-2500.jpg', '2018-01-17 20:30:49', '2018-01-17 20:30:49', 1),
(205, 'Onix Vantage 9590', 42, 50, 'image-1516217790-Nonin_9590.jpg', '2018-01-17 20:36:32', '2018-01-17 20:36:32', 1),
(206, 'Pace 101H', 93, 107, 'image-1516218261-PACE101.png', '2018-01-17 20:44:22', '2018-01-17 20:44:22', 1),
(207, 'HD15', 3, 5, 'image-1516218833-hd15.jpg', '2018-01-17 20:53:54', '2018-01-17 20:53:54', 1),
(208, 'Trilogy', 47, 5, 'image-1516275981-trilogy.jpg', '2018-01-18 12:46:22', '2018-01-18 12:46:22', 1),
(209, 'Epiq 5 / Epiq 7', 3, 5, 'image-1516278514-epiq5.jpg', '2018-01-18 13:27:45', '2018-01-18 13:28:35', 1),
(210, 'Suresigns VS3', 4, 5, 'image-1516279214-vs3.jpg', '2018-01-18 13:40:15', '2018-01-18 13:40:15', 1),
(211, 'Suresigns VM', 1, 5, 'image-1516290831-Vm.jpg', '2018-01-18 16:53:52', '2018-01-18 16:53:52', 1),
(212, 'PageWriter Trim II', 18, 5, 'image-1516299320-trim.jpg', '2018-01-18 19:14:14', '2018-01-18 19:15:21', 1),
(213, 'Physiotherm', 94, 108, 'image-1516299643-PHYSITHERM-S.jpg', '2018-01-18 19:20:44', '2018-01-18 19:20:44', 1),
(214, 'REF100', 6, 15, 'image-1507592634-default.jpg', '2018-01-18 19:29:40', '2018-01-18 19:29:40', 1),
(215, 'Lifepak 20', 5, 47, 'image-1516997409-lp20.jpg', '2018-01-26 16:16:00', '2018-01-26 21:10:10', 1),
(216, 'Lucea', 83, 44, 'image-1516998745-lucea-50-100-df-double-fork-primary.jpg', '2018-01-26 21:32:26', '2018-01-26 21:32:26', 1),
(217, '215M', 95, 109, 'image-1518036776-215.jpg', '2018-02-07 21:52:57', '2018-02-07 21:52:57', 1),
(218, '7100', 96, 60, 'image-1520352310-7100.jpg', '2018-03-06 17:05:11', '2018-03-06 17:05:11', 1),
(219, 'Serie M', 5, 16, 'image-1520352782-Zoll-M.jpg', '2018-03-06 17:13:03', '2018-03-06 17:13:03', 1),
(220, 'Bipap Vision', 97, 63, 'image-1520353529-bipap vision.jpg', '2018-03-06 17:25:30', '2018-03-06 17:25:30', 1);

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
(1, 1, '2017-10-15 22:49:21', '2017-10-15 22:49:21', 1),
(14, 2, '2017-10-24 18:59:51', '2017-10-24 18:59:51', 1),
(24, 3, '2017-10-24 19:00:50', '2017-10-24 19:00:50', 1);

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
(3, 'Protocolo Mantenimiento', 'protocolo-1507919028-PROTOCOLO DE MANTENIMIENTO_ARCO_C (1).docx', 6, '2017-10-13 20:23:16', '2017-10-13 20:23:51', 1),
(4, 'Protocolo Mantenimiento Acreditación', 'protocolo-1510949184-Protocolo Interno Monitor.xlsx', 24, '2017-11-17 21:06:24', '2017-11-17 21:06:24', 1),
(5, 'Protocolo Mantenimiento Acreditación', 'protocolo-1510949184-Protocolo Interno Monitor.xlsx', 4, '2017-11-17 21:06:26', '2017-11-17 21:06:26', 1),
(6, 'Protocolo Mantenimiento Hospital', 'protocolo-1510949401-Monitor Multiparametro.doc', 24, '2017-11-17 21:09:00', '2017-11-17 21:10:02', 1),
(7, 'Protocolo Mantenimiento Hospital', 'protocolo-1510949390-Monitor Multiparametro.doc', 4, '2017-11-17 21:09:01', '2017-11-17 21:09:51', 1),
(8, 'Protocolo MP', 'protocolo-1510949494-PROTOCOLO_ENDOSCOPIO.docx', 101, '2017-11-17 21:11:34', '2017-11-17 21:11:34', 1),
(9, 'Protocolo MP', 'protocolo-1510949494-PROTOCOLO_ENDOSCOPIO.docx', 100, '2017-11-17 21:11:35', '2017-11-17 21:11:35', 1),
(10, 'Protocolo MP', 'protocolo-1510949494-PROTOCOLO_ENDOSCOPIO.docx', 102, '2017-11-17 21:11:35', '2017-11-17 21:11:35', 1),
(11, 'Protocolo MP', 'protocolo-1510949494-PROTOCOLO_ENDOSCOPIO.docx', 99, '2017-11-17 21:11:36', '2017-11-17 21:11:36', 1),
(12, 'Protocolo Mantenimiento', 'protocolo-1513022303-PROTOCOLO_TITAN.docx', 139, '2017-12-11 20:58:24', '2017-12-11 20:58:24', 1),
(13, 'Protocolo Mant. Preventivo', 'protocolo-1515070310-PROTOCOLO_VENTILADOR.docx', 175, '2018-01-04 13:51:51', '2018-01-04 13:51:51', 1);

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
(1, 'Sensor oxígeno - Drager', '6850645', 'Sensor oxígeno, para máquina de anestesia', 'repuesto-1508154948-MT-423-2002.jpg', '2017-10-13 16:54:46', '2017-10-16 13:55:50', 1),
(2, 'Pila BR2335', 'BR2335', 'Pila de 3V, redonda.', 'repuesto-1508790066-BR2335.jpg', '2017-10-24 18:56:57', '2017-10-24 18:56:57', 1),
(3, 'Pila CR2450N', 'CR2450N', 'Pila de 3V, redonda, con sección más angosta que la otra', 'repuesto-1508781725-CR2450N.jpg', '2017-10-24 18:59:06', '2017-10-24 18:59:06', 1);

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
(9, 'RX Portátil', '2017-10-13 20:20:27', '2017-10-13 20:20:27', 1),
(10, 'Impresora RX', '2017-10-24 16:24:41', '2017-10-24 16:24:41', 1),
(11, 'Facovitrector', '2017-10-24 16:30:31', '2017-10-24 16:30:31', 1),
(12, 'Facoemulsificador', '2017-10-24 16:30:41', '2017-10-24 16:30:41', 1),
(13, 'Electrobisturí', '2017-10-24 16:31:14', '2017-10-24 16:31:14', 1),
(14, 'Bomba Jeringa', '2017-10-24 16:31:22', '2017-10-24 16:31:22', 1),
(15, 'Polismoniógrafo', '2017-10-24 16:31:39', '2017-10-24 16:31:39', 1),
(16, 'Piernera', '2017-10-24 16:31:45', '2017-10-24 16:31:45', 1),
(17, 'Ecógrafo ocular', '2017-10-24 16:32:01', '2017-10-24 16:32:01', 1),
(18, 'Electrocardiógrafo', '2017-10-24 16:38:29', '2017-10-24 16:38:29', 1),
(19, 'Analizador de Oxígeno', '2017-10-24 22:43:48', '2017-10-24 22:43:48', 1),
(20, 'Arco C RX', '2017-10-24 22:53:10', '2017-10-24 22:53:10', 1),
(21, 'Impresora Térmica', '2017-10-30 14:49:58', '2017-10-30 14:49:58', 1),
(22, 'Calentador de Paciente', '2017-10-30 14:58:16', '2017-10-30 14:58:16', 1),
(23, 'Balanza Mecánica', '2017-10-30 15:15:15', '2017-10-30 15:15:15', 1),
(24, 'Balanza eléctrónica digital', '2017-10-30 15:15:33', '2017-10-30 15:15:33', 1),
(25, 'Balanza Mecánica Pediátrica ', '2017-10-30 15:17:43', '2017-10-30 15:17:43', 1),
(26, 'Balanza Digital Pediátrica ', '2017-10-30 15:17:56', '2017-10-30 15:17:56', 1),
(27, 'Máquina Diálisis', '2017-10-30 15:39:38', '2017-10-30 15:39:38', 1),
(28, 'Bomba de infusión volumétrica', '2017-10-30 15:52:37', '2017-10-30 15:52:37', 1),
(29, 'Capnógrafo', '2017-10-30 16:00:00', '2017-10-30 16:00:00', 1),
(30, 'Fototerapia', '2017-10-30 17:05:52', '2017-10-30 17:05:52', 1),
(31, 'Monitor BIS', '2017-10-30 17:17:59', '2017-10-30 17:17:59', 1),
(32, 'Sistema de Hiper/Hipotermia', '2017-10-30 17:26:48', '2017-10-30 17:26:48', 1),
(33, 'Unidad lipoaspiración', '2017-10-30 18:01:41', '2017-10-30 18:01:41', 1),
(34, 'Electroencefalógrafo', '2017-10-30 20:59:24', '2017-10-30 20:59:24', 1),
(35, 'Monitor intracraneal', '2017-10-30 21:27:58', '2017-10-30 21:27:58', 1),
(36, 'Fibroscopio', '2017-10-30 21:35:32', '2017-10-30 21:35:32', 1),
(37, 'Panendoscopio', '2017-10-30 21:35:43', '2017-10-30 21:35:43', 1),
(38, 'Colonoscopio', '2017-10-30 21:35:51', '2017-10-30 21:35:51', 1),
(39, 'Videopanendoscopio', '2017-10-30 21:36:07', '2017-10-30 21:36:07', 1),
(40, 'Videocolonoscopio', '2017-10-30 21:36:19', '2017-10-30 21:36:19', 1),
(41, 'Etiquetadora de CDs', '2017-11-02 20:07:55', '2017-11-02 20:07:55', 1),
(42, 'Saturómetro portátil', '2017-11-02 20:55:41', '2017-11-02 20:55:41', 1),
(43, 'Reveladora de placas CR', '2017-11-02 21:13:02', '2017-11-02 21:13:02', 1),
(44, 'Cuna radiante', '2017-11-09 17:12:51', '2017-11-09 17:12:51', 1),
(45, 'Incubadora', '2017-11-09 21:11:40', '2017-11-09 21:11:40', 1),
(46, 'Incubadora de transporte', '2017-11-09 21:25:37', '2017-11-09 21:25:37', 1),
(47, 'Ventilador de transporte', '2017-11-10 19:58:19', '2017-11-10 19:58:19', 1),
(48, 'Tens', '2017-11-13 21:32:42', '2017-11-13 21:32:42', 1),
(49, 'Equipo de función pulmonar', '2017-11-13 21:36:43', '2017-11-13 21:36:43', 1),
(50, 'Generador de armónicos', '2017-11-14 13:19:03', '2017-11-14 13:19:03', 1),
(51, 'Calefactor radiante neonatal', '2017-11-14 13:30:13', '2017-11-14 13:30:13', 1),
(52, 'Reanimador neonatal', '2017-11-14 13:36:14', '2017-11-14 13:36:14', 1),
(53, 'Balanza neonatal', '2017-11-14 13:45:33', '2017-11-14 13:45:33', 1),
(54, 'Analizador de Seguridad Eléctrica', '2017-11-14 14:01:45', '2017-11-14 14:01:45', 1),
(55, 'Multímetro', '2017-11-14 15:13:17', '2017-11-14 15:13:17', 1),
(56, 'Procesador de Video', '2017-11-14 15:29:16', '2017-11-14 15:29:16', 1),
(57, 'Fuente de luz', '2017-11-14 15:33:06', '2017-11-14 15:33:06', 1),
(58, 'Densitómetro', '2017-11-20 16:53:39', '2017-11-20 16:53:39', 1),
(59, 'Oxímetro de pulso', '2017-11-20 19:23:57', '2017-11-20 19:23:57', 1),
(60, 'Equipo tamizaje auditivo neonatal', '2017-11-20 21:12:59', '2017-11-20 21:12:59', 1),
(61, 'Descongelador de plasma', '2017-11-20 21:34:01', '2017-11-20 21:34:01', 1),
(62, 'Termómetro digital', '2017-11-20 21:37:34', '2017-11-20 21:37:34', 1),
(63, 'Holter presión arterial', '2017-11-21 13:47:42', '2017-11-21 13:47:42', 1),
(64, 'Holter arritmia', '2017-11-21 13:47:53', '2017-11-21 13:47:53', 1),
(65, 'Monitor anestesia', '2017-11-21 14:46:57', '2017-11-21 14:46:57', 1),
(66, 'Absorbedor Anestesia', '2017-11-21 15:02:29', '2017-11-21 15:02:29', 1),
(67, 'Sistema de terapia', '2017-11-22 16:46:48', '2017-11-22 16:46:48', 1),
(68, 'Sistema medición acústica', '2017-11-23 13:22:18', '2017-11-23 13:22:18', 1),
(69, 'Reforzamiento visual para audiometría', '2017-11-24 20:11:53', '2017-11-24 20:11:53', 1),
(70, 'Audiómetro de Impedancia', '2017-11-24 20:14:39', '2017-11-24 20:14:39', 1),
(71, 'Viajero de audio', '2017-11-24 20:18:14', '2017-11-24 20:18:14', 1),
(72, 'Audiómetro clínico', '2017-11-24 20:23:49', '2017-11-24 20:23:49', 1),
(73, 'Audiómetro de diagnóstico', '2017-11-24 20:25:37', '2017-11-24 20:25:37', 1),
(74, 'Impedanciómetro', '2017-11-24 20:42:37', '2017-11-24 20:42:37', 1),
(75, 'Audiómetro pediátrico', '2017-11-24 20:51:08', '2017-11-24 20:51:08', 1),
(76, 'Silla rotatoria', '2017-11-24 20:53:01', '2017-11-24 20:53:01', 1),
(77, 'Cámara de prueba', '2017-11-24 20:54:00', '2017-11-24 20:54:00', 1),
(78, 'Sistema de videonistagmografía', '2017-11-24 20:55:49', '2017-11-24 20:55:49', 1),
(79, 'Láser diodo', '2017-12-26 13:56:30', '2017-12-26 13:56:30', 1),
(80, 'Sistema litotripsia', '2017-12-26 14:07:51', '2017-12-26 14:07:51', 1),
(81, 'Bomba nutrición enteral', '2017-12-26 14:16:45', '2017-12-26 14:16:45', 1),
(82, 'Cámara de bioseguridad', '2017-12-26 15:08:41', '2017-12-26 15:08:41', 1),
(83, 'Lámpara quirúrgica', '2017-12-26 19:37:57', '2017-12-26 19:37:57', 1),
(84, 'Videolaringoscopio', '2017-12-26 20:20:24', '2017-12-26 20:20:24', 1),
(85, 'Mesa quirúrgica', '2017-12-26 20:26:58', '2017-12-26 20:26:58', 1),
(86, 'Cama de parto', '2017-12-26 20:39:44', '2017-12-26 20:39:44', 1),
(87, 'Cama clínica', '2017-12-26 20:45:59', '2017-12-26 20:45:59', 1),
(88, 'Ventilador CPAP', '2018-01-04 13:45:49', '2018-01-04 13:45:49', 1),
(89, 'Aspirador quirúrgico de secreciones', '2018-01-11 13:58:00', '2018-01-11 13:58:00', 1),
(90, 'Test de esfuerzo', '2018-01-16 13:37:52', '2018-01-16 13:37:52', 1),
(91, 'Equipo RX', '2018-01-17 13:27:35', '2018-01-17 13:27:35', 1),
(92, 'Central de monitoreo', '2018-01-17 19:52:51', '2018-01-17 19:52:51', 1),
(93, 'Marcapasos portátil', '2018-01-17 20:42:48', '2018-01-17 20:42:48', 1),
(94, 'Equipo de terapia onda corta', '2018-01-18 19:19:19', '2018-01-18 19:19:19', 1),
(95, 'Simulador de EKG', '2018-02-07 21:52:18', '2018-02-07 21:52:18', 1),
(96, 'Ventilador anestesia', '2018-03-06 17:03:44', '2018-03-06 17:03:44', 1),
(97, 'Ventilador Bipap', '2018-03-06 17:24:41', '2018-03-06 17:24:41', 1);

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
(2, 'Método solucionar error 008', 'Procedimiento en archivo adjunto', 'apuntes-1507896374-Error 0008.txt', 3, '2017-10-13 00:58:09', '2017-10-13 14:06:17', 1),
(3, 'Cambio Pila CPU SRAM', 'Se requiere cambiar cada 5 años, la pila de CPU SRAM, modelo BR2335, de 3V, ubicada en el interior del equipo', '', 14, '2017-10-24 18:56:10', '2017-10-24 18:56:10', 1),
(4, 'Simulador de equipo online', 'En el siguiente enlace, es posible acceder al simulador del equipo, desde la página oficial de Drager', 'apuntes-1510255990-simulador drager gs.docx', 1, '2017-11-09 20:28:48', '2017-11-09 20:33:11', 1),
(5, 'Entrenamiento en video', 'Videos de entrenamiento acerca del equipo. Se debe seguir las instrucciones del documento.', 'apuntes-1510345783-Entrenamiento Fabius GS en Video.docx', 1, '2017-11-10 21:28:09', '2017-11-10 21:29:43', 1),
(6, 'Restauración de disco duro', 'El enlace entrega el procedimiento para restaurar el disco duro, en caso que el equipo no arranque o presente pantallas de error al inicio. \nTambién cuenta con enlace para descarga el disco de restauración, en caso que no se cuente con él.', 'apuntes-1510601473-Restauracion_disco_duro_Logiq_E.docx', 81, '2017-11-13 20:28:24', '2017-11-13 20:31:14', 1),
(7, 'Teoría de funcionamiento Electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510603749-electrobisturies.pdf', 54, '2017-11-13 21:08:31', '2017-11-13 21:09:10', 1),
(8, 'Teoría de funcionamiento Electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510603794-electrobisturies.pdf', 85, '2017-11-13 21:09:55', '2017-11-13 21:09:55', 1),
(9, 'Teoría de funcionamiento electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510603824-electrobisturies.pdf', 55, '2017-11-13 21:10:25', '2017-11-13 21:10:25', 1),
(10, 'Teoría de funcionamiento Electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510603855-electrobisturies.pdf', 18, '2017-11-13 21:10:56', '2017-11-13 21:10:56', 1),
(11, 'Teoría de funcionamiento Electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510604943-electrobisturies.pdf', 87, '2017-11-13 21:11:21', '2017-11-13 21:29:04', 1),
(12, 'Teoría de funcionamiento Electrobisturí', 'El presente documento pretende explicar la teoría de funcionamiento de un equipo de electrocirugía.', 'apuntes-1510604976-electrobisturies.pdf', 84, '2017-11-13 21:29:37', '2017-11-13 21:29:37', 1),
(13, 'Videos de entrenamiento', 'El enlace contiene el acceso a algunos videos acerca del uso del equipo.', 'apuntes-1510606044-EntrenamientoNDD.docx', 89, '2017-11-13 21:47:25', '2017-11-13 21:47:25', 1),
(14, 'Apuntes Seguridad Eléctrica', 'Resumen de teoría de seguridad eléctrica', 'apuntes-1510664851-segelec.pdf', 94, '2017-11-14 14:05:18', '2017-11-14 14:07:32', 1),
(15, 'Norma Chilena Equipos Electromédicos', 'Norma NCh2893/1-2004, que establece la homologación de la norma internacional IEC-60601-1, que regula las características de los equipos electromédicos.', 'apuntes-1510665252-NCh2893-1-2004.pdf', 94, '2017-11-14 14:14:14', '2017-11-14 14:14:14', 1),
(16, 'Instalación Software Ansur y plugin ESA612', 'Procedimiento y enlaces de descarga de aplicación Ansur y del plugin para conectar el equipo.', 'apuntes-1510666754-Datosansuresa612.docx', 94, '2017-11-14 14:39:15', '2017-11-14 14:39:15', 1),
(17, 'Fundamentos de Endoscopía', 'Teoría y fundamentos de los equipos de endoscopía', 'apuntes-1510674883-fundamentos.pdf', 99, '2017-11-14 16:54:45', '2017-11-14 16:54:45', 1),
(18, 'Fundamentos de Endoscopía', 'Teoría y fundamentos de los equipos de endoscopía', 'apuntes-1510674929-fundamentos.pdf', 100, '2017-11-14 16:55:30', '2017-11-14 16:55:30', 1),
(19, 'Fundamentos de Endoscopía', 'Teoría y fundamentos de los equipos de endoscopía.', 'apuntes-1510674984-fundamentos.pdf', 101, '2017-11-14 16:56:25', '2017-11-14 16:56:25', 1),
(20, 'Fundamentos de Endoscopía', 'Teoría y fundamentos de los equipos de endoscopía.', 'apuntes-1510675005-fundamentos.pdf', 102, '2017-11-14 16:56:46', '2017-11-14 16:56:46', 1),
(21, 'Lavado y desinfección', 'Instructivo acerca de los procedimientos de lavado y desinfección de los equipos de endoscopía', 'apuntes-1511180591-Lavado y desinfeccion.pdf', 100, '2017-11-20 13:23:11', '2017-11-20 13:23:11', 1),
(22, 'Lavado y desinfección', 'Instructivo acerca de los procedimientos de lavado y desinfección de los equipos de endoscopía', 'apuntes-1511180591-Lavado y desinfeccion.pdf', 102, '2017-11-20 13:23:11', '2017-11-20 13:23:11', 1),
(23, 'Lavado y desinfección', 'Instructivo acerca de los procedimientos de lavado y desinfección de los equipos de endoscopía', 'apuntes-1511180591-Lavado y desinfeccion.pdf', 99, '2017-11-20 13:23:11', '2017-11-20 13:23:11', 1),
(24, 'Lavado y desinfección', 'Instructivo acerca de los procedimientos de lavado y desinfección de los equipos de endoscopía', 'apuntes-1511180591-Lavado y desinfeccion.pdf', 101, '2017-11-20 13:23:12', '2017-11-20 13:23:12', 1),
(25, 'Preparación y uso', 'Instrucciones acerca de los pasos necesarios para la preparación de los equipos de endoscopía antes de su uso.', 'apuntes-1511180690-Preparacion y uso.pdf', 100, '2017-11-20 13:24:50', '2017-11-20 13:24:50', 1),
(26, 'Preparación y uso', 'Instrucciones acerca de los pasos necesarios para la preparación de los equipos de endoscopía antes de su uso.', 'apuntes-1511180690-Preparacion y uso.pdf', 101, '2017-11-20 13:24:50', '2017-11-20 13:24:50', 1),
(27, 'Preparación y uso', 'Instrucciones acerca de los pasos necesarios para la preparación de los equipos de endoscopía antes de su uso.', 'apuntes-1511180690-Preparacion y uso.pdf', 102, '2017-11-20 13:24:50', '2017-11-20 13:24:50', 1),
(28, 'Preparación y uso', 'Instrucciones acerca de los pasos necesarios para la preparación de los equipos de endoscopía antes de su uso.', 'apuntes-1511180690-Preparacion y uso.pdf', 99, '2017-11-20 13:24:51', '2017-11-20 13:24:51', 1),
(29, 'Resolución de problemas', 'Apuntes para solución de fallas frecuentes y métodos de reparación de primer nivel.', 'apuntes-1511180770-Resolucion de problemas.pdf', 99, '2017-11-20 13:26:10', '2017-11-20 13:26:10', 1),
(30, 'Resolución de problemas', 'Apuntes para solución de fallas frecuentes y métodos de reparación de primer nivel.', 'apuntes-1511180770-Resolucion de problemas.pdf', 102, '2017-11-20 13:26:10', '2017-11-20 13:26:10', 1),
(31, 'Resolución de problemas', 'Apuntes para solución de fallas frecuentes y métodos de reparación de primer nivel.', 'apuntes-1511180770-Resolucion de problemas.pdf', 100, '2017-11-20 13:26:10', '2017-11-20 13:26:10', 1),
(32, 'Resolución de problemas', 'Apuntes para solución de fallas frecuentes y métodos de reparación de primer nivel.', 'apuntes-1511180770-Resolucion de problemas.pdf', 101, '2017-11-20 13:26:12', '2017-11-20 13:26:12', 1),
(33, 'Estrategias de tratamiento', 'Estrategias para el tratamiento clínico, usando la ventilación de alta frecuencia.', 'apuntes-1511267849-Estrategias de tratamiento.pdf', 128, '2017-11-21 13:37:31', '2017-11-21 13:37:31', 1),
(34, 'Procedimiento de calibración', 'Documento con procedimiento de calibración para este modelo.', 'apuntes-1511272318-VENT. MEC. ANEST. AV-S CALIBRACION.pdf', 132, '2017-11-21 14:52:00', '2017-11-21 14:52:00', 1),
(35, 'Ganancia Talkback', 'Datos técnicos obtenidso de la información del proveedor', 'apuntes-1511898659-0410_Talk_Back_Gain_AA222.pdf', 141, '2017-11-28 20:51:01', '2017-11-28 20:51:01', 1),
(36, 'Falla impresora', 'Procedimiento obtenido del proveedor.', 'apuntes-1511898851-0413_AT235mfl_printer.pdf', 146, '2017-11-28 20:54:11', '2017-11-28 20:54:11', 1),
(37, 'Falla impresora', 'Procedimiento obtenido del proveedor.', 'apuntes-1511898851-0413_AT235mfl_printer.pdf', 140, '2017-11-28 20:54:11', '2017-11-28 20:54:11', 1),
(38, 'Falla impresora', 'Procedimiento obtenido del proveedor.', 'apuntes-1511898851-0413_AT235mfl_printer.pdf', 141, '2017-11-28 20:54:12', '2017-11-28 20:54:12', 1),
(39, 'Impresora', 'Procedimiento de reemplazo de componentes por falla en la impresora.', 'apuntes-1511898985-0507_AT235_AA22x_printer.pdf', 141, '2017-11-28 20:56:25', '2017-11-28 20:56:25', 1),
(40, 'Impresora', 'Procedimiento de reemplazo de componentes por falla en la impresora.', 'apuntes-1511898985-0507_AT235_AA22x_printer.pdf', 140, '2017-11-28 20:56:25', '2017-11-28 20:56:25', 1),
(41, 'Impresora', 'Procedimiento de reemplazo de componentes por falla en la impresora.', 'apuntes-1511898985-0507_AT235_AA22x_printer.pdf', 146, '2017-11-28 20:56:26', '2017-11-28 20:56:26', 1),
(42, 'Instalación en maleta', 'Instalación del equipo en maleta de transporte', 'apuntes-1511899082-0618_ACC25_Case_packing_for_AA222.pdf', 141, '2017-11-28 20:58:03', '2017-11-28 20:58:03', 1),
(43, 'Actualización de bomba', 'Procedimiento para cambio de bomba interna', 'apuntes-1511899162-0708_AT235,AA222 pump versions.pdf', 146, '2017-11-28 20:59:22', '2017-11-28 20:59:22', 1),
(44, 'Actualización de bomba', 'Procedimiento para cambio de bomba interna', 'apuntes-1511899162-0708_AT235,AA222 pump versions.pdf', 147, '2017-11-28 20:59:22', '2017-11-28 20:59:22', 1),
(45, 'Actualización de bomba', 'Procedimiento para cambio de bomba interna', 'apuntes-1511899162-0708_AT235,AA222 pump versions.pdf', 140, '2017-11-28 20:59:23', '2017-11-28 20:59:23', 1),
(46, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 142, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(47, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 141, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(48, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 149, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(49, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 145, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(50, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 144, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(51, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 143, '2017-11-28 21:01:44', '2017-11-28 21:01:44', 1),
(52, 'Ajuste de intensidad', 'Identificación del ajuste de intensidad', 'apuntes-1511899304-0709_Intensity_dial.pdf', 140, '2017-11-28 21:01:46', '2017-11-28 21:01:46', 1),
(53, 'Ajuste del cabezal', 'Ajuste del cabezal de soporte para micrófono y audífonos.', 'apuntes-1511899387-0711_Monitor headset for AA222.pdf', 141, '2017-11-28 21:03:08', '2017-11-28 21:03:08', 1),
(54, 'Falla No enciende o intermitente', 'Procedimiento de reparación en caso de falla en encendido del equipo.', 'apuntes-1511899488-0722_AA22x_AT235_intermittent_no_startup.pdf', 141, '2017-11-28 21:04:49', '2017-11-28 21:04:49', 1),
(55, 'Falla No enciende o intermitente', 'Procedimiento de reparación en caso de falla en encendido del equipo.', 'apuntes-1511899488-0722_AA22x_AT235_intermittent_no_startup.pdf', 146, '2017-11-28 21:04:49', '2017-11-28 21:04:49', 1),
(56, 'Falla No enciende o intermitente', 'Procedimiento de reparación en caso de falla en encendido del equipo.', 'apuntes-1511899488-0722_AA22x_AT235_intermittent_no_startup.pdf', 140, '2017-11-28 21:04:50', '2017-11-28 21:04:50', 1),
(57, 'Pruebas de campo libre', 'Procedimiento de pruebas de campo libre con 115dB', 'apuntes-1511958840-0104-AC40-AC33-AD28-AD229-FF-test-115dB.pdf', 149, '2017-11-29 13:34:00', '2017-11-29 13:34:00', 1),
(58, 'Pruebas de campo libre', 'Procedimiento de pruebas de campo libre con 115dB', 'apuntes-1511958840-0104-AC40-AC33-AD28-AD229-FF-test-115dB.pdf', 144, '2017-11-29 13:34:00', '2017-11-29 13:34:00', 1),
(59, 'Pruebas de campo libre', 'Procedimiento de pruebas de campo libre con 115dB', 'apuntes-1511958840-0104-AC40-AC33-AD28-AD229-FF-test-115dB.pdf', 145, '2017-11-29 13:34:00', '2017-11-29 13:34:00', 1),
(60, 'Pruebas de campo libre', 'Procedimiento de pruebas de campo libre con 115dB', 'apuntes-1511958840-0104-AC40-AC33-AD28-AD229-FF-test-115dB.pdf', 142, '2017-11-29 13:34:02', '2017-11-29 13:34:02', 1),
(61, 'Problema display', 'Procedimiento de reparación al visualizar caracteres perdidos o erróneos en pantalla.', 'apuntes-1511958925-0621_AC33_Display_problem.pdf', 142, '2017-11-29 13:35:26', '2017-11-29 13:35:26', 1),
(62, 'Cómo conseguir 18kHz y 20kHz', 'Procedimiento para obtener estas frecuencias mediante el software interno del equipo.', 'apuntes-1511959164-0207 How to get 18kHz and 20kHz.pdf', 149, '2017-11-29 13:39:26', '2017-11-29 13:39:26', 1),
(63, 'Cambio tarjeta CPU', 'Procedimiento de cambio de tarjeta CPU y conexiones correspondientes.', 'apuntes-1511959315-0607_AC40_CPU_board_change.pdf', 149, '2017-11-29 13:41:56', '2017-11-29 13:41:56', 1),
(64, 'Adaptar pulsador APS3', 'Modificación necesaria en el pulsador, modelo ASP3, para ser usado en el equipo.', 'apuntes-1511959672-0817_AD28_APS3_patient_response.pdf', 160, '2017-11-29 13:47:54', '2017-11-29 13:47:54', 1),
(65, 'Modificación de Fuente de energía', 'Procedimiento de modificación de conexión de cables por cambio de una fuente, modelo EPS512 por una UPS200.', 'apuntes-1511959821-0007-AD229b-e-AD226-AS216-wirecon-by-exc-power.pdf', 145, '2017-11-29 13:50:21', '2017-11-29 13:50:21', 1),
(66, 'Modificación de Fuente de energía', 'Procedimiento de modificación de conexión de cables por cambio de una fuente, modelo EPS512 por una UPS200.', 'apuntes-1511959821-0007-AD229b-e-AD226-AS216-wirecon-by-exc-power.pdf', 150, '2017-11-29 13:50:21', '2017-11-29 13:50:21', 1),
(67, 'Modificación de Fuente de energía', 'Procedimiento de modificación de conexión de cables por cambio de una fuente, modelo EPS512 por una UPS200.', 'apuntes-1511959821-0007-AD229b-e-AD226-AS216-wirecon-by-exc-power.pdf', 143, '2017-11-29 13:50:21', '2017-11-29 13:50:21', 1),
(68, 'Modificación de Fuente de energía', 'Procedimiento de modificación de conexión de cables por cambio de una fuente, modelo EPS512 por una UPS200.', 'apuntes-1511959821-0007-AD229b-e-AD226-AS216-wirecon-by-exc-power.pdf', 144, '2017-11-29 13:50:22', '2017-11-29 13:50:22', 1),
(69, 'Sistemas de campo libre', 'Datos técnicos de compatibilidad de los modelos de amplificadores en relación al modelo de audiómetro.', 'apuntes-1511959933-0010-AD28-AD229-AC33-AC40-FF-system.pdf', 144, '2017-11-29 13:52:13', '2017-11-29 13:52:13', 1),
(70, 'Sistemas de campo libre', 'Datos técnicos de compatibilidad de los modelos de amplificadores en relación al modelo de audiómetro.', 'apuntes-1511959933-0010-AD28-AD229-AC33-AC40-FF-system.pdf', 145, '2017-11-29 13:52:13', '2017-11-29 13:52:13', 1),
(71, 'Sistemas de campo libre', 'Datos técnicos de compatibilidad de los modelos de amplificadores en relación al modelo de audiómetro.', 'apuntes-1511959933-0010-AD28-AD229-AC33-AC40-FF-system.pdf', 142, '2017-11-29 13:52:13', '2017-11-29 13:52:13', 1),
(72, 'Sistemas de campo libre', 'Datos técnicos de compatibilidad de los modelos de amplificadores en relación al modelo de audiómetro.', 'apuntes-1511959933-0010-AD28-AD229-AC33-AC40-FF-system.pdf', 149, '2017-11-29 13:52:13', '2017-11-29 13:52:13', 1),
(73, 'Sistemas de campo libre', 'Datos técnicos de compatibilidad de los modelos de amplificadores en relación al modelo de audiómetro.', 'apuntes-1511959933-0010-AD28-AD229-AC33-AC40-FF-system.pdf', 160, '2017-11-29 13:52:14', '2017-11-29 13:52:14', 1),
(74, 'Problemas con impresoras HP', 'Modificaciones realizadas para instalación de impresoras HP.', 'apuntes-1511960193-0011-AD226-Ad229b-e-MTI10-MTP10-inkJetprint-from-Hewlettpa….pdf', 145, '2017-11-29 13:56:33', '2017-11-29 13:56:33', 1),
(75, 'Problemas con impresoras HP', 'Modificaciones realizadas para instalación de impresoras HP.', 'apuntes-1511960193-0011-AD226-Ad229b-e-MTI10-MTP10-inkJetprint-from-Hewlettpa….pdf', 144, '2017-11-29 13:56:33', '2017-11-29 13:56:33', 1),
(76, 'Problemas con impresoras HP', 'Modificaciones realizadas para instalación de impresoras HP.', 'apuntes-1511960193-0011-AD226-Ad229b-e-MTI10-MTP10-inkJetprint-from-Hewlettpa….pdf', 143, '2017-11-29 13:56:34', '2017-11-29 13:56:34', 1),
(77, 'Convertidor USB UCA29', 'Procedimiento de instalación de drivers para convertidor USB, modelo UCA29.', 'apuntes-1511960306-0309_UCA29_USB_Converter.pdf', 145, '2017-11-29 13:58:26', '2017-11-29 13:58:26', 1),
(78, 'Convertidor USB UCA29', 'Procedimiento de instalación de drivers para convertidor USB, modelo UCA29.', 'apuntes-1511960306-0309_UCA29_USB_Converter.pdf', 144, '2017-11-29 13:58:26', '2017-11-29 13:58:26', 1),
(79, 'Convertidor USB UCA29', 'Procedimiento de instalación de drivers para convertidor USB, modelo UCA29.', 'apuntes-1511960306-0309_UCA29_USB_Converter.pdf', 149, '2017-11-29 13:58:26', '2017-11-29 13:58:26', 1),
(80, 'Convertidor USB UCA29', 'Procedimiento de instalación de drivers para convertidor USB, modelo UCA29.', 'apuntes-1511960306-0309_UCA29_USB_Converter.pdf', 143, '2017-11-29 13:58:28', '2017-11-29 13:58:28', 1),
(81, 'Circuito de entrada de voz', 'Problema del circuito de entrada de voz al usar un reproductor de CD ', 'apuntes-1511960452-0402_T9_AD229_SpeechInput.pdf', 145, '2017-11-29 14:00:53', '2017-11-29 14:00:53', 1),
(82, 'Circuito de entrada de voz', 'Problema del circuito de entrada de voz al usar un reproductor de CD ', 'apuntes-1511960452-0402_T9_AD229_SpeechInput.pdf', 144, '2017-11-29 14:00:54', '2017-11-29 14:00:54', 1),
(83, 'Falla de pantalla', 'Procedimiento de reparación de pantalla por falla.', 'apuntes-1511960582-0419_AD229_display.pdf', 145, '2017-11-29 14:03:02', '2017-11-29 14:03:02', 1),
(84, 'Falla de pantalla', 'Procedimiento de reparación de pantalla por falla.', 'apuntes-1511960582-0419_AD229_display.pdf', 144, '2017-11-29 14:03:03', '2017-11-29 14:03:03', 1),
(85, 'Conversión desde EPS512 a UPS400/200', 'Modificación en la tarjeta al utilizar un modelo de cargador diferente.', 'apuntes-1511960862-0511_AD229_EPS512_UPS400.pdf', 144, '2017-11-29 14:07:42', '2017-11-29 14:07:42', 1),
(86, 'Conversión desde EPS512 a UPS400/200', 'Modificación en la tarjeta al utilizar un modelo de cargador diferente.', 'apuntes-1511960862-0511_AD229_EPS512_UPS400.pdf', 150, '2017-11-29 14:07:42', '2017-11-29 14:07:42', 1),
(87, 'Conversión desde EPS512 a UPS400/200', 'Modificación en la tarjeta al utilizar un modelo de cargador diferente.', 'apuntes-1511960862-0511_AD229_EPS512_UPS400.pdf', 145, '2017-11-29 14:07:42', '2017-11-29 14:07:42', 1),
(88, 'Conversión desde EPS512 a UPS400/200', 'Modificación en la tarjeta al utilizar un modelo de cargador diferente.', 'apuntes-1511960862-0511_AD229_EPS512_UPS400.pdf', 143, '2017-11-29 14:07:43', '2017-11-29 14:07:43', 1),
(89, 'Sobrecalentamiento de conductor B71', 'Procedimiento de reparación para solucionar falla de sobrecalentamiento de algunos conductores en el equipo', 'apuntes-1511960999-0805_B71_overheating.pdf', 141, '2017-11-29 14:10:00', '2017-11-29 14:10:00', 1),
(90, 'Sobrecalentamiento de conductor B71', 'Procedimiento de reparación para solucionar falla de sobrecalentamiento de algunos conductores en el equipo', 'apuntes-1511960999-0805_B71_overheating.pdf', 145, '2017-11-29 14:10:00', '2017-11-29 14:10:00', 1),
(91, 'Sobrecalentamiento de conductor B71', 'Procedimiento de reparación para solucionar falla de sobrecalentamiento de algunos conductores en el equipo', 'apuntes-1511960999-0805_B71_overheating.pdf', 144, '2017-11-29 14:10:00', '2017-11-29 14:10:00', 1),
(92, 'Sobrecalentamiento de conductor B71', 'Procedimiento de reparación para solucionar falla de sobrecalentamiento de algunos conductores en el equipo', 'apuntes-1511960999-0805_B71_overheating.pdf', 143, '2017-11-29 14:10:00', '2017-11-29 14:10:00', 1),
(93, 'Sobrecalentamiento de conductor B71', 'Procedimiento de reparación para solucionar falla de sobrecalentamiento de algunos conductores en el equipo', 'apuntes-1511960999-0805_B71_overheating.pdf', 140, '2017-11-29 14:10:02', '2017-11-29 14:10:02', 1),
(94, 'Pérdida de calibración y/o valores de configu', 'Método de ajuste y calibración.', 'apuntes-1512390486-0912_AD229_loss_of_calibration_or_setupV2.pdf', 145, '2017-12-04 13:28:07', '2017-12-04 13:28:07', 1),
(95, 'Pérdida de calibración y/o valores de configu', 'Método de ajuste y calibración.', 'apuntes-1512390486-0912_AD229_loss_of_calibration_or_setupV2.pdf', 144, '2017-12-04 13:28:09', '2017-12-04 13:28:09', 1),
(96, 'Alimentación de energía externa', 'Detalles técnicos de fuente externa instalable para este equipo', 'apuntes-1512390620-0118 AS208 power supply.pdf', 157, '2017-12-04 13:30:21', '2017-12-04 13:30:21', 1),
(97, 'Nuevos ítems de configuración', 'Detalles de nuevas opciones de configuración disponibles para este equipo.', 'apuntes-1512390710-0021-AS216-new-setups-items.pdf', 150, '2017-12-04 13:31:52', '2017-12-04 13:31:52', 1),
(98, 'Integración a PC', 'Detalles para obtener interfase que permita la conexión a un computador.', 'apuntes-1512390951-0907_AS608e_PC_integration[1].pdf', 156, '2017-12-04 13:35:53', '2017-12-04 13:35:53', 1),
(99, 'Medición inestable causada por la empaquetadu', 'Falla en la empaquetadura original y solución.', 'apuntes-1512391324-0120 AT235 Instable measurements caused by gasket.pdf', 147, '2017-12-04 13:42:04', '2017-12-04 13:42:04', 1),
(100, 'Medición inestable causada por la empaquetadu', 'Falla en la empaquetadura original y solución.', 'apuntes-1512391324-0120 AT235 Instable measurements caused by gasket.pdf', 146, '2017-12-04 13:42:06', '2017-12-04 13:42:06', 1),
(101, 'Bomba - Problemas de hermetismo', 'Cambio de mangueras para corregir problemas de hermetismo en el circuito.', 'apuntes-1512391570-0208 Pump - airtight problems.pdf', 146, '2017-12-04 13:46:11', '2017-12-04 13:46:11', 1),
(102, 'Control automático de ganancia', 'Método de uso del AGC', 'apuntes-1512391643-0208 Pump - airtight problems.pdf', 141, '2017-12-04 13:47:23', '2017-12-04 13:47:23', 1),
(103, 'Control automático de ganancia', 'Método de uso del AGC', 'apuntes-1512391643-0208 Pump - airtight problems.pdf', 147, '2017-12-04 13:47:23', '2017-12-04 13:47:23', 1),
(104, 'Control automático de ganancia', 'Método de uso del AGC', 'apuntes-1512391643-0208 Pump - airtight problems.pdf', 140, '2017-12-04 13:47:23', '2017-12-04 13:47:23', 1),
(105, 'Control automático de ganancia', 'Método de uso del AGC', 'apuntes-1512391643-0208 Pump - airtight problems.pdf', 146, '2017-12-04 13:47:24', '2017-12-04 13:47:24', 1),
(106, 'Riesgo de salida de nivel de sonido excesiva', 'Falla en un capacitor crea un problema con el sonido al usarse en máximo nivel.', 'apuntes-1512391758-0221-AC40_AC33-risk-exces-sound-lev-input.pdf', 149, '2017-12-04 13:49:18', '2017-12-04 13:49:18', 1),
(107, 'Riesgo de salida de nivel de sonido excesiva', 'Falla en un capacitor crea un problema con el sonido al usarse en máximo nivel.', 'apuntes-1512391758-0221-AC40_AC33-risk-exces-sound-lev-input.pdf', 142, '2017-12-04 13:49:19', '2017-12-04 13:49:19', 1),
(108, 'Circuito de protección de la tarjeta principa', 'Falla encontrada en estos equipos y método de reparación.', 'apuntes-1512391897-0222-AT235_h_-AA220-AA222- protection.pdf', 141, '2017-12-04 13:51:37', '2017-12-04 13:51:37', 1),
(109, 'Circuito de protección de la tarjeta principa', 'Falla encontrada en estos equipos y método de reparación.', 'apuntes-1512391897-0222-AT235_h_-AA220-AA222- protection.pdf', 147, '2017-12-04 13:51:37', '2017-12-04 13:51:37', 1),
(110, 'Circuito de protección de la tarjeta principa', 'Falla encontrada en estos equipos y método de reparación.', 'apuntes-1512391897-0222-AT235_h_-AA220-AA222- protection.pdf', 146, '2017-12-04 13:51:37', '2017-12-04 13:51:37', 1),
(111, 'Circuito de protección de la tarjeta principa', 'Falla encontrada en estos equipos y método de reparación.', 'apuntes-1512391897-0222-AT235_h_-AA220-AA222- protection.pdf', 140, '2017-12-04 13:51:38', '2017-12-04 13:51:38', 1),
(112, 'La pantalla se apaga durante impresión', 'Explicación de falla encontrada donde se apaga la pantalla al intentar imprimir. También aparece cómo resolverlo.', 'apuntes-1512392074-0301 AT235, AT235h, AA220 and AA222 Display blackout durin….pdf', 147, '2017-12-04 13:54:35', '2017-12-04 13:54:35', 1),
(113, 'La pantalla se apaga durante impresión', 'Explicación de falla encontrada donde se apaga la pantalla al intentar imprimir. También aparece cómo resolverlo.', 'apuntes-1512392074-0301 AT235, AT235h, AA220 and AA222 Display blackout durin….pdf', 141, '2017-12-04 13:54:35', '2017-12-04 13:54:35', 1),
(114, 'La pantalla se apaga durante impresión', 'Explicación de falla encontrada donde se apaga la pantalla al intentar imprimir. También aparece cómo resolverlo.', 'apuntes-1512392074-0301 AT235, AT235h, AA220 and AA222 Display blackout durin….pdf', 140, '2017-12-04 13:54:35', '2017-12-04 13:54:35', 1),
(115, 'La pantalla se apaga durante impresión', 'Explicación de falla encontrada donde se apaga la pantalla al intentar imprimir. También aparece cómo resolverlo.', 'apuntes-1512392074-0301 AT235, AT235h, AA220 and AA222 Display blackout durin….pdf', 146, '2017-12-04 13:54:37', '2017-12-04 13:54:37', 1),
(116, 'Actualización a punta de prueba universal', 'Procedimiento de instalación de punta de prueba actualizada.', 'apuntes-1512392254-0312-UniversalProbe.pdf', 141, '2017-12-04 13:57:34', '2017-12-04 13:57:34', 1),
(117, 'Actualización a punta de prueba universal', 'Procedimiento de instalación de punta de prueba actualizada.', 'apuntes-1512392254-0312-UniversalProbe.pdf', 147, '2017-12-04 13:57:34', '2017-12-04 13:57:34', 1),
(118, 'Actualización a punta de prueba universal', 'Procedimiento de instalación de punta de prueba actualizada.', 'apuntes-1512392254-0312-UniversalProbe.pdf', 146, '2017-12-04 13:57:34', '2017-12-04 13:57:34', 1),
(119, 'Actualización a punta de prueba universal', 'Procedimiento de instalación de punta de prueba actualizada.', 'apuntes-1512392254-0312-UniversalProbe.pdf', 140, '2017-12-04 13:57:35', '2017-12-04 13:57:35', 1),
(120, 'Falsos reflejos, error DSP', 'Medición errónea por falla en componentes.', 'apuntes-1512392402-0602_False_reflexes_or_DSP_error_on_AT235_AA22x.pdf', 140, '2017-12-04 14:00:02', '2017-12-04 14:00:02', 1),
(121, 'Falsos reflejos, error DSP', 'Medición errónea por falla en componentes.', 'apuntes-1512392402-0602_False_reflexes_or_DSP_error_on_AT235_AA22x.pdf', 141, '2017-12-04 14:00:02', '2017-12-04 14:00:02', 1),
(122, 'Falsos reflejos, error DSP', 'Medición errónea por falla en componentes.', 'apuntes-1512392402-0602_False_reflexes_or_DSP_error_on_AT235_AA22x.pdf', 146, '2017-12-04 14:00:03', '2017-12-04 14:00:03', 1),
(123, 'Cambio de display', 'Procedimiento de cambio de display', 'apuntes-1512392582-0612_AT235_AA22x_new_display.pdf', 140, '2017-12-04 14:03:02', '2017-12-04 14:03:02', 1),
(124, 'Cambio de display', 'Procedimiento de cambio de display', 'apuntes-1512392582-0612_AT235_AA22x_new_display.pdf', 147, '2017-12-04 14:03:02', '2017-12-04 14:03:02', 1),
(125, 'Cambio de display', 'Procedimiento de cambio de display', 'apuntes-1512392582-0612_AT235_AA22x_new_display.pdf', 141, '2017-12-04 14:03:02', '2017-12-04 14:03:02', 1),
(126, 'Cambio de display', 'Procedimiento de cambio de display', 'apuntes-1512392582-0612_AT235_AA22x_new_display.pdf', 146, '2017-12-04 14:03:03', '2017-12-04 14:03:03', 1),
(127, 'Intercambio de circuito impreso', 'Procedimiento en caso de falla de tarjeta principal', 'apuntes-1512392717-0723_AT235(h)_AA22x_Board Change.pdf', 141, '2017-12-04 14:05:17', '2017-12-04 14:05:17', 1),
(128, 'Intercambio de circuito impreso', 'Procedimiento en caso de falla de tarjeta principal', 'apuntes-1512392717-0723_AT235(h)_AA22x_Board Change.pdf', 140, '2017-12-04 14:05:17', '2017-12-04 14:05:17', 1),
(129, 'Intercambio de circuito impreso', 'Procedimiento en caso de falla de tarjeta principal', 'apuntes-1512392717-0723_AT235(h)_AA22x_Board Change.pdf', 147, '2017-12-04 14:05:17', '2017-12-04 14:05:17', 1),
(130, 'Intercambio de circuito impreso', 'Procedimiento en caso de falla de tarjeta principal', 'apuntes-1512392717-0723_AT235(h)_AA22x_Board Change.pdf', 146, '2017-12-04 14:05:19', '2017-12-04 14:05:19', 1),
(131, ' Mejora al sistema de medición de cumplimient', 'Procedimiento para mejorar la medición de compliance en el equipo.', 'apuntes-1512392967-0003-AZ26-ompr-compl-meas-sys.pdf', 158, '2017-12-04 14:09:28', '2017-12-04 14:09:28', 1),
(132, 'Medición de Reflejos Stapedius en pacientes c', 'Método de uso con pacientes con implante coclear', 'apuntes-1512394628-0012-AZ26-ext-trig-cochlea-impl.pdf', 158, '2017-12-04 14:37:10', '2017-12-04 14:37:10', 1),
(133, 'Reemplazo del inversor', 'Cambio de pieza interna.', 'apuntes-1512394662-0809_AZ26 Inverter_Replacement.pdf', 158, '2017-12-04 14:37:44', '2017-12-04 14:37:44', 1),
(134, 'Actualización a versión 4', 'Método de actualización de software', 'apuntes-1512476719-0008-MT10-upgrade-vers4.pdf', 148, '2017-12-05 13:25:20', '2017-12-05 13:25:20', 1),
(135, 'Falla CPU', 'Problema encontrado con la CPU de los equipos y método de reparación', 'apuntes-1512476787-0404_ MT10_CPU_board.pdf', 148, '2017-12-05 13:26:28', '2017-12-05 13:26:28', 1),
(136, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 158, '2017-12-05 13:28:31', '2017-12-05 13:28:31', 1),
(137, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 146, '2017-12-05 13:28:31', '2017-12-05 13:28:31', 1),
(138, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 147, '2017-12-05 13:28:32', '2017-12-05 13:28:32', 1),
(139, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 140, '2017-12-05 13:28:32', '2017-12-05 13:28:32', 1),
(140, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 141, '2017-12-05 13:28:32', '2017-12-05 13:28:32', 1),
(141, 'Tubos de silicona', 'Detalles para adquisición de tubos de silicona para este equipo.', 'apuntes-1512476911-0609_Silicone_tubes.pdf', 148, '2017-12-05 13:28:32', '2017-12-05 13:28:32', 1),
(142, 'Falla micrófono de prueba', 'Problema encontrado en micrófono de prueba y forma de solucionarlo.', 'apuntes-1512477176-0615_MT10_probe_microphone_problem.pdf', 148, '2017-12-05 13:32:57', '2017-12-05 13:32:57', 1),
(143, 'Cambio de display', 'Proceso de cambio de display para este modelo', 'apuntes-1512477239-0717_MT10_Display_change.pdf', 148, '2017-12-05 13:34:00', '2017-12-05 13:34:00', 1),
(144, 'Medición de audición de recién nacido', 'Método de medición para recién nacido en caso de pérdida de la audición en uno de los oídos', 'apuntes-1512477881-0316_Newborn_hearing_screening.pdf', 137, '2017-12-05 13:44:42', '2017-12-05 13:44:42', 1),
(145, 'Configuración del convertidor USB', 'Método de configuración del convertidor USB para este equipo.', 'apuntes-1512477972-0712_OtoRead_USB2SERIAL_converter_settings.pdf', 137, '2017-12-05 13:46:13', '2017-12-05 13:46:13', 1),
(146, 'Cambio de pantalla', 'Procedimiento para cambio de pantalla.', 'apuntes-1512478104-0801_Otoread_display_change.pdf', 137, '2017-12-05 13:48:25', '2017-12-05 13:48:25', 1),
(147, 'Parlante pediátrico', 'Calibración de parlante y audífono externos', 'apuntes-1512480659-0023-PA5-PLS5.pdf', 152, '2017-12-05 14:31:00', '2017-12-05 14:31:00', 1),
(148, 'Polarización inversa', 'Procedimiento de protección en caso de instalar la batería al revés.', 'apuntes-1512480864-0403_PA5_battery_polarization.pdf', 152, '2017-12-05 14:34:26', '2017-12-05 14:34:26', 1),
(149, 'Interruptor deslizable difícil de mover', 'Procedimiento de limpieza de interruptor deslizable', 'apuntes-1512481004-0605_PA5_slider_hard_to_move.pdf', 152, '2017-12-05 14:36:45', '2017-12-05 14:36:45', 1),
(150, 'Chequeo a puntas de prueba', 'Método de revisión de puntas de prueba', 'apuntes-1513017417-0905_Titan_probe.pdf', 139, '2017-12-11 19:36:58', '2017-12-11 19:36:58', 1),
(151, 'Descarga de sesiones en equipo autónomo', 'Descarga de sesiones si no se cuenta con Base de Datos de los pacientes.', 'apuntes-1513019564-1002_Titan_Screener_Download-Sessions.pdf', 139, '2017-12-11 19:38:58', '2017-12-11 20:12:45', 1),
(152, 'Interfase de datos XML', 'Detalles de la interface de datos del paciente en XML', 'apuntes-1513017620-1004_XML_Data_Interface_for_Titan_Suite.pdf', 139, '2017-12-11 19:40:22', '2017-12-11 19:40:22', 1),
(153, 'Plantilla para mediciones de Seg.Eléc.', 'El documento adjunto, entrega los detalles para descarga de la plantilla que se usa para mediciones de seguridad eléctrica, usando el software Ansur.', 'apuntes-1514318997-Plantilla Ansur Seguridad Electrica.docx', 94, '2017-12-26 21:08:06', '2017-12-26 21:09:58', 1),
(154, 'Cambio ampolleta', 'Procedimiento e indicaciones para cambio de ampolleta.', 'apuntes-1515074177-cambio_amp_axiostar_plus.docx', 176, '2018-01-04 14:56:18', '2018-01-04 14:56:18', 1),
(155, 'Error técnico 41', 'Descripción del error técnico 41 y su solución.', 'apuntes-1515672816-Servo-i_emx_technicalerror41_nonus_all.pdf', 177, '2018-01-11 13:13:37', '2018-01-11 13:13:37', 1),
(156, 'Instalación ELI Link', 'Instalación del software de generación de reportes para electrocardiógrafo ELI 250', 'apuntes-1515689481-Instalacion ELI Link.docx', 187, '2018-01-11 17:51:22', '2018-01-11 17:51:22', 1),
(157, 'Valor ampolleta colimador', 'Tipo: Bipin, Voltaje: 24V, Potencia: 120W', '', 198, '2018-01-17 13:29:10', '2018-01-17 13:29:10', 1),
(158, 'Descarga de registros', 'Detalle de procedimiento para descarga de registros a un PC.', 'apuntes-1516363627-Protoc descarg mail.pdf', 214, '2018-01-19 13:07:08', '2018-01-19 13:07:08', 1),
(159, 'Instructivo de operación', 'Resumen del proceso de operación del equipo.', 'apuntes-1516364977-CO-091152-CLÍNICA LAS LILAS.pdf', 214, '2018-01-19 13:29:39', '2018-01-19 13:29:39', 1),
(160, 'Errores frecuentes en lectura de datos en PC', 'Listado de errores frecuentes y método de reparación', 'apuntes-1516997537-Errores frecuentes en programa leetemp tutorial.pdf', 214, '2018-01-26 21:12:18', '2018-01-26 21:12:18', 1),
(161, 'Instrucciones de instalación programa de lect', 'Proceso de instalación de programa para lectura de temperaturas.', 'apuntes-1516997595-Instrucciones.txt', 214, '2018-01-26 21:13:16', '2018-01-26 21:13:16', 1),
(162, 'Software Pitec', 'Se dejan las instrucciones para instalación del software de monitoreo para refrigeradores Pitec, modelo REF100', 'apuntes-1516998572-software Pitec.docx', 214, '2018-01-26 21:29:33', '2018-01-26 21:29:33', 1),
(163, 'Password maestra V-35830', 'Contraseña maestra: 900373.', '', 111, '2018-03-06 19:17:42', '2018-03-06 19:17:42', 1),
(164, 'Contraseña Servicio', 'Contraseña de servicio: 1111', '', 111, '2018-03-06 19:19:03', '2018-03-06 19:19:03', 1);

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
  MODIFY `MAN_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=543;

--
-- AUTO_INCREMENT de la tabla `pm_marca`
--
ALTER TABLE `pm_marca`
  MODIFY `MAR_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT de la tabla `pm_modelo`
--
ALTER TABLE `pm_modelo`
  MODIFY `MOD_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT de la tabla `pm_protocolo`
--
ALTER TABLE `pm_protocolo`
  MODIFY `PRO_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `pm_repuesto`
--
ALTER TABLE `pm_repuesto`
  MODIFY `REP_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pm_tipoequipo`
--
ALTER TABLE `pm_tipoequipo`
  MODIFY `TIP_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de la tabla `pm_torpedo`
--
ALTER TABLE `pm_torpedo`
  MODIFY `TOR_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=165;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
