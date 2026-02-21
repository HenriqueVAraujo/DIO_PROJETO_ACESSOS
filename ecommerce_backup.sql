DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(45) DEFAULT NULL,
  `Lname` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump de dados da tabela `clients`
--

LOCK TABLES `clients` WRITE;
INSERT INTO `clients` VALUES (1,'João','Silva','joao@email.com'),(2,'Maria','Santos','maria@email.com');
UNLOCK TABLES;

--
-- Definição de Procedures (incluídas no backup)
--

DELIMITER ;;
CREATE PROCEDURE `sp_ManageData`(IN op INT, IN id INT, IN nome VARCHAR(50), IN extra VARCHAR(50))
BEGIN
    CASE op
        WHEN 1 THEN INSERT INTO clients VALUES (id, nome, extra, NULL);
    END CASE;
END ;;
DELIMITER ;
