CREATE SCHEMA IF NOT EXISTS `geodata` DEFAULT CHARACTER SET utf8 

CREATE TABLE IF NOT EXISTS `geodata`.`cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `r_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `region_idx` (`r_id` ASC) VISIBLE,
  CONSTRAINT `region`
    FOREIGN KEY (`r_id`)
    REFERENCES `geodata`.`region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

CREATE TABLE IF NOT EXISTS `geodata`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `country_id_UNIQUE` (`country_id` ASC) VISIBLE)

CREATE TABLE IF NOT EXISTS `geodata`.`region` (
  `region_id` INT NOT NULL AUTO_INCREMENT,
  `region` VARCHAR(45) NOT NULL,
  `c_id` INT NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `region_id_UNIQUE` (`region_id` ASC) VISIBLE,
  INDEX `country_idx` (`c_id` ASC) VISIBLE,
  CONSTRAINT `country`
    FOREIGN KEY (`c_id`)
    REFERENCES `geodata`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
