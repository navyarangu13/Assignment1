SELECT ProductID , Name , Color , ListPrice 
FROM Production.Product; 

GO

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice > 0; 

GO 

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL;

GO

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL;

GO 

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL
  AND ListPrice > 0;

 GO 

SELECT CONCAT(Name, ' ', Color) AS ProductDescription
FROM Production.Product
WHERE Color IS NOT NULL;

GO 

SELECT CONCAT('NAME: ', Name, ' -- COLOR: ', Color) AS ProductInfo
FROM Production.Product
WHERE (Name IN ('LL Crankarm', 'ML Crankarm', 'HL Crankarm', 'Chainring Bolts', 'Chainring Nut', 'Chainring'))
  AND (Color IN ('Black', 'Silver'));

GO 

SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500;

GO 

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Black', 'Blue');

GO

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%';

GO 

SELECT Name, FORMAT(ListPrice, 'N2') AS ListPrice
FROM Production.Product
ORDER BY Name;

GO 

SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' OR Name LIKE 'S%'
ORDER BY Name;

GO 

SELECT *
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
ORDER BY Name;

GO 

SELECT DISTINCT Color
FROM Production.Product
ORDER BY Color DESC;




