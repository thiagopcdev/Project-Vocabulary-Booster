DELIMITER $$
CREATE FUNCTION buscar_quantidade_de_empregos_por_funcionario(email VARCHAR(150))
RETURNS INT READS SQL DATA
BEGIN
DECLARE qnt_empregos INT;
SELECT 
COUNT(*)
FROM hr.job_history jh
JOIN hr.employees e ON e.employee_id = jh.employee_id
WHERE e.email = email INTO qnt_empregos;
RETURN qnt_empregos;
END $$
DELIMITER ;
