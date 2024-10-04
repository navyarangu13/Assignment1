SELECT DISTINCT c.city
FROM Customers c
JOIN Employees e ON c.city = e.city;

GO 
--using subquery
SELECT DISTINCT c.city
FROM Customers c
WHERE c.city NOT IN (SELECT DISTINCT e.city FROM Employees e);

GO
-- Without using a sub-query 
 SELECT DISTINCT c.city
FROM Customers c
LEFT JOIN Employees e ON c.city = e.city
WHERE e.city IS NULL;

GO
SELECT p.ProductName, SUM(oi.quantity) AS total_quantity
FROM Products p
JOIN UnitsOnOrder ON p.productID = oi.productID
GROUP BY p.productName;

GO
SELECT c.city, SUM(oi.quantity) AS total_quantity
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.orders_id = oi.order_id
GROUP BY c.city;

GO
SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM Customers c
GROUP BY c.city
HAVING COUNT(c.customer_id) >= 2;

GO 

SELECT c.city
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY c.city
HAVING COUNT(DISTINCT oi.product_id) >= 2;

GO

SELECT DISTINCT c.customer_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.city != o.ship_city;

GO

WITH ProductPopularity AS (
    SELECT p.product_name, AVG(p.price) AS avg_price, c.city, SUM(oi.quantity) AS total_quantity,
           ROW_NUMBER() OVER (PARTITION BY p.product_id ORDER BY SUM(oi.quantity) DESC) AS city_rank
    FROM Products p
    JOIN OrderItems oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    JOIN Customers c ON o.customer_id = c.customer_id
    GROUP BY p.product_name, c.city
)
SELECT product_name, avg_price, city, total_quantity
FROM ProductPopularity
WHERE city_rank = 1
ORDER BY total_quantity DESC
LIMIT 5;

GO
--Using a sub-query

SELECT DISTINCT e.city
FROM Employees e
WHERE e.city NOT IN (SELECT DISTINCT c.city FROM Customers c JOIN Orders o ON c.customer_id = o.customer_id);


GO
--Without using a sub-query
SELECT DISTINCT e.city
FROM Employees e
LEFT JOIN Customers c ON e.city = c.city
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

GO 

WITH EmployeeSales AS (
    SELECT e.city AS employee_city, COUNT(o.order_id) AS order_count
    FROM Employees e
    JOIN Orders o ON e.employee_id = o.employee_id
    GROUP BY e.city
    ORDER BY order_count DESC
    LIMIT 1
),
Customers AS (
    SELECT c.city AS customer_city, SUM(oi.quantity) AS total_quantity
    FROM Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderItems oi ON o.order_id = oi.order_id
    GROUP BY c.city
    ORDER BY total_quantity DESC
    LIMIT 1
)
SELECT e.employee_city
FROM EmployeeSales e
JOIN CustomerOrders c ON e.employee_city = c.customer_city;

GO



WITH CTE AS (
    SELECT ProductID, ROW_NUMBER() OVER (PARTITION BY ProductName ORDER BY ProductID) AS row_num
    FROM Products
)
DELETE FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM CTE
    WHERE row_num > 1
);
