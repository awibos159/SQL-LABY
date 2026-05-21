-- =============================================
-- Dominik
-- Sobos
-- 240440
-- =============================================
-- =============================================
-- zadanie 1
-- =============================================
create type d0_surname from nvarchar(50) not null
go
alter table saleslt.customer
alter column lastname d0_surname
go

-- =============================================
-- zadanie 2
-- =============================================
declare @productinfo nvarchar(max)

set @productinfo =
'[
{"productid":680,"newprice":1200},
{"productid":707,"newprice":1500},
{"productid":710,"newprice":999},
{"productid":715,"newprice":850},
{"productid":720,"newprice":400}
]'
create view saleslt.v_productpricecompare
as
select
p.productid,
p.name,
p.listprice as currentprice,
j.newprice,
j.newprice - p.listprice as pricedifference
from saleslt.product p
join openjson(
'[
{"productid":680,"newprice":1200},
{"productid":707,"newprice":1500},
{"productid":710,"newprice":999},
{"productid":715,"newprice":850},
{"productid":720,"newprice":400}
]'
)
with
(
productid int,
newprice money
) j
on p.productid = j.productid
go

-- =============================================
-- zadanie 3
-- =============================================
create view [240440]_order
as
select top 100
productid,
name,
listprice
from saleslt.product
order by listprice desc
go

-- =============================================
-- zadanie 4
-- =============================================

-- firma chce sprawdzaæ produkty które maj¹ wysok¹ cenê i niski stan na magazynie

create view student_0.mylogicview
as
select
productid,
name,
listprice,
safetystocklevel
from saleslt.product
where listprice > 1000
and safetystocklevel < 500
go

-- =============================================
-- zadanie 5
-- =============================================
create view saleslt.v_expensiveproductsinfo
as
select
productid,
name,
listprice
from [240440]_order
where listprice > 1000
go