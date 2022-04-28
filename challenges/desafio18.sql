SELECT
CONCAT(e.first_name, ' ', e.last_name) AS `Nome completo`,
DATE_FORMAT(jh.start_date, '%d/%m/%Y') AS `Data de início`,
DATE_FORMAT(jh.end_date, '%d/%m/%Y') AS `Data de rescisão`,
ROUND(DATEDIFF(jh.end_date, jh.start_date)/365, 2) AS `Anos trabalhados`
FROM
hr.employees e
JOIN hr.job_history jh ON jh.employee_id = e.employee_id
ORDER BY `Nome Completo`, `Anos trabalhados`
