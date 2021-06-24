-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: pedido_venda
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Cidade` varchar(100) NOT NULL,
  `UF` char(2) NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'JOSÉ HENRIQUE DOS SANTOS','GOIÂNIA','GO'),(2,'MARIA VITORIA SILVA SOUZA','GOIÂNIA','GO'),(3,'ANDRÉ WAGNER LEÃO','SÃO PAULO','SP'),(4,'ELIEZER BERRAZA DOS SANTOS','RIO DE JANEIRO','RJ'),(5,'GUIOMAR OLIVEIRA DOS SANTOS','GOIÂNIA','GO'),(6,'BERENICE RUI BARBOSA DE SOUZA SIQUEIRA','FORTALEZA','CE'),(7,'JUVENILDO JOSÉ DOS SANTOS','MANAUS','AM'),(8,'HENRIQUE FRANCISO DA COSTA','SÃO PAULO','SP'),(9,'JOSÉ DAMASCENO CRUZ','SÃO PAULO','SP'),(10,'GLÓRIA FRANCISCA DE ASSIS','SÃO PAULO','SP'),(11,'VINICIUS MARQUES DE MACHADO','SÃO PAULO','SP'),(12,'LOURDES MARIA CANTO','SÃO PAULO','SP'),(13,'FÁTIMA BERNARDES MONTAGNINI','BELO HORIZONTE','MG'),(14,'ABENAIR MAIRA DO CARMO','SALVADOR','BA'),(15,'MARIA HELENA SANTOS SILVA','GOIÂNIA','GO'),(16,'JOAQUIM FRANCISCO DE OLIVEIRA NETO','RIO BRANCO','AC'),(17,'BRENO MARCOS COSTA MENDES','BOA VISTA','RO'),(18,'RÔMULO TONE DA COSTA','SÃO PAULO','SP'),(19,'WAGNER BRITO CAMARGO','SÃO PAULO','SP'),(20,'BRUNO GONÇALVES NASCIMENTO','SÃO PAULO','SP');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens_pedido`
--

DROP TABLE IF EXISTS `itens_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_pedido` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Produto` int NOT NULL,
  `Qtd` int NOT NULL,
  `Valor_Unit` float NOT NULL,
  `Valor_Total` float NOT NULL,
  `Codigo_Pedido` int NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `Codigo_Pedido` (`Codigo_Pedido`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`Codigo_Pedido`) REFERENCES `pedidos` (`Pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
INSERT INTO `itens_pedido` VALUES (1,2,3,459.9,1379.7,3),(2,18,1,599.9,599.9,3),(3,5,3,129.9,389.7,3),(5,6,4,239.9,959.6,5),(6,4,2,199.9,399.8,5),(7,7,6,109.9,659.4,5),(8,1,2,250,500,6),(9,6,1,239.9,239.9,6),(10,7,8,109.9,879.2,6);
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `Pedido` int NOT NULL AUTO_INCREMENT,
  `Data_Emissao` date NOT NULL,
  `Valor_Total` float NOT NULL,
  `Cliente` int NOT NULL,
  PRIMARY KEY (`Pedido`),
  KEY `Cliente` (`Cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`Cliente`) REFERENCES `clientes` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (3,'2021-06-23',2369.3,1),(5,'2021-06-23',2018.8,1),(6,'2021-06-23',2098.9,1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(50) NOT NULL,
  `Pco_Venda` float NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'FURADEIRA',250),(2,'LAVADORA DE ALTA PRESSÃO',459.9),(3,'CARRINHO DE MÃO',199.9),(4,'LIQUIDIFICADOR MONDIAL',199.9),(5,'PIPOQUEIRA',129.9),(6,'CHURRASQUEIRA ELÉTRICA',239.9),(7,'CAFETEIRA',109.9),(8,'FOGÃO ELÉTRICO LAYR',229.9),(9,'ASPIRADOR DE PÓ',110),(10,'COIFA DE VIDRO',759.9),(11,'FRITADEIRA ELÉTRICA SOLAR',779.9),(12,'COOKTOP',499.9),(13,'LIQUIDIFICADOR BRINOX',159.9),(14,'TORNEIRA DE PIA',149.9),(15,'PIA FIBRA',150.9),(16,'GABINETE AÇO',779.9),(17,'FAQUEIRO TRAMONTINA',899.9),(18,'JOGO DE JANTAR',599.9),(19,'PORTA COPOS',59.9),(20,'JOGO DE SOBREMESA',79.9);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-24  0:03:44
