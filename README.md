## Projeto Vocabulary Booster!

### Habilidades

  * Criar condicionais no **SQL** usando **IF** e **CASE**

  * Manipular _strings_ no **SQL**

  * Usar as diversas funções matemáticas do **MySQL**

  * Extrair informações específicas sobre datas de uma tabela

  * Utilizar as funções de agregação **AVG**, **MIN**, **MAX**, **SUM** e **COUNT**

  * Exibir e filtrar dados de forma agrupada com **GROUP BY** e **HAVING**

  * Utilizar **INNER JOIN**, **LEFT JOIN**, **RIGHT JOIN** para combinar dados de duas ou mais tabelas

  * Utilizar **SELF JOIN** para fazer join de uma tabela com ela própria

  * Utilizar SUBQUERIES

  * Criar queries mais eficientes através do EXISTS

  * Montar blocos de código **SQL** reutilizáveis com **STORED PROCEDURES** e **STORED FUNCTIONS**

---

Projeto com o codinome _Vocabulary Booster_, em que explorei mais a fundo os conceitos sobre **SQL**.

---

### Requisitos do projeto

#### 1 - Exiba os países e indicando se cada um deles se encontra ou não na região formada pela Europa
~~~SQL
  SELECT c.COUNTRY_NAME AS País,
          IF(r.REGION_NAME = 'Europe', 'incluído', 'não incluído') AS 'Status Inclusão'
  FROM hr.countries AS c
  JOIN hr.regions AS r ON c.REGION_ID = r.REGION_ID
  ORDER BY País;
~~~

#### 2 - Exiba os cargos com seu nível de renumeração associado, com base no salário máximo do cargo
~~~SQL
  SELECT job_title AS `Cargo`,
  CASE
    WHEN max_salary BETWEEN 5000 AND 10000 THEN 'Baixo'
    WHEN max_salary BETWEEN 10001 AND 20000 THEN 'Médio'
    WHEN max_salary BETWEEN 20001 AND 30000 THEN 'Alto'
    WHEN max_salary > 3000 THEN 'Altíssimo'
  END AS `Nível`
  FROM
    hr.jobs
  ORDER BY `Cargo`;
~~~

#### 3 - Exiba os cargos com a diferença entre seus salários máximo e mínimo
~~~SQL
  SELECT job_title AS `Cargo`,
    max_salary - min_salary AS `Diferença entre salários máximo e mínimo`
  FROM
      hr.jobs
  ORDER BY `Diferença entre salários máximo e mínimo`, `Cargo`;
~~~

#### 4 - Exiba a média salarial e o nível de senioridade de todas as pessoas empregadas, agrupadas pelo cargo
~~~SQL
  SELECT j.job_title AS `Cargo`,
  ROUND(AVG(e.SALARY), 2) AS `Média salarial`,
  CASE
  WHEN ROUND(AVG(e.SALARY), 2) BETWEEN 2000 AND 5800 THEN 'Júnior'
  WHEN ROUND(AVG(e.SALARY), 2) BETWEEN 5801 AND 7500 THEN 'Pleno'
  WHEN ROUND(AVG(e.SALARY), 2) BETWEEN 7501 AND 10500 THEN 'Sênior'
  WHEN ROUND(AVG(e.SALARY), 2) > 10500 THEN 'CEO'
  ELSE 'Não Qualificado'
  END AS `Senioridade`
  FROM
    hr.jobs j
  JOIN hr.employees e ON j.JOB_ID = e.JOB_ID
  GROUP BY `Cargo`
  ORDER BY `Média salarial`, `Cargo`;
~~~

#### 5 - Exiba os cargos com sua variação salarial e suas médias máxima e mínima mensal, considerando salários máximo e minímo como anuais
~~~SQL
  SELECT j.job_title AS `Cargo`,
  max_salary - min_salary AS `Variação Salarial`,
  ROUND(min_salary/12, 2) AS `Média mínima mensal`,
  ROUND(max_salary/12, 2) AS `Média máxima mensal`
  FROM
    hr.jobs j
  ORDER BY `Variação Salarial`, `Cargo`;
~~~

#### 6 - Faça um relatório que mostra o histórico de cargos das pessoas empregadas
~~~SQL
  SELECT CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) AS `Nome completo`,
  j.JOB_TITLE AS `Cargo`,
  jh.START_DATE AS `Data de início do cargo`,
  d.DEPARTMENT_NAME AS `Departamento`
  FROM
    hr.job_history jh
  JOIN hr.jobs j ON j.JOB_ID = jh.JOB_ID
  JOIN hr.employees e ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID
  JOIN hr.departments d ON d.DEPARTMENT_ID = jh.DEPARTMENT_ID
  ORDER BY `Nome completo` DESC, `Cargo`;
~~~

#### 7 - Faça um relatório que mostra o histórico de cargos das pessoas empregadas que iniciaram seus cargos nos meses de janeiro, fevereiro ou março
~~~SQL
  SELECT UCASE(CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME)) AS `Nome completo`,
  jh.START_DATE AS `Data de início`,
  e.salary AS `Salário`
  FROM
    hr.employees e
  JOIN hr.job_history jh ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID
  WHERE MONTH(jh.START_DATE) <= 3
  ORDER BY `Nome completo`, `Data de início`;
~~~

#### 8 - Exibe todas as **pessoas consumidoras** cujos pedidos já foram enviados pelas empresas `"Speedy Express"` ou `"United Package"`
~~~SQL
  SELECT
  c.ContactName AS `Nome de contato`,
  s.ShipperName AS `Empresa que fez o envio`,
  o.OrderDate AS `Data do pedido` 
  FROM
      w3schools.customers c
  JOIN 
  w3schools.orders o ON o.CustomerID = c.CustomerID
  JOIN
  w3schools.shippers s ON s.ShipperID = o.ShipperID
  WHERE s.ShipperName = 'Speedy Express' OR s.ShipperName = 'United Package' 
  ORDER BY `Nome de contato`, `Empresa que fez o envio`, `Data do pedido`
~~~

#### 9 - Exibe todos as pessoas funcionárias que já realizaram algum pedido, mostrando também seu total de pedidos feitos
~~~SQL
  SELECT 
  CONCAT(e.FirstName, ' ', e.LastName ) AS `Nome completo`,
  COUNT(e.EmployeeID) AS `Total de pedidos`
  FROM
      w3schools.employees e
  JOIN 
  w3schools.orders o ON o.EmployeeID = e.EmployeeID
  GROUP BY `Nome completo`
  ORDER BY `Total de pedidos`
~~~

#### 10 - Exibe todos os produtos que já foram pedidos, que possuem uma média de quantidade nos pedidos registrados acima de `20.00`
~~~SQL
  SELECT 
  p.ProductName AS `Produto`,
  MIN(od.Quantity) AS `Mínima`,
  MAX(od.Quantity) AS `Máxima`,
  ROUND(AVG(od.Quantity), 2) AS `Média`
  FROM
      w3schools.order_details AS od
  JOIN
  w3schools.products p ON p.ProductID = od.ProductID
  GROUP BY `Produto` HAVING ROUND(AVG(od.Quantity), 2) > 20
  ORDER BY `Média`, `Produto`;
~~~

#### 11 - Exibe todas as pessoas clientes **que possuem compatriotas**, mostrando a quantidade de compatriotas para cada pessoa cliente
~~~SQL
  SELECT
  c1.contactName AS `Nome`,
  c1.country AS `País`,
  COUNT(c1.country) AS `Número de compatriotas`
  FROM
  w3schools.customers c1, w3schools.customers c2
  WHERE c1.country = c2.country AND c1.customerID <> c2.customerID
  GROUP BY `País`, `Nome`
  ORDER BY `Nome`;
~~~

#### 12 - Faça um relatório que lista todas as pessoas funcionárias **que possuem o mesmo cargo**
~~~SQL
  SELECT 
  CONCAT(e1.first_name, ' ', e1.last_name) AS `Nome completo funcionário 1`,
  e1.salary AS `Salário funcionário 1`,
  e1.phone_number AS `Telefone funcionário 1`,
  CONCAT(e2.first_name, ' ', e2.last_name) AS `Nome completo funcionário 2`,
  e2.salary AS `Salário funcionário 2`,
  e2.phone_number AS `Telefone funcionário 2`    
  FROM
  hr.employees e1, hr.employees e2
  WHERE e1.job_id = e2.job_id AND e1.employee_ID <> e2.employee_ID
  ORDER BY `Nome completo funcionário 1`, `Nome completo funcionário 2`;

~~~

#### 13 - Exibe todos produtos **que já tiveram um pedido associado requerindo uma quantidade desse produto maior que 80**
~~~SQL
  SELECT
  p.ProductName AS `Produto`,
  p.Price AS `Preço`
  FROM
  w3schools.products p
  JOIN
  w3schools.order_details od ON od.ProductID = p.ProductID
  WHERE od.Quantity > 80
  ORDER BY `Produto`;
~~~

#### 14 - Considerando o conjunto formado pelas pessoas consumidoras e empresas fornecedoras de produtos, queremos saber quais são os cinco primeiros países distintos, em ordem alfabética, presentes nesse conjunto
~~~SQL
  SELECT
  c.country AS `País`
  FROM
  w3schools.customers c
  UNION
  SELECT
  s.country AS `País`
  FROM
  w3schools.suppliers s
  ORDER BY `País`
  LIMIT 5;
~~~

#### 15 - Crie uma procedure chamada `buscar_media_por_cargo` que recebe como parâmetro o nome de um cargo e em retorno deve mostrar a média salarial de todas as pessoas que possuem esse cargo
~~~SQL
  DELIMITER $$
  CREATE PROCEDURE buscar_media_por_cargo(IN cargo VARCHAR(50))
  BEGIN
  SELECT
  ROUND(AVG(e.salary), 2) AS `Média salarial`
  FROM
  hr.employees e
  JOIN
  hr.jobs j
  ON e.job_id = j.job_id
  WHERE j.job_title = cargo;
  END $$
  DELIMITER ;
~~~

#### 16 - Crie uma função chamada `buscar_quantidade_de_empregos_por_funcionario` no banco de dados `hr` que, ao receber o **email de uma pessoa funcionária**, retorne a quantidade de empregos **presentes em seu histórico**
~~~SQL
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
~~~

#### 17 - Crie uma TRIGGER que, a cada nova inserção realizada na tabela `orders`, insira automaticamente a data atual na coluna `OrderDate`
~~~SQL
  DELIMITER $$
  CREATE TRIGGER set_current_date
  BEFORE INSERT ON w3schools.orders
  FOR EACH ROW
  BEGIN
  SET NEW.OrderDate = NOW();
  END $$
  DELIMITER ;
~~~

#### 18 - Faça um relatório que mostra o **histórico de cargos das pessoas empregadas**, mostrando as datas de início e de saída, assim como os anos que ela ficou nesse cargo
~~~SQL
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
~~~

#### 19 - Crie uma função chamada `exibir_quantidade_pessoas_contratadas_por_mes_e_ano` no banco de dados `hr` que, dados o mês e ano como parâmetros nessa ordem, retorna a quantidade de pessoas funcionárias **que foram contratadas** nesse mês e ano
~~~SQL
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
~~~

#### 20 - Toda pessoa funcionária no banco `hr` possui um histórico completo de cargos. Logo, crie uma procedure chamada `exibir_historico_completo_por_funcionario` que, dado o e-mail de uma pessoa funcionária, retorna todos os cargos em seu histórico
~~~SQL
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
~~~
