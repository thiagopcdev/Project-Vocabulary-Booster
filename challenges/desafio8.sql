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
