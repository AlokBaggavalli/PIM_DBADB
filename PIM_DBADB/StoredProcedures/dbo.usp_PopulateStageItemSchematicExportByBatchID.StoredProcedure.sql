CREATE Procedure [dbo].[usp_PopulateStageItemSchematicExportByBatchID] 
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output
as

set nocount on


declare @LocaleID			int,
		@Type				varchar(50),
		@MinID				int,
		@BatchStatus		int
		
		
declare @ItemSchematic	Table	(
									UniqueID			int identity(1,1) Primary Key,
									NPProductCode		nvarchar(50),
									ItemSchematic		nvarchar(1000),
									FinalString			nvarchar(1200)
								)
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '10'




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
	set @ExtractCompleted = '3'
end

if @BatchStatus = 6
begin
	set @ExtractCompleted = '7'
end




if @BatchStatus = 2
begin
	insert @ItemSchematic
		(
			NPProductCode,
			ItemSchematic,
			FinalString
		)			
	select	p.NPProductCode,
			p.ItemSchematic,
			p.NPProductCode + '=' + replace(ISNULL(p.ItemSchematic,''),'.properties','') as FinalString
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end


if @BatchStatus = 6
begin
	insert @ItemSchematic
		(
			NPProductCode,
			ItemSchematic,
			FinalString
		)			
	select	p.NPProductCode,
			p.ItemSchematic,
			p.NPProductCode + '=' + replace(ISNULL(p.ItemSchematic,''),'.properties','') as FinalString
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where be.[Status] = '6'
		and be.ID = @MinID
	order by p.ID
end



insert PIM_ETL_STAGE.dbo.Stage_ItemSchematicForExport 
	(
		NPProductCode,
		ItemSchematic,
		FinalString
	)	
select	NPProductCode,
		ItemSchematic,
		FinalString
from @ItemSchematic
order by UniqueID



GO
