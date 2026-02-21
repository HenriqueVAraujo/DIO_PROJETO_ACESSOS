-- 1. Número de empregados por departamento e localidade
CREATE VIEW v_emp_dept_location AS
SELECT d.Dname, l.Llocation, COUNT(e.Ssn) AS Total_Employees
FROM department d
JOIN dept_locations l ON d.Dnumber = l.Dnumber
JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname, l.Llocation;

-- 2. Lista de departamentos e seus gerentes
CREATE VIEW v_dept_managers AS
SELECT d.Dname, e.Fname, e.Lname
FROM department d
JOIN employee e ON d.Mgr_ssn = e.Ssn;

-- 3. Projetos com maior número de empregados
CREATE VIEW v_project_emp_count AS
SELECT Pname, COUNT(Essn) AS Num_Employees
FROM project p
JOIN works_on w ON p.Pnumber = w.Pno
GROUP BY Pname
ORDER BY Num_Employees DESC;

-- 4. Lista de projetos, departamentos e gerentes
CREATE VIEW v_project_details AS
SELECT p.Pname, d.Dname, e.Fname AS Manager_Name
FROM project p
JOIN department d ON p.Dnum = d.Dnumber
JOIN employee e ON d.Mgr_ssn = e.Ssn;

-- 5. Quais empregados possuem dependentes e se são gerentes
CREATE VIEW v_emp_dependents_status AS
SELECT e.Fname, e.Lname, 
       (CASE WHEN d.Mgr_ssn IS NOT NULL THEN 'Sim' ELSE 'Não' END) AS Is_Manager,
       COUNT(dep.Dependent_name) AS Num_Dependents
FROM employee e
LEFT JOIN department d ON e.Ssn = d.Mgr_ssn
LEFT JOIN dependent dep ON e.Ssn = dep.Essn
GROUP BY e.Ssn;

-- DEFINIÇÃO DE PERMISSÕES
-- Criando Usuário Gerente
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha123';
GRANT SELECT ON v_emp_dept_location TO 'gerente'@'localhost';
GRANT SELECT ON v_dept_managers TO 'gerente'@'localhost';

-- Criando Usuário Funcionário (Acesso Limitado)
CREATE USER 'funcionario'@'localhost' IDENTIFIED BY 'senha456';
GRANT SELECT ON v_project_emp_count TO 'funcionario'@'localhost';
