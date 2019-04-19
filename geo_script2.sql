USE `geodata`;

ALTER TABLE `region`
DROP FOREIGN KEY `country`;

ALTER TABLE `cities`
DROP FOREIGN KEY `region`;

ALTER TABLE `country`
CHANGE COLUMN `country_id` `id` INT AUTO_INCREMENT,
CHANGE COLUMN `country` `title` VARCHAR(150) NOT NULL,
DROP INDEX `country_id_UNIQUE`,
ADD INDEX `country` (`title`)
;

ALTER TABLE `region`
CHANGE COLUMN `region_id` `id` INT AUTO_INCREMENT,
CHANGE COLUMN `region` `title` VARCHAR(150) NOT NULL,
CHANGE COLUMN `c_id` `country_id` INT NOT NULL,
DROP INDEX `region_id_UNIQUE`,
ADD INDEX `region` (`title`),
ADD CONSTRAINT `r_country` FOREIGN KEY (`country_id`)
	REFERENCES `country`(id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
;

ALTER TABLE `cities`
CHANGE COLUMN `city_id` `id` INT AUTO_INCREMENT,
CHANGE COLUMN `city_name` `title` VARCHAR(150) NOT NULL,
CHANGE COLUMN `r_id` `region_id` INT NOT NULL,
ADD COLUMN `country_id` INT NOT NULL AFTER `id`,
ADD COLUMN `important` TINYINT(1) NOT NULL AFTER `country_id`,
ADD INDEX `city` (`title`),
ADD CONSTRAINT `region` FOREIGN KEY (`region_id`)
	REFERENCES `region`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
ADD CONSTRAINT `country` FOREIGN KEY (`country_id`)
	REFERENCES `country`(`id`)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
;