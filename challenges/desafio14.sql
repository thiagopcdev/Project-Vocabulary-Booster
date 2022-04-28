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
