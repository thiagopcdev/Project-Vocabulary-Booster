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
