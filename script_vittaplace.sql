CREATE DATABASE  IF NOT EXISTS `vittaplace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vittaplace`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: vittaplace
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cliente_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `cpf_cnpj` varchar(14) NOT NULL,
  `email` varchar(160) DEFAULT NULL,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cliente_id`),
  UNIQUE KEY `uk_cliente_cpf_cnpj` (`cpf_cnpj`),
  UNIQUE KEY `uk_cliente_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Cliente Exemplo 1','11111111111','cliente1@email.com','2026-04-29 20:51:44'),(2,'Cliente Exemplo 2','22222222222','cliente2@email.com','2026-04-29 20:51:44');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despesa_operacional`
--

DROP TABLE IF EXISTS `despesa_operacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesa_operacional` (
  `despesa_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `periodo_id` int unsigned NOT NULL,
  `categoria` enum('MARKETING','LOGISTICA','SISTEMAS','PESSOAL','OUTRAS') NOT NULL,
  `descricao` varchar(160) NOT NULL,
  `valor` decimal(12,2) NOT NULL,
  `data_competencia` date NOT NULL,
  PRIMARY KEY (`despesa_id`),
  KEY `idx_despesa_periodo` (`periodo_id`),
  KEY `idx_despesa_categoria` (`categoria`),
  KEY `idx_despesa_data` (`data_competencia`),
  CONSTRAINT `fk_despesa_periodo` FOREIGN KEY (`periodo_id`) REFERENCES `periodo` (`periodo_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_despesa_valor` CHECK ((`valor` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despesa_operacional`
--

LOCK TABLES `despesa_operacional` WRITE;
/*!40000 ALTER TABLE `despesa_operacional` DISABLE KEYS */;
INSERT INTO `despesa_operacional` VALUES (1,1,'MARKETING','Campanha de divulgação em mídia paga',1500.00,'2026-01-15');
/*!40000 ALTER TABLE `despesa_operacional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estorno`
--

DROP TABLE IF EXISTS `estorno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estorno` (
  `estorno_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pagamento_id` bigint unsigned NOT NULL,
  `data_estorno` datetime NOT NULL,
  `motivo` varchar(120) NOT NULL,
  `valor_estornado` decimal(12,2) NOT NULL,
  PRIMARY KEY (`estorno_id`),
  KEY `idx_estorno_pagamento` (`pagamento_id`),
  KEY `idx_estorno_data` (`data_estorno`),
  CONSTRAINT `fk_estorno_pagamento` FOREIGN KEY (`pagamento_id`) REFERENCES `pagamento` (`pagamento_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_estorno_valor` CHECK ((`valor_estornado` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estorno`
--

LOCK TABLES `estorno` WRITE;
/*!40000 ALTER TABLE `estorno` DISABLE KEYS */;
/*!40000 ALTER TABLE `estorno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `pagamento_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pedido_id` bigint unsigned NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `metodo` enum('PIX','CARTAO_CREDITO','CARTAO_DEBITO','BOLETO','TRANSFERENCIA','OUTRO') NOT NULL,
  `status_pagamento` enum('PENDENTE','CONFIRMADO','RECUSADO','ESTORNADO','CHARGEBACK') NOT NULL DEFAULT 'PENDENTE',
  `valor_bruto` decimal(12,2) NOT NULL,
  `codigo_transacao` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`pagamento_id`),
  KEY `idx_pag_pedido` (`pedido_id`),
  KEY `idx_pag_data` (`data_pagamento`),
  KEY `idx_pag_status` (`status_pagamento`),
  CONSTRAINT `fk_pagamento_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`pedido_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_pag_valor` CHECK ((`valor_bruto` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (1,1,'2026-04-29 20:51:44','PIX','CONFIRMADO',340.00,'60b959a8-4426-11f1-b4a5-d09466e9f237');
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `pedido_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint unsigned NOT NULL,
  `periodo_id` int unsigned NOT NULL,
  `data_pedido` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status_pedido` enum('CRIADO','PAGO','ENVIADO','ENTREGUE','CANCELADO') NOT NULL DEFAULT 'CRIADO',
  `frete_cobrado` decimal(12,2) NOT NULL DEFAULT '0.00',
  `frete_subsidiado` decimal(12,2) NOT NULL DEFAULT '0.00',
  `observacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pedido_id`),
  KEY `idx_pedido_cliente` (`cliente_id`),
  KEY `idx_pedido_periodo` (`periodo_id`),
  KEY `idx_pedido_data` (`data_pedido`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_periodo` FOREIGN KEY (`periodo_id`) REFERENCES `periodo` (`periodo_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_pedido_fretes` CHECK (((`frete_cobrado` >= 0) and (`frete_subsidiado` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'2026-01-10 10:00:00','PAGO',20.00,5.00,'Pedido de teste com dois vendedores');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_item`
--

DROP TABLE IF EXISTS `pedido_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_item` (
  `pedido_item_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pedido_id` bigint unsigned NOT NULL,
  `produto_id` bigint unsigned NOT NULL,
  `vendedor_id` bigint unsigned NOT NULL,
  `quantidade` int unsigned NOT NULL,
  `preco_unitario` decimal(12,2) NOT NULL,
  `desconto_item` decimal(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`pedido_item_id`),
  KEY `idx_item_pedido` (`pedido_id`),
  KEY `idx_item_produto` (`produto_id`),
  KEY `idx_item_vendedor` (`vendedor_id`),
  CONSTRAINT `fk_item_pedido` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`pedido_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_item_produto` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`produto_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_item_vendedor` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor` (`vendedor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_item_regras` CHECK (((`quantidade` > 0) and (`preco_unitario` >= 0) and (`desconto_item` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_item`
--

LOCK TABLES `pedido_item` WRITE;
/*!40000 ALTER TABLE `pedido_item` DISABLE KEYS */;
INSERT INTO `pedido_item` VALUES (1,1,1,1,1,150.00,0.00),(2,1,3,2,2,89.90,9.80);
/*!40000 ALTER TABLE `pedido_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodo`
--

DROP TABLE IF EXISTS `periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodo` (
  `periodo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `ano` smallint unsigned NOT NULL,
  `mes` tinyint unsigned NOT NULL,
  `inicio` date NOT NULL,
  `fim` date NOT NULL,
  PRIMARY KEY (`periodo_id`),
  UNIQUE KEY `uk_periodo_ano_mes` (`ano`,`mes`),
  CONSTRAINT `ck_periodo_datas` CHECK ((`inicio` <= `fim`)),
  CONSTRAINT `ck_periodo_mes` CHECK ((`mes` between 1 and 12))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodo`
--

LOCK TABLES `periodo` WRITE;
/*!40000 ALTER TABLE `periodo` DISABLE KEYS */;
INSERT INTO `periodo` VALUES (1,2026,1,'2026-01-01','2026-01-31'),(2,2026,2,'2026-02-01','2026-02-28');
/*!40000 ALTER TABLE `periodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `produto_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `vendedor_id` bigint unsigned NOT NULL,
  `nome` varchar(160) NOT NULL,
  `categoria` varchar(80) NOT NULL,
  `custo_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `preco_base` decimal(12,2) NOT NULL DEFAULT '0.00',
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`produto_id`),
  KEY `idx_produto_vendedor` (`vendedor_id`),
  KEY `idx_produto_categoria` (`categoria`),
  CONSTRAINT `fk_produto_vendedor` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor` (`vendedor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_produto_valores` CHECK (((`custo_unitario` >= 0) and (`preco_base` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,1,'Fone Bluetooth','Eletrônicos',80.00,150.00,1,'2026-04-29 20:51:44'),(2,1,'Mouse Gamer','Informática',60.00,120.00,1,'2026-04-29 20:51:44'),(3,2,'Camiseta Casual','Moda',35.00,89.90,1,'2026-04-29 20:51:44'),(4,2,'Mochila Executiva','Acessórios',90.00,199.90,1,'2026-04-29 20:51:44');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repasse`
--

DROP TABLE IF EXISTS `repasse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repasse` (
  `repasse_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pagamento_id` bigint unsigned NOT NULL,
  `vendedor_id` bigint unsigned NOT NULL,
  `data_prevista` datetime NOT NULL,
  `data_repasse` datetime DEFAULT NULL,
  `status_repasse` enum('PENDENTE','PROGRAMADO','PAGO','CANCELADO') NOT NULL DEFAULT 'PENDENTE',
  `valor_repasse` decimal(12,2) NOT NULL,
  `comissao_marketplace` decimal(12,2) NOT NULL,
  PRIMARY KEY (`repasse_id`),
  KEY `idx_repasse_pagamento` (`pagamento_id`),
  KEY `idx_repasse_vendedor` (`vendedor_id`),
  KEY `idx_repasse_status_data` (`status_repasse`,`data_repasse`),
  CONSTRAINT `fk_repasse_pagamento` FOREIGN KEY (`pagamento_id`) REFERENCES `pagamento` (`pagamento_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_repasse_vendedor` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor` (`vendedor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ck_repasse_valores` CHECK (((`valor_repasse` >= 0) and (`comissao_marketplace` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repasse`
--

LOCK TABLES `repasse` WRITE;
/*!40000 ALTER TABLE `repasse` DISABLE KEYS */;
INSERT INTO `repasse` VALUES (1,1,1,'2026-05-06 20:51:44',NULL,'PROGRAMADO',132.00,18.00),(2,1,2,'2026-05-06 20:51:44',NULL,'PROGRAMADO',149.60,20.40);
/*!40000 ALTER TABLE `repasse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxa_pagamento`
--

DROP TABLE IF EXISTS `taxa_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxa_pagamento` (
  `taxa_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pagamento_id` bigint unsigned NOT NULL,
  `tipo_taxa` enum('GATEWAY','PLATAFORMA','ANTECIPACAO','OUTRA') NOT NULL,
  `valor_taxa` decimal(12,2) NOT NULL,
  PRIMARY KEY (`taxa_id`),
  KEY `idx_taxa_pagamento` (`pagamento_id`),
  KEY `idx_taxa_tipo` (`tipo_taxa`),
  CONSTRAINT `fk_taxa_pagamento` FOREIGN KEY (`pagamento_id`) REFERENCES `pagamento` (`pagamento_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_taxa_valor` CHECK ((`valor_taxa` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxa_pagamento`
--

LOCK TABLES `taxa_pagamento` WRITE;
/*!40000 ALTER TABLE `taxa_pagamento` DISABLE KEYS */;
INSERT INTO `taxa_pagamento` VALUES (1,1,'GATEWAY',6.50);
/*!40000 ALTER TABLE `taxa_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `vendedor_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nome_loja` varchar(140) NOT NULL,
  `cpf_cnpj` varchar(14) NOT NULL,
  `email` varchar(160) DEFAULT NULL,
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vendedor_id`),
  UNIQUE KEY `uk_vendedor_cpf_cnpj` (`cpf_cnpj`),
  UNIQUE KEY `uk_vendedor_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'Loja Alpha','33333333333333','alpha@email.com','2026-04-29 20:51:44'),(2,'Loja Beta','44444444444444','beta@email.com','2026-04-29 20:51:44');
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_dre_periodo`
--

DROP TABLE IF EXISTS `vw_dre_periodo`;
/*!50001 DROP VIEW IF EXISTS `vw_dre_periodo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dre_periodo` AS SELECT 
 1 AS `periodo_id`,
 1 AS `ano`,
 1 AS `mes`,
 1 AS `receita_comissao`,
 1 AS `receita_frete`,
 1 AS `total_taxas_pagamento`,
 1 AS `total_estornos`,
 1 AS `frete_subsidiado`,
 1 AS `total_despesas_operacionais`,
 1 AS `resultado_operacional`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_produto_vendedor`
--

DROP TABLE IF EXISTS `vw_produto_vendedor`;
/*!50001 DROP VIEW IF EXISTS `vw_produto_vendedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_produto_vendedor` AS SELECT 
 1 AS `produto_id`,
 1 AS `nome_produto`,
 1 AS `categoria`,
 1 AS `ativo`,
 1 AS `vendedor_id`,
 1 AS `nome_loja`,
 1 AS `custo_unitario`,
 1 AS `preco_base`,
 1 AS `margem_bruta_unitaria`,
 1 AS `percentual_margem`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_repasse_vendedor`
--

DROP TABLE IF EXISTS `vw_repasse_vendedor`;
/*!50001 DROP VIEW IF EXISTS `vw_repasse_vendedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_repasse_vendedor` AS SELECT 
 1 AS `repasse_id`,
 1 AS `pagamento_id`,
 1 AS `pedido_id`,
 1 AS `vendedor_id`,
 1 AS `nome_loja`,
 1 AS `status_pagamento`,
 1 AS `status_repasse`,
 1 AS `data_prevista`,
 1 AS `data_repasse`,
 1 AS `valor_repasse`,
 1 AS `comissao_marketplace`,
 1 AS `valor_venda_vendedor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_resumo_pedido`
--

DROP TABLE IF EXISTS `vw_resumo_pedido`;
/*!50001 DROP VIEW IF EXISTS `vw_resumo_pedido`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_resumo_pedido` AS SELECT 
 1 AS `pedido_id`,
 1 AS `data_pedido`,
 1 AS `status_pedido`,
 1 AS `cliente_id`,
 1 AS `nome_cliente`,
 1 AS `ano`,
 1 AS `mes`,
 1 AS `quantidade_itens`,
 1 AS `quantidade_produtos`,
 1 AS `subtotal_produtos`,
 1 AS `total_descontos`,
 1 AS `frete_cobrado`,
 1 AS `frete_subsidiado`,
 1 AS `valor_total_pedido`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_dre_periodo`
--

/*!50001 DROP VIEW IF EXISTS `vw_dre_periodo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dre_periodo` AS select `pe`.`periodo_id` AS `periodo_id`,`pe`.`ano` AS `ano`,`pe`.`mes` AS `mes`,coalesce(`rc`.`receita_comissao`,0) AS `receita_comissao`,coalesce(`fr`.`receita_frete`,0) AS `receita_frete`,coalesce(`tx`.`total_taxas_pagamento`,0) AS `total_taxas_pagamento`,coalesce(`es`.`total_estornos`,0) AS `total_estornos`,coalesce(`fr`.`frete_subsidiado`,0) AS `frete_subsidiado`,coalesce(`dp`.`total_despesas_operacionais`,0) AS `total_despesas_operacionais`,(((((coalesce(`rc`.`receita_comissao`,0) + coalesce(`fr`.`receita_frete`,0)) - coalesce(`tx`.`total_taxas_pagamento`,0)) - coalesce(`es`.`total_estornos`,0)) - coalesce(`fr`.`frete_subsidiado`,0)) - coalesce(`dp`.`total_despesas_operacionais`,0)) AS `resultado_operacional` from (((((`periodo` `pe` left join (select `p`.`periodo_id` AS `periodo_id`,sum(`r`.`comissao_marketplace`) AS `receita_comissao` from ((`repasse` `r` join `pagamento` `pg` on((`pg`.`pagamento_id` = `r`.`pagamento_id`))) join `pedido` `p` on((`p`.`pedido_id` = `pg`.`pedido_id`))) where (`pg`.`status_pagamento` = 'CONFIRMADO') group by `p`.`periodo_id`) `rc` on((`rc`.`periodo_id` = `pe`.`periodo_id`))) left join (select `pedido`.`periodo_id` AS `periodo_id`,sum(`pedido`.`frete_cobrado`) AS `receita_frete`,sum(`pedido`.`frete_subsidiado`) AS `frete_subsidiado` from `pedido` where (`pedido`.`status_pedido` in ('PAGO','ENVIADO','ENTREGUE')) group by `pedido`.`periodo_id`) `fr` on((`fr`.`periodo_id` = `pe`.`periodo_id`))) left join (select `p`.`periodo_id` AS `periodo_id`,sum(`tp`.`valor_taxa`) AS `total_taxas_pagamento` from ((`taxa_pagamento` `tp` join `pagamento` `pg` on((`pg`.`pagamento_id` = `tp`.`pagamento_id`))) join `pedido` `p` on((`p`.`pedido_id` = `pg`.`pedido_id`))) where (`pg`.`status_pagamento` = 'CONFIRMADO') group by `p`.`periodo_id`) `tx` on((`tx`.`periodo_id` = `pe`.`periodo_id`))) left join (select `p`.`periodo_id` AS `periodo_id`,sum(`e`.`valor_estornado`) AS `total_estornos` from ((`estorno` `e` join `pagamento` `pg` on((`pg`.`pagamento_id` = `e`.`pagamento_id`))) join `pedido` `p` on((`p`.`pedido_id` = `pg`.`pedido_id`))) group by `p`.`periodo_id`) `es` on((`es`.`periodo_id` = `pe`.`periodo_id`))) left join (select `despesa_operacional`.`periodo_id` AS `periodo_id`,sum(`despesa_operacional`.`valor`) AS `total_despesas_operacionais` from `despesa_operacional` group by `despesa_operacional`.`periodo_id`) `dp` on((`dp`.`periodo_id` = `pe`.`periodo_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_produto_vendedor`
--

/*!50001 DROP VIEW IF EXISTS `vw_produto_vendedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_produto_vendedor` AS select `pr`.`produto_id` AS `produto_id`,`pr`.`nome` AS `nome_produto`,`pr`.`categoria` AS `categoria`,`pr`.`ativo` AS `ativo`,`v`.`vendedor_id` AS `vendedor_id`,`v`.`nome_loja` AS `nome_loja`,`pr`.`custo_unitario` AS `custo_unitario`,`pr`.`preco_base` AS `preco_base`,(`pr`.`preco_base` - `pr`.`custo_unitario`) AS `margem_bruta_unitaria`,(case when (`pr`.`preco_base` = 0) then 0 else round((((`pr`.`preco_base` - `pr`.`custo_unitario`) / `pr`.`preco_base`) * 100),2) end) AS `percentual_margem` from (`produto` `pr` join `vendedor` `v` on((`v`.`vendedor_id` = `pr`.`vendedor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_repasse_vendedor`
--

/*!50001 DROP VIEW IF EXISTS `vw_repasse_vendedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_repasse_vendedor` AS select `r`.`repasse_id` AS `repasse_id`,`r`.`pagamento_id` AS `pagamento_id`,`pg`.`pedido_id` AS `pedido_id`,`v`.`vendedor_id` AS `vendedor_id`,`v`.`nome_loja` AS `nome_loja`,`pg`.`status_pagamento` AS `status_pagamento`,`r`.`status_repasse` AS `status_repasse`,`r`.`data_prevista` AS `data_prevista`,`r`.`data_repasse` AS `data_repasse`,`r`.`valor_repasse` AS `valor_repasse`,`r`.`comissao_marketplace` AS `comissao_marketplace`,(`r`.`valor_repasse` + `r`.`comissao_marketplace`) AS `valor_venda_vendedor` from ((`repasse` `r` join `pagamento` `pg` on((`pg`.`pagamento_id` = `r`.`pagamento_id`))) join `vendedor` `v` on((`v`.`vendedor_id` = `r`.`vendedor_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_resumo_pedido`
--

/*!50001 DROP VIEW IF EXISTS `vw_resumo_pedido`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_resumo_pedido` AS select `p`.`pedido_id` AS `pedido_id`,`p`.`data_pedido` AS `data_pedido`,`p`.`status_pedido` AS `status_pedido`,`c`.`cliente_id` AS `cliente_id`,`c`.`nome` AS `nome_cliente`,`pe`.`ano` AS `ano`,`pe`.`mes` AS `mes`,count(`pi`.`pedido_item_id`) AS `quantidade_itens`,sum(`pi`.`quantidade`) AS `quantidade_produtos`,sum((`pi`.`quantidade` * `pi`.`preco_unitario`)) AS `subtotal_produtos`,sum(`pi`.`desconto_item`) AS `total_descontos`,`p`.`frete_cobrado` AS `frete_cobrado`,`p`.`frete_subsidiado` AS `frete_subsidiado`,((sum((`pi`.`quantidade` * `pi`.`preco_unitario`)) - sum(`pi`.`desconto_item`)) + `p`.`frete_cobrado`) AS `valor_total_pedido` from (((`pedido` `p` join `cliente` `c` on((`c`.`cliente_id` = `p`.`cliente_id`))) join `periodo` `pe` on((`pe`.`periodo_id` = `p`.`periodo_id`))) join `pedido_item` `pi` on((`pi`.`pedido_id` = `p`.`pedido_id`))) group by `p`.`pedido_id`,`p`.`data_pedido`,`p`.`status_pedido`,`c`.`cliente_id`,`c`.`nome`,`pe`.`ano`,`pe`.`mes`,`p`.`frete_cobrado`,`p`.`frete_subsidiado` */;
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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-29 21:06:25
