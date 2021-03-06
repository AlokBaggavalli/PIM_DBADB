Create Procedure [dbo].[usp_PopulateStageMassPriceListForOracleItem]
	@BatchID			varchar(10)

as

set nocount on


declare @LocaleID				int,
		@Type					varchar(50),
		@MinID					int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '7'



insert Stage_OracleItem(Item)
select ps.OracleID as Item
from
	(
		select	p.ID as ProductID
		from Products p
			join dbo.MassPriceUpdate mpu
				on p.ID = mpu.ProductID
			left join ProductPriceLists ppl
				on p.ID = ppl.ProductID
			left join Locale l
				on l.ID = ppl.PriceListNameID
		where mpu.StatusID = 2
		group by p.ID
	) a
	join ProductSKUs ps
		on a.ProductID = ps.ProductID
	left join dbo.Stage_OracleItem oi
		on ps.OracleID = oi.Item
where oi.Item is null
group by ps.OracleID

GO
