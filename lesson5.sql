
2. 
BEGIN;
INSERT INTO employees VALUE (NULL, 'Popov', 2, 400);
INSERT INTO salaries VALUE (NULL, (SELECT empl_id FROM employees WHERE empl_name = 'Popov'), 100, curdate());
COMMIT;

---------------------------------------------------------------------------------------------------------------------------

#Добавляю таблицу уволенных сотрудников
CREATE TABLE IF NOT EXISTS `staff`.`fired_empl` (
	`f_id` INT NOT NULL AUTO_INCREMENT,
	`empl_id` INT NOT NULL,
	`f_date` DATE,
	PRIMARY KEY (`f_id`),
	UNIQUE INDEX `f_idx` (`f_id` ASC) VISIBLE,
	CONSTRAINT `fired`
		FOREIGN KEY (empl_id)
		REFERENCES `staff`.`employees` (`empl_id`));

Добавляю столбец в список сотрудников:
ALTER TABLE employees ADD COLUMN `fired` BOOLEAN;

BEGIN;
INSERT INTO fired_empl VALUE (NULL, (SELECT empl_id FROM employees WHERE empl_name = 'Ivanov'), curdate());
UPDATE employees SET fired = TRUE WHERE empl_name = 'Ivanov';
COMMIT;

3.
EXPLAIN SELECT d.dep, e.empl_name, s.amount
FROM employees e
	LEFT JOIN dep d
		ON e.dep_id = d.dep_id
	RIGHT JOIN salaries s
		ON e.empl_id = s.empl_id
	WHERE d.dep_id = 2
	
+----+-------------+-------+------------+-------+-----------------------------+------------+---------+-----------------+------+----------+-----------------------+
| id | select_type | table | partitions | type  | possible_keys               | key        | key_len | ref             | rows | filtered | Extra                 |
+----+-------------+-------+------------+-------+-----------------------------+------------+---------+-----------------+------+----------+-----------------------+
|  1 | SIMPLE      | d     | NULL       | const | PRIMARY,dep_id_UNIQUE       | PRIMARY    | 4       | const           |    1 |   100.00 | NULL                  |
|  1 | SIMPLE      | e     | NULL       | ref   | PRIMARY,empl_idx,department | department | 4       | const           |    3 |   100.00 | Using index condition |
|  1 | SIMPLE      | s     | NULL       | ref   | salary                      | salary     | 4       | staff.e.empl_id |    1 |   100.00 | NULL                  |
+----+-------------+-------+------------+-------+-----------------------------+------------+---------+-----------------+------+----------+-----------------------+
3 rows in set, 1 warning (0.00 sec)


EXPLAIN SELECT d.dep, avg(salary) FROM employees e LEFT JOIN dep d ON e.dep_id = d.dep_id GROUP BY dep;
+----+-------------+-------+------------+------+-----------------------+------+---------+------+------+----------+----------------------------------------------------+
| id | select_type | table | partitions | type | possible_keys         | key  | key_len | ref  | rows | filtered | Extra                                              |
+----+-------------+-------+------------+------+-----------------------+------+---------+------+------+----------+----------------------------------------------------+
|  1 | SIMPLE      | e     | NULL       | ALL  | NULL                  | NULL | NULL    | NULL |    5 |   100.00 | Using temporary                                    |
|  1 | SIMPLE      | d     | NULL       | ALL  | PRIMARY,dep_id_UNIQUE | NULL | NULL    | NULL |    2 |   100.00 | Using where; Using join buffer (Block Nested Loop) |
+----+-------------+-------+------------+------+-----------------------+------+---------+------+------+----------+----------------------------------------------------+
2 rows in set, 1 warning (0.00 sec)


mysql> use geodata;
Database changed
mysql> EXPLAIN SELECT c.title, r.title, co.title FROM cities c LEFT JOIN (region r, country co) ON (c.country_id = co.id AND c.region_id = r.id) WHERE c.title = 'Moscow';
+----+-------------+-------+------------+--------+---------------+---------+---------+----------------------+------+----------+-------+
| id | select_type | table | partitions | type   | possible_keys | key     | key_len | ref                  | rows | filtered | Extra |
+----+-------------+-------+------------+--------+---------------+---------+---------+----------------------+------+----------+-------+
|  1 | SIMPLE      | c     | NULL       | ref    | city          | city    | 452     | const                |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | r     | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | geodata.c.region_id  |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | co    | NULL       | eq_ref | PRIMARY       | PRIMARY | 4       | geodata.c.country_id |    1 |   100.00 | NULL  |
+----+-------------+-------+------------+--------+---------------+---------+---------+----------------------+------+----------+-------+
3 rows in set, 1 warning (0.00 sec)