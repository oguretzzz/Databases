1.
SELECT c.title, r.title, co.title
FROM cities c
	LEFT JOIN (region r, country co)
    ON (c.country_id = co.id AND c.region_id = r.id)
WHERE c.title = 'Moscow';

2.
SELECT c.title
FROM cities c
	LEFT JOIN region r
    ON c.country_id = r.id
WHERE r.title = 'Moscow region';


----------------------------------------------------------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `staff` DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS `staff`.`dep` (
  `dep_id` INT NOT NULL AUTO_INCREMENT,
  `dep` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dep_id`),
  UNIQUE INDEX `dep_id_UNIQUE` (`dep_id` ASC) VISIBLE);

CREATE TABLE IF NOT EXISTS `staff`.`employees` (
  `empl_id` INT NOT NULL AUTO_INCREMENT,
  `empl_name` VARCHAR(45) NOT NULL,
  `dep_id` INT NOT NULL,
  `salary` INT NOT NULL,
  PRIMARY KEY (`empl_id`),
  INDEX `dep_idx` (`dep_id` ASC) VISIBLE,
  CONSTRAINT `department`
    FOREIGN KEY (`dep_id`)
    REFERENCES `staff`.`dep` (`dep_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


1.
SELECT dept, avg(salary) FROM employees e
LEFT JOIN dept d
ON e.dep_id = d.dep_id
GROUP BY dept;

2.
SELECT max(salary), empl_name FROM employees;

3.
DELETE FROM employees
ORDER BY salary DESC
LIMIT 1;

4.
SELECT COUNT(empl_id) FROM employees;

5.
SELECT dept, count(empl_name), sum(salary) FROM employees e
LEFT JOIN dept d
ON e.dep_id = d.dep_id
GROUP BY dept;

