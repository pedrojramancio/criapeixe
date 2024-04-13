-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_cria_peixe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_cria_peixe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_cria_peixe` DEFAULT CHARACTER SET utf8mb4 ;
USE `db_cria_peixe` ;

-- -----------------------------------------------------
-- Table `db_cria_peixe`.`AnimalDeCultivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`AnimalDeCultivo` (
  `idAnimal` INT NOT NULL AUTO_INCREMENT COMMENT 'chave do registro Peixe',
  `nmAnimal` VARCHAR(100) NOT NULL COMMENT 'Nome do peixe, ou de qualquer outro bicho que se queira criar',
  UNIQUE INDEX `nmPeixe_UNIQUE` (`nmAnimal` ASC) VISIBLE,
  PRIMARY KEY (`idAnimal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`Tanque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`Tanque` (
  `idTanque` INT NOT NULL AUTO_INCREMENT COMMENT 'chave do registro Tanque',
  `nmTanque` VARCHAR(100) NOT NULL,
  UNIQUE INDEX `nmTanque_UNIQUE` (`nmTanque` ASC) VISIBLE,
  PRIMARY KEY (`idTanque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`UnidadesMedida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`UnidadesMedida` (
  `idUnidadesMedida` INT NOT NULL AUTO_INCREMENT,
  `nmUnidadesMedida` VARCHAR(100) NOT NULL,
  `sgUnidadesMedida` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idUnidadesMedida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`ParametrosAgua`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`ParametrosAgua` (
  `idParametroAgua` INT NULL AUTO_INCREMENT COMMENT 'chave do registro Parâmetro da Água',
  `nmParametroAgua` VARCHAR(100) NOT NULL COMMENT 'Parâmetro da égua a ser usado em um tanque de criação',
  `idUnidadesMedida` INT NOT NULL,
  PRIMARY KEY (`idParametroAgua`),
  UNIQUE INDEX `nmParametroAgua_UNIQUE` (`nmParametroAgua` ASC) VISIBLE,
  INDEX `fk_Parametros_Agua_UnidadesMedida1_idx` (`idUnidadesMedida` ASC) VISIBLE,
  CONSTRAINT `fk_Parametros_Agua_UnidadesMedida1`
    FOREIGN KEY (`idUnidadesMedida`)
    REFERENCES `db_cria_peixe`.`UnidadesMedida` (`idUnidadesMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`ParametrosPorPeixe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`ParametrosPorPeixe` (
  `idPatametroPeixe` VARCHAR(45) NOT NULL,
  `idAnimal` INT NOT NULL,
  `idParametroAgua` INT NOT NULL,
  `nuValorPadrao` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idPatametroPeixe`),
  INDEX `fk_AnimalDeCultivo_has_Parametros_Agua_Parametros_Agua1_idx` (`idParametroAgua` ASC) VISIBLE,
  INDEX `fk_AnimalDeCultivo_has_Parametros_Agua_AnimalDeCultivo_idx` (`idAnimal` ASC) VISIBLE,
  UNIQUE INDEX `idAnimal_UNIQUE` (`idAnimal` ASC) VISIBLE,
  UNIQUE INDEX `idParametroAgua_UNIQUE` (`idParametroAgua` ASC) VISIBLE,
  CONSTRAINT `fk_AnimalDeCultivo_has_Parametros_Agua_AnimalDeCultivo`
    FOREIGN KEY (`idAnimal`)
    REFERENCES `db_cria_peixe`.`AnimalDeCultivo` (`idAnimal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AnimalDeCultivo_has_Parametros_Agua_Parametros_Agua1`
    FOREIGN KEY (`idParametroAgua`)
    REFERENCES `db_cria_peixe`.`ParametrosAgua` (`idParametroAgua`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`ParametrosPorTanque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`ParametrosPorTanque` (
  `idParametroTanque` VARCHAR(45) NOT NULL,
  `idTanque` INT NOT NULL,
  `idParametroAgua` INT NOT NULL,
  `nuValorPadrao` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idParametroTanque`),
  INDEX `fk_Tanque_has_Parametros_Agua_Parametros_Agua1_idx` (`idParametroAgua` ASC) VISIBLE,
  INDEX `fk_Tanque_has_Parametros_Agua_Tanque1_idx` (`idTanque` ASC) VISIBLE,
  UNIQUE INDEX `idTanque_UNIQUE` (`idTanque` ASC) VISIBLE,
  UNIQUE INDEX `idParametroAgua_UNIQUE` (`idParametroAgua` ASC) VISIBLE,
  CONSTRAINT `fk_Tanque_has_Parametros_Agua_Tanque1`
    FOREIGN KEY (`idTanque`)
    REFERENCES `db_cria_peixe`.`Tanque` (`idTanque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tanque_has_Parametros_Agua_Parametros_Agua1`
    FOREIGN KEY (`idParametroAgua`)
    REFERENCES `db_cria_peixe`.`ParametrosAgua` (`idParametroAgua`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_cria_peixe`.`FolhaDeCultivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cria_peixe`.`FolhaDeCultivo` (
  `idFolhaDeCultivo` INT NOT NULL,
  `idParametroTanque` VARCHAR(45) NOT NULL,
  `idPatametroPeixe` VARCHAR(45) NOT NULL,
  `dtCriacao` DATETIME NOT NULL,
  `nmFolhaDeCultivo` VARCHAR(100) NOT NULL,
  INDEX `fk_FolhaDeCultivo_ParametrosPorTanque1_idx` (`idParametroTanque` ASC) VISIBLE,
  INDEX `fk_FolhaDeCultivo_ParametrosPorPeixe1_idx` (`idPatametroPeixe` ASC) VISIBLE,
  PRIMARY KEY (`idFolhaDeCultivo`),
  CONSTRAINT `fk_FolhaDeCultivo_ParametrosPorTanque1`
    FOREIGN KEY (`idParametroTanque`)
    REFERENCES `db_cria_peixe`.`ParametrosPorTanque` (`idParametroTanque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FolhaDeCultivo_ParametrosPorPeixe1`
    FOREIGN KEY (`idPatametroPeixe`)
    REFERENCES `db_cria_peixe`.`ParametrosPorPeixe` (`idPatametroPeixe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
