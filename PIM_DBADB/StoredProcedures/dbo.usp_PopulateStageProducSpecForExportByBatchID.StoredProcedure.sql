CREATE Procedure [dbo].[usp_PopulateStageProducSpecForExportByBatchID]
	@BatchID		varchar(10)

as

set nocount on

declare @LocaleID		int,
		@Type			varchar(50),
		@MinID			int,
		@BatchStatus	int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '2'


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
	insert PIM_ETL_STAGE.dbo.Stage_ProductSpecForExport
	(
		ID,
		prodSpecDefault,
		prodSpecPriority,
		Blank1,
		Blank2,
		Locale
	)
	select	ID,
			prodSpecDefault,
			prodSpecPriority,
			Blank1,
			Blank2,
			Locale
	from
		(
			select	'/atg/commerce/catalog/SecureProductCatalog:personalizableProduct' as ID,
					'FORMAT=itemized' as prodSpecDefault,
					'prodSpecPriority' as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'LOCALE=en_US' as Locale,
					1 as [Priority]
					
			union

			select	'ID' as ID,
					'prodSpecDefault' as prodSpecDefault,
					'prodSpecPriority' as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					2 as [Priority]
					
			union		
					

			select	isnull(atg.Product_ID,p.NPProductCode) ID,
					ps.[Key] + '=' + ps.Value as prodSpecDefault,
					ps.[Key] + '=' + CONVERT(varchar(10),ps.[Priority] + 1) as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					ps.[Priority] + 100 as [Priority]
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join dbo.BatchExtracts be
					on pb.BatchID = be.BatchID
				Join ProductSpecs ps
					on p.ID = ps.ProductID
						and ps.LocaleID = @LocaleID
				Join Locale l
					on l.ID = @LocaleID
				Left Join dbo.ATGView_Product_Main atg
					on p.NPProductCode = atg.Display_Name
						and atg.Locale = l.Locale
			where be.[Status] = '2'
				and be.ID = @MinID
		) t
	order by ID,[Priority]
end




if @BatchStatus = 6
begin
	insert PIM_ETL_STAGE.dbo.Stage_ProductSpecForExport
	(
		ID,
		prodSpecDefault,
		prodSpecPriority,
		Blank1,
		Blank2,
		Locale
	)
	select	ID,
			prodSpecDefault,
			prodSpecPriority,
			Blank1,
			Blank2,
			Locale
	from
		(
			select	'/atg/commerce/catalog/SecureProductCatalog:personalizableProduct' as ID,
					'FORMAT=itemized' as prodSpecDefault,
					'prodSpecPriority' as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'LOCALE=en_US' as Locale,
					1 as [Priority]
					
			union

			select	'ID' as ID,
					'prodSpecDefault' as prodSpecDefault,
					'prodSpecPriority' as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					2 as [Priority]
					
			union		
					

			select	isnull(atg.Product_ID,p.NPProductCode) ID,
					ps.[Key] + '=' + ps.Value as prodSpecDefault,
					ps.[Key] + '=' + CONVERT(varchar(10),ps.[Priority] + 1) as prodSpecPriority,
					'' as Blank1,
					'' as Blank2,
					'' as Locale,
					ps.[Priority] + 100 as [Priority]
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join dbo.BatchExtracts be
					on pb.BatchID = be.BatchID
				Join ProductSpecs ps
					on p.ID = ps.ProductID
						and ps.LocaleID = @LocaleID
				Join Locale l
					on l.ID = @LocaleID
				Left Join dbo.ATGView_Product_Main atg
					on p.NPProductCode = atg.Display_Name
						and atg.Locale = l.Locale
				join BatchExtractPartial bep
					on be.BatchID = bep.BatchID
						and be.[Type] = bep.[Type]
						and bep.ProductID = p.ID
						and bep.[Description] = p.NPProductCode		
			where be.[Status] = '6'
				and be.ID = @MinID
		) t
	order by ID,[Priority]
end









GO
