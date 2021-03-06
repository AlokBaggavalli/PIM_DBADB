CREATE Procedure [dbo].[usp_PopulateStageProductPriceListForOracleItemByBatchID]
	@BatchID			varchar(10)

as

set nocount on


declare @LocaleID				int,
		@Type					varchar(50),
		@MinID					int,
		@BatchStatus			int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '7'


select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('2','6')
				)


select @BatchStatus = [Status] from BatchExtracts where ID = @MinID


if @BatchStatus = 2
begin
	insert PIM_ETL_STAGE.dbo.Stage_OracleItem(Item)
	select ps.OracleID as Item
	from
		(
			select	p.ID as ProductID
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join dbo.BatchExtracts be
					on pb.BatchID = be.BatchID
				left join ProductPriceLists ppl
					on p.ID = ppl.ProductID
				left join Locale l
					on l.ID = ppl.PriceListNameID				
			where be.[Status] = '2'
				and be.ID = @MinID
			group by p.ID
		) a
		join ProductSKUs ps
			on a.ProductID = ps.ProductID
				--and ps.Active = 1 -- Obsolete (Field has been removed)
				and ps.SkuFormatID = 1
		left join PIM_ETL_STAGE.dbo.Stage_OracleItem oi
			on ps.OracleID = oi.Item
	where oi.Item is null
	group by ps.OracleID
end


if @BatchStatus = 6
begin
	if @BatchID <> 1
	begin
		insert PIM_ETL_STAGE.dbo.Stage_OracleItem(Item)
		select ps.OracleID as Item
		from
			(
				select	p.ID as ProductID
				from Products p
					join ProductBatches pb
						on p.ID = pb.ProductID
							and pb.ChannelID = 1 -- NADM Only
					join dbo.BatchExtracts be
						on pb.BatchID = be.BatchID
					left join ProductPriceLists ppl
						on p.ID = ppl.ProductID
					left join Locale l
						on l.ID = ppl.PriceListNameID	
					join BatchExtractPartial bep
						on be.BatchID = bep.BatchID
							and be.[Type] = bep.[Type]
							and bep.ProductID = p.ID
							and bep.[Description] = p.NPProductCode		
				where be.[Status] = '6'
					and be.ID = @MinID
				group by p.ID
			) a
			join ProductSKUs ps
				on a.ProductID = ps.ProductID
					--and ps.Active = 1 -- Obsolete (Field has been removed)
					and ps.SkuFormatID = 1
			left join PIM_ETL_STAGE.dbo.Stage_OracleItem oi
				on ps.OracleID = oi.Item
		where oi.Item is null
		group by ps.OracleID
	end
	else
	begin
		insert PIM_ETL_STAGE.dbo.Stage_OracleItem(Item)
		select ps.OracleID as Item
		from
			(
				select	p.ID as ProductID
				from dbo.BatchExtracts be
					join BatchExtractPartial bep
						on be.BatchID = bep.BatchID
							and be.[Type] = bep.[Type]
					join Products p
						on bep.ProductID = p.ID
					--join ProductBatches pb
					--	on p.ID = pb.ProductID
					--		and pb.ChannelID = 1 -- NADM Only -- Take Everything
					join PriceLists plist
						on bep.PriceList = plist.ID
					join ProductPriceLists ppl
						on p.ID = ppl.ProductID
							and ppl.PriceListNameID = plist.ID
					join Locale l
						on l.ID = plist.LocaleID		
				where be.[Status] = '6'
					and be.ID = @MinID
				group by p.ID
				
			) a
			join ProductSKUs ps
				on a.ProductID = ps.ProductID
					--and ps.Active = 1 -- Obsolete (Field has been removed)
					--and ps.SkuFormatID = 1
			left join PIM_ETL_STAGE.dbo.Stage_OracleItem oi
				on ps.OracleID = oi.Item
		where oi.Item is null
		group by ps.OracleID
	end
end












GO
