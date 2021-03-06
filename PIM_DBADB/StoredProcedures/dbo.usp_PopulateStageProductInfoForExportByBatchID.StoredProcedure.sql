CREATE Procedure [dbo].[usp_PopulateStageProductInfoForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @ProductInfo	Table	(
									UniqueID						int identity(1,1) Primary Key,
									ProductID						int,
									ID								nvarchar(200),
									Blank1							nvarchar(200),
									Blank9							nvarchar(200),
									Blank2							nvarchar(max),
									Blank3							nvarchar(200),
									Locale							nvarchar(max),
									Blank4							nvarchar(max),
									Blank5							nvarchar(max),
									Blank6							nvarchar(200),
									allowPricingTiers				nvarchar(200),
									Blank7							nvarchar(200),
									productShippingCategory			nvarchar(200),
									Blank8							nvarchar(max)
								)
								
declare @HexColor	Table	(
								UniqueID					int identity(1,1) Primary Key,
								PInfoUniqueID				int,
								ProductImprintAreaColorsID	int,
								HexCode						nvarchar(50),
								[Type]						nvarchar(50),
								Name						nvarchar(255),
								ColorID						nvarchar(255)
							)
							
declare @ProductRelated	Table	(
									SequenceID				int identity(1,1) Primary Key,
									UniqueID				int,
									ProductID				int,
									RelatedProductID		int,
									PartNumber				nvarchar(60)
								)
								
declare @ProductRelatedFinal	Table	(
											UniqueID				int Primary Key,
											ProductID				int,
											RelatedProductIDString	nvarchar(200),
											PartNumberString		nvarchar(200)
										)
										
declare @ProductRelatedHolder	Table	(
											IUniqueID				int identity(1,1) Primary Key,
											RelatedProductID		int,
											PartNumber				nvarchar(60)
										)
							
							
declare @PInfoHolder				Table (PInfoUniqueID int Primary Key)

declare @PInfoUniqueID				int,
		@UniqueID					int,
		@ProductImprintAreaColorsID	int,
		@HexCode					nvarchar(50),
		@Type						nvarchar(50),
		@Name						nvarchar(200),
		@ColorID					nvarchar(50),
		@HexString					nvarchar(2000),
		@MaxUniqueID				int,
		@LocaleID					int,
		@BType						varchar(50),
		@MinID						int,
		@BatchStatus				int,
		@SequenceID					int,
		@RUniqueID					int,
		@RProductID					int,
		@RelatedProductIDString		nvarchar(200),
		@PartNumberString			nvarchar(200),
		@RelatedStringHold			nvarchar(200),
		@PartStringHold				nvarchar(200),
		@IUniqueID					int,
		@MaxID						int



set @LocaleID = 12 -- LOCALE=en_US
set @BType = '6'



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
	insert @ProductInfo
	(
		ProductID,
		ID,
		Blank1,
		Blank9,
		Blank2,
		Blank3,
		Locale,
		Blank4,
		Blank5,
		Blank6,
		allowPricingTiers,
		Blank7,
		productShippingCategory,
		Blank8
	)
	select	ProductID,
			ID,
			Blank1,
			Blank9,
			Blank2,
			Blank3,
			Locale,
			Blank4,
			Blank5,
			Blank6,
			allowPricingTiers,
			Blank7,
			productShippingCategory,
			Blank8
	from
		(
			select	0 as ProductID,
					'/atg/commerce/catalog/SecureProductCatalog:personalizableProduct' as ID,
					'' as Blank1,
					'' as Blank9,
					'' as Blank2,
					'' as Blank3,
					'LOCALE=en_US' as Locale,
					'' as Blank4,
					'' as Blank5,
					'' as Blank6,
					'' as allowPricingTiers,
					'' as Blank7,
					'' as productShippingCategory,
					'' as Blank8,
					1 as SortOrder
			union
			select  0 as ProductID,
					'ID' as ID,
					'brand'	as Blank1,
					'compatibleAccPrds' as Blank9,
					'descriptionDefault' as Blank2,
					'displayNameDefault' as Blank3,	
					'imprintColors' as Locale,	
					'keywordsDefault' as Blank4,	
					'longDescriptionDefault' as Blank5,	
					'marketingCategoryName' as Blank6,	
					'allowPricingTiers' as allowPricingTiers,
					'productCode' as Blank7,	
					'productShippingCategory' as productShippingCategory,
					'siteItemDisplayNameDefault' as Blank8,
					2 as SortOrder
			union				
			select	p.ID as ProductID,
					'' as ID,
					p.BrandedName as Blank1,
					'' as Blank9,
					pt.NPProductName as Blank2,
					p.NPProductCode as Blank3,
					'' as Locale,
					isnull(pt.NPKeywords,'') as Blank4,
					case 
						when ISNULL(pt.SubHeader,'') <> ''
							then '<p class="text-center"><strong><em>' + pt.SubHeader + '</strong></em></p>' + '<p>' + pt.LongDescriptionCopy + '</p>'
						else
							'<p>' + pt.LongDescriptionCopy + '</p>'
					end as Blank5,				
					pct.Name as Blank6,
					case
						when (ppl.PriceTier is null or ppl.PriceTier = '')
							then '6'
						else
							convert(nvarchar(200),ppl.PriceTier)
					end allowPricingTiers,
					pcn.WebCode as Blank7,
					case
						when (p.ShipCategory is null or p.ShipCategory = '')
							then  'LIGHT'
						else
							p.ShipCategory
					end as productShippingCategory,
					pt.NPProductName as Blank8,
					3 as SortOrder
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join ProductChannels pcn 
					on p.ID = pcn.ProductID
						and pcn.ChannelID = 1 -- NADM Only
				join dbo.BatchExtracts be
					on pb.BatchID = be.BatchID
				left join ProductTranslations pt
					on p.ID = pt.ProductID
						and pt.ChannelID = 1 -- NADM Only
						and pt.LocaleID = @LocaleID
				--left join ProductCategoryTranslations pct
				--	on p.ID = pct.ProductID
				--		and pct.LocaleID = @LocaleID
				left join
					(
						select	a.ProductID,
								a.LocaleID,
								a.Name
						from ProductCategoryTranslations a
							join
							(
								select	ProductID,
										LocaleID,
										MIN(ID) as MinID
								from ProductCategoryTranslations
								group by ProductID,
										 LocaleID
							) b
						on a.ID = b.MinID
					) pct
				on p.ID = pct.ProductID
					and pct.LocaleID = @LocaleID
				left join ProductPriceLists ppl
					on p.ID = ppl.ProductID
						and ppl.PriceListNameID = @LocaleID
			where be.[Status] = '2'
				and be.ID = @MinID
		) t
	--where SortOrder <> 1
	order by SortOrder,ProductID
end



if @BatchStatus = 6
begin
	insert @ProductInfo
	(
		ProductID,
		ID,
		Blank1,
		Blank9,
		Blank2,
		Blank3,
		Locale,
		Blank4,
		Blank5,
		Blank6,
		allowPricingTiers,
		Blank7,
		productShippingCategory,
		Blank8
	)
	select	ProductID,
			ID,
			Blank1,
			Blank9,
			Blank2,
			Blank3,
			Locale,
			Blank4,
			Blank5,
			Blank6,
			allowPricingTiers,
			Blank7,
			productShippingCategory,
			Blank8
	from
		(
			select	0 as ProductID,
					'/atg/commerce/catalog/SecureProductCatalog:personalizableProduct' as ID,
					'' as Blank1,
					'' as Blank9,
					'' as Blank2,
					'' as Blank3,
					'LOCALE=en_US' as Locale,
					'' as Blank4,
					'' as Blank5,
					'' as Blank6,
					'' as allowPricingTiers,
					'' as Blank7,
					'' as productShippingCategory,
					'' as Blank8,
					1 as SortOrder
			union
			select  0 as ProductID,
					'ID' as ID,
					'brand'	as Blank1,
					'compatibleAccPrds' as Blank9,
					'descriptionDefault' as Blank2,
					'displayNameDefault' as Blank3,	
					'imprintColors' as Locale,	
					'keywordsDefault' as Blank4,	
					'longDescriptionDefault' as Blank5,	
					'marketingCategoryName' as Blank6,	
					'allowPricingTiers' as allowPricingTiers,
					'productCode' as Blank7,	
					'productShippingCategory' as productShippingCategory,
					'siteItemDisplayNameDefault' as Blank8,
					2 as SortOrder
			union				
			select	p.ID as ProductID,
					'' as ID,
					p.BrandedName as Blank1,
					'' as Blank9,
					pt.NPProductName as Blank2,
					p.NPProductCode as Blank3,
					'' as Locale,
					isnull(pt.NPKeywords,'') as Blank4,
					case 
						when ISNULL(pt.SubHeader,'') <> ''
							then '<p class="text-center"><strong><em>' + pt.SubHeader + '</strong></em></p>' + '<p>' + pt.LongDescriptionCopy + '</p>'
						else
							'<p>' + pt.LongDescriptionCopy + '</p>'
					end as Blank5,				
					pct.Name as Blank6,
					case
						when (ppl.PriceTier is null or ppl.PriceTier = '')
							then '6'
						else
							convert(nvarchar(200),ppl.PriceTier)
					end allowPricingTiers,
					pcn.WebCode as Blank7,
					case
						when (p.ShipCategory is null or p.ShipCategory = '')
							then  'LIGHT'
						else
							p.ShipCategory
					end as productShippingCategory,
					pt.NPProductName as Blank8,
					3 as SortOrder
			from Products p
				join ProductBatches pb
					on p.ID = pb.ProductID
						and pb.ChannelID = 1 -- NADM Only
				join ProductChannels pcn 
					on p.ID = pcn.ProductID
						and pcn.ChannelID = 1 -- NADM Only
				join dbo.BatchExtracts be
					on pb.BatchID = be.BatchID
				left join ProductTranslations pt
					on p.ID = pt.ProductID
						and pt.ChannelID = 1 -- NADM Only
						and pt.LocaleID = @LocaleID
				--left join ProductCategoryTranslations pct
				--	on p.ID = pct.ProductID
				--		and pct.LocaleID = @LocaleID
				left join
					(
						select	a.ProductID,
								a.LocaleID,
								a.Name
						from ProductCategoryTranslations a
							join
							(
								select	ProductID,
										LocaleID,
										MIN(ID) as MinID
								from ProductCategoryTranslations
								group by ProductID,
										 LocaleID
							) b
						on a.ID = b.MinID
					) pct
				on p.ID = pct.ProductID
					and pct.LocaleID = @LocaleID
				left join ProductPriceLists ppl
					on p.ID = ppl.ProductID
						and ppl.PriceListNameID = @LocaleID
				join BatchExtractPartial bep
					on be.BatchID = bep.BatchID
						and be.[Type] = bep.[Type]
						and bep.ProductID = p.ID
						and bep.[Description] = p.NPProductCode		
			where be.[Status] = '6'
				and be.ID = @MinID
		) t
	--where SortOrder <> 1
	order by SortOrder,ProductID
end


-- Update ATG ID
update a
set a.ID = b.Product_ID
from @ProductInfo a
	join ATGView_Product_Main b
		on a.Blank3 = b.Display_name
where a.ProductID <> 0
	and b.Locale = 'en_US'
	and b.[Site] = 'US'




insert @HexColor
(
	PInfoUniqueID,
	ProductImprintAreaColorsID,
	HexCode,
	[Type],
	Name,
	ColorID
)
select	distinct
		m.UniqueID as PInfoUniqueID,
		a.ID as ProductImprintAreaColorsID,
		a.HexCode,
		b.[Type],
		e.Name,
		case 
			when c.Color_ID is null
				then 'noColorID' + ' - ' + e.Name + ' - ' + isnull(a.HexCode,'')
			else
				c.Color_ID
		end as Color_ID
from @ProductInfo m
	join ProductImprintAreaColors a
		on m.ProductID = a.ProductID
			and m.ProductID <> 0
	join ProductImprintAreas b
		on a.ProductImprintAreaID = b.ID
	join ProductImprintAreaColorTranslations e
		on a.ID = e.ProductImprintAreaColorID
			and b.ID = e.ProductImprintAreaID
			and e.LocaleID = @LocaleID
	left join ATGCompSKUColorMapper c
		on replace(a.HexCode,'#','0x') = c.Color_Value
			and e.Name = c.Color_Name
			and e.LocaleID = @LocaleID
where b.[Type] = 'Standard'
order by a.ID



-- Get Rid of Dupes
delete a
from @HexColor a
	join
		(
			select	PInfoUniqueID,
					ProductImprintAreaColorsId,
					HexCode,
					ColorID
			from @HexColor
			where ColorID <> 'noColorID'
			group by PInfoUniqueID,
					ProductImprintAreaColorsId,
					HexCode,
					ColorID
		) b
	on a.PInfoUniqueID = b.PInfoUniqueID
		and a.ProductImprintAreaColorsID = b.ProductImprintAreaColorsID
		and a.HexCode = b.HexCode
		and a.ColorID = 'noColorID'


delete p
from @HexColor p
	left join
		(
			select	MIN(UniqueID) as MinUniqueID,
					PInfoUniqueID,
					ProductImprintAreaColorsID
			from @HexColor
			group by PInfoUniqueID,
					 ProductImprintAreaColorsID
		) t
	on p.UniqueID = t.MinUniqueID
where t.MinUniqueID is null



insert @PInfoHolder(PInfoUniqueID)
select distinct PInfoUniqueID
from @HexColor
order by PInfoUniqueID




while exists(select top 1 PInfoUniqueID from @PInfoHolder)
begin
	select @PInfoUniqueID = (select top 1 PInfoUniqueID from @PInfoHolder order by PInfoUniqueID)
	
	set @HexString = ''
	
		
	while exists(select top 1 UniqueID from @HexColor where PInfoUniqueID = @PInfoUniqueID)
	begin
		select @MaxUniqueID = (select MAX(UniqueID) from @HexColor where PInfoUniqueID = @PInfoUniqueID)
		
		select	@UniqueID = (select top 1 UniqueID from @HexColor where PInfoUniqueID = @PInfoUniqueID order by UniqueID)
		select	@ProductImprintAreaColorsID = ProductImprintAreaColorsID,
				@HexCode = HexCode,
				@Type = [Type],
				@Name = Name,
				@ColorID = ColorID
		from @HexColor
		where UniqueID = @UniqueID
		
		
		if @UniqueID < @MaxUniqueID
		begin
			select @HexString = @HexString + @ColorID + ', '
		end
		else
		begin
			select @HexString = @HexString + @ColorID
		end
		
		
		delete @HexColor where UniqueID = @UniqueID
	end
	
	
	update @ProductInfo
	set Locale = @HexString
	where UniqueID = @PInfoUniqueID
	
	
	delete @PInfoHolder where PInfoUniqueID = @PInfoUniqueID
end




-- Calculate Related Products
insert @ProductRelated
	(
		UniqueID,
		ProductID,
		RelatedProductID,
		PartNumber
	)
select	p.UniqueID,
		p.ProductID,
		pa.RelatedProductID,
		ps.PartNumber
from @ProductInfo p
	left join ProductAccessories pa (nolock)
		on p.ProductID = pa.ProductID
			and pa.RelationTypeID = 1
	left join ProductSKUs ps (nolock)
		on pa.RelatedProductID = ps.ProductID
			and ps.SkuFormatID = 1
where p.ProductID <> 0
	and ISNULL(ps.PartNumber,'') <> ''
order by p.UniqueID
	
	
set @SequenceID = 0
set @RUniqueID = 0
set @RProductID = 0
set @RelatedProductIDString = ''
set @PartNumberString = ''
set @RelatedStringHold = ''
set @PartStringHold = ''
set @IUniqueID = 0
set @MaxID = 0


while exists(select top 1 SequenceID from @ProductRelated)
begin
	select	@SequenceID = (select top 1 SequenceID from @ProductRelated order by SequenceID)
	
	select	@RUniqueID = UniqueID,
			@RProductID = ProductID
	from @ProductRelated 
	where SequenceID = @SequenceID
	
	insert @ProductRelatedHolder(RelatedProductID,PartNumber)
	select	RelatedProductID,
			PartNumber
	from @ProductRelated
	where UniqueID = @RUniqueID
	
	
	select @MaxID = MAX(IUniqueID) from @ProductRelatedHolder
	
	while exists(select top 1 IUniqueID from @ProductRelatedHolder)
	begin
		select	@IUniqueID = (select top 1 IUniqueID from @ProductRelatedHolder order by IUniqueID)
		select	@RelatedStringHold = CONVERT(nvarchar(50),RelatedProductID),
				@PartStringHold = CONVERT(nvarchar(50),PartNumber)
		from @ProductRelatedHolder
		where IUniqueID = @IUniqueID
		
		
		if @IUniqueID < @MaxID
		begin
			select @RelatedProductIDString = @RelatedProductIDString + @RelatedStringHold + ', '
			select @PartNumberString = @PartNumberString + @PartStringHold + ', '
		end
		else
		begin
			select @RelatedProductIDString = @RelatedProductIDString + @RelatedStringHold
			select @PartNumberString = @PartNumberString + @PartStringHold
		end
		
		
		delete @ProductRelatedHolder where IUniqueID = @IUniqueID
		
		set @IUniqueID = 0
		set @RelatedStringHold = ''
		set @PartStringHold = ''
	end
	
	
	insert @ProductRelatedFinal
		(
			UniqueID,
			ProductID,
			RelatedProductIDString,
			PartNumberString
		)
	values(@RUniqueID,@RProductID,@RelatedProductIDString,@PartNumberString)
	
	
	delete @ProductRelated where UniqueID = @RUniqueID
	
	
	set @RUniqueID = 0
	set @RProductID = 0
	set @RelatedProductIDString = ''
	set @PartNumberString = ''
end


update p
set p.Blank9 = pr.PartNumberString
from @ProductInfo p
	join @ProductRelatedFinal pr
		on p.UniqueID = pr.UniqueID




if exists(select top 1 * from @ProductInfo where len(isnull(Blank2,'')) > 50)
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '4'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '8'
	end
	
	update @ProductInfo
	set Blank2 = ''
	where len(isnull(Blank2,'')) > 50
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


if exists(select top 1 * from @ProductInfo where Locale like '%noColorID%')
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




insert PIM_ETL_STAGE.dbo.Stage_ProductInfoForExport
	(
	   [ProductID]
      ,[ID]
      ,[Blank1]
      ,[Blank2]
      ,[Blank3]
      ,[Locale]
      ,[Blank4]
      ,[Blank5]
      ,[Blank6]
      ,[allowPricingTiers]
      ,[Blank7]
      ,[productShippingCategory]
      ,[Blank8]
      ,[Blank9]
	)
select [ProductID]
      ,[ID]
      ,[Blank1]
      ,[Blank2]
      ,[Blank3]
      ,[Locale]
      ,[Blank4]
      ,[Blank5]
      ,[Blank6]
      ,[allowPricingTiers]
      ,[Blank7]
      ,[productShippingCategory]
      ,[Blank8] 
      ,[Blank9]
from @ProductInfo
order by UniqueID












GO
