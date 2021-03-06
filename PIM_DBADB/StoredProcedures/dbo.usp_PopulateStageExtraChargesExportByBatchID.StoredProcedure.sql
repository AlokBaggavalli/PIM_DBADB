CREATE Procedure [dbo].[usp_PopulateStageExtraChargesExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on


declare @ExtraCharges	Table	(
									UniqueID				int identity(1,1) Primary Key,
									ID						nvarchar(200),
									chargesDefault			nvarchar(200),
									Blank1					nvarchar(50),
									Blank2					nvarchar(50),
									Locale					nvarchar(50)
								)

declare @LocaleID					int,
		@BType						varchar(50),
		@MinID						int,
		@BatchStatus				int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @BType = '9'



select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @BType
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
	insert @ExtraCharges
	(
		ID,
		chargesDefault,
		Blank1,
		Blank2,
		Locale
	)
	select	ID,
			chargesDefault,
			Blank1,
			Blank2,
			Locale
	from
		(
			select	'/atg/commerce/catalog/SecureProductCatalog:personalizableSku' as ID,
					'' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'LOCALE=en_US' as Locale,
					1 as SortOrder

			union

			select	'ID' as ID,
					'chargesDefault' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					2 as SortOrder
					
			union

			select	ps.OracleID as ID,
					' ' + ps.OracleID + '-SETUP_CRG, ' + ps.OracleID + '-LOGO_CRG' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					3 as SortOrder
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join BatchExtracts be
					on pb.BatchID = be.BatchID
				join ProductSKUs ps
					on p.ID = ps.ProductID
						--and ps.Active = 1 -- Obsolete (Field has been removed)
						and ps.SkuFormatID = 1
			where be.[Status] = '2'
				and be.ID = @MinID
		) t
	order by SortOrder,ID
end



if @BatchStatus = 6
begin
	insert @ExtraCharges
	(
		ID,
		chargesDefault,
		Blank1,
		Blank2,
		Locale
	)
	select	ID,
			chargesDefault,
			Blank1,
			Blank2,
			Locale
	from
		(
			select	'/atg/commerce/catalog/SecureProductCatalog:personalizableSku' as ID,
					'' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'LOCALE=en_US' as Locale,
					1 as SortOrder

			union

			select	'ID' as ID,
					'chargesDefault' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					2 as SortOrder
					
			union

			select	ps.OracleID as ID,
					' ' + ps.OracleID + '-SETUP_CRG, ' + ps.OracleID + '-LOGO_CRG' as chargesDefault,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					3 as SortOrder
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join BatchExtracts be
					on pb.BatchID = be.BatchID
				join ProductSKUs ps
					on p.ID = ps.ProductID
						--and ps.Active = 1 -- Obsolete (Field has been removed)
						and ps.SkuFormatID = 1
				join BatchExtractPartial bep
					on be.BatchID = bep.BatchID
						and be.[Type] = bep.[Type]
						and bep.ProductID = p.ID
						--and bep.[Description] = p.NPProductCode		
						and bep.SkuID = ps.ID
			where be.[Status] = '6'
				and be.ID = @MinID
		) t
	order by SortOrder,ID
end



insert PIM_ETL_STAGE.dbo.Stage_ExtraChargesForExport
(
	ID,
	chargesDefault,
	Blank1,
	Blank2,
	Locale
)	
select	ID,
		chargesDefault,
		Blank1,
		Blank2,
		Locale
from @ExtraCharges
order by UniqueID









GO
