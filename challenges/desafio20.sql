DELIMITER $$
CREATE PROCEDURE exibir_historico_completo_por_funcionario(IN email VARCHAR(150))
BEGIN
SELECT
CONCAT(first_name, ' ', last_name) AS `Nome completo`,
d.department_name AS `Departamento`,
j.job_title AS `Cargo`
FROM
hr.employees e
JOIN job_history jh ON jh.employee_id = e.employee_id
JOIN jobs j ON j.job_id = jh.job_id
JOIN departments d ON d.department_id = jh.department_id
WHERE e.email = email
ORDER BY `Departamento`, `Cargo`;
END $$
DELIMITER ;
