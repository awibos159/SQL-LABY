-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- Zadanie 1
-- =============================================

-- https://github.com/awibos159/SQL-LABY.git

-- =============================================
-- Zadanie 2
-- =============================================

alter table [240440].[customer]
Add startdate datetime2 generated always as row start not null
default sysutcdatetime(),
enddate datetime2 generated always as row end not null
default convert(datetime2,'9999-12-31 23:59:59.9999999'),
period for system_time(startdate,enddate);
GO

alter table [240440].[customer]
set(system_versioning=on(history_table=[240440].[customerhistory]));
GO

-- =============================================
-- Zadanie 3
-- =============================================

Update top(10) [240440].[customer]
set companyname='firma_0';
GO

update [240440].[customer]
Set firstname='kamil'
where customerid=1;
GO

update [240440].[customer]
set firstname='pawe³'
where customerid=1;
GO

Update [240440].[customer]
set firstname='marek'
where customerid=1;
GO

declare @czas datetime2=sysutcdatetime();

Insert into [240440].[customer]
(firstname,lastname,companyname,emailaddress,phone)
values
('jan','doda','tesla','tesla@wow.pl','123456789'),
('anna','durda','strza³ka','strza³ka@wow.pl','123456788'),
('piotr','d¹b','miêso','mieso@wow.pl','123456777'),
('ola','drzewo','ogieñ','ogien@wow.pl','123456807'),
('tomek','dzik','warzywa','warzywa@wow.pl','123567345');
GO

-- =============================================
-- Zadanie 4
-- =============================================

Select *
from [240440].[customer]
FOR system_time all
where customerid=1;
GO

-- =============================================
-- Zadanie 5
-- =============================================

select *
From [240440].[customer]
for system_time as of '2026-05-21 08:00:00.000000';
GO

-- =============================================
-- Zadanie 6
-- =============================================

Create xml schema collection productxml as
N'
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="Data">
<xs:complexType>
<xs:sequence>
<xs:element name="Weight" type="xs:string"/>
<xs:element name="Color" type="xs:string"/>
<xs:element name="Material" type="xs:string"/>
<xs:element name="Height" type="xs:string"/>
<xs:element name="Width" type="xs:string"/>
</xs:sequence>
</xs:complexType>
</xs:element>
</xs:schema>';
GO

create table [SalesLT].[ProductAttribute]
(
Id int identity(1,1) primary key,
ProductID int,
Info xml(ProductXML),
foreign key(ProductID)
references [SalesLT].[Product](ProductID)
);
GO

-- =============================================
-- Zadanie 7
-- =============================================

Insert into [SalesLT].[ProductAttribute]
(ProductID,Info)
values
(680,
'<Data>
<Weight>10kg</Weight>
<Color>Black</Color>
<Material>Steel</Material>
<Height>100</Height>
<Width>50</Width>
</Data>'),
(706,
'<Data>
<Weight>5kg</Weight>
<Color>Blue</Color>
<Material>Plastic</Material>
<Height>70</Height>
<Width>30</Width>
</Data>'),
(707,
'<Data>
<Weight>8kg</Weight>
<Color>White</Color>
<Material>Wood</Material>
<Height>80</Height>
<Width>35</Width>
</Data>'),
(708,
'<Data>
<Weight>12kg</Weight>
<Color>Red</Color>
<Material>Iron</Material>
<Height>90</Height>
<Width>45</Width>
</Data>'),
(709,
'<Data>
<Weight>15kg</Weight>
<Color>Green</Color>
<Material>Carbon</Material>
<Height>95</Height>
<Width>55</Width>
</Data>');
GO

-- =============================================
-- Zadanie 8
-- =============================================

update [SalesLT].[ProductAttribute]
SET Info.modify('replace value of (/Data/Color/text())[1]
with concat("D",(/Data/Color/text())[1])');
GO

Update [SalesLT].[ProductAttribute]
set Info.modify('replace value of (/Data/Material/text())[1]
with concat("D",(/Data/Material/text())[1])');
GO

-- =============================================
-- Zadanie 9
-- =============================================

declare @json nvarchar(max)=
N'{
"name":"produkt",
"type":"gra",
"status":"uzywana"
}';
Set @json=json_modify(@json,'$.status','240440');
select @json;
GO