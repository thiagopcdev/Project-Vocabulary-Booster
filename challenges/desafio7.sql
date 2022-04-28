SELECT UCASE(CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME)) AS `Nome completo`,
jh.START_DATE AS `Data de início`,
e.salary AS `Salário`
FROM
  hr.employees e
JOIN hr.job_history jh ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID
WHERE MONTH(jh.START_DATE) <= 3
ORDER BY `Nome completo`, `Data de início`;
