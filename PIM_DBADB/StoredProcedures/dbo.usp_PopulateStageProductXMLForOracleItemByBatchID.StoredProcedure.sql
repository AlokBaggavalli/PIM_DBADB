CREATE Procedure [dbo].[usp_PopulateStageProductXMLForOracleItemByBatchID]
	@BatchID			varchar(10)

as

set nocount on


declare @LocaleID				int,
		@Type					varchar(50),
		@MinID					int,
		@BatchStatus			int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '4'


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
	select	ps.OracleID as Item
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
				and ps.SkuFormatID = 1
		left join PIM_ETL_STAGE.dbo.Stage_OracleItem oi
			on ps.OracleID = oi.Item
	where be.[Status] = '2'
		and be.ID = @MinID
		and oi.Item is null
	group by ps.OracleID
end


if @BatchStatus = 6
begin
	insert PIM_ETL_STAGE.dbo.Stage_OracleItem(Item)
	select	ps.OracleID as Item
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
				and ps.SkuFormatID = 1
		left join PIM_ETL_STAGE.dbo.Stage_OracleItem oi
			on ps.OracleID = oi.Item
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = ps.OracleID	
	where be.[Status] = '6'
		and be.ID = @MinID
		and oi.Item is null
	group by ps.OracleID
end









GO
