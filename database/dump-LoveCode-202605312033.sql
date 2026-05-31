/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.7.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: LoveCode
-- ------------------------------------------------------
-- Server version	11.8.6-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id_like` int(11) NOT NULL AUTO_INCREMENT,
  `id_emisor` int(11) NOT NULL,
  `id_receptor` int(11) NOT NULL,
  `fecha_like` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_like`),
  UNIQUE KEY `uq_like` (`id_emisor`,`id_receptor`),
  KEY `id_receptor` (`id_receptor`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`id_emisor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`id_receptor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES
(19,4,1,'2026-05-31 12:15:21'),
(20,1,4,'2026-05-31 12:16:22');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`db_admin`@`localhost`*/ /*!50003 TRIGGER tr_generacion_matches
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
IF EXISTS(
SELECT 1 FROM likes
WHERE id_emisor = NEW.id_receptor
AND id_receptor = NEW.id_emisor
) THEN
INSERT IGNORE INTO matches (id_usuario1, id_usuario2, fecha_match)
VALUES (LEAST(NEW.id_emisor, NEW.id_receptor), GREATEST(NEW.id_emisor, NEW.id_receptor), NOW());
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `id_match` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario1` int(11) NOT NULL,
  `id_usuario2` int(11) NOT NULL,
  `fecha_match` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_match`),
  UNIQUE KEY `uq_match` (`id_usuario1`,`id_usuario2`),
  KEY `id_usuario2` (`id_usuario2`),
  CONSTRAINT `matches_ibfk_1` FOREIGN KEY (`id_usuario1`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`id_usuario2`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` VALUES
(2,1,4,'2026-05-31 12:16:22');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnologias`
--

DROP TABLE IF EXISTS `tecnologias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecnologias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnologias`
--

LOCK TABLES `tecnologias` WRITE;
/*!40000 ALTER TABLE `tecnologias` DISABLE KEYS */;
INSERT INTO `tecnologias` VALUES
(4,'CSS'),
(3,'HTML'),
(1,'Java'),
(5,'JavaScript'),
(2,'MySQL');
/*!40000 ALTER TABLE `tecnologias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,'Sergio Ruiz Obama','sergio.ruiz.obama@gmail.com','Sergio','Desarrollador backend','2026-04-25 19:27:42'),
(3,'Kylian Mbappe','mbappe@email.com','1234','Apasionado del desarrollo web','2026-05-21 09:44:35'),
(4,'Erling Haaland','haaland@email.com','1234','Desarrollador backend','2026-05-21 09:44:35'),
(5,'Vinicius Junior','vinicius@email.com','1234','Amante de las bases de datos','2026-05-21 09:44:35'),
(6,'Pedri Gonzalez','pedri@email.com','1234','Diseñador frontend','2026-05-21 09:44:35'),
(7,'Sergio','sergio@gmailuknow.com','1234','No quiero jurao.',NULL),
(8,'Rubinho Jr','carls@gmail.com','1234','Me encanta absolutamente todo.',NULL),
(9,'Negreira','nosoycorrupto@gmail.com','1234','Penalti para el Madrid.',NULL),
(10,'Paco Buyo','paquito@gmail.com','1234','Nada que decir.',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_tecnologias`
--

DROP TABLE IF EXISTS `usuarios_tecnologias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_tecnologias` (
  `id_usuario` int(11) NOT NULL,
  `id_tecnologia` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_tecnologia`),
  KEY `id_tecnologia` (`id_tecnologia`),
  CONSTRAINT `usuarios_tecnologias_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuarios_tecnologias_ibfk_2` FOREIGN KEY (`id_tecnologia`) REFERENCES `tecnologias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_tecnologias`
--

LOCK TABLES `usuarios_tecnologias` WRITE;
/*!40000 ALTER TABLE `usuarios_tecnologias` DISABLE KEYS */;
INSERT INTO `usuarios_tecnologias` VALUES
(1,1),
(3,1),
(8,1),
(10,1),
(3,2),
(4,2),
(9,2),
(10,2),
(1,3),
(5,3),
(9,3),
(10,3),
(5,4),
(7,4),
(10,4),
(4,5),
(8,5),
(10,5);
/*!40000 ALTER TABLE `usuarios_tecnologias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vista_usuarios_tecnologias`
--

DROP TABLE IF EXISTS `vista_usuarios_tecnologias`;
/*!50001 DROP VIEW IF EXISTS `vista_usuarios_tecnologias`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vista_usuarios_tecnologias` AS SELECT
 1 AS `nombre`,
  1 AS `tecnologia` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'LoveCode'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BorrarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`db_admin`@`_gateway` PROCEDURE `BorrarUsuario`(IN p_id_usuario INT)
BEGIN
    DELETE FROM Usuarios
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CargarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`db_admin`@`_gateway` PROCEDURE `CargarUsuario`(IN p_id_usuario INT)
BEGIN
    SELECT * FROM Usuarios
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ContarMatches` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
DELIMITER ;;
CREATE DEFINER=`db_admin`@`_gateway` PROCEDURE `ContarMatches`()
BEGIN
    SELECT COUNT(*) AS total_matches
    FROM Matches;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_usuarios_tecnologias`
--

/*!50001 DROP VIEW IF EXISTS `vista_usuarios_tecnologias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`db_admin`@`_gateway` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_usuarios_tecnologias` AS select `u`.`nombre` AS `nombre`,`t`.`nombre` AS `tecnologia` from ((`usuarios` `u` join `usuarios_tecnologias` `ut` on(`u`.`id` = `ut`.`id_usuario`)) join `tecnologias` `t` on(`ut`.`id_tecnologia` = `t`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-05-31 20:33:51
