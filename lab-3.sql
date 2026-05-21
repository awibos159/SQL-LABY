-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- Zadanie 1
-- =============================================
    SELECT 
        soh.SalesOrderID,
        soh.ShipDate,
        a.City,
        a.StateProvince,
        p.Name AS ProductName,
        pd.Description,
        sod.OrderQty,
        sod.LineTotal
    FROM 
        SalesLT.SalesOrderHeader soh
    JOIN 
        SalesLT.Address a ON soh.ShipToAddressID = a.AddressID
    JOIN 
        SalesLT.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN 
        SalesLT.Product p ON sod.ProductID = p.ProductID
    JOIN 
        SalesLT.ProductModelProductDescription pmpd ON p.ProductModelID = pmpd.ProductModelID
    JOIN 
        SalesLT.ProductDescription pd ON pmpd.ProductDescriptionID = pd.ProductDescriptionID
    WHERE 
        a.City IN ('London', 'Cambridge', 'Oxford')
        AND pmpd.Culture = 'en'
        AND soh.ShipDate IS NOT NULL
    ORDER BY 
        soh.ShipDate DESC, a.City ASC;

-- Zapytanie pobiera dane z tabel i ³¹czy je z innymi (SalesOrderHeader, SalesOrderDetail)., ¿eby wyœwietliæ informacje o zamówieniach: co zosta³o kupione, gdzie wys³ane i w jakiej iloœci.
-- Nastêpnie filtruje wyniki do wybranych miast, tylko wys³anych zamówieñ i w konkretnym jêzyku i na koñcu sortuje wed³ug daty wysy³ki i miasta.

-- =============================================
-- Zadanie 2
-- =============================================


    SELECT 
        p.Name AS ProductName,
        pc.Name AS CategoryName,
        SUM(sod.LineTotal) AS TotalRevenue,
        AVG(p.StandardCost) AS AvgCost,
        (SUM(sod.LineTotal) - SUM(sod.UnitPrice * sod.OrderQty)) AS ProfitMargin
    FROM 
        SalesLT.Product p
    JOIN 
        SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    LEFT JOIN 
        SalesLT.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    WHERE 
        p.ProductNumber = '705' 
        OR p.ProductNumber LIKE 'B%'
        AND ISNULL(sod.UnitPrice, 0) > 0
    GROUP BY 
        p.Name, pc.Name
    ORDER BY 
        TotalRevenue DESC;
GO

CREATE NONCLUSTERED INDEX IX_Product_ProductNumber
ON SalesLT.Product (ProductNumber)
INCLUDE (ProductID, ProductCategoryID, Name, StandardCost);
GO

CREATE NONCLUSTERED INDEX IX_SalesOrderDetail_Product
ON SalesLT.SalesOrderDetail (ProductID)
INCLUDE (LineTotal, UnitPrice, OrderQty);
GO

CREATE NONCLUSTERED INDEX IX_ProductCategory_ID
ON SalesLT.ProductCategory (ProductCategoryID)
INCLUDE (Name);
GO

-- =============================================
-- Zadanie 3
-- =============================================
-- =============================================
-- Zadanie 4
-- =============================================
UPDATE STATISTICS SalesLT.VendorPriceHistory;
GO
-- wybra³em tabelê VendorPriceHistory poniewa¿ w takiej tabeli dane czêsto siê zmieniaj¹, wiêc statystyki szybko s¹ nieaktualne.