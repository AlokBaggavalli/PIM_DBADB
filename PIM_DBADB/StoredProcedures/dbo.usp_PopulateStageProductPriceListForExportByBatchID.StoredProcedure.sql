CREATE Procedure [dbo].[usp_PopulateStageProductPriceListForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @ProductPriceMainID			int,
		@PriceList_Name				nvarchar(255),
		@PriceListID				int,
		@Item						nvarchar(255),
		@ListPrice					money,
		@Free						int,
		@QtyFrom					int,
		@QtyTo						int,
		@Price						money,
		@UpsellQty					int,
		@UpsellPrice				money,
		@MaxCount					int,
		@Counter					int,
		@SetupCharge				money,
		@LogoCharge					money,
		@LocaleID					int,
		@Type						varchar(50),
		@MinID						int,
		@SKU						nvarchar(255),
		@T_ProductCodeListID		int,
		@T_PriceListID				nvarchar(50),
		@T_PriceListName			nvarchar(255),
		@T_NPProductCode			nvarchar(255),
		@Z_TopPriceListID			int,
		@Z_PriceListID				nvarchar(50),
		@Z_PriceListName			nvarchar(255),
		@Z_Description				nvarchar(255),
		@Z_PriceListOrg				nvarchar(255),
		@Z_Status					nvarchar(50),
		@Z_CurrencyCode				nvarchar(50),
		@Z_Country					nvarchar(50),
		@Z_ATGSiteID				nvarchar(50),
		@Z_StartDateActive			varchar(50),
		@Z_EndDateActive			varchar(50),
		@BatchStatus				int,
		@PListLocaleID				int



--declare @ProductPriceMain	Table	(
--										ProductPriceMainID						int identity(1,1) Primary Key,
--										ProductID								int,
--										ProductPriceListID						int,
--										PriceListID								nvarchar(50),
--										PriceListName							nvarchar(255),
--										[Description]							nvarchar(255),
--										PriceListOrg							nvarchar(255),
--										[Status]								nvarchar(50),
--										CurrencyCode							nvarchar(50),
--										Country									nvarchar(50),
--										ATGSiteID								nvarchar(50),
--										OrderType								nvarchar(50),
--										CustomerClass							nvarchar(50),
--										StartDateActive							datetime,
--										EndDateActive							datetime,
--										NPProductCode							nvarchar(255),
--										ListPrice								money,
--										Free									int,
--										SetUpCharge								money,
--										LogoCharge								money,								
--										CSVUsed									int default(0),
--										XMLUsed									int default(0)
--									)


Create Table #ProductPriceMain		(
										ProductPriceMainID						int identity(1,1) Primary Key,
										ProductID								int,
										ProductPriceListID						int,
										PriceListID								nvarchar(50),
										PriceListName							nvarchar(255),
										[Description]							nvarchar(255),
										PriceListOrg							nvarchar(255),
										[Status]								nvarchar(50),
										CurrencyCode							nvarchar(50),
										Country									nvarchar(50),
										ATGSiteID								nvarchar(50),
										OrderType								nvarchar(50),
										CustomerClass							nvarchar(50),
										StartDateActive							datetime,
										EndDateActive							datetime,
										NPProductCode							nvarchar(255),
										ListPrice								money,
										Free									int,
										SetUpCharge								money,
										LogoCharge								money,								
										CSVUsed									int default(0),
										XMLUsed									int default(0)
									)


CREATE NONCLUSTERED INDEX [IX_#ProductPriceMain_ProductID_ProductPriceListID] ON #ProductPriceMain
(
	[ProductID] ASC,
	[ProductPriceListID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


									
declare @TopPriceListLevel	Table	(
										TopPriceListID							int identity(1,1) Primary Key,
										PriceListID								nvarchar(50),
										PriceListName							nvarchar(255),
										[Description]							nvarchar(255),
										PriceListOrg							nvarchar(255),
										[Status]								nvarchar(50),
										CurrencyCode							nvarchar(50),
										Country									nvarchar(50),
										ATGSiteID								nvarchar(50),
										StartDateActive							datetime,
										EndDateActive							datetime
									)
									
									
declare @ProductCodeList	Table	(
										ProductCodeListID					int identity(1,1) Primary Key,
										PriceListID							nvarchar(50),
										PriceListName						nvarchar(255),
										NPProductCode						nvarchar(255)
									)									

									
declare @ProductSKUs	Table	(
									ProductSKUID				int identity(1,1) Primary Key,
									ProductPriceMainID			int,
									ProductID					int,
									ProductPriceListID			int,
									ItemRelation				nvarchar(50),
									ItemID						nvarchar(50),
									Item						nvarchar(255)
								)
								
								
declare @ProductSKUsHold	Table	(
										ProductSKUID				int identity(1,1) Primary Key,
										ProductPriceMainID			int,
										ProductID					int,
										ProductPriceListID			int,
										ItemRelation				nvarchar(50),
										ItemID						nvarchar(50),
										Item						nvarchar(255)
									)
									
--declare @PriceList	Table	(
--								PriceListID						int identity(1,1) Primary Key,
--								ProductPriceMainID				int,
--								PriceListName					nvarchar(255),
--								ListPrice						money,
--								Free							int,
--								ItemID							nvarchar(50),
--								Item							nvarchar(255),
--								QtyFrom							int,
--								QtyTo							int,
--								Price							money,
--								UpsellQty						int,
--								UpsellPrice						money,
--								CSVUsed							int default(0),
--								XMLUsed							int default(0),
--								NPProductCode					nvarchar(255)
--							)


Create Table #PriceList		(
								PriceListID						int identity(1,1) Primary Key,
								ProductPriceMainID				int,
								PriceListName					nvarchar(255),
								ListPrice						money,
								Free							int,
								ItemID							nvarchar(50),
								Item							nvarchar(255),
								QtyFrom							int,
								QtyTo							int,
								Price							money,
								UpsellQty						int,
								UpsellPrice						money,
								CSVUsed							int default(0),
								XMLUsed							int default(0),
								NPProductCode					nvarchar(255)
							)
							
							
CREATE NONCLUSTERED INDEX [IX_#PriceList_ProductPriceMainID_Used] ON #PriceList
(
	[ProductPriceMainID] ASC,
	[CSVUsed] ASC,
	[XMLUsed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE NONCLUSTERED INDEX [IX_#PriceList_Item_PriceListName_CSVUsed] ON #PriceList
(
	[Item] ASC,
	[PriceListName] ASC,
	[CSVUsed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE NONCLUSTERED INDEX [IX_#PriceList_Item_PriceListName_XMLUsed] ON #PriceList
(
	[PriceListName] ASC,
	[NPProductCode] ASC,
	[XMLUsed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



declare @SetupTable	Table	(
								SetupID							int identity(1,1) Primary Key,
								ProductPriceMainID				int,
								ChargeType						nvarchar(255),
								ApplicationMethod				nvarchar(50),
								ChargeAmount					money
							)
							
							
--declare @PriceListCSV	Table	(
--									PriceListCSVID				int identity(1,1) Primary Key,
--									PRICELIST_NAME				nvarchar(255),
--									ITEM_LEVEL					nvarchar(50),
--									ITEM						nvarchar(255),
--									LIST_PRICE					money,
--									PRICE1						money,
--									PRICE2						money,
--									PRICE3						money,
--									PRICE4						money,
--									PRICE5						money,
--									PRICE6						money,
--									PRICE7						money,
--									PRICE8						money,
--									PRICE9						money,
--									PRICE10						money,
--									PRICE11						money,
--									PRICE12						money,
--									QTY1						int,
--									QTY2						int,
--									QTY3						int,
--									QTY4						int,
--									QTY5						int,
--									QTY6						int,
--									QTY7						int,
--									QTY8						int,
--									QTY9						int,
--									QTY10						int,
--									QTY11						int,
--									QTY12						int,
--									FREE						int,
--									UPSELL1						int,
--									UPSELL2						int,
--									UPSELL3						int,
--									UPSELL4						int,
--									UPSELL5						int,
--									UPSELL6						int,
--									UPSELL7						int,
--									UPSELL8						int,
--									UPSELL9						int,
--									UPSELL10					int,
--									UPSELL11					int,
--									UPSELL12					int,
--									UPSELLPRICE1				money,
--									UPSELLPRICE2				money,
--									UPSELLPRICE3				money,
--									UPSELLPRICE4				money,
--									UPSELLPRICE5				money,
--									UPSELLPRICE6				money,
--									UPSELLPRICE7				money,
--									UPSELLPRICE8				money,
--									UPSELLPRICE9				money,
--									UPSELLPRICE10				money,
--									UPSELLPRICE11				money,
--									UPSELLPRICE12				money,
--									CHARGES1					money,
--									CHARGES2					money
--								)

Create Table #PriceListCSV		(
									PriceListCSVID				int identity(1,1) Primary Key,
									PRICELIST_NAME				nvarchar(255),
									ITEM_LEVEL					nvarchar(50),
									ITEM						nvarchar(255),
									LIST_PRICE					money,
									PRICE1						money,
									PRICE2						money,
									PRICE3						money,
									PRICE4						money,
									PRICE5						money,
									PRICE6						money,
									PRICE7						money,
									PRICE8						money,
									PRICE9						money,
									PRICE10						money,
									PRICE11						money,
									PRICE12						money,
									QTY1						int,
									QTY2						int,
									QTY3						int,
									QTY4						int,
									QTY5						int,
									QTY6						int,
									QTY7						int,
									QTY8						int,
									QTY9						int,
									QTY10						int,
									QTY11						int,
									QTY12						int,
									FREE						int,
									UPSELL1						int,
									UPSELL2						int,
									UPSELL3						int,
									UPSELL4						int,
									UPSELL5						int,
									UPSELL6						int,
									UPSELL7						int,
									UPSELL8						int,
									UPSELL9						int,
									UPSELL10					int,
									UPSELL11					int,
									UPSELL12					int,
									UPSELLPRICE1				money,
									UPSELLPRICE2				money,
									UPSELLPRICE3				money,
									UPSELLPRICE4				money,
									UPSELLPRICE5				money,
									UPSELLPRICE6				money,
									UPSELLPRICE7				money,
									UPSELLPRICE8				money,
									UPSELLPRICE9				money,
									UPSELLPRICE10				money,
									UPSELLPRICE11				money,
									UPSELLPRICE12				money,
									CHARGES1					money,
									CHARGES2					money
								)

CREATE NONCLUSTERED INDEX [IX_#PriceListCSVt_Item_PRICELIST_NAME] ON #PriceListCSV
(
	[Item] ASC,
	[PRICELIST_NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



declare @XMLFinal	Table	(
								UniqueID				int identity(1,1) Primary Key,
								LineVal					varchar(250)
							)
							
							
							
							
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '7'
set @PListLocaleID = @LocaleID


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
	insert #ProductPriceMain
	(
		ProductID,
		ProductPriceListID,
		PriceListID,
		PriceListName,
		[Description],
		PriceListOrg,
		[Status],
		CurrencyCode,
		Country,
		ATGSiteID,
		OrderType,
		CustomerClass,
		StartDateActive,
		EndDateActive,
		NPProductCode,
		ListPrice,
		Free
	)
	select	p.ID as ProductID,
			ppl.ID as ProductPriceListID,
			isnull(plist.OracleID,plist.ID) as PriceListID,
			plist.Name as PriceListName,
			plist.Name as [Description],
			plist.Org as PriceListOrg,
			'ACTIVE' as [Status],
			plist.Currency as CurrencyCode,
			l.CountryCode as Country,
			l.ATGSiteID as ATGSiteID,
			'' as OrderType,
			'' as CustomerClass,
			isnull(plist.EffectiveFrom,'20101202') as StartDateActive,
			isnull(plist.EffectiveTo,'20281202') as EndDateActive,
			p.NPProductCode as NPProductCode,
			ppl.ListPrice as ListPrice,
			ppl.FreePercent as Free
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
		left join PriceLists plist
			on l.ID = plist.LocaleID
	where be.[Status] = '2'
		and be.ID = @MinID
		and ppl.PriceListNameID in(7,12)
		and plist.OracleID is not null
	order by plist.Name,p.ID
end


if @BatchStatus = 6
begin
	if @BatchID <> 1
	begin
		insert #ProductPriceMain
		(
			ProductID,
			ProductPriceListID,
			PriceListID,
			PriceListName,
			[Description],
			PriceListOrg,
			[Status],
			CurrencyCode,
			Country,
			ATGSiteID,
			OrderType,
			CustomerClass,
			StartDateActive,
			EndDateActive,
			NPProductCode,
			ListPrice,
			Free
		)
		select	p.ID as ProductID,
				ppl.ID as ProductPriceListID,
				isnull(plist.OracleID,plist.ID) as PriceListID,
				plist.Name as PriceListName,
				plist.Name as [Description],
				plist.Org as PriceListOrg,
				'ACTIVE' as [Status],
				plist.Currency as CurrencyCode,
				l.CountryCode as Country,
				l.ATGSiteID as ATGSiteID,
				'' as OrderType,
				'' as CustomerClass,
				isnull(plist.EffectiveFrom,'20101202') as StartDateActive,
				isnull(plist.EffectiveTo,'20281202') as EndDateActive,
				p.NPProductCode as NPProductCode,
				ppl.ListPrice as ListPrice,
				ppl.FreePercent as Free
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
			left join PriceLists plist
				on l.ID = plist.LocaleID
			join BatchExtractPartial bep
				on be.BatchID = bep.BatchID
					and be.[Type] = bep.[Type]
					and bep.ProductID = p.ID
					and bep.[Description] = p.NPProductCode	
		where be.[Status] = '6'
			and be.ID = @MinID
			and ppl.PriceListNameID in(7,12)
			and plist.OracleID is not null
		order by plist.Name,p.ID
	end
	else
	begin		
		insert #ProductPriceMain
			(
				ProductID,
				ProductPriceListID,
				PriceListID,
				PriceListName,
				[Description],
				PriceListOrg,
				[Status],
				CurrencyCode,
				Country,
				ATGSiteID,
				OrderType,
				CustomerClass,
				StartDateActive,
				EndDateActive,
				NPProductCode,
				ListPrice,
				Free
			)	
		select	p.ID as ProductID,
				ppl.ID as ProductPriceListID,
				isnull(plist.OracleID,plist.ID) as PriceListID,
				plist.Name as PriceListName,
				plist.Name as [Description],
				plist.Org as PriceListOrg,
				'ACTIVE' as [Status],
				plist.Currency as CurrencyCode,
				l.CountryCode as Country,
				l.ATGSiteID as ATGSiteID,
				'' as OrderType,
				'' as CustomerClass,
				isnull(plist.EffectiveFrom,'20101202') as StartDateActive,
				isnull(plist.EffectiveTo,'20281202') as EndDateActive,
				p.NPProductCode as NPProductCode,
				ppl.ListPrice as ListPrice,
				ppl.FreePercent as Free
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
		order by plist.Name,p.ID
		
		
		select @PListLocaleID =	(
									select top 1 pl.LocaleID 
									from PriceLists pl
										join #ProductPriceMain ppm
											on pl.ID = ppm.PriceListID
								)
	end
end





insert @TopPriceListLevel
	(
		PriceListID,
		PriceListName,
		[Description],
		PriceListOrg,
		[Status],
		CurrencyCode,
		Country,
		ATGSiteID,
		StartDateActive,
		EndDateActive
	)
select	PriceListID,
		PriceListName,
		[Description],
		PriceListOrg,
		[Status],
		CurrencyCode,
		Country,
		ATGSiteID,
		StartDateActive,
		EndDateActive
from #ProductPriceMain
group by PriceListID,
		PriceListName,
		[Description],
		PriceListOrg,
		[Status],
		CurrencyCode,
		Country,
		ATGSiteID,
		StartDateActive,
		EndDateActive
order by PriceListName




insert @ProductCodeList
	(
		PriceListID,
		PriceListName,
		NPProductCode
	)
select	PriceListID,
		PriceListName,
		NPProductCode
from #ProductPriceMain
group by	PriceListID,
			PriceListName,
			NPProductCode
order by	PriceListName,NPProductCode





insert @SetupTable
(
	ProductPriceMainID,
	ChargeType,
	ApplicationMethod,
	ChargeAmount
)
select	ppm.ProductPriceMainID,
		plc.ATGCode as ChargeType,
		'LUMPSUM' as ApplicationMethod,
		pplc.Amount as ChargeAmount
from #ProductPriceMain ppm
	left join ProductPriceListCharges pplc
		on ppm.ProductID = pplc.ProductID
			and ppm.ProductPriceListID = pplc.ProductPriceListID
	left join PriceListCharges plc
		on plc.ID = pplc.PriceListChargeID
		
		
		
update ppm
set ppm.SetUpCharge = sup.ChargeAmount,
	ppm.LogoCharge = logo.ChargeAmount
from #ProductPriceMain ppm
	left join @SetupTable sup
		on ppm.ProductPriceMainID = sup.ProductPriceMainID
			and sup.ChargeType = 'SETUP_CRG'
	left join @SetupTable logo
		on ppm.ProductPriceMainID = logo.ProductPriceMainID
			and logo.ChargeType = 'LOGO_CRG'
		

if @PListLocaleID in (7,12)
begin
	insert @ProductSKUsHold
	(
		ProductPriceMainID,
		ProductID,
		ProductPriceListID,
		ItemRelation,
		ItemID,
		Item
	)
	select	ppm.ProductPriceMainID,
			ppm.ProductID,
			ppm.ProductPriceListID,
			'' as ItemRelation,
			'' as ItemID,
			ps.OracleID as Item
	from #ProductPriceMain ppm
		left join ProductSKUs ps
			on ppm.ProductID = ps.ProductID
				--and ps.Active = 1 -- Obsolete (Field has been removed)
				and ps.SkuFormatID = 1
				and ISNULL(ps.OracleID,'') <> ''
	order by ppm.ProductPriceMainID,ps.OracleID
end
else
begin
	insert @ProductSKUsHold
	(
		ProductPriceMainID,
		ProductID,
		ProductPriceListID,
		ItemRelation,
		ItemID,
		Item
	)
	select	ppm.ProductPriceMainID,
			ppm.ProductID,
			ppm.ProductPriceListID,
			'' as ItemRelation,
			'' as ItemID,
			ps.OracleID as Item
	from #ProductPriceMain ppm
		left join ProductSKUs ps
			on ppm.ProductID = ps.ProductID
				--and ps.Active = 1 -- Obsolete (Field has been removed)
				--and ps.SkuFormatID = 1
				and ISNULL(ps.OracleID,'') <> ''
	order by ppm.ProductPriceMainID,ps.OracleID
end



-- Add this to get rid of duplicates
insert @ProductSKUs
	(
		ProductPriceMainID,
		ProductID,
		ProductPriceListID,
		ItemRelation,
		ItemID,
		Item
	)
select	a.ProductPriceMainID,
		a.ProductID,
		a.ProductPriceListID,
		a.ItemRelation,
		a.ItemID,
		a.Item
from @ProductSKUsHold a
	join
		(
			select	ProductID,
					ProductPriceListID,
					Item,
					MIN(ProductSKUID) as MinProductSKUID
			from @ProductSKUsHold
			group by ProductID,ProductPriceListID,Item
		) b
	on a.ProductSKUID = b.MinProductSKUID
order by a.ProductSKUID



update t
set t.ItemID = opi.ItemID
from @ProductSKUs t
	join PIM_ETL_STAGE.dbo.Stage_OracleItem opi
		on t.Item = opi.Item
		
		




insert #PriceList
(
	ProductPriceMainID,
	PriceListName,
	ListPrice,
	Free,
	ItemID,
	Item,
	QtyFrom,
	QtyTo,
	Price,
	UpsellQty,
	UpsellPrice,
	NPProductCode
)
select	ppm.ProductPriceMainID,
		ppm.PriceListName,
		ppm.ListPrice as ListPrice,
		ppm.Free,
		ps.ItemID,
		ps.Item,
		pplt.QtyBreaks as QtyFrom,
		0 as QtyTo,
		pplt.PriceBreaks as Price,
		pplt.UpsellQty as UpsellQty,
		pplt.UpsellPrice as UpsellPrice,
		ppm.NPProductCode
from #ProductPriceMain ppm
	left join @ProductSKUs ps
		on ppm.ProductPriceMainID = ps.ProductPriceMainID
	left join ProductPriceListTiers pplt
		on ppm.ProductID = pplt.ProductID
			and ppm.ProductPriceListID = pplt.ProductPriceListID
order by ppm.ProductPriceMainID,ps.Item,pplt.QtyBreaks





-- Update PriceList QtyTo
update pl
set pl.QtyTo = pl2.QtyFrom - 1
from #PriceList pl
	left join #PriceList pl2
		on pl.Item = pl2.Item
			and pl.PriceListID + 1 = pl2.PriceListID
			and pl.PriceListName = pl2.PriceListName
			
update #PriceList
set QtyTo = 999999
where QtyTo is null




set @ProductPriceMainID = null
set @PriceList_Name = null
set @SetupCharge = null
set @LogoCharge = null

set @PriceListID = null
set @ListPrice = null
set @Free = null
set @Item = null		
set @QtyFrom = null
set @QtyTo = null
set @Price = null
set @UpsellQty = null
set @UpsellPrice = null
set @SKU = null
set @MaxCount = null
set @Counter = null



-- Build the Data for CSV Export
while exists(select top 1 * from #ProductPriceMain where CSVUsed = 0)
begin
	select	@ProductPriceMainID = (select top 1 ProductPriceMainID from #ProductPriceMain where CSVUsed = 0 order by ProductPriceMainID)
	
	select	@PriceList_Name = PriceListName,
			@SetupCharge = SetUpCharge,
			@LogoCharge = LogoCharge
	from #ProductPriceMain
	where ProductPriceMainID = @ProductPriceMainID
	
	
	while exists(select top 1 PriceListID from #PriceList where ProductPriceMainID = @ProductPriceMainID and CSVUsed = 0)
	begin
		select	@PriceListID = (select top 1 PriceListID from #PriceList where ProductPriceMainID = @ProductPriceMainID and CSVUsed = 0 order by PriceListID)
			
		select	@ListPrice = ListPrice,
				@Free = Free,
				@Item = NPProductCode,			
				@QtyFrom = QtyFrom,
				@QtyTo = QtyTo,
				@Price = Price,
				@UpsellQty = UpsellQty,
				@UpsellPrice = UpsellPrice,
				@SKU = Item
		from #PriceList
		where PriceListID = @PriceListID

		
		select @MaxCount = COUNT(*) from #PriceList where Item = @SKU and PriceListName = @PriceList_Name and NPProductCode = @Item
		select @Counter = COUNT(*) from #PriceList where Item = @SKU and PriceListName = @PriceList_Name and NPProductCode = @Item and CSVUsed = 0
		select @Counter = @MaxCount - (@Counter - 1)
		
		
		
		if not exists(select top 1 * from #PriceListCSV where Item = @Item and PRICELIST_NAME = @PriceList_Name)
		begin
			insert #PriceListCSV
				(
					PRICELIST_NAME,
					ITEM_LEVEL,
					ITEM,
					LIST_PRICE,
					PRICE1,
					QTY1,
					FREE,
					UPSELL1,
					UPSELLPRICE1,
					CHARGES1,
					CHARGES2
				)
			values	(
						@PriceList_Name,
						'PRODUCT',
						@Item,
						@ListPrice,
						@Price,
						@QtyFrom,
						@Free,
						@UpsellQty,
						@UpsellPrice,
						@SetupCharge,
						@LogoCharge
					)
		end
		else
		begin
			if @Counter = 2
			begin
				update #PriceListCSV
				set Price2 = @Price,
					QTY2 = @QtyFrom,
					UPSELL2 = @UpsellQty,
					UPSELLPRICE2 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 3
			begin
				update #PriceListCSV
				set Price3 = @Price,
					QTY3 = @QtyFrom,
					UPSELL3 = @UpsellQty,
					UPSELLPRICE3 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 4
			begin
				update #PriceListCSV
				set Price4 = @Price,
					QTY4 = @QtyFrom,
					UPSELL4 = @UpsellQty,
					UPSELLPRICE4 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 5
			begin
				update #PriceListCSV
				set Price5 = @Price,
					QTY5 = @QtyFrom,
					UPSELL5 = @UpsellQty,
					UPSELLPRICE5 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 6
			begin
				update #PriceListCSV
				set Price6 = @Price,
					QTY6 = @QtyFrom,
					UPSELL6 = @UpsellQty,
					UPSELLPRICE6 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 7
			begin
				update #PriceListCSV
				set Price7 = @Price,
					QTY7 = @QtyFrom,
					UPSELL7 = @UpsellQty,
					UPSELLPRICE7 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 8
			begin
				update #PriceListCSV
				set Price8 = @Price,
					QTY8 = @QtyFrom,
					UPSELL8 = @UpsellQty,
					UPSELLPRICE8 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 9
			begin
				update #PriceListCSV
				set Price9 = @Price,
					QTY9 = @QtyFrom,
					UPSELL9 = @UpsellQty,
					UPSELLPRICE9 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 10
			begin
				update #PriceListCSV
				set Price10 = @Price,
					QTY10 = @QtyFrom,
					UPSELL10 = @UpsellQty,
					UPSELLPRICE10 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 11
			begin
				update #PriceListCSV
				set Price11 = @Price,
					QTY11 = @QtyFrom,
					UPSELL11 = @UpsellQty,
					UPSELLPRICE11 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
			if @Counter = 12
			begin
				update #PriceListCSV
				set Price12 = @Price,
					QTY12 = @QtyFrom,
					UPSELL12 = @UpsellQty,
					UPSELLPRICE12 = @UpsellPrice
				where Item = @Item
					and PRICELIST_NAME = @PriceList_Name
			end
		end
		
		
		update #PriceList
		set CSVUsed = 1
		where PriceListID = @PriceListID	
		
		
		set @PriceListID = null
		set @ListPrice = null
		set @Free = null
		set @Item = null		
		set @QtyFrom = null
		set @QtyTo = null
		set @Price = null
		set @UpsellQty = null
		set @UpsellPrice = null
		set @SKU = null
		set @MaxCount = null
		set @Counter = null
	end

	
	update #ProductPriceMain 
	set CSVUsed = 1
	where ProductPriceMainID = @ProductPriceMainID


	set @ProductPriceMainID = null
	set @PriceList_Name = null
	set @SetupCharge = null
	set @LogoCharge = null
end



if @PListLocaleID not in(7,12)
begin
	goto DONE
end



-- Build Data for XML Export
declare @Header1				varchar(100),
		@Header2				varchar(100),
		@Header2_E				varchar(100),
		@Description			varchar(255),
		@PriceListID_X			varchar(50),
		@PriceListOrg			varchar(50),
		@Status					varchar(50),
		@CurrencyCode			varchar(50),
		@Country				varchar(50),
		@SiteID					varchar(50),
		@StartDate				varchar(50),
		@EndDate				varchar(50),
		@NPProductCode			varchar(100),
		@ItemID					varchar(50)
		
		
		
		
set @Header1 = '<?xml version="1.0"?>'
set @Header2 = '<priceLists xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> '
set @Header2_E = '</priceLists>'


insert @XMLFinal(LineVal)
values(@Header1)
insert @XMLFinal(LineVal)
values(@Header2)



	
	
while exists(select top 1 TopPriceListID from @TopPriceListLevel)
begin
	select	@Z_TopPriceListID = (select top 1 TopPriceListID from @TopPriceListLevel order by TopPriceListID)
	
	select	@Z_PriceListID = PriceListID,
			@Z_PriceListName = PriceListName,
			@Z_Description = [Description],
			@Z_PriceListOrg = PriceListOrg,
			@Z_Status = [Status],
			@Z_CurrencyCode = CurrencyCode,
			@Z_Country = Country,
			@Z_ATGSiteID = ATGSiteID,
			@Z_StartDateActive = CONVERT(varchar(50),StartDateActive,120),
			@Z_EndDateActive = CONVERT(varchar(50),EndDateActive,120)
	from @TopPriceListLevel
	where TopPriceListID = @Z_TopPriceListID
	
	
	insert @XMLFinal(LineVal)
	values('  <priceList>')
	
	if @Z_PriceListID is null
	begin
		insert @XMLFinal(LineVal)
		values('    <priceListId/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <priceListId>' + @Z_PriceListID + '</priceListId>')
	end
	
	if @Z_PriceListName is null
	begin
		insert @XMLFinal(LineVal)
		values('    <priceListName/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <priceListName>' + @Z_PriceListName + '</priceListName>')
	end
	
	if @Z_Description is null
	begin
		insert @XMLFinal(LineVal)
		values('    <description/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <description>' + @Z_Description + '</description>')
	end
	
	insert @XMLFinal(LineVal)
	values('    <org>')
	
	if @Z_PriceListOrg is null
	begin
		insert @XMLFinal(LineVal)
		values('      <NAME/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('      <NAME>' + @Z_PriceListOrg + '</NAME>')
	end
	
	insert @XMLFinal(LineVal)
	values('      <STATUS>' + @Z_Status + '</STATUS>')
	
	insert @XMLFinal(LineVal)
	values('    </org>')
	
	if @Z_CurrencyCode is null
	begin
		insert @XMLFinal(LineVal)
		values('    <currencyCode/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <currencyCode>' + @Z_CurrencyCode + '</currencyCode>')
	end
	
	if @Z_Country is null
	begin
		insert @XMLFinal(LineVal)
		values('    <country/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <country>' + @Z_Country + '</country>')
	end
	
	if @Z_ATGSiteID is null
	begin
		insert @XMLFinal(LineVal)
		values('    <siteId/>')
	end
	else
	begin
		insert @XMLFinal(LineVal)
		values('    <siteId>' + @Z_ATGSiteID + '</siteId>')
	end
	
	insert @XMLFinal(LineVal)
	values('    <orderType/>')
	
	insert @XMLFinal(LineVal)
	values('    <customerClass/>')
	
	insert @XMLFinal(LineVal)
	values('    <startDateActive>' + @Z_StartDateActive + '</startDateActive>')
	
	insert @XMLFinal(LineVal)
	values('    <endDateActive>' + @Z_EndDateActive + '</endDateActive>')
	
		
	
	while exists(select top 1 * from @ProductCodeList where PriceListID = @Z_PriceListID)
	begin
		select @T_ProductCodeListID = (select top 1 ProductCodeListID from @ProductCodeList where PriceListID = @Z_PriceListID order by ProductCodeListID)
		select @T_PriceListID = PriceListID,
			   @T_PriceListName = PriceListName,
			   @T_NPProductCode = NPProductCode
		from @ProductCodeList
		where ProductCodeListID = @T_ProductCodeListID
		
		
		select	@SetupCharge = SetUpCharge,
				@LogoCharge = LogoCharge
		from #ProductPriceMain
		where PriceListID = @T_PriceListID
			and NPProductCode = @T_NPProductCode
		
		
		
		insert @XMLFinal(LineVal)
		values('    <product>')
		
	
		if @T_NPProductCode is null
		begin
			insert @XMLFinal(LineVal)
			values('      <productCode/>')
		end
		else
		begin
			insert @XMLFinal(LineVal)
			values('      <productCode>' + @T_NPProductCode + '</productCode>')
		end
		
		insert @XMLFinal(LineVal)
		values('      <itemRelation/>')
	
	
	
		while exists(select top 1 PriceListID from #PriceList where PriceListName = @T_PriceListName and NPProductCode = @T_NPProductCode and XMLUsed = 0)
		begin
			select @PriceListID = (select top 1 PriceListID from #PriceList 
									where PriceListName = @T_PriceListName and NPProductCode = @T_NPProductCode and XMLUsed = 0 order by PriceListID)
			
			select	@ListPrice = ListPrice,
					@Free = Free,
					@ItemID = ItemID,
					@Item = Item,			
					@QtyFrom = QtyFrom,
					@QtyTo = QtyTo,
					@Price = Price,
					@UpsellQty = UpsellQty,
					@UpsellPrice = UpsellPrice
			from #PriceList
			where PriceListID = @PriceListID

			
			select @MaxCount = COUNT(*) from #PriceList where PriceListName = @T_PriceListName and Item = @Item and NPProductCode = @T_NPProductCode
			select @Counter = COUNT(*) from #PriceList where PriceListName = @T_PriceListName and Item = @Item and NPProductCode = @T_NPProductCode and XMLUsed = 0
			select @Counter = @MaxCount - (@Counter - 1)
	
			
			if @Counter = 1
			begin
				insert @XMLFinal(LineVal)
				values('      <sku>')
				
				if @ItemID is null
				begin
					insert @XMLFinal(LineVal)
					values('        <itemId/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('        <itemId>' + @ItemID + '</itemId>')
				end
				
				if @Item is null
				begin
					insert @XMLFinal(LineVal)
					values('        <item/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('        <item>' + @Item + '</item>')
				end
				
				if @ListPrice is null
				begin
					insert @XMLFinal(LineVal)
					values('        <listPrice/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('        <listPrice>' + Convert(varchar(50),@ListPrice) + '</listPrice>')
				end
				
				insert @XMLFinal(LineVal)
				values('        <priceBreaks>')
				
				
				
				-- Begin Default for 1 - (QtyFrom - 1) - only if Quantity from does not start with 1
				if @QtyFrom <> 1
				begin
					insert @XMLFinal(LineVal)
					values('          <prices>')
					
					if @QtyFrom is null
					begin
						insert @XMLFinal(LineVal)
						values('            <qtyFrom/>')
					end
					else
					begin
						insert @XMLFinal(LineVal)
						values('            <qtyFrom>' + '1' + '</qtyFrom>')
					end
					
					if @QtyFrom is null
					begin
						insert @XMLFinal(LineVal)
						values('            <qtyTo/>')
					end
					else
					begin
						insert @XMLFinal(LineVal)
						values('            <qtyTo>' + convert(varchar(50),@QtyFrom - 1) + '</qtyTo>')
					end
					
					if @Price is null
					begin
						insert @XMLFinal(LineVal)
						values('            <price/>')
					end
					else
					begin
						insert @XMLFinal(LineVal)
						values('            <price>' + convert(varchar(50),@Price) + '</price>')
					end
					
					
					insert @XMLFinal(LineVal)
					values('            <free/>')
					
					
					insert @XMLFinal(LineVal)
					values('            <upSellQty/>')
					
					
					insert @XMLFinal(LineVal)
					values('            <upSellPrice/>')
					
					
					
					insert @XMLFinal(LineVal)
					values('          </prices>')
				end
				
				-- End Default for 1 - (QtyFrom - 1)
				
						
				
				
				insert @XMLFinal(LineVal)
				values('          <prices>')
				
				if @QtyFrom is null
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyFrom/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyFrom>' + convert(varchar(50),@QtyFrom) + '</qtyFrom>')
				end
				
				if @QtyTo is null
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyTo/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyTo>' + convert(varchar(50),@QtyTo) + '</qtyTo>')
				end
				
				if @Price is null
				begin
					insert @XMLFinal(LineVal)
					values('            <price/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <price>' + convert(varchar(50),@Price) + '</price>')
				end
				
				if @Free is null
				begin
					insert @XMLFinal(LineVal)
					values('            <free/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <free>' + convert(varchar(50),@Free) + '</free>')
				end
				
				if @UpsellQty is null
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellQty/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellQty>' + convert(varchar(50),@UpsellQty) + '</upSellQty>')
				end
				
				if @UpsellPrice is null
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellPrice/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellPrice>' + convert(varchar(50),@UpsellPrice) + '</upSellPrice>')
				end
				
				
				insert @XMLFinal(LineVal)
				values('          </prices>')
			end
			
			
			if @Counter > 1
			begin
				insert @XMLFinal(LineVal)
				values('          <prices>')
				
				if @QtyFrom is null
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyFrom/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyFrom>' + convert(varchar(50),@QtyFrom) + '</qtyFrom>')
				end
				
				if @QtyTo is null
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyTo/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <qtyTo>' + convert(varchar(50),@QtyTo) + '</qtyTo>')
				end
				
				if @Price is null
				begin
					insert @XMLFinal(LineVal)
					values('            <price/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <price>' + convert(varchar(50),@Price) + '</price>')
				end
				
				if @Free is null
				begin
					insert @XMLFinal(LineVal)
					values('            <free/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <free>' + convert(varchar(50),@Free) + '</free>')
				end
				
				if @UpsellQty is null
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellQty/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellQty>' + convert(varchar(50),@UpsellQty) + '</upSellQty>')
				end
				
				if @UpsellPrice is null
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellPrice/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <upSellPrice>' + convert(varchar(50),@UpsellPrice) + '</upSellPrice>')
				end
				
				insert @XMLFinal(LineVal)
				values('          </prices>')
			end
			
			
			if @Counter = @MaxCount
			begin
				insert @XMLFinal(LineVal)
				values('        </priceBreaks>')
				
				insert @XMLFinal(LineVal)
				values('        <charges>')
				
				insert @XMLFinal(LineVal)
				values('          <charge>')
				
				insert @XMLFinal(LineVal)
				values('            <chargeType>' + 'SETUP_CRG' + '</chargeType>')
				
				insert @XMLFinal(LineVal)
				values('            <applicationMethod>' + 'LUMPSUM' + '</applicationMethod>')
				
				if @SetupCharge is null
				begin
					insert @XMLFinal(LineVal)
					values('            <chargeAmount/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <chargeAmount>' + convert(varchar(50),@SetupCharge) + '</chargeAmount>')
				end
				
				insert @XMLFinal(LineVal)
				values('          </charge>')
				
							
				insert @XMLFinal(LineVal)
				values('          <charge>')
				
				insert @XMLFinal(LineVal)
				values('            <chargeType>' + 'LOGO_CRG' + '</chargeType>')
				
				insert @XMLFinal(LineVal)
				values('            <applicationMethod>' + 'LUMPSUM' + '</applicationMethod>')
				
				if @LogoCharge is null
				begin
					insert @XMLFinal(LineVal)
					values('            <chargeAmount/>')
				end
				else
				begin
					insert @XMLFinal(LineVal)
					values('            <chargeAmount>' + convert(varchar(50),@LogoCharge) + '</chargeAmount>')
				end
				
				insert @XMLFinal(LineVal)
				values('          </charge>')
				
				
				insert @XMLFinal(LineVal)
				values('        </charges>')
				
				insert @XMLFinal(LineVal)
				values('      </sku>')
			end
			
			
			update #PriceList
			set XMLUsed = 1
			where PriceListID = @PriceListID
		end
	
	
	insert @XMLFinal(LineVal)
	values('    </product>')
	
	delete @ProductCodeList where ProductCodeListID = @T_ProductCodeListID
	
	end
	
		
	insert @XMLFinal(LineVal)
	values('  </priceList>')
	
	
	delete @TopPriceListLevel where TopPriceListID = @Z_TopPriceListID
end




insert @XMLFinal(LineVal)
values(@Header2_E)




insert PIM_ETL_STAGE.dbo.Stage_ProductPriceListForXMLExport(LineVal,BatchID)
select LineVal,@BatchID
from @XMLFinal 
order by UniqueID



DONE:

insert PIM_ETL_STAGE.dbo.Stage_ProductPriceListForCSVExport
(
	[PRICELIST_NAME]
      ,[ITEM_LEVEL]
      ,[ITEM]
      ,[LIST_PRICE]
      ,[PRICE1]
      ,[PRICE2]
      ,[PRICE3]
      ,[PRICE4]
      ,[PRICE5]
      ,[PRICE6]
      ,[PRICE7]
      ,[PRICE8]
      ,[PRICE9]
      ,[PRICE10]
      ,[PRICE11]
      ,[PRICE12]
      ,[QTY1]
      ,[QTY2]
      ,[QTY3]
      ,[QTY4]
      ,[QTY5]
      ,[QTY6]
      ,[QTY7]
      ,[QTY8]
      ,[QTY9]
      ,[QTY10]
      ,[QTY11]
      ,[QTY12]
      ,[FREE]
      ,[UPSELL1]
      ,[UPSELL2]
      ,[UPSELL3]
      ,[UPSELL4]
      ,[UPSELL5]
      ,[UPSELL6]
      ,[UPSELL7]
      ,[UPSELL8]
      ,[UPSELL9]
      ,[UPSELL10]
      ,[UPSELL11]
      ,[UPSELL12]
      ,[UPSELLPRICE1]
      ,[UPSELLPRICE2]
      ,[UPSELLPRICE3]
      ,[UPSELLPRICE4]
      ,[UPSELLPRICE5]
      ,[UPSELLPRICE6]
      ,[UPSELLPRICE7]
      ,[UPSELLPRICE8]
      ,[UPSELLPRICE9]
      ,[UPSELLPRICE10]
      ,[UPSELLPRICE11]
      ,[UPSELLPRICE12]
      ,[CHARGES1]
      ,[CHARGES2]
      ,[BatchID]
)
select [PRICELIST_NAME]
      ,[ITEM_LEVEL]
      ,[ITEM]
      ,[LIST_PRICE]
      ,[PRICE1]
      ,[PRICE2]
      ,[PRICE3]
      ,[PRICE4]
      ,[PRICE5]
      ,[PRICE6]
      ,[PRICE7]
      ,[PRICE8]
      ,[PRICE9]
      ,[PRICE10]
      ,[PRICE11]
      ,[PRICE12]
      ,[QTY1]
      ,[QTY2]
      ,[QTY3]
      ,[QTY4]
      ,[QTY5]
      ,[QTY6]
      ,[QTY7]
      ,[QTY8]
      ,[QTY9]
      ,[QTY10]
      ,[QTY11]
      ,[QTY12]
      ,[FREE]
      ,[UPSELL1]
      ,[UPSELL2]
      ,[UPSELL3]
      ,[UPSELL4]
      ,[UPSELL5]
      ,[UPSELL6]
      ,[UPSELL7]
      ,[UPSELL8]
      ,[UPSELL9]
      ,[UPSELL10]
      ,[UPSELL11]
      ,[UPSELL12]
      ,[UPSELLPRICE1]
      ,[UPSELLPRICE2]
      ,[UPSELLPRICE3]
      ,[UPSELLPRICE4]
      ,[UPSELLPRICE5]
      ,[UPSELLPRICE6]
      ,[UPSELLPRICE7]
      ,[UPSELLPRICE8]
      ,[UPSELLPRICE9]
      ,[UPSELLPRICE10]
      ,[UPSELLPRICE11]
      ,[UPSELLPRICE12]
      ,[CHARGES1]
      ,[CHARGES2]
      ,@BatchID
from #PriceListCSV
order by PriceListCSVID





if @PListLocaleID in(7,12)
begin
	if exists(select * from @ProductSKUs where isnull(ItemID,'') = '')
	begin
		if @BatchStatus = 2
		begin
			select @ExtractCompleted = '4'
		end
		
		if @BatchStatus = 6
		begin
			select @ExtractCompleted = '8'
		end
	end
	else
	begin
		if @BatchStatus = 2
		begin
			select @ExtractCompleted = '3'
		end
		
		if @BatchStatus = 6
		begin
			select @ExtractCompleted = '7'
		end
	end
end
else
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '3'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '7'
	end
end



--select * from @ProductPriceMain
--select * from @SetupTable
--select * from @ProductSKUs
--select * from @PriceList
--select * from @PriceListCSV



drop table #ProductPriceMain
drop table #PriceList
drop table #PriceListCSV



















GO
