DELIMITER $$
CREATE FUNCTION exibir_quantidade_pessoas_contratadas_por_mes_e_ano(mes INT, ano INT)
RETURNS INT READS SQL DATA
BEGIN
DECLARE resp INT;
SELECT COUNT(*) AS `qnt_pessoas_contratadas` FROM hr.employees
WHERE YEAR(hire_date) = ano AND MONTH(hire_date) = mes INTO resp;
RETURN resp;
END $$
DELIMITER ;
