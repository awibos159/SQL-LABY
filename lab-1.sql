-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- Zadanie 1
-- =============================================
Select *
From SalesLT.Customer
Where LastName LIKE 'D%';
GO
-- =============================================
-- Zadanie 2
-- =============================================
SELECT FirstName, LastName, EmailAddress
FROM SalesLT.Customer
WHERE CustomerID % 10 = 0;
GO
-- =============================================
-- Zadanie 3
-- =============================================
SELECT Name, ListPrice, ProductNumber
FROM SalesLT.Product
WHERE Name LIKE '%D%'
ORDER BY ListPrice DESC;
GO
-- =============================================
-- Zadanie 4
-- =============================================
SELECT AVG(ListPrice) AS AvgPrice
FROM SalesLT.Product
WHERE ProductCategoryID % 10 = 0;
GO
-- =============================================
-- Zadanie 5
-- =============================================
SELECT DISTINCT A.City
FROM SalesLT.CustomerAddress CA
JOIN SalesLT.Address A ON CA.AddressID = A.AddressID
WHERE A.City LIKE 'D%';
GO
-- =============================================
-- Zadanie 6
-- =============================================
INSERT INTO SalesLT.Customer (FirstName, LastName, CompanyName, EmailAddress)
VALUES ('Dominik', 'Sobos', 'Lab0', 'dominik.sobos@lab0.com');
GO
SELECT *
FROM SalesLT.Customer
WHERE FirstName = 'Dominik'
AND LastName = 'Sobos'
AND CompanyName = 'Lab0'
AND EmailAddress = 'dominik.sobos@lab0.com';
GO
-- =============================================
-- Zadanie 7
-- =============================================
INSERT INTO SalesLT.ProductCategory (Name)
VALUES ('Special-D'), ('Extra-0');
GO
-- =============================================
-- Zadanie 8
-- =============================================
SELECT p.Name, p.ProductNumber, pc.Name AS CategoryName, 240440 AS OwnerId
INTO ProductsCategories240440
FROM SalesLT.Product p
JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.Name LIKE 'D%D'
OR pc.Name LIKE '%D%';
GO
-- =============================================
-- Zadanie 9
-- =============================================
SELECT CategoryName, COUNT(*) AS ProductCount
FROM ProductsCategories240440
GROUP BY CategoryName;
GO