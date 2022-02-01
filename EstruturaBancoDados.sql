
CREATE DATABASE `teste_wk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `NOME_IDX1` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela destinada ao armazenamento de clientes.';

CREATE TABLE `pedidos_dados_gerais` (
  `numero_pedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `valor_total` float NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  KEY `fk_cliente_idx` (`codigo_cliente`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela destinada ao armazenamento de dados dos pedidos.';

CREATE TABLE `pedidos_produtos` (
  `Autoincrem` int NOT NULL AUTO_INCREMENT,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` float NOT NULL,
  `valor_unitario` float NOT NULL,
  `valor_total` float NOT NULL,
  PRIMARY KEY (`Autoincrem`),
  KEY `fk_pedidos_idx` (`numero_pedido`),
  KEY `fk_produtos_idx` (`codigo_produto`),
  CONSTRAINT `fk_pedidos` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos_dados_gerais` (`numero_pedido`) ON UPDATE CASCADE,
  CONSTRAINT `fk_produtos` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela para armazenar pedidos.';

CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `preco_venda` float NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `descricao_UNIQUE` (`descricao`),
  KEY `descricao_idx1` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela destinada ao armazenamento de produtos.';



