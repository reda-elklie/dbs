CREATE DATABASE IF NOT EXISTS departement COLLATE='utf8mb4_general_ci';
USE departement;

CREATE TABLE DEPARTEMENT (
    ID_DEP INT PRIMARY KEY AUTO_INCREMENT,
    NOM_DEP VARCHAR(50),
    Ville VARCHAR(50)
);

CREATE TABLE EMPLOYE (
    ID_EMP INT PRIMARY KEY,
    NOM_EMP VARCHAR(50),
    PRENOM_EMP VARCHAR(50),
    DATE_NAIS_EMP DATETIME,
    SALAIRE FLOAT,
    ID_DEP INT,
    CONSTRAINT fk_dep FOREIGN KEY (ID_DEP) REFERENCES DEPARTEMENT(ID_DEP)
);

INSERT INTO DEPARTEMENT (NOM_DEP, Ville) VALUES
('Department 1', 'Ville 1'),
('Department 2', 'Ville 2'),
('Department 3', 'Ville 3');

INSERT INTO EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, ID_DEP) VALUES
(1, 'Smith', 'John', '1980-05-20 00:00:00', 50000, 1),
(2, 'Johnson', 'Robert', '1982-03-15 00:00:00', 60000, 1),
(3, 'Williams', 'Michael', '1978-11-10 00:00:00', 55000, 2),
(4, 'Jones', 'William', '1985-08-25 00:00:00', 52000, 2),
(5, 'Brown', 'David', '1981-07-05 00:00:00', 58000, 3);

-- 1. Count the number of employees
delimiter $$
create function countEmploy()
returns int
reads sql data  
begin
declare result int;
set result = (select count(*) employe from employe);
return result;
end $$
delimiter ;

select countEmploy();



-- 2
CREATE FUNCTION sumSalaries() RETURNS FLOAT

    DECLARE sum_result FLOAT;
    SELECT SUM(SALAIRE) INTO sum_result FROM EMPLOYE;
    RETURN sum_result;


-- 3
CREATE FUNCTION minSalary() RETURNS FLOAT

    DECLARE min_result FLOAT;
    SELECT MIN(SALAIRE) INTO min_result FROM EMPLOYE;
    RETURN min_result;

-- 4
CREATE FUNCTION maxSalary() RETURNS FLOAT
BEGIN
    DECLARE max_result FLOAT;
    SELECT MAX(SALAIRE) INTO max_result FROM EMPLOYE;
    RETURN max_result;
END;

-- 5
SELECT countEmployees() AS nb_employees, sumSalaries() AS total_salaries, minSalary() AS min_salary, maxSalary() AS max_salary;

-- 6
CREATE FUNCTION countEmployeesInDepartment(dep_id INT) RETURNS INT

    DECLARE count_result INT;
    SELECT COUNT(*) INTO count_result FROM EMPLOYE WHERE ID_DEP = dep_id;
    RETURN count_result;


-- 7
CREATE FUNCTION sumSalariesInDepartment(dep_id INT) RETURNS FLOAT

    DECLARE sum_result FLOAT;
    SELECT SUM(SALAIRE) INTO sum_result FROM EMPLOYE WHERE ID_DEP = dep_id;
    RETURN sum_result;


-- 8
CREATE FUNCTION minSalaryInDepartment(dep_id INT) RETURNS FLOAT

    DECLARE min_result FLOAT;
    SELECT MIN(SALAIRE) INTO min_result FROM EMPLOYE WHERE ID_DEP = dep_id;
    RETURN min_result;


-- 9
CREATE FUNCTION maxSalaryInDepartment(dep_id INT) RETURNS FLOAT

    DECLARE max_result FLOAT;
    SELECT MAX(SALAIRE) INTO max_result FROM EMPLOYE WHERE ID_DEP = dep_id;
    RETURN max_result;


-- 10
SELECT d.NOM_DEP AS department_name, 
       sumSalariesInDepartment(d.ID_DEP) AS total_salaries, 
       minSalaryInDepartment(d.ID_DEP) AS min_salary, 
       maxSalaryInDepartment(d.ID_DEP) AS max_salary
FROM DEPARTEMENT d;

-- 11
CREATE FUNCTION concatenateStrings(str1 VARCHAR(100), str2 VARCHAR(100)) RETURNS VARCHAR(200)

    DECLARE result_string VARCHAR(200);
    SET result_string = CONCAT(UPPER(str1), ' ', UPPER(str2));
    RETURN result_string;

