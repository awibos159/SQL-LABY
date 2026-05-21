-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- Zadanie 1
-- =============================================
declare @Litera char(1);
declare @Cyfra int;
set @Litera='D';
set @Cyfra=0;
select CustomerID, FirstName, LastName
from SalesLT.Customer
where LastName like @Litera + '%'
and CustomerID % 10 = @Cyfra;
-- =============================================
-- Zadanie 2
-- =============================================
declare @Produkty table(
ProductID int,
Name nvarchar(50),
ListPrice money
)
insert into @Produkty(ProductID,Name,ListPrice)
select ProductID,Name,ListPrice
from SalesLT.Product
where Name like '%D%'
select *
from @Produkty
-- =============================================
-- Zadanie 3
-- =============================================
create table #KlienciMiasta(
CustomerID int,
FirstName nvarchar(50),
LastName nvarchar(50),
City nvarchar(50)
)
insert into #KlienciMiasta(CustomerID,FirstName,LastName,City)
select c.CustomerID,c.FirstName,c.LastName,a.City
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca on c.CustomerID = ca.CustomerID
inner join SalesLT.Address a on ca.AddressID = a.AddressID
where a.City like 'D%'
select * from #KlienciMiasta
drop table #KlienciMiasta
-- =============================================
-- Zadanie 4
-- =============================================
create schema Student_0 authorization dbo
go
create table Student_0.ProduktyD(
ProductID int,
Name nvarchar(100),
Category nvarchar(100),
ListPrice money
)
insert into Student_0.ProduktyD(ProductID,Name,Category,ListPrice)
select p.ProductID,p.Name,pc.Name,p.ListPrice
from SalesLT.Product p
inner join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID
where pc.Name like '%D%'
select * from Student_0.ProduktyD
-- =============================================
-- Zadanie 5
-- =============================================
declare @Podsumowanie table(
Category nvarchar(100),
SredniaCena money
)
insert into @Podsumowanie(Category,SredniaCena)
select pc.Name, AVG(p.ListPrice)
from SalesLT.ProductCategory pc
inner join SalesLT.Product p
on pc.ProductCategoryID = p.ProductCategoryID
where pc.ProductCategoryID % 10 = 0
group by pc.Name
select * from @Podsumowanie
-- =============================================
-- Zadanie 6
-- =============================================
alter schema [240440]
transfer SalesLT.Customer

alter schema [240440]
transfer SalesLT.CustomerAddress