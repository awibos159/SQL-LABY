-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- zadanie 1
-- =============================================

begin tran
select *
from saleslt.product with (tablockx)
-- tablockx blokuje ca³¹ tabelê i inne sesje musz¹ czekaæ a¿ transakcja zostanie zakoñczona.
waitfor delay '00:05:00'
rollback tran

-- =============================================
-- zadanie 2
-- =============================================

begin tran

update saleslt.address
set city = 'warsaw'
where addressid = 470

update saleslt.address
set city = 'cracow'
where addressid = 471

update saleslt.address
set stateprovince = 'mazowieckie'
where addressid = 479

update saleslt.address
set addressline1 = 'testowa 15'
where addressid = 482

update saleslt.address
set addressline2 = 'mieszkanie 7'
where addressid = 489

insert into saleslt.address(addressline1,city,stateprovince,countryregion,postalcode)
values
('kwiatowa 1', 'warsaw', 'mazowieckie', 'poland', '00-001'),
('leœna 1', 'krakow', 'malopolskie', 'poland', '30-002'),
('polna 3', 'poznan', 'wielkopolskie', 'poland', '60-003'),
('lipowa 7', 'gdansk', 'pomorskie', 'poland', '80-004'),
('szkolna 4', 'lodz', 'lodzkie', 'poland', '90-005'),
('s³oneczna 2', 'lublin', 'lubelskie', 'poland', '20-006'),
('krótka 9', 'katowice', 'slaskie', 'poland', '40-007'),
('d³uga 29', 'wroclaw', 'dolnoslaskie', 'poland', '50-008'),
('ogrodowa 15', 'szczecin', 'zachodniopomorskie', 'poland', '70-009'),
('jasna 10', 'bydgoszcz', 'kujawsko-pomorskie', 'poland', '85-010')
select *
from saleslt.address
update saleslt.product
set color = 'black'
where productid between 740 and 750
select *
from saleslt.product
where productid between 740 and 750
update saleslt.product
set sellenddate = getdate()
where productid between 680 and 690
select *
from saleslt.product
where productid between 680 and 690
truncate table saleslt.productcategory
select *
from saleslt.productcategory
rollback tran
select *
from saleslt.address
select *
from saleslt.product
select *
from saleslt.product
where productid between 680 and 690
-- rollback cofn¹³ wszystkie zmiany, poniewa¿ transakcja nie zosta³a zatwierdzona przez commit.

-- =============================================
-- zadanie 3
-- =============================================

begin tran
update saleslt.address
set city = 'warsaw'
where addressid = 470
update saleslt.product
set color = 'brown'
where productid between 740 and 745
waitfor delay '00:05:00'
rollback tran
go
-- niezale¿na sesja
select *
from saleslt.product
where productid between 740 and 745
select *
from saleslt.product with (nolock)
where productid between 740 and 745
-- with (nolock) pozwala odczytaæ dane mimo blokady, ale mog¹ to byæ raczej dane jeszcze niezatwierdzone.

-- =============================================
-- zadanie 4
-- =============================================

begin try
select 10/0 as errortest
end try
begin catch
select
error_number() as errornumber,
error_line() as errorline,
error_message() as errormessage
end catch
go

-- po zrobieniu zapytania powinien pojawiæ siê b³¹d dzielenia przez zero przechwycony przez try i catch.

-- =============================================
-- zadanie 5
-- =============================================
-- zrobi³em prost¹ logikê dotycz¹c¹ dodawania nowego klienta, najpierw sprawdzam czy pola nie s¹ puste, potem czy email ju¿ istnieje, a jak wszystko jest dobrze to dodaje klienta do tabeli
-- mo¿liwe b³êdy:brak danych, duplikat maila, b³êdy przy insercie

declare @firstname nvarchar(50) = 'dominik'
declare @lastname nvarchar(50) = 'sobos'
declare @emailaddress nvarchar(50) = '240440@student.uek.krakow.pl'
declare @phone nvarchar(25) = '123456789'
begin try
if @firstname is null or ltrim(rtrim(@firstname)) = ''
begin
throw 50001, 'imie nie moze byc puste', 1
end
if @lastname is null or ltrim(rtrim(@lastname)) = ''
begin
throw 50002, 'nazwisko nie moze byc puste', 1
end
if @emailaddress is null or ltrim(rtrim(@emailaddress)) = ''
begin
throw 50003, 'email nie moze byc pusty', 1
end
if exists
(
select 1
from saleslt.customer
where emailaddress = @emailaddress
)
begin
throw 50004, 'klient z takim mailem juz istnieje', 1
end
insert into saleslt.customer(firstname,lastname,emailaddress,phone)
values (@firstname,@lastname,@emailaddress,@phone)
select 'klient dodany poprawnie' as status
end try
begin catch
select
error_number() as errornumber,
error_line() as errorline,
error_message() as errormessage
end catch

-- =============================================
-- zadanie 6
-- =============================================
-- rozszerzenie z zadania 5
-- ró¿nice: teraz wszystko dzia³a w jednej transakcji, oprócz klienta dodawany bêdzie te¿ adres, jak coœ siê zepsuje to rollback cofnie wszystko
declare @firstname2 nvarchar(50) = 'dominik'
declare @lastname2 nvarchar(50) = 'sobos'
declare @emailaddress2 nvarchar(50) = '240440@student.uek.katowice.pl'
declare @phone2 nvarchar(25) = '111222333'
declare @addressline1 nvarchar(60) = 'grunwaldzka 99'
declare @city nvarchar(30) = 'jaworzno'
declare @stateprovince nvarchar(50) = 'slaskie'
declare @countryregion nvarchar(50) = 'poland'
declare @postalcode nvarchar(15) = '43-600'
declare @customerid int
declare @addressid int
begin try
begin tran
if @firstname2 is null or ltrim(rtrim(@firstname2)) = ''
begin
throw 50010, 'imie nie moze byc puste', 1
end
if exists
(
select 1
from saleslt.customer
where emailaddress = @emailaddress2
)
begin
throw 50011, 'taki email juz istnieje', 1
end

insert into saleslt.customer
(
firstname,
lastname,
emailaddress,
phone
)
values
(
@firstname2,
@lastname2,
@emailaddress2,
@phone2
)
set @customerid = scope_identity()
insert into saleslt.address
(
addressline1,
city,
stateprovince,
countryregion,
postalcode
)
values
(
@addressline1,
@city,
@stateprovince,
@countryregion,
@postalcode
)
set @addressid = scope_identity()
insert into saleslt.customeraddress
(
customerid,
addressid,
addresstype
)
values
(
@customerid,
@addressid,
'main office'
)
commit tran
select 'klient i adres dodane poprawnie' as status
end try
begin catch
if @@trancount > 0
begin
rollback tran
end
select
error_number() as errornumber,
error_line() as errorline,
error_message() as errormessage
end catch