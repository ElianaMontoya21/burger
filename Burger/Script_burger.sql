-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_db` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_db` ;

-- -----------------------------------------------------
-- Table `proyecto_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(50) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `password` VARCHAR(250) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_db`.`acompanions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_db`.`acompanions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(250) NULL,
  `price` INT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_db`.`burgers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_db`.`burgers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(250) NULL,
  `price` INT NULL,
  `num_burger` INT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `acompanions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_burgers_acompanions1_idx` (`acompanions_id` ASC) VISIBLE,
  CONSTRAINT `fk_burgers_acompanions1`
    FOREIGN KEY (`acompanions_id`)
    REFERENCES `proyecto_db`.`acompanions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_db`.`drinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_db`.`drinks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` INT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `burgers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_drinks_burgers1_idx` (`burgers_id` ASC) VISIBLE,
  CONSTRAINT `fk_drinks_burgers1`
    FOREIGN KEY (`burgers_id`)
    REFERENCES `proyecto_db`.`burgers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_db`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `burgers_id` INT NOT NULL,
  `drinks_id` INT NOT NULL,
  `acompanions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_users_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_orders_burgers1_idx` (`burgers_id` ASC) VISIBLE,
  INDEX `fk_orders_drinks1_idx` (`drinks_id` ASC) VISIBLE,
  INDEX `fk_orders_acompanions1_idx` (`acompanions_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `proyecto_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_burgers1`
    FOREIGN KEY (`burgers_id`)
    REFERENCES `proyecto_db`.`burgers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_drinks1`
    FOREIGN KEY (`drinks_id`)
    REFERENCES `proyecto_db`.`drinks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_acompanions1`
    FOREIGN KEY (`acompanions_id`)
    REFERENCES `proyecto_db`.`acompanions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
