-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atendente` (
  `idAtendente` SMALLINT(3) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Salario` DECIMAL NOT NULL,
  `Telefore` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idAtendente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idMesa` TINYINT(2) NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Atendente_idAtendente` SMALLINT(3) NOT NULL,
  PRIMARY KEY (`idMesa`, `Atendente_idAtendente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Cliente_Atendente1_idx` (`Atendente_idAtendente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Atendente1`
    FOREIGN KEY (`Atendente_idAtendente`)
    REFERENCES `mydb`.`Atendente` (`idAtendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Tempo` INT NOT NULL,
  `Cliente_idMesa` TINYINT(2) NOT NULL,
  `Atendente_idAtendente` SMALLINT(3) NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idMesa`, `Atendente_idAtendente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idMesa` ASC) VISIBLE,
  INDEX `fk_Pedido_Atendente1_idx` (`Atendente_idAtendente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idMesa`)
    REFERENCES `mydb`.`Cliente` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Atendente1`
    FOREIGN KEY (`Atendente_idAtendente`)
    REFERENCES `mydb`.`Atendente` (`idAtendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pratos` (
  `IdPedidos` INT NOT NULL,
  `Codigo` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Preco` FLOAT NOT NULL,
  PRIMARY KEY (`IdPedidos`, `Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bebidas` (
  `idBebidas` INT NOT NULL,
  `Codigo` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Preco` FLOAT NOT NULL,
  PRIMARY KEY (`idBebidas`, `Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido_has_Pratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido_has_Pratos` (
  `Pedido_idPedido` INT NOT NULL,
  `Pratos_IdPedidos` INT NOT NULL,
  `Pratos_Codigo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pratos_IdPedidos`, `Pratos_Codigo`),
  INDEX `fk_Pedido_has_Pratos_Pratos1_idx` (`Pratos_IdPedidos` ASC, `Pratos_Codigo` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Pratos_Pedido_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Pratos_Pedido`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Pratos_Pratos1`
    FOREIGN KEY (`Pratos_IdPedidos` , `Pratos_Codigo`)
    REFERENCES `mydb`.`Pratos` (`IdPedidos` , `Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido_has_Bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido_has_Bebidas` (
  `Pedido_idPedido` INT NOT NULL,
  `Bebidas_idBebidas` INT NOT NULL,
  `Bebidas_Codigo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Bebidas_idBebidas`, `Bebidas_Codigo`),
  INDEX `fk_Pedido_has_Bebidas_Bebidas1_idx` (`Bebidas_idBebidas` ASC, `Bebidas_Codigo` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Bebidas_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Bebidas_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Bebidas_Bebidas1`
    FOREIGN KEY (`Bebidas_idBebidas` , `Bebidas_Codigo`)
    REFERENCES `mydb`.`Bebidas` (`idBebidas` , `Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


