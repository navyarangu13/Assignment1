SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

GO

SELECT COUNT(*) AS ProductsInSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;





GO

SELECT ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;



GO
SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;




GO

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY ProductID;



GO
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

GO
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100;


GO
SELECT ProductID, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID;


GO

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf;

GO
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf;

GO
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;




GO

SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr
JOIN Person.StateProvince sp ON cr.CountryRegionCode = sp.CountryRegionCode;



GO
SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr
JOIN Person.StateProvince sp ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name IN ('Germany', 'Canada');

GO

SELECT DISTINCT p.ProductID, p.Name
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE soh.OrderDate >= DATEADD(YEAR, -27, GETDATE());

GO
SELECT a.PostalCode AS ZipCode, COUNT(*) AS NumberOfSales
FROM Sales.SalesOrderHeader soh
JOIN Customer.Address a ON soh.ShipToAddressID = a.AddressID
GROUP BY a.PostalCode
ORDER BY NumberOfSales DESC
LIMIT 5;

GO
SELECT a.PostalCode AS ZipCode, COUNT(*) AS NumberOfSales
FROM Sales.SalesOrderHeader soh
JOIN Customer.Address a ON soh.ShipToAddressID = a.AddressID
WHERE soh.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY a.PostalCode
ORDER BY NumberOfSales DESC
LIMIT 5;

GO
SELECT a.City, COUNT(DISTINCT c.CustomerID) AS NumberOfCustomers
FROM Customer.Customer c
JOIN Customer.Address a ON c.AddressID = a.AddressID
GROUP BY a.City;

GO

SELECT a.City, COUNT(DISTINCT c.CustomerID) AS NumberOfCustomers
FROM Customer.Customer c
JOIN Customer.Address a ON c.AddressID = a.AddressID
GROUP BY a.City
HAVING COUNT(DISTINCT c.CustomerID) > 2;

GO

SELECT p.FirstName, p.LastName, soh.OrderDate
FROM Person.Person p
JOIN Sales.Customer c ON p.BusinessEntityID = c.CustomerID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.OrderDate > '1998-01-01';

GO

SELECT p.FirstName, p.LastName, MAX(soh.OrderDate) AS MostRecentOrder
FROM Person.Person p
JOIN Sales.Customer c ON p.BusinessEntityID = c.CustomerID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY p.FirstName, p.LastName
ORDER BY MostRecentOrder DESC;


GO

SELECT p.FirstName, p.LastName, COUNT(sod.ProductID) AS ProductsBought
FROM Person.Person p
JOIN Sales.Customer c ON p.BusinessEntityID = c.CustomerID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY p.FirstName, p.LastName;

GO
SELECT c.CustomerID, COUNT(sod.ProductID) AS ProductsBought
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY c.CustomerID
HAVING COUNT(sod.ProductID) > 100;

GO
SELECT s.CompanyName AS SupplierCompanyName, sm.Name AS ShippingCompanyName
FROM Purchasing.Supplier s
JOIN Purchasing.ShipMethod sm ON s.PreferredShipMethodID = sm.ShipMethodID;

GO 
SELECT soh.OrderDate, p.Name AS ProductName
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
ORDER BY soh.OrderDate;

GO 
SELECT e.ManagerID, COUNT(e.EmployeeID) AS NumberOfEmployees
FROM HumanResources.Employee e
WHERE e.ManagerID IS NOT NULL
GROUP BY e.ManagerID
HAVING COUNT(e.EmployeeID) > 2;

GO

SELECT a.City, c.Name AS CustomerName, c.ContactName, 'Customer' AS Type
FROM Customer.Address a
JOIN Sales.Customer c ON a.AddressID = c.AddressID

UNION

SELECT a.City, s.CompanyName AS SupplierName, s.ContactName, 'Supplier' AS Type
FROM Customer.Address a
JOIN Purchasing.Supplier s ON a.AddressID = s.AddressID;

