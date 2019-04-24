1.
CREATE VIEW Moscow
AS SELECT c.title city, r.title region, co.title counrty
FROM cities c
	LEFT JOIN (region r, country co)
    ON (c.country_id = co.id AND c.region_id = r.id)
WHERE c.title = 'Moscow';

2.
CREATE PROCEDURE `empl_search`(in emplname varchar(20))
SELECT e.empl_name Surname, d.dept Department, e.salary Salary
FROM employees e
LEFT JOIN dept d
ON e.dep_id = d.dep_id
WHERE empl_name = emplname

3.
CREATE TRIGGER `staff`.`welcome`
AFTER INSERT ON employees
FOR EACH ROW
INSERT INTO salaries VALUES (NULL, NEW.empl_id, 100, curdate()); 