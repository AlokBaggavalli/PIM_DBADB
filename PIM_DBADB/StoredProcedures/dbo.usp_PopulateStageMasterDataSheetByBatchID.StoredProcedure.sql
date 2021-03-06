CREATE Procedure [dbo].[usp_PopulateStageMasterDataSheetByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as 

set nocount on


declare @ProductsTable	Table	(
									ProductID				int,
									BatchID					int,
									NPGeneralComments		nvarchar(1000),
									ProductImage			nvarchar(10) default(''),
									URL						nvarchar(1000),
									Name					nvarchar(255),
									ASINumber				nvarchar(50),
									SupplierProductID		nvarchar(60),
									VendorProductID			nvarchar(60),
									OracleID				nvarchar(2000),
									OracleDesc				nvarchar(2000),
									WebCode					nvarchar(50),
									NPProductName			nvarchar(255),
									BrandedName				nvarchar(100),
									BrandLogoImageName		nvarchar(10) default(''),
									BrandLogoImagePath		nvarchar(10) default(''),
									AvailableCountries		nvarchar(1000),
									SellToCountries			nvarchar(1000),
									OracleCatalog1			int,
									OracleCatalog2			int,
									OracleCatalog3			int,
									OracleCatalog4			int,
									OracleCategoryCode		nvarchar(10),
									ImageName				nvarchar(2000),
									ImagePath				nvarchar(4000),
									VideoLinkURL			nvarchar(1000),
									Capacity				nvarchar(1000),
									CapacityUOM				nvarchar(1000),
									SizeAvailable			nvarchar(1000),
									AttributeComboKey		nvarchar(100),
									AttributeComboValue		nvarchar(2000),
									Attribute1Name			nvarchar(50) default('Product'),
									Attribute1Options		nvarchar(1000),
									Attribute1ColorHexVal	nvarchar(1000),
									Attribute2Name			nvarchar(50) default(''),
									Attribute2Options		nvarchar(1000) default(''),
									Attribute2ColorHexVal	nvarchar(1000) default(''),
									Attribute3Name			nvarchar(50) default(''),
									Attribute3Options		nvarchar(1000) default(''),
									Attribute3ColorHexVal	nvarchar(1000) default(''),
									RefillType				nvarchar(1000),
									PointType				nvarchar(1000),
									PointSize				nvarchar(1000),
									InkColor				nvarchar(1000),
									IncColorHexValues		nvarchar(1000),
									Material				nvarchar(4000),
									COO						nvarchar(10),
									MadeInUSA				nvarchar(1),
									FreightQtyPerBox		int,
									FreightBoxWeight		decimal(10,2),					
									[Weight]				decimal(10,2),
									WeightUOM				nvarchar(10),
									Width					decimal(10,2),
									Height					decimal(10,2),
									Depth					decimal(10,2),
									SizeUOM					nvarchar(10),
									DimensionsComment		nvarchar(1000),
									TATmin					int,
									TATmax					int,
									ArtTemplateName			nvarchar(2000),
									ArtTemplatePath			nvarchar(4000),
									ImprintArea1Location	nvarchar(255),
									ImprintArea1Width		decimal(10,2),
									ImprintArea1Height		decimal(10,2),
									ImprintArea1UOM			nvarchar(10),
									ImprintArea1Method		nvarchar(255),
									ImprintAreaIncludedCol	int,
									ImprintArea1ColorMax	int,
									ImpinttArea1ColorOption	nvarchar(2000),
									ImprintArea1ColorHexVal	nvarchar(1000),
									ImprintArea2Location	nvarchar(255),
									ImprintArea2Width		decimal(10,2),
									ImprintArea2Height		decimal(10,2),
									ImprintArea2UOM			nvarchar(10),
									ImprintArea2Method		nvarchar(255),
									SupplierKeyword			nvarchar(2000),
									WebSearchWords			nvarchar(2000),
									SubHeaderDescription	nvarchar(1000),
									LongDescription			nvarchar(3000),
									MOQNPC					nvarchar(50) default(''),
									NOQCATSTD				nvarchar(50) default(''),
									Currency				nvarchar(3),
									NPCQuote				nvarchar(10) default(''),
									CATSTDNet				decimal(10,3),
									CATSTDPrice				decimal(10,3),
									QuoteQtyTiered			nvarchar(500),
									QuoteCostTiered			nvarchar(500),
									NewOrderSetupNPQuote	decimal(10,2),
									NewOrderSetupCATNet		decimal(10,2),
									NewOrderSetupCATPrice	decimal(10,2),
									ReOrderSetupNPQuote		decimal(10,2),
									AddlColorRunCharge		decimal(10,2),
									AddlLocationRunCharge	decimal(10,2),
									PreProdProofCharge		decimal(10,2),
									PolyBagCharge			decimal(10,2),
									OracleCatalog1Trans		nvarchar(100),
									OracleCatalog2Trans		nvarchar(100),
									OracleCatalog3Trans		nvarchar(100),
									OracleCatalog4Trans		nvarchar(100),
									NPProductCode			nvarchar(50),
									SKU_Format				nvarchar(2000),
									Supplier_Product_Sku				nvarchar(2000),
									Supplier_Product_Sku_Description	nvarchar(3000),
									Category_Product_Family				nvarchar(100),
									Subcategory							nvarchar(100),
									Oracle_Catalog_Level_1				nvarchar(100),
									Oracle_Catalog_Level_2				nvarchar(100),
									Freight_Box_Weight_UOM				nvarchar(10),
									Standard_Catalog_MOQ				int,
									Net_Item_Cost_at_Catalog_MOQ		decimal(10,3),
									NPC_Quote_Quantity_1				int,
									NPC_Quote_Net_Item_Cost_1			decimal(10,3),
									NPC_Quote_Quantity_2				int,
									NPC_Quote_Net_Item_Cost_2			decimal(10,3),
									NPC_Quote_Quantity_3				int,
									NPC_Quote_Net_Item_Cost_3			decimal(10,3),
									NPC_Quote_Quantity_4				int,
									NPC_Quote_Net_Item_Cost_4			decimal(10,3),
									NPC_Quote_Quantity_5				int,
									NPC_Quote_Net_Item_Cost_5			decimal(10,3),
									NPC_Quote_Quantity_6				int,
									NPC_Quote_Net_Item_Cost_6			decimal(10,3),
									NPC_Quote_Quantity_7				int,
									NPC_Quote_Net_Item_Cost_7			decimal(10,3),
									HTS_Code							nvarchar(20),
									Features_BPA_Free					nvarchar(50),
									Features_Eco_Friendly				nvarchar(50),
									Features_FDA_Compliant				nvarchar(50),
									Features_Lead_Free					nvarchar(50),
									Features_Prop_65_Label_Required		nvarchar(50),
									Features_Recyclable					nvarchar(50),
									Features_Hazardous_Shipping			nvarchar(50),
									Hazardous_Shipping_Charge_NET		decimal(10,2),
									Rush_Production_Available			nvarchar(50),
									Rush_TAT							nvarchar(50),
									Rush_Charge							nvarchar(50),
									MCP_Product_Ref_ID					nvarchar(255),
									MCP_SKU_ID							nvarchar(255)
								)
								
declare @ProductSKUHolder	Table	(
										UniqueID			int identity(1,1) Primary Key,
										ProductID			int,
										SKUID				int,
										OracleID			nvarchar(255),
										OracleDesc			nvarchar(200),
										SkuFormat			nvarchar(200),
										PartNumber			nvarchar(200),
										[Description]		nvarchar(1000)
									)
									
declare @ProductSKUFinal	Table	(
										ProductID			int Primary Key,
										OracleIDString		nvarchar(2000),
										OracleDescString	nvarchar(2000),
										SkuFormatString		nvarchar(2000),
										PartNumberString	nvarchar(2000),
										DescriptionString	nvarchar(3000)
									)
									
declare @ProductSKUHolder2	Table	(
										UniqueID			int Primary Key,
										ProductID			int,
										SKUID				int,
										OracleID			nvarchar(255),
										OracleDesc			nvarchar(200),
										SkuFormat			nvarchar(200),
										PartNumber			nvarchar(200),
										[Description]		nvarchar(1000)
									)
									
declare @ProductImagesHolder	Table	(
											UniqueID			int identity(1,1) Primary Key,
											ProductID			int,
											ImageID				int,
											ImageName			nvarchar(255),
											ImagePath			nvarchar(1000)
										)
										
declare @ProductImagesHolder2	Table	(
											UniqueID			int Primary Key,
											ProductID			int,
											ImageID				int,
											ImageName			nvarchar(255),
											ImagePath			nvarchar(1000)
										)
										
declare @ProductImagesFinal	Table	(
										ProductID			int Primary Key,
										ImageNameString		nvarchar(2000),
										ImagePathString		nvarchar(4000)
									)
									
declare @ProductAttributeSizeHolder	Table	(
												UniqueID					int identity(1,1) Primary Key,
												ProductID					int,
												OracleID					nvarchar(255),
												ProductAttributeSizeID		int,
												ProductAttributeID			int,
												ProductAttributeName		nvarchar(60),
												ProductAttributeValue		nvarchar(20),
												ProductAttributeUOM			nvarchar(10)
											)
											
declare @ProductAttributeSizeHolder2	Table	(
													UniqueID					int Primary Key,
													ProductID					int,
													ProductAttributeSizeID		int,
													ProductAttributeID			int,
													ProductAttributeName		nvarchar(60),
													ProductAttributeValue		nvarchar(20),
													ProductAttributeUOM			nvarchar(10)
												)
												
declare @ProductAttributeSizeFinal	Table	(
												ProductID					int,
												ProductAttributeName		nvarchar(50),
												ProductAttributeValueString	nvarchar(1000),
												ProductAttributeUOMString	nvarchar(1000)
											)
											
declare @ProductAttributeColorHexHolder	Table	(
													UniqueID					int identity(1,1) Primary Key,
													ProductID					int,
													ProductAttributeColorID		int,
													Start						nvarchar(255),
													StartHexCode				nvarchar(7)
												)
												
declare @ProductAttributeColorHexHolder2	Table	(
														UniqueID					int Primary Key,
														ProductID					int,
														ProductAttributeColorID		int,
														Start						nvarchar(255),
														StartHexCode				nvarchar(7)
													)
declare @ProductAttributeColorHexFinal	Table	(
													ProductID					int Primary Key,
													StartString					nvarchar(255),
													StartHexCodeString			nvarchar(500)
												)
												
													
declare @ProductAttributeTypeTranHold	Table	(
													UniqueID					int identity(1,1) Primary Key,
													ProductID					int,
													OracleID					nvarchar(255),
													ProductAttTranID			int,
													ProductAttTypeTranID		int,
													AttributeType				nvarchar(60),
													AttributeTypeValue			nvarchar(60)
												)
												
declare @ProductAttributeTypeTranHold2	Table	(
													UniqueID					int Primary Key,
													ProductID					int,
													ProductAttTranID			int,
													ProductAttTypeTranID		int,
													AttributeType				nvarchar(60),
													AttributeTypeValue			nvarchar(60)
												)
												
declare @ProductAttributeTypeTranFinal	Table	(
													UniqueID					int identity(1,1) Primary Key,
													ProductID					int,
													AttributeType				nvarchar(60),
													AttributeTypeValueString	nvarchar(1000)
												)
												
declare @ProductAttributeInkHold	Table	(
												UniqueID					int identity(1,1) Primary Key,
												ProductID					int,
												OracleID					nvarchar(255),
												ProductAttTranID			int,
												ProductAttColorTranID		int,
												ProductAttTranType			nvarchar(60),
												ProductAttTranColorValue	nvarchar(60),
												ProductAttColorHexValue		nvarchar(60)
											)
											
declare @ProductAttributeInkHold2	Table	(
												UniqueID					int Primary Key,
												ProductID					int,
												ProductAttTranID			int,
												ProductAttColorTranID		int,
												ProductAttTranType			nvarchar(60),
												ProductAttTranColorValue	nvarchar(60),
												ProductAttColorHexValue		nvarchar(60)
											)
											
declare @ProductAttributeInkFinal	Table	(
												UniqueID							int identity(1,1) Primary Key,
												ProductID							int,
												ProductAttTranType					nvarchar(60),
												ProductAttTranColorValueString		nvarchar(1000),
												ProductAttColorHexValueString		nvarchar(1000)
											)
											
declare @ProductTransMaterialHold	Table	(
												UniqueID					int identity(1,1) Primary Key,
												ProductID					int,
												OracleID					nvarchar(255),
												ProductTranID				int,
												Material					nvarchar(1000)
											)
											
declare @ProductTransMaterialHold2	Table	(
												UniqueID					int Primary Key,
												ProductID					int,
												ProductTranID				int,
												Material					nvarchar(1000)
											)		
											
declare @ProductTransMaterialFinal	Table	(
												ProductID					int Primary Key,
												MaterialString				nvarchar(4000)
											)									
																
declare @ProductArtTemplateHold		Table	(
												UniqueID					int identity(1,1) Primary Key,
												ProductID					int,
												ProductArtTemplateID		int,
												ProductArtName				nvarchar(255),
												ProductArtPath				nvarchar(1000)
											)	
											
declare @ProductArtTemplateHold2		Table	(
												UniqueID					int Primary Key,
												ProductID					int,
												ProductArtTemplateID		int,
												ProductArtName				nvarchar(255),
												ProductArtPath				nvarchar(1000)
											)	
											
declare @ProductArtTemplateFinal		Table	(
													ProductID					int Primary Key,
													ProductArtNameString		nvarchar(2000),
													ProductArtPathString		nvarchar(4000)
												)	
												
declare @ProductImprintAreaColorHold	Table	(
													UniqueID						int identity(1,1) Primary Key,
													ProductID						int,
													ProductImprintAreaColorID		int,
													ProductImprintAreaColorTranID	int,
													ColorHexCode					nvarchar(7),
													ColorName						nvarchar(255)
												)
												
declare @ProductImprintAreaColorHold2	Table	(
													UniqueID						int Primary Key,
													ProductID						int,
													ProductImprintAreaColorID		int,
													ProductImprintAreaColorTranID	int,
													ColorHexCode					nvarchar(7),
													ColorName						nvarchar(255)
												)
												
declare @ProductImprintAreaColorFinal	Table	(
													ProductID						int Primary Key,
													ColorHexCodeString				nvarchar(1000),
													ColorNameString					nvarchar(2000)
												)
												
declare @ProductPriceTierHold	Table	(
											UniqueID					int identity(1,1) Primary Key,
											ProductID					int,
											ProductFOBID				int,
											ProductFOBPriceTierID		int,
											QtyStart					nvarchar(20),
											NPQuote						nvarchar(20),
											SequenceID					int,
											NPC_Quote_Quantity_1				int,
											NPC_Quote_Net_Item_Cost_1			decimal(10,3),
											NPC_Quote_Quantity_2				int,
											NPC_Quote_Net_Item_Cost_2			decimal(10,3),
											NPC_Quote_Quantity_3				int,
											NPC_Quote_Net_Item_Cost_3			decimal(10,3),
											NPC_Quote_Quantity_4				int,
											NPC_Quote_Net_Item_Cost_4			decimal(10,3),
											NPC_Quote_Quantity_5				int,
											NPC_Quote_Net_Item_Cost_5			decimal(10,3),
											NPC_Quote_Quantity_6				int,
											NPC_Quote_Net_Item_Cost_6			decimal(10,3),
											NPC_Quote_Quantity_7				int,
											NPC_Quote_Net_Item_Cost_7			decimal(10,3)
										)
										
declare @ProductPriceTierHold2	Table	(
											UniqueID					int Primary Key,
											ProductID					int,
											ProductFOBID				int,
											ProductFOBPriceTierID		int,
											QtyStart					nvarchar(20),
											NPQuote						nvarchar(20)
										)
										
declare @ProductPriceTierFinal	Table	(
											ProductID					int,
											QtyStartString				nvarchar(500),
											NPQuoteString				nvarchar(500),
											NPC_Quote_Quantity_1				int,
											NPC_Quote_Net_Item_Cost_1			decimal(10,3),
											NPC_Quote_Quantity_2				int,
											NPC_Quote_Net_Item_Cost_2			decimal(10,3),
											NPC_Quote_Quantity_3				int,
											NPC_Quote_Net_Item_Cost_3			decimal(10,3),
											NPC_Quote_Quantity_4				int,
											NPC_Quote_Net_Item_Cost_4			decimal(10,3),
											NPC_Quote_Quantity_5				int,
											NPC_Quote_Net_Item_Cost_5			decimal(10,3),
											NPC_Quote_Quantity_6				int,
											NPC_Quote_Net_Item_Cost_6			decimal(10,3),
											NPC_Quote_Quantity_7				int,
											NPC_Quote_Net_Item_Cost_7			decimal(10,3)
										)
										
declare @ProductAdditionChargeFinal	Table	(
												UniqueID				int identity(1,1) Primary Key,
												ProductID				int,
												Name					nvarchar(255),
												STDCatalogNet			decimal(10,2),
												STDCatalogPrice			decimal(10,2),
												NPQuote					decimal(10,2)
											)
																		
									

declare	@UniqueID							int,
		@ProductID							int,
		@OracleIDString						nvarchar(2000),
		@OracleDescString					nvarchar(2000),
		@OracleID							nvarchar(255),
		@OracleDesc							nvarchar(200),
		@SkuFormat							nvarchar(200),
		@SkuFormatString					nvarchar(2000),
		@PartNumber							nvarchar(200),
		@PartNumberString					nvarchar(2000),
		@Description						nvarchar(1000),
		@DescrptionString					nvarchar(3000),
		@SKUID								int,
		@MaxUniqueID						int,
		@UID								int,
		@LocaleID							int,
		@ImageID							int,
		@ImageName							nvarchar(255),
		@ImagePath							nvarchar(1000),
		@ImageNameString					nvarchar(2000),
		@ImagePathString					nvarchar(4000),
		@ProductAttributeColorID			int,
		@StartHexCode						nvarchar(7),
		@StartHexCodeString					nvarchar(500),
		@ProductAttColorTranID				int,
		@Start								nvarchar(255),
		@StartString						nvarchar(2000),
		@ProductAttTranID					int,
		@ProductAttTypeTranID				int,
		@AttributeType						nvarchar(60),
		@AttributeTypeValue					nvarchar(50),
		@AttributeTypeValueString			nvarchar(1000),
		@ProductAttTranType					nvarchar(50),
		@ProductAttTranColorValue			nvarchar(50),
		@ProductAttTranColorValueString		nvarchar(1000),
		@ProductAttColorHexValueString		nvarchar(1000),
		@ProductAttColorHexValue			nvarchar(1000),
		@ProductTranID						int,
		@Material							nvarchar(1000),
		@MaterialString						nvarchar(4000),
		@ProductArtTemplateID				int,
		@ProductArtName						nvarchar(255),
		@ProductArtPath						nvarchar(1000),
		@ProductArtNameString				nvarchar(2000),
		@ProductArtPathString				nvarchar(4000),
		@ProductAttributeSizeID				int,
		@ProductAttributeID					int,
		@ProductAttributeName				nvarchar(60),
		@ProductAttributeValue				nvarchar(20),
		@ProductAttributeUOM				nvarchar(10),
		@ProductAttributeValueString		nvarchar(1000),
		@ProductAttributeUOMString			nvarchar(1000),
		@ProductFOBID						int,
		@ProductFOBPriceTierID				int,
		@QtyStart							nvarchar(20),
		@NPQuote							nvarchar(20),
		@QtyStartSting						nvarchar(500),
		@NPQuoteString						nvarchar(500),
		@Type								varchar(50),
		@MinID								int,
		@BatchStatus						int,
		@NPC_Quote_Quantity_1				int,
		@NPC_Quote_Net_Item_Cost_1			decimal(10,3),
		@NPC_Quote_Quantity_2				int,
		@NPC_Quote_Net_Item_Cost_2			decimal(10,3),
		@NPC_Quote_Quantity_3				int,
		@NPC_Quote_Net_Item_Cost_3			decimal(10,3),
		@NPC_Quote_Quantity_4				int,
		@NPC_Quote_Net_Item_Cost_4			decimal(10,3),
		@NPC_Quote_Quantity_5				int,
		@NPC_Quote_Net_Item_Cost_5			decimal(10,3),
		@NPC_Quote_Quantity_6				int,
		@NPC_Quote_Net_Item_Cost_6			decimal(10,3),
		@NPC_Quote_Quantity_7				int,
		@NPC_Quote_Net_Item_Cost_7			decimal(10,3)
		
		

set @LocaleID = 12 -- LOCALE=en_US
set @Type = '14'



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
	insert @ProductsTable
		(
			ProductID,
			BatchID,
			NPGeneralComments,
			URL,
			Name,
			ASINumber,
			SupplierProductID,
			VendorProductID,
			WebCode,
			NPProductName,
			BrandedName,
			AvailableCountries,
			SellToCountries,
			OracleCatalog1,
			OracleCatalog2,
			OracleCatalog3,
			OracleCatalog4,
			OracleCategoryCode,
			VideoLinkURL,
			COO,
			MadeInUSA,
			[Weight],
			WeightUOM,
			Width,
			Height,
			Depth,
			SizeUOM,
			DimensionsComment,
			TATmin,
			TATmax,
			AttributeComboKey,
			AttributeComboValue,
			NPProductCode,
			Category_Product_Family,
			Subcategory,
			Oracle_Catalog_Level_1,
			Oracle_Catalog_Level_2,
			HTS_Code,
			Features_BPA_Free,
			Features_Eco_Friendly,
			Features_FDA_Compliant,
			Features_Lead_Free,
			Features_Prop_65_Label_Required,
			Features_Recyclable,
			Features_Hazardous_Shipping,
			Rush_Production_Available,
			OracleID,
			OracleDesc,
			SKU_Format,
			Supplier_Product_Sku,
			Supplier_Product_Sku_Description,
			MCP_Product_Ref_ID,
			MCP_SKU_ID
		)
	select	p.ID as ProductID,
			pb.BatchID,
			p.NPGeneralComments,
			p.URL,
			s.Name,
			s.ASINumber,
			p.SupplierProductID,
			p.VendorProductID,
			pcn.WebCode,
			pt.NPProductName,
			p.BrandedName,
			p.AvailableCountries,
			p.SellToCountries,
			p.OracleCatalog1,
			p.OracleCatalog2,
			p.OracleCatalog3,
			p.OracleCatalog4,
			p.OracleCategoryCode,
			p.VideoLinkURL,
			p.COO,
			case 
				when p.Features like '%USA Made%'
					then 'Y'
				else
					'N'
			end as MadeInUSA,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.[MetricWeight]
				else
					p.[Weight]
			end as [Weight],
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricWeightUOM
				else
					p.WeightUOM
			end as WeightUOM,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricWidth
				else
					p.Width
			end as Width,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricHeight
				else
					p.Height
			end as Height,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricDepth
				else
					p.Depth
			end as Depth,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricSizeUOM
				else
					p.SizeUOM
			end as SizeUOM,
			p.DimensionsComment,
			p.SupplierTATMin as TATmin,
			p.SupplierTATMax as TATmax,
			p.AttributeComboKey,
			p.AttributeComboValue,
			p.NPProductCode,
			pct.Name as Category_Product_Family,
			psct.Name as Subcategory,
			cc1.[Description] as Oracle_Catalog_Level_1,
			cc2.[Description] as Oracle_Catalog_Level_2,
			case
				when pcn.ChannelID in(4,5,6,7)
					then p.EUTarriffCode
				else
					p.CaTariffCode
			end as HTS_Code,
			case
				when p.Features like '%BPA Free%'
					then 'Yes'
				else
					'No'
			end as Features_BPA_Free,
			case
				when p.Features like '%Eco Friendly%'
					then 'Yes'
				else
					'No'
			end as Features_Eco_Friendly,
			case
				when p.Features like '%FDA Compliant%'
					then 'Yes'
				else
					'No'
			end as Features_FDA_Compliant,
			case
				when p.Features like '%Lead Free%'
					then 'Yes'
				else
					'No'
			end as Features_Lead_Free,
			case
				when p.Features like '%Prop 65 Label Required%'
					then 'Yes'
				else
					'No'
			end as Features_Prop_65_Label_Required,
			case
				when p.Features like '%Recyclable%'
					then 'Yes'
				else
					'No'
			end as Features_Recyclable,
			case
				when p.Features like '%Hazardous%'
					then 'Yes'
				else
					'No'
			end as Features_Hazardous_Shipping,
			case
				when p.Features like '%Rush Available%'
					then 'Yes'
				else
					'No'
			end as Rush_Production_Available,
			isnull(ps.OracleID,'') as OracleID,
			isnull(ps.OracleDesc,'') as OracleDesc,
			ISNULL(sf.Code,'') as SKU_Format,
			ps.PartNumber as Supplier_Product_Sku,
			ps.[Description] as Supplier_Product_Sku_Description,
			p.MCPFamilyRefID as MCP_Product_Ref_ID,
			ps.MCPSku as MCP_SKU_ID
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				-- and pb.ChannelID = 1 -- NADM Only (Take All channels)
		join ProductChannels pcn
			on p.ID = pcn.ProductID
				and pcn.ChannelID = pb.ChannelID -- NADM Only (Take All Channels)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join Suppliers s
			on p.SupplierID = s.ID
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pb.ChannelID = pt.ChannelID
		left join ProductCategories pc
			on p.ID = pc.ProductID
		left join ProductCategoryTranslations pct
			on p.ID = pct.ProductID
				and pc.ID = pct.ProductCategoryID
				and pct.LocaleID = @LocaleID
		left join ProductSubCategories psc
			on p.ID = psc.ProductID
		left join ProductSubCategoryTranslations psct
			on p.ID = psct.ProductID
				and psc.ProductCategoryID = psct.ProductCategoryID
				and psc.ID = psct.ProductSubCategoryID
				and psct.LocaleID = @LocaleID
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
		left join SkuFormats sf
			on ps.SkuFormatID = sf.ID
	where be.[Status] = '2'
		and be.ID = @MinID
end



if @BatchStatus = 6
begin
	insert @ProductsTable
		(
			ProductID,
			BatchID,
			NPGeneralComments,
			URL,
			Name,
			ASINumber,
			SupplierProductID,
			VendorProductID,
			WebCode,
			NPProductName,
			BrandedName,
			AvailableCountries,
			SellToCountries,
			OracleCatalog1,
			OracleCatalog2,
			OracleCatalog3,
			OracleCatalog4,
			OracleCategoryCode,
			VideoLinkURL,
			COO,
			MadeInUSA,
			[Weight],
			WeightUOM,
			Width,
			Height,
			Depth,
			SizeUOM,
			DimensionsComment,
			TATmin,
			TATmax,
			AttributeComboKey,
			AttributeComboValue,
			NPProductCode,
			Category_Product_Family,
			Subcategory,
			Oracle_Catalog_Level_1,
			Oracle_Catalog_Level_2,
			HTS_Code,
			Features_BPA_Free,
			Features_Eco_Friendly,
			Features_FDA_Compliant,
			Features_Lead_Free,
			Features_Prop_65_Label_Required,
			Features_Recyclable,
			Features_Hazardous_Shipping,
			Rush_Production_Available,
			OracleID,
			OracleDesc,
			SKU_Format,
			Supplier_Product_Sku,
			Supplier_Product_Sku_Description,
			MCP_Product_Ref_ID,
			MCP_SKU_ID
		)
	select	p.ID as ProductID,
			pb.BatchID,
			p.NPGeneralComments,
			p.URL,
			s.Name,
			s.ASINumber,
			p.SupplierProductID,
			p.VendorProductID,
			pcn.WebCode,
			pt.NPProductName,
			p.BrandedName,
			p.AvailableCountries,
			p.SellToCountries,
			p.OracleCatalog1,
			p.OracleCatalog2,
			p.OracleCatalog3,
			p.OracleCatalog4,
			p.OracleCategoryCode,
			p.VideoLinkURL,
			p.COO,
			case 
				when p.Features like '%USA Made%'
					then 'Y'
				else
					'N'
			end as MadeInUSA,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.[MetricWeight]
				else
					p.[Weight]
			end as [Weight],
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricWeightUOM
				else
					p.WeightUOM
			end as WeightUOM,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricWidth
				else
					p.Width
			end as Width,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricHeight
				else
					p.Height
			end as Height,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricDepth
				else
					p.Depth
			end as Depth,
			case 
				when pcn.ChannelID in(4,5,6,7)
					then p.MetricSizeUOM
				else
					p.SizeUOM
			end as SizeUOM,
			p.DimensionsComment,
			p.SupplierTATMin as TATmin,
			p.SupplierTATMax as TATmax,
			p.AttributeComboKey,
			p.AttributeComboValue,
			p.NPProductCode,
			pct.Name as Category_Product_Family,
			psct.Name as Subcategory,
			cc1.[Description] as Oracle_Catalog_Level_1,
			cc2.[Description] as Oracle_Catalog_Level_2,
			case
				when pcn.ChannelID in(4,5,6,7)
					then p.EUTarriffCode
				else
					p.CaTariffCode
			end as HTS_Code,
			case
				when p.Features like '%BPA Free%'
					then 'Yes'
				else
					'No'
			end as Features_BPA_Free,
			case
				when p.Features like '%Eco Friendly%'
					then 'Yes'
				else
					'No'
			end as Features_Eco_Friendly,
			case
				when p.Features like '%FDA Compliant%'
					then 'Yes'
				else
					'No'
			end as Features_FDA_Compliant,
			case
				when p.Features like '%Lead Free%'
					then 'Yes'
				else
					'No'
			end as Features_Lead_Free,
			case
				when p.Features like '%Prop 65 Label Required%'
					then 'Yes'
				else
					'No'
			end as Features_Prop_65_Label_Required,
			case
				when p.Features like '%Recyclable%'
					then 'Yes'
				else
					'No'
			end as Features_Recyclable,
			case
				when p.Features like '%Hazardous%'
					then 'Yes'
				else
					'No'
			end as Features_Hazardous_Shipping,
			case
				when p.Features like '%Rush Available%'
					then 'Yes'
				else
					'No'
			end as Rush_Production_Available,
			isnull(ps.OracleID,'') as OracleID,
			isnull(ps.OracleDesc,'') as OracleDesc,
			ISNULL(sf.Code,'') as SKU_Format,
			ps.PartNumber as Supplier_Product_Sku,
			ps.[Description] as Supplier_Product_Sku_Description,
			p.MCPFamilyRefID as MCP_Product_Ref_ID,
			ps.MCPSku as MCP_SKU_ID
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only (Take All channels)
		join ProductChannels pcn
			on p.ID = pcn.ProductID
				and pcn.ChannelID = pb.ChannelID -- NADM Only (Take All Channels)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join Suppliers s
			on p.SupplierID = s.ID
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pb.ChannelID = pt.ChannelID
		left join ProductCategories pc
			on p.ID = pc.ProductID
		left join ProductCategoryTranslations pct
			on p.ID = pct.ProductID
				and pc.ID = pct.ProductCategoryID
				and pct.LocaleID = @LocaleID
		left join ProductSubCategories psc
			on p.ID = psc.ProductID
		left join ProductSubCategoryTranslations psct
			on p.ID = psct.ProductID
				and psc.ProductCategoryID = psct.ProductCategoryID
				and psc.ID = psct.ProductSubCategoryID
				and psct.LocaleID = @LocaleID
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
		left join SkuFormats sf
			on ps.SkuFormatID = sf.ID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where be.[Status] = '6'
		and be.ID = @MinID
end



-- Product SKUs Start
/*  Comment this part out to make the skus not itemized into one row 5/1/2020 -- Nhan Le.
insert @ProductSKUHolder
	(
		ProductID,
		SKUID,
		OracleID,
		OracleDesc,
		SkuFormat,
		PartNumber,
		[Description]
	)
select	p.ProductID,
		ps.ID,
		isnull(ps.OracleID,''),
		isnull(ps.OracleDesc,''),
		ISNULL(sf.Code,''),
		ps.PartNumber,
		ps.[Description]
from @ProductsTable p
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
	left join SkuFormats sf
		on ps.SkuFormatID = sf.ID
where isnull(ps.OracleID,'') <> ''
	or isnull(ps.OracleDesc,'') <> ''
order by p.ProductID,ps.ID





set @OracleIDString = ''
set @OracleDescString = ''
set @OracleID = ''
set @OracleDesc = ''
set @SkuFormat = ''
set @SkuFormatString = ''
set @PartNumber = ''
set @PartNumberString = ''
set @Description = ''
set @DescrptionString = ''


while exists (select top 1 UniqueID from @ProductSKUHolder)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductSKUHolder order by UniqueID)
	
	select	@ProductID = ProductID
	from @ProductSKUHolder
	where UniqueID = @UniqueID
	
	
	insert @ProductSKUHolder2	(
									UniqueID,
									ProductID,
									SKUID,
									OracleID,
									OracleDesc,
									SkuFormat,
									PartNumber,
									[Description]
								)
	select	UniqueID,
			ProductID,
			SKUID,
			OracleID,
			OracleDesc,
			SkuFormat,
			PartNumber,
			[Description]
	from @ProductSKUHolder
	where ProductID = @ProductID
	order by UniqueID
	
	select	@MaxUniqueID = (select MAX(UniqueID) from @ProductSKUHolder2)

	while exists(select top 1 UniqueID from @ProductSKUHolder2)
		begin
			select @UID = (select top 1 UniqueID from @ProductSKUHolder2 order by UniqueID)
			select	@SKUID = SKUID,
					@OracleID = OracleID,
					@OracleDesc = OracleDesc,
					@SkuFormat = SkuFormat,
					@PartNumber = PartNumber,
					@Description = [Description]
			from @ProductSKUHolder2
			where UniqueID = @UID
		
		

			if @UID <> @MaxUniqueID
			begin
				select @OracleIDString = @OracleIDString + @OracleID + ', '
				select @OracleDescString = @OracleDescString + @OracleDesc + ', '
				select @SkuFormatString = @SkuFormatString + @SkuFormat + ', '
				select @PartNumberString = @PartNumberString + @PartNumber + ', '
				select @DescrptionString = @DescrptionString + @Description + ', '
			end
			else
			begin
				select @OracleIDString = @OracleIDString + @OracleID
				select @OracleDescString = @OracleDescString + @OracleDesc
				select @SkuFormatString = @SkuFormatString + @SkuFormat
				select @PartNumberString = @PartNumberString + @PartNumber
				select @DescrptionString = @DescrptionString + @Description
			end
						
			
			delete @ProductSKUHolder2 where UniqueID = @UID
		end
		
		
	if exists(select top 1 ProductID from @ProductSKUFinal where ProductID = @ProductID)
	begin
		update @ProductSKUFinal
		set OracleIDString = @OracleIDString,
			OracleDescString = @OracleDescString,
			SkuFormatString = @SkuFormatString,
			PartNumberString = @PartNumberString,
			DescriptionString = @DescrptionString
		where ProductID = @ProductID
	end
	begin
		insert @ProductSKUFinal(ProductID,OracleIDString,OracleDescString,SkuFormatString,PartNumberString,DescriptionString)
		values(@ProductID,@OracleIDString,@OracleDescString,@SkuFormatString,@PartNumberString,@DescrptionString)
	end
	
	
	delete @ProductSKUHolder where ProductID = @ProductID
	
	set @OracleIDString = ''
	set @OracleDescString = ''
	set @OracleID = ''
	set @OracleDesc = ''
	set @SkuFormat = ''
	set @SkuFormatString = ''
	set @PartNumber = ''
	set @PartNumberString = ''
	set @Description = ''
	set @DescrptionString = ''
	set @ProductID = 0
	set @SKUID = 0
	set @UniqueID = 0
	set @MaxUniqueID = 0

end



update p
set p.OracleID = ps.OracleIDString,
	p.OracleDesc = ps.OracleDescString,
	p.SKU_Format = ps.SkuFormatString,
	p.Supplier_Product_Sku = ps.PartNumberString,
	p.Supplier_Product_Sku_Description = ps.DescriptionString
from @ProductsTable p
	join @ProductSKUFinal ps
		on p.ProductID = ps.ProductID
*/

-- Product SKUs End




-- Product Images Start
insert @ProductImagesHolder	(
								ProductID,
								ImageID,
								ImageName,
								ImagePath
							)
select	distinct p.ProductID,
		i.ID,
		isnull(i.Name,''),
		isnull(i.[Path],'')
from @ProductsTable p
	join ProductBatches pb
			on p.ProductID = pb.ProductID
				and pb.BatchID = @BatchID
	join ProductImages i
		on p.ProductID = i.ProductID
			and i.ChannelID = pb.ChannelID
			and i.LocaleID = @LocaleID
			and pb.ChannelID = i.ChannelID
where isnull(i.Name,'') <> ''
	or isnull(i.[Path],'') <> ''
order by p.ProductID,i.ID




set @UniqueID = 0
set @UID = 0
set @ImageID = 0
set @ProductID = 0
set @ImageName = ''
set @ImagePath = ''
set @ImageNameString = ''
set @ImagePathString = ''
set @MaxUniqueID = 0


while exists(select top 1 UniqueID from @ProductImagesHolder)
begin
	select @UniqueID = (select top 1 UniqueID from @ProductImagesHolder order by UniqueID)
	
	select @ProductID = ProductID
	from @ProductImagesHolder
	where UniqueID = @UniqueID
	
	
	insert @ProductImagesHolder2	(
										UniqueID,
										ProductID,
										ImageID,
										ImageName,
										ImagePath
									)
	select	UniqueID,
			ProductID,
			ImageID,
			ImageName,
			ImagePath
	from @ProductImagesHolder
	where ProductID = @ProductID
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductImagesHolder2)
	
	while exists(select top 1 UniqueID from @ProductImagesHolder2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductImagesHolder2 order by UniqueID)
		select	@ImageID = ImageID,
				@ImageName = ImageName,
				@ImagePath = ImagePath
		from @ProductImagesHolder2
		where UniqueID = @UID
		

		if @UID <> @MaxUniqueID
		begin
			select @ImageNameString = @ImageNameString + @ImageName + ', '
			select @ImagePathString = @ImagePathString + @ImagePath + ', '
		end
		else
		begin
			select @ImageNameString = @ImageNameString + @ImageName
			select @ImagePathString = @ImagePathString + @ImagePath
		end
		
		
		delete @ProductImagesHolder2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductImagesFinal where ProductID = @ProductID)
	begin
		update @ProductImagesFinal
		set ImageNameString = @ImageNameString,
			ImagePathString = @ImagePathString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductImagesFinal(ProductID,ImageNameString,ImagePathString)
		values(@ProductID,@ImageNameString,@ImagePathString)
	end
	
	
	delete @ProductImagesHolder where ProductID = @ProductID
	
	set @UniqueID = 0
	set @UID = 0
	set @ImageID = 0
	set @ProductID = 0
	set @ImageName = ''
	set @ImagePath = ''
	set @ImageNameString = ''
	set @ImagePathString = ''
	set @MaxUniqueID = 0
end


update p
set p.ImageName = pif.ImageNameString,
	p.ImagePath = pif.ImagePathString
from @ProductsTable p
	join @ProductImagesFinal pif
		on p.ProductID = pif.ProductID

-- Product Images End



-- Product Attribute Sizes Start
insert @ProductAttributeSizeHolder	(
										ProductID,
										OracleID,
										ProductAttributeSizeID,
										ProductAttributeID,
										ProductAttributeName,
										ProductAttributeValue,
										ProductAttributeUOM
									)
select	distinct p.ProductID,
		ps.OracleID,
		pas.ID,
		pas.ProductAttributeID,
		isnull(pat.Name,''),
		isnull(pas.Value,''),
		isnull(pas.UOM,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductAttributeSizes pas
		on p.ProductID = pas.ProductID
	join ProductAttributeTranslations pat
		on pas.ProductID = pat.ProductID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Capacity'		
	join ProductSkuAttributes psa
		on p.ProductID = psa.ProductID
			and pas.ProductAttributeID = psa.AttributeID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
	join ProductSKUs ps
		on psa.ProductSkuID = ps.ID
			and psa.ProductID = ps.ProductID
where isnull(pat.Name,'') <> ''
	or isnull(pas.Value,'') <> ''
	or isnull(pas.UOM,'') <> ''
order by p.ProductID,pas.ID



insert @ProductAttributeSizeHolder	(
										ProductID,
										OracleID,
										ProductAttributeSizeID,
										ProductAttributeID,
										ProductAttributeName,
										ProductAttributeValue,
										ProductAttributeUOM
									)
select	distinct p.ProductID,
		ps.OracleID,
		pas.ID,
		pas.ProductAttributeID,
		isnull(pat.Name,''),
		isnull(pas.Value,''),
		isnull(pas.UOM,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductAttributeSizes pas
		on p.ProductID = pas.ProductID
	join ProductAttributeTranslations pat
		on pas.ProductID = pat.ProductID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Size'
	join ProductSkuAttributes psa
		on p.ProductID = psa.ProductID
			and pas.ProductAttributeID = psa.AttributeID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
			and psa.Value = pas.Value
	join ProductSKUs ps
		on psa.ProductSkuID = ps.ID
			and psa.ProductID = ps.ProductID
where isnull(pat.Name,'') <> ''
	or isnull(pas.Value,'') <> ''
	or isnull(pas.UOM,'') <> ''
order by p.ProductID,pas.ID




insert @ProductAttributeSizeHolder	(
										ProductID,
										OracleID,
										ProductAttributeSizeID,
										ProductAttributeID,
										ProductAttributeName,
										ProductAttributeValue,
										ProductAttributeUOM
									)
select	distinct p.ProductID,
		ps.OracleID,
		pas.ID,
		pas.ProductAttributeID,
		isnull(pat.Name,''),
		isnull(pas.Value,''),
		isnull(pas.UOM,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductAttributeSizes pas
		on p.ProductID = pas.ProductID
	join ProductAttributeTranslations pat
		on pas.ProductID = pat.ProductID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Point Size'
	join ProductSkuAttributes psa
		on p.ProductID = psa.ProductID
			and pas.ProductAttributeID = psa.AttributeID
			and pas.ProductAttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
	join ProductSKUs ps
		on psa.ProductSkuID = ps.ID
			and psa.ProductID = ps.ProductID
where isnull(pat.Name,'') <> ''
	or isnull(pas.Value,'') <> ''
	or isnull(pas.UOM,'') <> ''
order by p.ProductID,pas.ID--,pat.Name,pat.ID
	

update p
set p.Capacity = pasf.ProductAttributeValue,
	p.CapacityUOM = pasf.ProductAttributeUOM
from @ProductsTable p
	join @ProductAttributeSizeHolder pasf
		on p.ProductID = pasf.ProductID
			and p.OracleID = pasf.OracleID
			and pasf.ProductAttributeName = 'Capacity'

update p
set p.SizeAvailable = pasf.ProductAttributeValue
from @ProductsTable p
	join @ProductAttributeSizeHolder pasf
		on p.ProductID = pasf.ProductID
			and p.OracleID = pasf.OracleID
			and pasf.ProductAttributeName = 'Size'			
					
update p
set p.PointSize = pasf.ProductAttributeValue,
	p.CapacityUOM = pasf.ProductAttributeUOM
from @ProductsTable p
	join @ProductAttributeSizeHolder pasf
		on p.ProductID = pasf.ProductID
			and p.OracleID = pasf.OracleID
			and pasf.ProductAttributeName = 'Point Size'


/*
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductAttributeSizeID = 0
set @ProductAttributeID	= 0
set @ProductAttributeName = ''
set @ProductAttributeValue = ''
set @ProductAttributeUOM = ''
set @ProductAttributeValueString = ''
set @ProductAttributeUOMString = ''




while exists(select top 1 UniqueID from @ProductAttributeSizeHolder)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductAttributeSizeHolder order by UniqueID)
	
	select	@ProductID = ProductID,
			@ProductAttributeName = ProductAttributeName
	from @ProductAttributeSizeHolder
	where UniqueID = @UniqueID
	
	
	insert @ProductAttributeSizeHolder2	(
											UniqueID,
											ProductID,
											ProductAttributeSizeID,
											ProductAttributeID,
											ProductAttributeName,
											ProductAttributeValue,
											ProductAttributeUOM
										)
	select	UniqueID,
			ProductID,
			ProductAttributeSizeID,
			ProductAttributeID,
			ProductAttributeName,
			ProductAttributeValue,
			ProductAttributeUOM
	from @ProductAttributeSizeHolder
	where ProductID = @ProductID
		and ProductAttributeName = @ProductAttributeName
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductAttributeSizeHolder2)
	
	while exists(select top 1 UniqueID from @ProductAttributeSizeHolder2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductAttributeSizeHolder2 order by UniqueID)
		
		select	@ProductAttributeSizeID = ProductAttributeSizeID,
				@ProductAttributeID = ProductAttributeID,
				@ProductAttributeValue = ProductAttributeValue,
				@ProductAttributeUOM = ProductAttributeUOM
		from @ProductAttributeSizeHolder2
		where UniqueID = @UID
		
		

		if @UID <> @MaxUniqueID
		begin
			select @ProductAttributeValueString = @ProductAttributeValueString + @ProductAttributeValue + ', '
			select @ProductAttributeUOMString = @ProductAttributeUOMString + @ProductAttributeUOM + ', '
		end
		else
		begin
			select @ProductAttributeValueString = @ProductAttributeValueString + @ProductAttributeValue
			select @ProductAttributeUOMString = @ProductAttributeUOMString + @ProductAttributeUOM
		end

		
		
		delete @ProductAttributeSizeHolder2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductAttributeSizeFinal where ProductID = @ProductID and ProductAttributeName = @ProductAttributeName)
	begin
		update @ProductAttributeSizeFinal
		set ProductAttributeValueString = @ProductAttributeValueString,
			ProductAttributeUOMString = @ProductAttributeUOMString
		where ProductID = @ProductID
			and ProductAttributeName = @ProductAttributeName
	end
	else
	begin
		insert @ProductAttributeSizeFinal(ProductID,ProductAttributeName,ProductAttributeValueString,ProductAttributeUOMString)
		values(@ProductID,@ProductAttributeName,@ProductAttributeValueString,@ProductAttributeUOMString)
	end
	
	
	delete @ProductAttributeSizeHolder where ProductID = @ProductID and ProductAttributeName = @ProductAttributeName
	
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductAttributeSizeID = 0
	set @ProductAttributeID	= 0
	set @ProductAttributeName = ''
	set @ProductAttributeValue = ''
	set @ProductAttributeUOM = ''
	set @ProductAttributeValueString = ''
	set @ProductAttributeUOMString = ''
end


--update p
--set p.Capacity = pasf.ProductAttributeValueString,
--	p.CapacityUOM = pasf.ProductAttributeUOMString
--from @ProductsTable p
--	join @ProductAttributeSizeFinal pasf
--		on p.ProductID = pasf.ProductID
--			and pasf.ProductAttributeName = 'Capacity'
			
			

			
update p
set p.SizeAvailable = pasf.ProductAttributeValueString
from @ProductsTable p
	join @ProductAttributeSizeFinal pasf
		on p.ProductID = pasf.ProductID
			and pasf.ProductAttributeName = 'Size'
			
			
update p
set p.PointSize = pasf.ProductAttributeValueString
from @ProductsTable p
	join @ProductAttributeSizeFinal pasf
		on p.ProductID = pasf.ProductID
			and pasf.ProductAttributeName = 'Point Size'
*/
-- Product Attribute Sizes End



--Product Attribute Option Start
declare @ProdAttributeStart	Table	(
										UniqueID				int identity(1,1) Primary Key,
										ProductID				int,
										PartNumber				nvarchar(60),
										OracleID				nvarchar(255),
										AttributeName			nvarchar(255),
										AttributeOptionID		int,
										AttributeOption			nvarchar(255),
										AttributeHexVal			nvarchar(255),
										AttributeOptionType		nvarchar(50)
									)
									
declare @ProdAttributeFinal	Table	(
										UniqueID				int identity(1,1) Primary Key,
										ProductID				int,
										PartNumber				nvarchar(60),
										OracleID				nvarchar(255),
										AttributeName			nvarchar(255),
										AttributeOptionID		int,
										AttributeOption			nvarchar(255),
										AttributeHexVal			nvarchar(255),
										AttributeOptionType		nvarchar(50),
										AttributeOptionOrder	int
									)
									
declare @ProdAttributeLoop	Table	(
										UniqueID				int identity(1,1) Primary Key,
										ProductID				int,
										AttributeName			nvarchar(255),
										AttributeOptionID		int,
										AttributeOption			nvarchar(255),
										AttributeHexVal			nvarchar(255),
										AttributeOptionType		nvarchar(50)
									)




insert @ProdAttributeStart
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType
	)
select	distinct p.ProductID,
		ps.PartNumber,
		ps.OracleID,
		pat.Name,
		pac.ID,
		isnull(pact.Start,''),
		isnull(pac.StartHexCode,''),
		'Color' as OptionOrderType
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on psa.ProductID = pat.ProductID
			and psa.AttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
	join ProductAttributeColors pac
		on pat.ProductID = pac.ProductID
			and pat.ProductAttributeID = pac.ProductAttributeID
	join ProductAttributeColorTranslations pact
		on pac.ProductID = pact.ProductID
			and pac.ProductAttributeID = pact.ProductAttributeID
			and pac.ID = pact.ProductAttributeColorID
			and pact.LocaleID = @LocaleID
			and pact.Start = psa.Value
			and pb.ChannelID = pact.ChannelID
where (
		isnull(pact.Start,'') <> ''
		or 
		isnull(pac.StartHexCode,'') <> ''
	  )
	  and pat.Name not in
	  (
		'Capacity',
		'Size',
		'Refill Type',
		'Point Type',
		'Point Size',
		'Ink'
	  )
order by p.ProductID,pac.ID



insert @ProdAttributeStart
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType
	)
select	distinct p.ProductID,
		ps.PartNumber,
		ps.OracleID,
		pat.Name,
		pac.ID,
		pac.Name,
		'',
		'Type' as OptionOrderType
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on p.ProductID = pat.ProductID
			and pat.LocaleID = @LocaleID
	join ProductAttributeTypes patype
		on pat.ProductID = patype.ProductID
			and pat.ProductAttributeID = patype.ProductAttributeID		
	join ProductAttributeTypeTranslations pac
		on patype.ProductID = pac.ProductID
			and patype.ProductAttributeID = pac.ProductAttributeID
			and patype.ID = pac.ProductAttributeTypeID
			and pac.LocaleID = @LocaleID
			and pac.Name = psa.Value
where ISNULL(pac.Name,'') <> ''
	  and pat.Name not in
	  (
		'Capacity',
		'Size',
		'Refill Type',
		'Point Type',
		'Point Size',
		'Ink'
	  )
order by p.ProductID,pac.ID


insert @ProdAttributeStart
	(
		ProductID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType
	)
select	distinct p.ProductID,
		pat.Name,
		pac.ID,
		pac.Value,
		'',
		'Size' as OptionOrderType
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on p.ProductID = pat.ProductID
			and pat.LocaleID = @LocaleID
	join ProductAttributeSizes pac
		on pat.ProductID = pac.ProductID
			and pat.ProductAttributeID = pac.ProductAttributeID
			and pac.Value = psa.Value
where ISNULL(pac.Value,'') <> ''
	  and pat.Name not in
	  (
		'Capacity',
		'Size',
		'Refill Type',
		'Point Type',
		'Point Size',
		'Ink'
	  )
order by p.ProductID,pac.ID




insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		1 as AttributeOptionOrder
from @ProdAttributeStart
where AttributeName = 'Product'
	and AttributeOptionType = 'Color'
order by UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName = 'Product'
				and aa.AttributeOptionType = 'Type'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName = 'Product'
	and a.AttributeOptionType = 'Type'
order by a.UniqueID



insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName = 'Product'
				and aa.AttributeOptionType = 'Size'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName = 'Product'
	and a.AttributeOptionType = 'Size'
order by a.UniqueID




insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Product%'
				and LEN(aa.AttributeName) > 7
				and aa.AttributeOptionType = 'Color'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Product%'
	and LEN(a.AttributeName) > 7
	and a.AttributeOptionType = 'Color'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Product%'
				and LEN(aa.AttributeName) > 7
				and aa.AttributeOptionType = 'Type'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Product%'
	and LEN(a.AttributeName) > 7
	and a.AttributeOptionType = 'Type'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Product%'
				and LEN(aa.AttributeName) > 7
				and aa.AttributeOptionType = 'Size'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Product%'
	and LEN(a.AttributeName) > 7
	and a.AttributeOptionType = 'Size'
order by a.UniqueID



insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a	
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName = 'Trim'
				and aa.AttributeOptionType = 'Color'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName = 'Trim'
	and a.AttributeOptionType = 'Color'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder  + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a	
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName = 'Trim'
				and aa.AttributeOptionType = 'Type'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName = 'Trim'
	and a.AttributeOptionType = 'Type'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder  + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a	
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName = 'Trim'
				and aa.AttributeOptionType = 'Size'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName = 'Trim'
	and a.AttributeOptionType = 'Size'
order by a.UniqueID



insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Trim%'
				and LEN(aa.AttributeName) > 4
				and aa.AttributeOptionType = 'Color'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Trim%'
	and LEN(a.AttributeName) > 4
	and a.AttributeOptionType = 'Color'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Trim%'
				and LEN(aa.AttributeName) > 4
				and aa.AttributeOptionType = 'Type'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Trim%'
	and LEN(a.AttributeName) > 4
	and a.AttributeOptionType = 'Type'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
			where aa.AttributeName like 'Trim%'
				and LEN(aa.AttributeName) > 4
				and aa.AttributeOptionType = 'Size'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName like 'Trim%'
	and LEN(a.AttributeName) > 4
	and a.AttributeOptionType = 'Size'
order by a.UniqueID


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
				left join @ProdAttributeFinal bb
					on aa.ProductID = bb.ProductID
						and aa.AttributeName <> bb.AttributeName
						and aa.AttributeOptionType = 'Color'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName not like 'Product%'
	and a.AttributeName not like 'Trim%'
	and a.AttributeOptionType = 'Color'		
order by a.ProductID,a.AttributeName



insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
				left join @ProdAttributeFinal bb
					on aa.ProductID = bb.ProductID
						and aa.AttributeName <> bb.AttributeName
						and aa.AttributeOptionType = 'Type'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName not like 'Product%'
	and a.AttributeName not like 'Trim%'
	and a.AttributeOptionType = 'Type'		
order by a.ProductID,a.AttributeName


insert @ProdAttributeFinal	
	(
		ProductID,
		PartNumber,
		OracleID,
		AttributeName,
		AttributeOptionID,
		AttributeOption,
		AttributeHexVal,
		AttributeOptionType,
		AttributeOptionOrder
	)
select	a.ProductID,
		a.PartNumber,
		a.OracleID,
		a.AttributeName,
		a.AttributeOptionID,
		a.AttributeOption,
		a.AttributeHexVal,
		a.AttributeOptionType,
		Case
			when b.AttributeOptionOrder is null
				then 1
			else
				b.AttributeOptionOrder + c.RowNumber
		End as AttributeOptionOrder
from @ProdAttributeStart a
	join
		(
			select	aa.ProductID,
					aa.AttributeName,
					RowNumber = ROW_NUMBER() over (Partition by aa.ProductID,aa.AttributeName Order By aa.ProductID,aa.AttributeName)
			from @ProdAttributeStart aa
				left join @ProdAttributeFinal bb
					on aa.ProductID = bb.ProductID
						and aa.AttributeName <> bb.AttributeName
						and aa.AttributeOptionType = 'Size'
			group by aa.ProductID,aa.AttributeName
		) c
	on a.ProductID = c.ProductID
		and a.AttributeName = c.AttributeName
	left join
		(
			select	ProductID,
					MAX(AttributeOptionOrder) as AttributeOptionOrder
			from @ProdAttributeFinal
			group by ProductID
		) b
	on a.ProductID = b.ProductID
where a.AttributeName not like 'Product%'
	and a.AttributeName not like 'Trim%'
	and a.AttributeOptionType = 'Size'		
order by a.ProductID,a.AttributeName




update p
set p.Attribute1Name = pac.AttributeName
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 1
			
update p
set p.Attribute2Name = pac.AttributeName
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 2
			
update p
set p.Attribute3Name = pac.AttributeName
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 3


update p
set p.Attribute1ColorHexVal = pac.AttributeHexVal,
	p.Attribute1Options = pac.AttributeOption
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and p.Supplier_Product_Sku = pac.PartNumber
			and p.OracleID = pac.OracleID
			and pac.AttributeOptionOrder = 1
			
			
update p
set p.Attribute2ColorHexVal = pac.AttributeHexVal,
	p.Attribute2Options = pac.AttributeOption
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and p.Supplier_Product_Sku = pac.PartNumber
			and p.OracleID = pac.OracleID
			and pac.AttributeOptionOrder = 2
			
			
update p
set p.Attribute3ColorHexVal = pac.AttributeHexVal,
	p.Attribute3Options = pac.AttributeOption
from @ProductsTable p
	join @ProdAttributeFinal pac
		on p.ProductID = pac.ProductID
			and p.Supplier_Product_Sku = pac.PartNumber
			and p.OracleID = pac.OracleID
			and pac.AttributeOptionOrder = 3





/*
declare @ProdAttributeFinalHolder	Table	(
												UniqueID				int Primary Key,
												ProductID				int,
												AttributeName			nvarchar(255),
												AttributeOptionID		int,
												AttributeOption			nvarchar(255),
												AttributeHexVal			nvarchar(255),
												AttributeOptionType		nvarchar(50),
												AttributeOptionOrder	int
											)
											
declare @ProdAttributeFinalHolder2	Table	(
												UniqueID				int identity(1,1) Primary Key,
												ProductID				int,
												AttributeName			nvarchar(255),
												AttributeOptionID		int,
												AttributeOptionString	nvarchar(1000),
												AttributeHexValString	nvarchar(1000),
												AttributeOptionType		nvarchar(50),
												AttributeOptionOrder	int
											)


declare @AttributeName			nvarchar(255),
		@AttributeOptionID		int,
		@AttributeOption		nvarchar(255),
		@AttributeHexVal		nvarchar(255),
		@AttributeOptionType	nvarchar(50),
		@AttributeOptionOrder	int,
		@AttributeOptionString	nvarchar(1000),
		@AttributeHexValString	nvarchar(1000)


set @UniqueID = 0
set @UID = 0
set @ProductID = 0
set @MaxUniqueID = 0
set @AttributeName = ''
set @AttributeOptionID = 0
set @AttributeOption= ''
set @AttributeHexVal = ''
set @AttributeOptionType = ''
set @AttributeOptionOrder = 0
set @AttributeOptionString = ''
set @AttributeHexValString = ''


while exists(select top 1 UniqueID from @ProdAttributeFinal)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProdAttributeFinal	order by UniqueID)
	
	select	@ProductID = ProductID,
			@AttributeName = AttributeName,
			@AttributeOptionOrder = AttributeOptionOrder
	from @ProdAttributeFinal	
	where UniqueID = @UniqueID
	
	
	insert @ProdAttributeFinalHolder	(
											UniqueID,
											ProductID,
											AttributeName,
											AttributeOptionID,
											AttributeOption,
											AttributeHexVal,
											AttributeOptionType,
											AttributeOptionOrder
										)
	select	UniqueID,
			ProductID,
			AttributeName,
			AttributeOptionID,
			AttributeOption,
			AttributeHexVal,
			AttributeOptionType,
			AttributeOptionOrder
	from @ProdAttributeFinal
	where ProductID = @ProductID
		and AttributeName = @AttributeName
		and AttributeOptionOrder = @AttributeOptionOrder
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProdAttributeFinalHolder)
	
	while exists(select top 1 UniqueID from @ProdAttributeFinalHolder)
	begin
		select	@UID = (select top 1 UniqueID from @ProdAttributeFinalHolder order by UniqueID)
		select	@AttributeOptionID = AttributeOptionID,
				@AttributeOption = AttributeOption,
				@AttributeHexVal = AttributeHexVal,
				@AttributeOptionType = AttributeOptionType,
				@AttributeOptionOrder = AttributeOptionOrder
		from @ProdAttributeFinalHolder
		where UniqueID = @UID
		

		if @UID <> @MaxUniqueID
		begin
			if @AttributeOptionType = 'Color'
			begin
				select @AttributeOptionString = @AttributeOptionString + @AttributeOption + ', '
				select @AttributeHexValString = @AttributeHexValString + @AttributeHexVal + ', '
			end
			else
			begin
				select @AttributeOptionString = @AttributeOptionString + @AttributeOption + ', '
				select @AttributeHexValString = ''
			end
		end
		else
		begin
			if @AttributeOptionType = 'Color'
			begin
				select @AttributeOptionString = @AttributeOptionString + @AttributeOption
				select @AttributeHexValString = @AttributeHexValString + @AttributeHexVal
			end
			else
			begin
				select @AttributeOptionString = @AttributeOptionString + @AttributeOption
				select @AttributeHexValString = ''
			end
		end
			
		
		delete @ProdAttributeFinalHolder where UniqueID = @UID		
	end
	
	
	if exists(select top 1 ProductID from @ProdAttributeFinalHolder2 where ProductID = @ProductID and AttributeName = @AttributeName and AttributeOptionOrder = @AttributeOptionOrder)
	begin
		update @ProdAttributeFinalHolder2
		set AttributeOptionString = @AttributeOptionString,
			AttributeHexValString = @AttributeHexValString
		where ProductID = @ProductID
			and AttributeName = @AttributeName
			and AttributeOptionOrder = @AttributeOptionOrder
	end
	begin
		insert @ProdAttributeFinalHolder2(ProductID,AttributeName,AttributeOptionID,AttributeOptionString,AttributeHexValString,AttributeOptionType,AttributeOptionOrder)
		values(@ProductID,@AttributeName,@AttributeOptionID,@AttributeOptionString,@AttributeHexValString,@AttributeOptionType,@AttributeOptionOrder)
	end
	
	
	delete @ProdAttributeFinal where ProductID = @ProductID and AttributeName = @AttributeName and AttributeOptionOrder = @AttributeOptionOrder
	
	set @UniqueID = 0
	set @UID = 0
	set @ProductID = 0
	set @MaxUniqueID = 0
	set @AttributeName = ''
	set @AttributeOptionID = 0
	set @AttributeOption= ''
	set @AttributeHexVal = ''
	set @AttributeOptionType = ''
	set @AttributeOptionOrder = 0
	set @AttributeOptionString = ''
	set @AttributeHexValString = ''
end



update p
set p.Attribute1Name = pac.AttributeName,
	p.Attribute1ColorHexVal = pac.AttributeHexValString,
	p.Attribute1Options = pac.AttributeOptionString
from @ProductsTable p
	join @ProdAttributeFinalHolder2 pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 1
			
			
update p
set p.Attribute2Name = pac.AttributeName,
	p.Attribute2ColorHexVal = pac.AttributeHexValString,
	p.Attribute2Options = pac.AttributeOptionString
from @ProductsTable p
	join @ProdAttributeFinalHolder2 pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 2
			
			
update p
set p.Attribute3Name = pac.AttributeName,
	p.Attribute3ColorHexVal = pac.AttributeHexValString,
	p.Attribute3Options = pac.AttributeOptionString
from @ProductsTable p
	join @ProdAttributeFinalHolder2 pac
		on p.ProductID = pac.ProductID
			and pac.AttributeOptionOrder = 3
*/			

--Product Attribute Option End







-- Product Attribute Type Tran Start
insert @ProductAttributeTypeTranHold
	(
		ProductID,
		OracleID,
		ProductAttTranID,
		ProductAttTypeTranID,
		AttributeType,
		AttributeTypeValue
	)
select	p.ProductID,
		ps.OracleID,
		pat.ID,
		patt.ID,
		isnull(pat.Name,''),
		isnull(patt.Name,'')
from @ProductsTable p
	join ProductBatches pb
			on p.ProductID = pb.ProductID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on p.ProductID = pat.ProductID
			and pat.ProductAttributeID = psa.AttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Refill Type'
	join ProductAttributeTypeTranslations patt
		on pat.ProductID = patt.ProductID
			and pat.ProductAttributeID = patt.ProductAttributeID
			and patt.LocaleID = @LocaleID
			and patt.Name = psa.Value
where isnull(pat.Name,'') <> ''
	or isnull(patt.Name,'') <> ''
order by p.ProductID,pat.ID,patt.ID



insert @ProductAttributeTypeTranHold
	(
		ProductID,
		OracleID,
		ProductAttTranID,
		ProductAttTypeTranID,
		AttributeType,
		AttributeTypeValue
	)
select	p.ProductID,
		ps.OracleID,
		pat.ID,
		patt.ID,
		isnull(pat.Name,''),
		isnull(patt.Name,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on p.ProductID = pat.ProductID
			and pat.ProductAttributeID = psa.AttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Point Type'
	join ProductAttributeTypeTranslations patt
		on pat.ProductID = patt.ProductID
			and pat.ProductAttributeID = patt.ProductAttributeID
			and patt.LocaleID = @LocaleID
			and patt.Name = psa.Value
where isnull(pat.Name,'') <> ''
	or isnull(patt.Name,'') <> ''
order by p.ProductID,pat.ID,patt.ID


insert @ProductAttributeTypeTranHold
	(
		ProductID,
		OracleID,
		ProductAttTranID,
		ProductAttTypeTranID,
		AttributeType,
		AttributeTypeValue
	)
select	p.ProductID,
		ps.OracleID,
		pat.ID,
		patt.ID,
		isnull(pat.Name,''),
		isnull(patt.Name,'')
from @ProductsTable p
	join ProductBatches pb
			on p.ProductID = pb.ProductID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on p.ProductID = pat.ProductID
			and pat.ProductAttributeID = psa.AttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Ink Type'
	join ProductAttributeTypeTranslations patt
		on pat.ProductID = patt.ProductID
			and pat.ProductAttributeID = patt.ProductAttributeID
			and patt.LocaleID = @LocaleID
			and patt.Name = psa.Value
where isnull(pat.Name,'') <> ''
	or isnull(patt.Name,'') <> ''
order by p.ProductID,pat.ID,patt.ID





update p
set p.RefillType = patt.AttributeTypeValue
from @ProductsTable p
	join @ProductAttributeTypeTranHold patt
		on p.ProductID = patt.ProductID
			and p.OracleID = patt.OracleID
			and patt.AttributeType = 'Refill Type'
			
			
update p
set p.PointType = patt.AttributeTypeValue
from @ProductsTable p
	join @ProductAttributeTypeTranHold patt
		on p.ProductID = patt.ProductID
			and p.OracleID = patt.OracleID
			and patt.AttributeType = 'Point Type'
			
			
update p
set p.PointSize = patt.AttributeTypeValue
from @ProductsTable p
	join @ProductAttributeTypeTranHold patt
		on p.ProductID = patt.ProductID
			and p.OracleID = patt.OracleID
			and patt.AttributeType = 'Ink Type'


/*
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductAttTranID = 0
set @ProductAttTypeTranID = 0
set @AttributeType = ''
set @AttributeTypeValue = ''
set @AttributeTypeValueString = ''


while exists(select top 1 ProductID from @ProductAttributeTypeTranHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductAttributeTypeTranHold order by UniqueID)
	
	select	@ProductID = ProductID,
			@AttributeType = AttributeType
	from @ProductAttributeTypeTranHold
	where UniqueID = @UniqueID
	
	insert @ProductAttributeTypeTranHold2(UniqueID,ProductID,ProductAttTranID,ProductAttTypeTranID,AttributeType,AttributeTypeValue)
	select	UniqueID,
			ProductID,
			ProductAttTranID,
			ProductAttTypeTranID,
			AttributeType,
			AttributeTypeValue
	from @ProductAttributeTypeTranHold
	where ProductID = @ProductID
		and AttributeType = @AttributeType
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductAttributeTypeTranHold2)
	
	while exists(select top 1 UniqueID from @ProductAttributeTypeTranHold2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductAttributeTypeTranHold2 order by UniqueID)
		select	@ProductAttTranID = ProductAttTranID,
				@ProductAttTypeTranID = ProductAttTypeTranID,
				@AttributeTypeValue = AttributeTypeValue
		from @ProductAttributeTypeTranHold2
		where UniqueID = @UID
		

		if @UID <> @MaxUniqueID
		begin
			select @AttributeTypeValueString = @AttributeTypeValueString + @AttributeTypeValue + ', '
		end
		else
		begin
			select @AttributeTypeValueString = @AttributeTypeValueString + @AttributeTypeValue
		end
		
		
		delete @ProductAttributeTypeTranHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductAttributeTypeTranFinal where ProductID = @ProductID and AttributeType = @AttributeType)
	begin
		update @ProductAttributeTypeTranFinal
		set AttributeTypeValueString = @AttributeTypeValueString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductAttributeTypeTranFinal(ProductID,AttributeType,AttributeTypeValueString)
		values(@ProductID,@AttributeType,@AttributeTypeValueString)
	end
	
	
	delete @ProductAttributeTypeTranHold where ProductID = @ProductID and AttributeType = @AttributeType
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductAttTranID = 0
	set @ProductAttTypeTranID = 0
	set @AttributeType = ''
	set @AttributeTypeValue = ''
	set @AttributeTypeValueString = ''
end


update p
set p.RefillType = patt.AttributeTypeValueString
from @ProductsTable p
	join @ProductAttributeTypeTranFinal patt
		on p.ProductID = patt.ProductID
			and patt.AttributeType = 'Refill Type'
			
			
update p
set p.PointType = patt.AttributeTypeValueString
from @ProductsTable p
	join @ProductAttributeTypeTranFinal patt
		on p.ProductID = patt.ProductID
			and patt.AttributeType = 'Point Type'

*/
			
-- Product Attribute Type Tran End




-- Product Ink Start
insert @ProductAttributeInkHold
	(
		ProductID,
		OracleID,
		ProductAttTranID,
		ProductAttColorTranID,
		ProductAttTranType,
		ProductAttTranColorValue,
		ProductAttColorHexValue
	)
select	p.ProductID,
		ps.OracleID,
		pat.ID,
		pact.ID,
		isnull(pat.Name,''),
		isnull(pact.Start,''),
		isnull(pac.StartHexCode,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductAttributeTranslations pat
		on psa.ProductID = pat.ProductID
			and psa.AttributeID = pat.ProductAttributeID
			and pat.LocaleID = @LocaleID
			and pat.Name = 'Ink'
	join ProductAttributeColors pac
		on pat.ProductID = pac.ProductID
			and pat.ProductAttributeID = pac.ProductAttributeID
	join ProductAttributeColorTranslations pact
		on pac.ProductID = pact.ProductID
			and pac.ProductAttributeID = pact.ProductAttributeID
			and pac.ID = pact.ProductAttributeColorID
			and pact.LocaleID = @LocaleID
			and pact.Start = psa.Value
			and pb.ChannelID = pact.ChannelID
where isnull(pat.Name,'') <> ''
	or isnull(pact.Start,'') <> ''
	or isnull(pac.StartHexCode,'') <> ''
order by p.ProductID,pat.ID,pact.ID


update p
set p.InkColor = pia.ProductAttTranColorValue,
	p.IncColorHexValues = pia.ProductAttColorHexValue
from @ProductsTable p
	join @ProductAttributeInkHold pia
		on p.ProductID = pia.ProductID
			and p.OracleID = pia.OracleID

/*
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductAttTranID = 0
set @ProductAttColorTranID = 0
set @ProductAttTranType = ''
set @ProductAttTranColorValue = ''
set @ProductAttTranColorValueString = ''
set @ProductAttColorHexValueString = ''
set @ProductAttColorHexValue = ''



while exists(select top 1 UniqueID from @ProductAttributeInkHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductAttributeInkHold order by UniqueID)
	
	select	@ProductID = ProductID
	from @ProductAttributeInkHold
	where UniqueID = @UniqueID
	
	insert	@ProductAttributeInkHold2(UniqueID,ProductID,ProductAttTranID,ProductAttColorTranID,ProductAttTranType,ProductAttTranColorValue,ProductAttColorHexValue)
	select	UniqueID,
			ProductID,
			ProductAttTranID,
			ProductAttColorTranID,
			ProductAttTranType,
			ProductAttTranColorValue,
			ProductAttColorHexValue
	from @ProductAttributeInkHold
	where ProductID = @ProductID
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductAttributeInkHold2)
	
	while exists(select top 1 UniqueID from @ProductAttributeInkHold2 order by UniqueID)
	begin
		select	@UID = (select top 1 UniqueID from @ProductAttributeInkHold2 order by UniqueID)
		select	@ProductAttTranID = ProductAttTranID,
				@ProductAttColorTranID = ProductAttColorTranID,
				@ProductAttTranType = ProductAttTranType,
				@ProductAttTranColorValue = ProductAttTranColorValue,
				@ProductAttColorHexValue = ProductAttColorHexValue
		from @ProductAttributeInkHold2
		where UniqueID = @UID
		

		if @UID <> @MaxUniqueID
		begin
			select @ProductAttTranColorValueString = @ProductAttTranColorValueString + @ProductAttTranColorValue + ', '
			select @ProductAttColorHexValueString = @ProductAttColorHexValueString + @ProductAttColorHexValue + ', '
		end
		else
		begin
			select @ProductAttTranColorValueString = @ProductAttTranColorValueString + @ProductAttTranColorValue
			select @ProductAttColorHexValueString = @ProductAttColorHexValueString + @ProductAttColorHexValue
		end
	
		
		delete @ProductAttributeInkHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductAttributeInkFinal where ProductID = @ProductID)
	begin
		update @ProductAttributeInkFinal
		set ProductAttTranColorValueString = @ProductAttTranColorValueString,
			ProductAttColorHexValueString = @ProductAttColorHexValueString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductAttributeInkFinal(ProductID,ProductAttTranType,ProductAttTranColorValueString,ProductAttColorHexValueString)
		values(@ProductID,@ProductAttTranType,@ProductAttTranColorValueString,@ProductAttColorHexValueString)
	end
	
	
	delete @ProductAttributeInkHold where ProductID = @ProductID
	
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductAttTranID = 0
	set @ProductAttColorTranID = 0
	set @ProductAttTranType = ''
	set @ProductAttTranColorValue = ''
	set @ProductAttTranColorValueString = ''
	set @ProductAttColorHexValueString = ''
	set @ProductAttColorHexValue = ''
end


update p
set p.InkColor = pia.ProductAttTranColorValueString,
	p.IncColorHexValues = pia.ProductAttColorHexValueString
from @ProductsTable p
	join @ProductAttributeInkFinal pia
		on p.ProductID = pia.ProductID
*/
	
-- Product Ink End



-- Product Tran Material Start
insert	@ProductTransMaterialHold(ProductID,OracleID,ProductTranID,Material)
select	distinct p.ProductID,
		p.OracleID,
		pt.ID,
		isnull(pt.Material,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductSKUs ps
		on p.ProductID = ps.ProductID
			and ps.OracleID = p.OracleID
	join ProductSkuAttributes psa
		on ps.ProductID = psa.ProductID
			and ps.ID = psa.ProductSkuID
	join ProductTranslations pt
		on p.ProductID = pt.ProductID
			and pt.ChannelID = pb.ChannelID
			and LocaleID = @LocaleID
where isnull(pt.Material,'') <> ''
order by p.ProductID,pt.ID


update p
set p.Material = ptm.Material
from @ProductsTable p
	join @ProductTransMaterialHold ptm
		on p.ProductID = ptm.ProductID
			and p.OracleID = ptm.OracleID

/*
		
set @ProductID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductTranID = 0
set @Material = ''
set @MaterialString = ''


while exists(select top 1 UniqueID from @ProductTransMaterialHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductTransMaterialHold order by UniqueID)
	
	select	@ProductID = ProductID
	from @ProductTransMaterialHold
	where UniqueID = @UniqueID
	
	insert	@ProductTransMaterialHold2(UniqueID,ProductID,ProductTranID,Material)
	select	UniqueID,
			ProductID,
			ProductTranID,
			Material
	from @ProductTransMaterialHold
	where ProductID = @ProductID
	order by UniqueID
	
	select	@MaxUniqueID = (select MAX(UniqueID) from @ProductTransMaterialHold2)
	
	while exists(select top 1 UniqueID from @ProductTransMaterialHold2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductTransMaterialHold2 order by UniqueID)
		
		select	@ProductTranID = ProductTranID,
				@Material = Material
		from @ProductTransMaterialHold2
		where UniqueID = @UID
		

		if @UID <> @MaxUniqueID
		begin
			select @MaterialString = @MaterialString + @Material + ', '
		end
		else
		begin
			select @MaterialString = @MaterialString + @Material
		end

		
		
		delete @ProductTransMaterialHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductTransMaterialFinal where ProductID = @ProductID)
	begin
		update @ProductTransMaterialFinal
		set MaterialString = @MaterialString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductTransMaterialFinal(ProductID,MaterialString)
		values(@ProductID,@MaterialString)
	end
	
	
	delete @ProductTransMaterialHold where ProductID = @ProductID
	
	set @ProductID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductTranID = 0
	set @Material = ''
	set @MaterialString = ''
end


update p
set p.Material = ptm.MaterialString
from @ProductsTable p
	join @ProductTransMaterialFinal ptm
		on p.ProductID = ptm.ProductID
		
*/

-- Product Tran Material End


-- Product Freight Start

update p
set p.FreightQtyPerBox = f.QtyPerBox,
	p.FreightBoxWeight = f.BoxWeight,
	p.Freight_Box_Weight_UOM = f.WeightUOM
from @ProductsTable p
	join
		(
			select	ppd2.ProductID,
					ppd2.QtyPerBox,
					ppd2.BoxWeight,
					ppd2.WeightUOM
			from
				(
					select	ppd.ProductID,
							MIN(ppd.QtyPerBox) as MinQtyPerBox
					from @ProductsTable p
						join ProductPackagingDetails ppd
							on p.ProductID = ppd.ProductID
					where ppd.QtyPerBox is not null
						and ppd.QtyPerBox <> ''
					group by ppd.ProductID
				) a
				join ProductPackagingDetails ppd2
					on a.ProductID = ppd2.ProductID
						and a.MinQtyPerBox = ppd2.QtyPerBox
		) f
	on p.ProductID = f.ProductID
			
-- Product Freight End



-- Product Art Template Start
insert	@ProductArtTemplateHold(ProductID,ProductArtTemplateID,ProductArtName,ProductArtPath)
select	distinct p.ProductID,
		pa.ID,
		isnull(pa.Name,''),
		isnull(pa.[Path],'')
from @ProductsTable p
	join ProductBatches pb
			on p.ProductID = pb.ProductID
	join ProductArtTemplates pa
		on p.ProductID = pa.ProductID
			and pa.ChannelID = pb.ChannelID
where ISNULL(pa.Name,'') <> ''
	or ISNULL(pa.[Path],'') <> ''
order by p.ProductID,pa.ID



	
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductArtTemplateID = 0
set @ProductArtName	= ''
set @ProductArtPath	= ''
set @ProductArtNameString = ''
set @ProductArtPathString = ''


while exists(select top 1 UniqueID from @ProductArtTemplateHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductArtTemplateHold order by UniqueID)
	
	select	@ProductID = ProductID	
	from @ProductArtTemplateHold
	where UniqueID = @UniqueID
	
	insert	@ProductArtTemplateHold2(UniqueID,ProductID,ProductArtTemplateID,ProductArtName,ProductArtPath)
	select	UniqueID,
			ProductID,
			ProductArtTemplateID,
			ProductArtName,
			ProductArtPath
	from @ProductArtTemplateHold
	where ProductID = @ProductID
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductArtTemplateHold2)
	
	while exists(select top 1 UniqueID from @ProductArtTemplateHold2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductArtTemplateHold2 order by UniqueID)
		select	@ProductArtTemplateID = ProductArtTemplateID,
				@ProductArtName = ProductArtName,
				@ProductArtPath = ProductArtPath	
		from @ProductArtTemplateHold2 
		where UniqueID = @UID
		
		if @UID <> @MaxUniqueID
		begin
			select @ProductArtNameString = @ProductArtNameString + @ProductArtName + ', '
			select @ProductArtPathString = @ProductArtPathString + @ProductArtPath + ', '
		end
		else
		begin
			select @ProductArtNameString = @ProductArtNameString + @ProductArtName
			select @ProductArtPathString = @ProductArtPathString + @ProductArtPath
		end
		
		
		delete @ProductArtTemplateHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductArtTemplateFinal where ProductID = @ProductID)
	begin
		update @ProductArtTemplateFinal
		set ProductArtNameString = @ProductArtNameString,
			ProductArtPathString = @ProductArtPathString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductArtTemplateFinal(ProductID,ProductArtNameString,ProductArtPathString)
		values(@ProductID,@ProductArtNameString,@ProductArtPathString)
	end
	
	
	delete @ProductArtTemplateHold where ProductID = @ProductID
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductArtTemplateID = 0
	set @ProductArtName	= ''
	set @ProductArtPath	= ''
	set @ProductArtNameString = ''
	set @ProductArtPathString = ''
end


update p
set p.ArtTemplateName = pat.ProductArtNameString,
	p.ArtTemplatePath = pat.ProductArtPathString
from @ProductsTable p
	join @ProductArtTemplateFinal pat
		on p.ProductID = pat.ProductID
		
-- Product Art Template End




-- Imprint Area Start
update p
set p.ImprintArea1Location = pii.Location,
	p.ImprintArea1Width =	case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricWidth
								else
									pii.Width
							end,
	p.ImprintArea1Height = case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricHeight
								else
									pii.Height
							end,
	p.ImprintArea1UOM = case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricUOM
								else
									pii.UOM
						end,
	p.ImprintArea1Method = pii.Method,
	p.ImprintAreaIncludedCol = pii.IncludedColors,
	p.ImprintArea1ColorMax = pii.ColorMax
from @ProductsTable p
	join
		(
			select	p.ProductID,
					pia.ID as ProductImprintAreaID,
					piat.ID as ProductImprintAreaTransID,
					piat.Location,
					pia.Width,
					pia.MetricWidth,
					pia.Height,
					pia.MetricHeight,
					pia.UOM,
					pia.MetricUOM,
					piat.Method,
					pia.IncludedColors,
					pia.ColorMax,
					pcn.ChannelID
			from @ProductsTable p
				join ProductBatches pb
					on p.ProductID = pb.ProductID
						and pb.BatchID = @BatchID
				join ProductChannels pcn
					on p.ProductID = pcn.ProductID
						and pcn.ChannelID = pb.ChannelID
				join ProductImprintAreas pia
					on p.ProductID = pia.ProductID
				left join ProductImprintAreaTranslations piat
					on pia.ProductID = piat.ProductID
						and pia.ID = piat.ProductImprintAreaID
						and piat.LocaleID = @LocaleID
			where pia.[Type] = 'Standard'
		) pii
	on p.ProductID = pii.ProductID
	
	
update p
set p.ImprintArea2Location = pii.Location,
	p.ImprintArea2Width = case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricWidth
								else
									pii.Width
							end,
	p.ImprintArea2Height = case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricHeight
								else
									pii.Height
							end,
	p.ImprintArea2UOM = case
								when pii.ChannelID in(4,5,6,7)
									then pii.MetricUOM
								else
									pii.UOM
						end,
	p.ImprintArea2Method = pii.Method
from @ProductsTable p
	join
		(
			select	p.ProductID,
					pia.ID as ProductImprintAreaID,
					piat.ID as ProductImprintAreaTransID,
					piat.Location,
					pia.Width,
					pia.MetricWidth,
					pia.Height,
					pia.MetricHeight,
					pia.UOM,
					pia.MetricUOM,
					piat.Method,
					pia.IncludedColors,
					pia.ColorMax,
					pcn.ChannelID
			from @ProductsTable p
				join ProductBatches pb
					on p.ProductID = pb.ProductID
						and pb.BatchID = @BatchID
				join ProductChannels pcn
					on p.ProductID = pcn.ProductID
						and pcn.ChannelID = pb.ChannelID
				join ProductImprintAreas pia
					on p.ProductID = pia.ProductID
				left join ProductImprintAreaTranslations piat
					on pia.ProductID = piat.ProductID
						and pia.ID = piat.ProductImprintAreaID
						and piat.LocaleID = @LocaleID
			where pia.[Type] = 'Optional'
		) pii
	on p.ProductID = pii.ProductID

-- Imprint Area End



-- Imprint Area Color Start
insert @ProductImprintAreaColorHold(ProductID,ProductImprintAreaColorID,ProductImprintAreaColorTranID,ColorHexCode,ColorName)
select	distinct p.ProductID,
		piac.ID as ProductImprintAreaColorID,
		piact.ID as ProductImprintAreaColorTranID,
		isnull(piac.HexCode,''),
		isnull(piact.Name,'')
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductImprintAreas pia
		on p.ProductID = pia.ProductID
			and pia.[Type] = 'Standard'
	left join ProductImprintAreaColors piac
		on p.ProductID = piac.ProductID
			and pia.ID = piac.ProductImprintAreaID
	left join ProductImprintAreaColorTranslations piact
		on piac.ProductID = piact.ProductID
			and piac.ProductImprintAreaID = piact.ProductImprintAreaID
			and piac.ID = piact.ProductImprintAreaColorID
			and piact.LocaleID = @LocaleID
where isnull(piac.HexCode,'') <> ''
	or isnull(piact.Name,'') <> ''
order by p.ProductID,piac.ID,piact.ID


declare @ProductImprintAreaColorID		int,
		@ProductImprintAreaColorTranID	int,
		@ColorHexCode					nvarchar(7),
		@ColorName						nvarchar(255),
		@ColorHexCodeString				nvarchar(1000),
		@ColorNameString				nvarchar(2000)
		
		
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductImprintAreaColorID = 0
set @ProductImprintAreaColorTranID = 0
set @ColorHexCode = ''
set @ColorName = ''
set @ColorHexCodeString = ''
set @ColorNameString = ''
		
		
while exists(select top 1 UniqueID from @ProductImprintAreaColorHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductImprintAreaColorHold order by UniqueID)
	
	select	@ProductID = ProductID
	from @ProductImprintAreaColorHold
	where UniqueID = @UniqueID
	
	insert @ProductImprintAreaColorHold2(UniqueID,ProductID,ProductImprintAreaColorID,ProductImprintAreaColorTranID,ColorHexCode,ColorName)
	select	UniqueID,
			ProductID,
			ProductImprintAreaColorID,
			ProductImprintAreaColorTranID,
			ColorHexCode,
			ColorName	
	from @ProductImprintAreaColorHold
	where ProductID = @ProductID
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductImprintAreaColorHold2)
	
	while exists(select top 1 UniqueID from @ProductImprintAreaColorHold2)
	begin
		select	@UID = (select top 1 UniqueID from @ProductImprintAreaColorHold2 order by UniqueID)
		select	@ProductImprintAreaColorID = ProductImprintAreaColorID,
				@ProductImprintAreaColorTranID = ProductImprintAreaColorTranID,
				@ColorHexCode = ColorHexCode,
				@ColorName = ColorName
		from @ProductImprintAreaColorHold2
		where UniqueID = @UID
		
		if @UID <> @MaxUniqueID
		begin
			select @ColorHexCodeString = @ColorHexCodeString + @ColorHexCode + ', '
			select @ColorNameString = @ColorNameString + @ColorName + ', '
		end
		else
		begin
			select @ColorHexCodeString = @ColorHexCodeString + @ColorHexCode
			select @ColorNameString = @ColorNameString + @ColorName
		end
		
		
		delete @ProductImprintAreaColorHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductImprintAreaColorFinal where ProductID = @ProductID)
	begin
		update @ProductImprintAreaColorFinal
		set ColorHexCodeString = @ColorHexCodeString,
			ColorNameString = @ColorNameString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductImprintAreaColorFinal(ProductID,ColorHexCodeString,ColorNameString)
		values(@ProductID,@ColorHexCodeString,@ColorNameString)
	end
	
	
	delete @ProductImprintAreaColorHold where ProductID = @ProductID
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductImprintAreaColorID = 0
	set @ProductImprintAreaColorTranID = 0
	set @ColorHexCode = ''
	set @ColorName = ''
	set @ColorHexCodeString = ''
	set @ColorNameString = ''
end


update p
set p.ImpinttArea1ColorOption = piac.ColorNameString,
	p.ImprintArea1ColorHexVal = piac.ColorHexCodeString
from @ProductsTable p
	join @ProductImprintAreaColorFinal piac
		on p.ProductID = piac.ProductID
-- Imprint Area Color End



-- Product Translation Keyword Start

update p
set p.SupplierKeyword = pt.Keywords,
	p.WebSearchWords = pt.Keywords,
	p.SubHeaderDescription = pt.SubHeader,
	p.LongDescription = pt.[Description]
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductTranslations pt
		on p.ProductID = pt.ProductID
			and pt.ChannelID = pb.ChannelID
			and pt.LocaleID = @LocaleID
			
-- Product Translation Keyword Start



-- Currency Start
update p
set p.Currency = pf.Currency
from @ProductsTable p
	join ProductFOBs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
			
-- Currency End


-- Price Tier STD Net Price Start
update p
set p.CATSTDNet = pst.STDCatalogNet,
	p.CATSTDPrice = pst.STDCatalogPrice
from @ProductsTable p
	join
		(
			select	pp.ProductID,
					pp.ProductFobID,
					pp.STDCatalogNet,
					pp.STDCatalogPrice
			from ProductFOBPriceTiers pp
				join
					(	
						select	p.ProductID,
								pf.ID as ProductFOBID,
								MIN(popt.QtyStart) MinQtyStart
						from @ProductsTable p
							join ProductBatches pb
								on p.ProductID = pb.ProductID
									and pb.BatchID = @BatchID
							join ProductFOBs pf
								on p.ProductID = pf.ProductID
									and pf.Country = 'US'
							join ProductFOBPriceTiers popt
								on p.ProductID = popt.ProductID
									and pf.ID = popt.ProductFobID
						where popt.QtyStart is not null
						group by	p.ProductID,
									pf.ID,
									pf.Currency
					) zz
				on pp.ProductID = zz.ProductID
					and pp.ProductFobID = zz.ProductFOBID
					and pp.QtyStart = zz.MinQtyStart
		) pst
	on p.ProductID = pst.ProductID

-- Price Tier STD Net Price End



-- Price Tier Quote Start
insert @ProductPriceTierHold(ProductID,ProductFOBID,ProductFOBPriceTierID,QtyStart,NPQuote)
select	distinct p.ProductID,
		pf.ID as ProductFOBID,
		popt.ID as ProductFOBPriceTierID,
		--isnull(convert(nvarchar(20),popt.QtyStart),'') as QtyStart,
		--isnull(convert(nvarchar(20),popt.NPQuote),'') as NPQuote
		popt.QtyStart as QtyStart,
		popt.NPQuote as NPQuote
from @ProductsTable p
	join ProductFOBs pf
		on p.ProductID = pf.ProductID
			--and pf.Country = 'US'
			and pf.[Type] = 'Standard'
	join ProductFOBPriceTiers popt
		on p.ProductID = popt.ProductID
			and pf.ID = popt.ProductFobID
where isnull(convert(nvarchar(20),popt.QtyStart),'') <> ''
	or isnull(convert(nvarchar(20),popt.NPQuote),'') <> ''
order by p.ProductID,pf.ID,popt.ID






update m
set m.SequenceID = t.SequenceID
from @ProductPriceTierHold m
	join
		(
			select	ProductID,
					ProductFOBID,
					QtyStart,
					ROW_NUMBER() OVER(PARTITION BY ProductID,ProductFOBID ORDER BY convert(int,QtyStart) ASC) as SequenceID
			from @ProductPriceTierHold
		) t
	on m.ProductID = t.ProductID
		and m.ProductFOBID = t.ProductFOBID
		and m.QtyStart = t.QtyStart





update m
set m.NPC_Quote_Quantity_1 = t1.QtyStart,
	m.NPC_Quote_Net_Item_Cost_1 = t1.NPQuote,
	m.NPC_Quote_Quantity_2 = t2.QtyStart,
	m.NPC_Quote_Net_Item_Cost_2 = t2.NPQuote,
	m.NPC_Quote_Quantity_3 = t3.QtyStart,
	m.NPC_Quote_Net_Item_Cost_3 = t3.NPQuote,
	m.NPC_Quote_Quantity_4 = t4.QtyStart,
	m.NPC_Quote_Net_Item_Cost_4 = t4.NPQuote,
	m.NPC_Quote_Quantity_5 = t5.QtyStart,
	m.NPC_Quote_Net_Item_Cost_5 = t5.NPQuote,
	m.NPC_Quote_Quantity_6 = t6.QtyStart,
	m.NPC_Quote_Net_Item_Cost_6 = t6.NPQuote,
	m.NPC_Quote_Quantity_7 = t7.QtyStart,
	m.NPC_Quote_Net_Item_Cost_7 = t7.NPQuote
from @ProductPriceTierHold m
	left join @ProductPriceTierHold t1
		on m.ProductID = t1.ProductID
			and t1.SequenceID = 1
	left join @ProductPriceTierHold t2
		on m.ProductID = t2.ProductID
			and t2.SequenceID = 2
	left join @ProductPriceTierHold t3
		on m.ProductID = t3.ProductID
			and t3.SequenceID = 3
	left join @ProductPriceTierHold t4
		on m.ProductID = t4.ProductID
			and t4.SequenceID = 4
	left join @ProductPriceTierHold t5
		on m.ProductID = t5.ProductID
			and t5.SequenceID = 5
	left join @ProductPriceTierHold t6
		on m.ProductID = t6.ProductID
			and t6.SequenceID = 6
	left join @ProductPriceTierHold t7
		on m.ProductID = t7.ProductID
			and t7.SequenceID = 7

		
	
		
set @UniqueID = 0
set @UID = 0
set @MaxUniqueID = 0
set @ProductID = 0
set @ProductFOBID = 0
set @ProductFOBPriceTierID = 0
set @QtyStart = ''
set @NPQuote = ''
set @QtyStartSting = ''
set @NPQuoteString = ''


while exists(select top 1 UniqueID from @ProductPriceTierHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProductPriceTierHold order by UniqueID)
	
	select	@ProductID = ProductID,
			@NPC_Quote_Quantity_1 = NPC_Quote_Quantity_1,
			@NPC_Quote_Net_Item_Cost_1 = NPC_Quote_Net_Item_Cost_1,
			@NPC_Quote_Quantity_2 = NPC_Quote_Quantity_2,
			@NPC_Quote_Net_Item_Cost_2 = NPC_Quote_Net_Item_Cost_2,
			@NPC_Quote_Quantity_3 = NPC_Quote_Quantity_3,
			@NPC_Quote_Net_Item_Cost_3 = NPC_Quote_Net_Item_Cost_3,
			@NPC_Quote_Quantity_4 = NPC_Quote_Quantity_4,
			@NPC_Quote_Net_Item_Cost_4 = NPC_Quote_Net_Item_Cost_4,
			@NPC_Quote_Quantity_5 = NPC_Quote_Quantity_5,
			@NPC_Quote_Net_Item_Cost_5 = NPC_Quote_Net_Item_Cost_5,
			@NPC_Quote_Quantity_6 = NPC_Quote_Quantity_6,
			@NPC_Quote_Net_Item_Cost_6 = NPC_Quote_Net_Item_Cost_6,
			@NPC_Quote_Quantity_7 = NPC_Quote_Quantity_7,
			@NPC_Quote_Net_Item_Cost_7 = NPC_Quote_Net_Item_Cost_7
	from @ProductPriceTierHold
	where UniqueID = @UniqueID
	
	
	insert	@ProductPriceTierHold2(UniqueID,ProductID,ProductFOBID,ProductFOBPriceTierID,QtyStart,NPQuote)
	select	UniqueID,
			ProductID,
			ProductFOBID,
			ProductFOBPriceTierID,
			QtyStart,
			NPQuote
	from @ProductPriceTierHold
	where ProductID = @ProductID
	order by UniqueID
	
	select @MaxUniqueID = (select MAX(UniqueID) from @ProductPriceTierHold2)
	
	while exists(select top 1 UniqueID from @ProductPriceTierHold2)
	begin
		select	@UID = (select top 1 UniqueId from @ProductPriceTierHold2 order by UniqueID)
		
		select	@ProductFOBID = ProductFOBID,
				@ProductFOBPriceTierID = ProductFOBPriceTierID,
				@QtyStart = QtyStart,
				@NPQuote = NPQuote
		from @ProductPriceTierHold2
		where UniqueID = @UID
		
		if @UID <> @MaxUniqueID
		begin
			select @QtyStartSting = @QtyStartSting + @QtyStart + ', '
			select @NPQuoteString = @NPQuoteString + @NPQuote + ', '
		end
		else
		begin
			select @QtyStartSting = @QtyStartSting + @QtyStart
			select @NPQuoteString = @NPQuoteString + @NPQuote
		end
		
		
		delete @ProductPriceTierHold2 where UniqueID = @UID
	end
	
	
	if exists(select top 1 ProductID from @ProductPriceTierFinal where ProductID = @ProductID)
	begin
		update @ProductPriceTierFinal
		set QtyStartString = @QtyStartSting,
			NPQuoteString = @NPQuoteString
		where ProductID = @ProductID
	end
	else
	begin
		insert @ProductPriceTierFinal(ProductID,QtyStartString,NPQuoteString)
		values(@ProductID,@QtyStartSting,@NPQuoteString)
	end
	
	
	update @ProductPriceTierFinal
	set	NPC_Quote_Quantity_1 = @NPC_Quote_Quantity_1,
		NPC_Quote_Net_Item_Cost_1 = @NPC_Quote_Net_Item_Cost_1,
		NPC_Quote_Quantity_2 = @NPC_Quote_Quantity_2,
		NPC_Quote_Net_Item_Cost_2 = @NPC_Quote_Net_Item_Cost_2,
		NPC_Quote_Quantity_3 = @NPC_Quote_Quantity_3,
		NPC_Quote_Net_Item_Cost_3 = @NPC_Quote_Net_Item_Cost_3,
		NPC_Quote_Quantity_4 = @NPC_Quote_Quantity_4,
		NPC_Quote_Net_Item_Cost_4 = @NPC_Quote_Net_Item_Cost_4,
		NPC_Quote_Quantity_5 = @NPC_Quote_Quantity_5,
		NPC_Quote_Net_Item_Cost_5 = @NPC_Quote_Net_Item_Cost_5,
		NPC_Quote_Quantity_6 = @NPC_Quote_Quantity_6,
		NPC_Quote_Net_Item_Cost_6 = @NPC_Quote_Net_Item_Cost_6,
		NPC_Quote_Quantity_7 = @NPC_Quote_Quantity_7,
		NPC_Quote_Net_Item_Cost_7 = @NPC_Quote_Net_Item_Cost_7
	where ProductID = @ProductID
	
	
	delete @ProductPriceTierHold where ProductID = @ProductID
	
	set @UniqueID = 0
	set @UID = 0
	set @MaxUniqueID = 0
	set @ProductID = 0
	set @ProductFOBID = 0
	set @ProductFOBPriceTierID = 0
	set @QtyStart = ''
	set @NPQuote = ''
	set @QtyStartSting = ''
	set @NPQuoteString = ''
end


update p
set p.QuoteQtyTiered = ppt.QtyStartString,
	p.QuoteCostTiered = ppt.NPQuoteString,
	p.NPC_Quote_Quantity_1 = ppt.NPC_Quote_Quantity_1,
	p.NPC_Quote_Net_Item_Cost_1 = ppt.NPC_Quote_Net_Item_Cost_1,
	p.NPC_Quote_Quantity_2 = ppt.NPC_Quote_Quantity_2,
	p.NPC_Quote_Net_Item_Cost_2 = ppt.NPC_Quote_Net_Item_Cost_2,
	p.NPC_Quote_Quantity_3 = ppt.NPC_Quote_Quantity_3,
	p.NPC_Quote_Net_Item_Cost_3 = ppt.NPC_Quote_Net_Item_Cost_3,
	p.NPC_Quote_Quantity_4 = ppt.NPC_Quote_Quantity_4,
	p.NPC_Quote_Net_Item_Cost_4 = ppt.NPC_Quote_Net_Item_Cost_4,
	p.NPC_Quote_Quantity_5 = ppt.NPC_Quote_Quantity_5,
	p.NPC_Quote_Net_Item_Cost_5 = ppt.NPC_Quote_Net_Item_Cost_5,
	p.NPC_Quote_Quantity_6 = ppt.NPC_Quote_Quantity_6,
	p.NPC_Quote_Net_Item_Cost_6 = ppt.NPC_Quote_Net_Item_Cost_6,
	p.NPC_Quote_Quantity_7 = ppt.NPC_Quote_Quantity_7,
	p.NPC_Quote_Net_Item_Cost_7 = ppt.NPC_Quote_Net_Item_Cost_7
from @ProductsTable p
	join @ProductPriceTierFinal ppt
		on p.ProductID = ppt.ProductID


update p
set Standard_Catalog_MOQ = pfpt.QtyStart,
	Net_Item_Cost_at_Catalog_MOQ = pfpt.STDCatalogNet
from @ProductsTable p
	join ProductFobs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Catalog'
	join ProductFOBPriceTiers pfpt
		on pf.ProductID = pfpt.ProductID
			and pf.ID = pfpt.ProductFobID

update p
set p.Hazardous_Shipping_Charge_NET = pfac.NPQuote
from @ProductsTable p
	join ProductFobs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
	join ProductFOBAdditionalCharges pfac
		on pf.ProductID = pfac.ProductID
			and pf.ID = pfac.ProductFobID
			and pfac.Name = 'Hazardous Shipping Charge'
			
			
declare @ProductRushTAT	Table	(	
									UniqueID			int identity(1,1) Primary Key,
									ProductID			int,
									RushTAT				varchar(50),
									RushCharge			varchar(50)
								)
								
								
declare @ProductRushTATHold	Table	(	
										UniqueID			int Primary Key,
										ProductID			int,
										RushTAT				varchar(50),
										RushCharge			varchar(50)
									)
								
declare @ProductRushTAT2	Table	(	
										UniqueID			int identity(1,1) Primary Key,
										ProductID			int,
										RushTATString		varchar(250),
										RushChargeString	varchar(50)
									)
									
declare @RUniqueID		int,
		@RProductID		int,
		@RushTAT		varchar(50),
		@RushCharge		varchar(50),
		@RushTATString	varchar(250),
		@RushChargeString	varchar(50),
		@PUniqueID		int,
		@MinPUniqueID	int
		
insert @ProductRushTAT	
	(	
		ProductID,
		RushTAT,
		RushCharge
	)
select	distinct 
		p.ProductID,
		'24' as RushTAT,
		CONVERT(varchar(50),pfac.NPQuote)
from @ProductsTable p
	join ProductFobs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
	join ProductFOBAdditionalCharges pfac
		on pf.ProductID = pfac.ProductID
			and pf.ID = pfac.ProductFobID
			and pfac.Name = 'Rush Charge - 24 Hours'
			--and pfac.OracleChargeSkuID = 39


insert @ProductRushTAT	
	(	
		ProductID,
		RushTAT,
		RushCharge
	)
select	distinct
		p.ProductID,
		'48' as RushTAT,
		CONVERT(varchar(50),pfac.NPQuote)
from @ProductsTable p
	join ProductFobs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
	join ProductFOBAdditionalCharges pfac
		on pf.ProductID = pfac.ProductID
			and pf.ID = pfac.ProductFobID
			and pfac.Name = 'Rush Charge - 48 Hours'
			--and pfac.OracleChargeSkuID = 39
			

insert @ProductRushTAT	
	(	
		ProductID,
		RushTAT,
		RushCharge
	)
select	distinct
		p.ProductID,
		'72' as RushTAT,
		CONVERT(varchar(50),pfac.NPQuote)
from @ProductsTable p
	join ProductFobs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
	join ProductFOBAdditionalCharges pfac
		on pf.ProductID = pfac.ProductID
			and pf.ID = pfac.ProductFobID
			and pfac.Name = 'Rush Charge - 72 Hours'
			--and pfac.OracleChargeSkuID = 39



set @RushTAT = ''
set @RushCharge = ''
set @RushTATString = ''
set @RushChargeString = ''


while exists(select top 1 UniqueID from @ProductRushTAT)
begin
	select	@RUniqueID = (select top 1 UniqueID from @ProductRushTAT order by UniqueID)
	select	@RProductID = ProductID
	from @ProductRushTAT 
	where UniqueID = @RUniqueID
	

	insert @ProductRushTATHold
		(	
			UniqueID,
			ProductID,
			RushTAT,
			RushCharge
		)
	select  UniqueID,
			ProductID,
			RushTAT,
			RushCharge
	from @ProductRushTAT
	where ProductID = @RProductID
	order by UniqueID


	select @MinPUniqueID = MIN(UniqueID) from @ProductRushTATHold


	while exists(select top 1 UniqueID from @ProductRushTATHold)
	begin
		select	@PUniqueID = (select top 1 UniqueID from @ProductRushTATHold order by UniqueID)
		select	@RushTAT = RushTAT,
				@RushCharge = RushCharge
		from @ProductRushTATHold
		where UniqueID = @PUniqueID
		
		
		if @PUniqueID = @MinPUniqueID
		begin
			if ISNULL(@RushTAT,'') <> ''
			begin
				select @RushTATString = @RushTAT
			end
			
			if ISNULL(@RushCharge,'') <> ''
			begin
				select @RushChargeString = @RushCharge
			end
		end
		else
		begin
			if ISNULL(@RushTAT,'') <> ''
			begin
				select @RushTATString = @RushTATString + ', ' + @RushTAT
			end
			
			if ISNULL(@RushCharge,'') <> ''
			begin
				select @RushChargeString = @RushChargeString + ', ' + @RushCharge
			end
		end
			
		
		delete @ProductRushTATHold where UniqueID = @PUniqueID
	end
	
	
	insert @ProductRushTAT2
		(	
			ProductID,
			RushTATString,
			RushChargeString
		)
	values(@RProductID,@RushTATString,@RushChargeString)
	
	
	delete @ProductRushTAT where ProductID = @RProductID
	
	
	set @RushTAT = ''
	set @RushCharge = ''
	set @RushTATString = ''
	set @RushChargeString = ''
	set @RProductID = 0
	set @PUniqueID = 0
end


update m
set m.Rush_TAT = t.RushTATString,
	m.Rush_Charge = t.RushChargeString
from @ProductsTable m
	join @ProductRushTAT2 t
		on m.ProductID = t.ProductID
-- Price Tier Quote End



-- Additional Charges Start
insert @ProductAdditionChargeFinal(ProductID,Name,STDCatalogNet,STDCatalogPrice,NPQuote)
select	pfac.ProductID,
		pfac.Name,
		pfac.STDCatalogNet,
		pfac.STDCatalogPrice,
		pfac.NPQuote
from @ProductsTable p
	join ProductBatches pb
		on p.ProductID = pb.ProductID
			and pb.BatchID = @BatchID
	join ProductFOBs pf
		on p.ProductID = pf.ProductID
			and pf.[Type] = 'Standard'
	join ProductFOBAdditionalCharges pfac
		on p.ProductID = pfac.ProductID
			and pf.ID = pfac.ProductFobID
where pfac.Name in
	(
		'Setup Charge',
		'Repeat Setup Charge',
		'Addl Color Run Charge: NPC Quote - NET',
		'Addl Location Run Charge: NPC Quote - NET',
		'Pre Production Proof Charge',
		'Poly Bag Charge'
	)
order by p.ProductID,pf.ID


update p
set p.NewOrderSetupNPQuote = pac.NPQuote,
	p.NewOrderSetupCATNet = pac.STDCatalogNet,
	p.NewOrderSetupCATPrice = pac.STDCatalogPrice
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Setup Charge'
			
update p
set p.ReOrderSetupNPQuote = pac.NPQuote
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Repeat Setup Charge'
			
update p
set p.AddlColorRunCharge = pac.NPQuote
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Addl Color Run Charge: NPC Quote - NET'
			
update p
set p.AddlLocationRunCharge = pac.NPQuote
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Addl Location Run Charge: NPC Quote - NET'
			
update p
set p.PreProdProofCharge = pac.NPQuote
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Pre Production Proof Charge'
			
update p
set p.PolyBagCharge = pac.NPQuote
from @ProductsTable p
	join @ProductAdditionChargeFinal pac
		on p.ProductID = pac.ProductID
			and pac.Name = 'Poly Bag Charge'

-- Additional Charges End


-- Category Codes Start

update p
set OracleCatalog1Trans = cc.[Description]
from @ProductsTable p
	join CategoryCodes cc
		on p.OracleCatalog1 = cc.ID
		
update p
set OracleCatalog2Trans = cc.[Description]
from @ProductsTable p
	join CategoryCodes cc
		on p.OracleCatalog2 = cc.ID
		
update p
set OracleCatalog3Trans = cc.[Description]
from @ProductsTable p
	join CategoryCodes cc
		on p.OracleCatalog3 = cc.ID
		
update p
set OracleCatalog4Trans = cc.[Description]
from @ProductsTable p
	join CategoryCodes cc
		on p.OracleCatalog4 = cc.ID

-- Category Codes End




-- Final Main Table Insert
insert PIM_ETL_STAGE.dbo.Stage_MasterDataSheet
	(
	   [ProductID]
      ,[BatchID]
      ,[NPGeneralComments]
      ,[ProductImage]
      ,[URL]
      ,[Name]
      ,[ASINumber]
      ,[SupplierProductID]
      ,[VendorProductID]
      ,[OracleID]
      ,[OracleDesc]
      ,[WebCode]
      ,[NPProductName]
      ,[BrandedName]
      ,[BrandLogoImageName]
      ,[BrandLogoImagePath]
      ,[AvailableCountries]
      ,[SellToCountries]
      ,[OracleCatalog1]
      ,[OracleCatalog2]
      ,[OracleCatalog3]
      ,[OracleCatalog4]
      ,[OracleCategoryCode]
      ,[ImageName]
      ,[ImagePath]
      ,[VideoLinkURL]
      ,[Capacity]
      ,[CapacityUOM]
      ,[SizeAvailable]
      ,[AttributeComboKey]
      ,[AttributeComboValue]
      ,[Attribute1Name]
      ,[Attribute1Options]
      ,[Attribute1ColorHexVal]
      ,[Attribute2Name]
      ,[Attribute2Options]
      ,[Attribute2ColorHexCal]
      ,[Attribute3Name]
      ,[Attribute3Options]
      ,[Attribute3ColorHexCal]
      ,[RefillType]
      ,[PointType]
      ,[PointSize]
      ,[InkColor]
      ,[IncColorHexValues]
      ,[Material]
      ,[COO]
      ,[MadeInUSA]
      ,[FreightQtyPerBox]
      ,[FreightBoxWeight]
      ,[Weight]
      ,[WeightUOM]
      ,[Width]
      ,[Height]
      ,[Depth]
      ,[SizeUOM]
      ,[DimensionsComment]
      ,[TATmin]
      ,[TATmax]
      ,[ArtTemplateName]
      ,[ArtTemplatePath]
      ,[ImprintArea1Location]
      ,[ImprintArea1Width]
      ,[ImprintArea1Height]
      ,[ImprintArea1UOM]
      ,[ImprintArea1Method]
      ,[ImprintAreaIncludedCol]
      ,[ImprintArea1ColorMax]
      ,[ImpinttArea1ColorOption]
      ,[ImprintArea1ColorHexVal]
      ,[ImprintArea2Location]
      ,[ImprintArea2Width]
      ,[ImprintArea2Height]
      ,[ImprintArea2UOM]
      ,[ImprintArea2Method]
      ,[SupplierKeyword]
      ,[WebSearchWords]
      ,[SubHeaderDescription]
      ,[LongDescription]
      ,[MOQNPC]
      ,[NOQCATSTD]
      ,[Currency]
      ,[NPCQuote]
      ,[CATSTDNet]
      ,[CATSTDPrice]
      ,[QuoteQtyTiered]
      ,[QuoteCostTiered]
      ,[NewOrderSetupNPQuote]
      ,[NewOrderSetupCATNet]
      ,[NewOrderSetupCATPrice]
      ,[ReOrderSetupNPQuote]
      ,[AddlColorRunCharge]
      ,[AddlLocationRunCharge]
      ,[PreProdProofCharge]
      ,[PolyBagCharge]
      ,[OracleCatalog1Trans]
      ,[OracleCatalog2Trans]
      ,[OracleCatalog3Trans]
      ,[OracleCatalog4Trans]
      ,[NPProductCode]
      ,[Sku_Format]
      ,[Supplier_Product_Sku]
      ,[Supplier_Product_Sku_Description]
      ,[Category_Product_Family]
      ,[Subcategory]
      ,[Oracle_Catalog_Level_1]
	  ,[Oracle_Catalog_Level_2]
	  ,[Freight_Box_Weight_UOM]
	  ,[Standard_Catalog_MOQ]
      ,[Net_Item_Cost_at_Catalog_MOQ]
      ,[NPC_Quote_Quantity_1]
      ,[NPC_Quote_Net_Item_Cost_1]
      ,[NPC_Quote_Quantity_2]
      ,[NPC_Quote_Net_Item_Cost_2]
      ,[NPC_Quote_Quantity_3]
      ,[NPC_Quote_Net_Item_Cost_3]
      ,[NPC_Quote_Quantity_4]
      ,[NPC_Quote_Net_Item_Cost_4]
      ,[NPC_Quote_Quantity_5]
      ,[NPC_Quote_Net_Item_Cost_5]
      ,[NPC_Quote_Quantity_6]
      ,[NPC_Quote_Net_Item_Cost_6]
      ,[NPC_Quote_Quantity_7]
      ,[NPC_Quote_Net_Item_Cost_7]
      ,[HTS_Code]
      ,[Features_BPA_Free]
      ,[Features_Eco_Friendly]
      ,[Features_FDA_Compliant]
      ,[Features_Lead_Free]
      ,[Features_Prop_65_Label_Required]
      ,[Features_Recyclable]
      ,[Features_Hazardous_Shipping]
      ,[Hazardous_Shipping_Charge_NET]
	  ,[Rush_Production_Available]
	  ,[Rush_TAT]
	  ,[Rush_Charge]
	  ,[MCP_Product_Ref_ID]
	  ,[MCP_SKU_ID]
	)
select	[ProductID]
      ,[BatchID]
      ,[NPGeneralComments]
      ,[ProductImage]
      ,[URL]
      ,[Name]
      ,[ASINumber]
      ,[SupplierProductID]
      ,[VendorProductID]
      ,[OracleID]
      ,[OracleDesc]
      ,[WebCode]
      ,[NPProductName]
      ,[BrandedName]
      ,[BrandLogoImageName]
      ,[BrandLogoImagePath]
      ,[AvailableCountries]
      ,[SellToCountries]
      ,[OracleCatalog1]
      ,[OracleCatalog2]
      ,[OracleCatalog3]
      ,[OracleCatalog4]
      ,[OracleCategoryCode]
      ,[ImageName]
      ,[ImagePath]
      ,[VideoLinkURL]
      ,[Capacity]
      ,[CapacityUOM]
      ,[SizeAvailable]
      ,[AttributeComboKey]
      ,[AttributeComboValue]
      ,[Attribute1Name]
      ,[Attribute1Options]
      ,[Attribute1ColorHexVal]
      ,[Attribute2Name]
      ,[Attribute2Options]
      ,[Attribute2ColorHexVal]
      ,[Attribute3Name]
      ,[Attribute3Options]
      ,[Attribute3ColorHexVal]
      ,[RefillType]
      ,[PointType]
      ,[PointSize]
      ,[InkColor]
      ,[IncColorHexValues]
      ,[Material]
      ,[COO]
      ,[MadeInUSA]
      ,[FreightQtyPerBox]
      ,[FreightBoxWeight]
      ,[Weight]
      ,[WeightUOM]
      ,[Width]
      ,[Height]
      ,[Depth]
      ,[SizeUOM]
      ,[DimensionsComment]
      ,[TATmin]
      ,[TATmax]
      ,[ArtTemplateName]
      ,[ArtTemplatePath]
      ,[ImprintArea1Location]
      ,[ImprintArea1Width]
      ,[ImprintArea1Height]
      ,[ImprintArea1UOM]
      ,[ImprintArea1Method]
      ,[ImprintAreaIncludedCol]
      ,[ImprintArea1ColorMax]
      ,[ImpinttArea1ColorOption]
      ,[ImprintArea1ColorHexVal]
      ,[ImprintArea2Location]
      ,[ImprintArea2Width]
      ,[ImprintArea2Height]
      ,[ImprintArea2UOM]
      ,[ImprintArea2Method]
      ,[SupplierKeyword]
      ,[WebSearchWords]
      ,[SubHeaderDescription]
      ,[LongDescription]
      ,[MOQNPC]
      ,[NOQCATSTD]
      ,[Currency]
      ,[NPCQuote]
      ,[CATSTDNet]
      ,[CATSTDPrice]
      ,[QuoteQtyTiered]
      ,[QuoteCostTiered]
      ,[NewOrderSetupNPQuote]
      ,[NewOrderSetupCATNet]
      ,[NewOrderSetupCATPrice]
      ,[ReOrderSetupNPQuote]
      ,[AddlColorRunCharge]
      ,[AddlLocationRunCharge]
      ,[PreProdProofCharge]
      ,[PolyBagCharge]
      ,[OracleCatalog1Trans]
      ,[OracleCatalog2Trans]
      ,[OracleCatalog3Trans]
      ,[OracleCatalog4Trans]
      ,[NPProductCode]
      ,[SKU_Format]
      ,[Supplier_Product_Sku]
      ,[Supplier_Product_Sku_Description]
      ,[Category_Product_Family]
      ,[Subcategory]
      ,[Oracle_Catalog_Level_1]
	  ,[Oracle_Catalog_Level_2]
	  ,[Freight_Box_Weight_UOM]
	  ,[Standard_Catalog_MOQ]
      ,[Net_Item_Cost_at_Catalog_MOQ]
      ,[NPC_Quote_Quantity_1]
      ,[NPC_Quote_Net_Item_Cost_1]
      ,[NPC_Quote_Quantity_2]
      ,[NPC_Quote_Net_Item_Cost_2]
      ,[NPC_Quote_Quantity_3]
      ,[NPC_Quote_Net_Item_Cost_3]
      ,[NPC_Quote_Quantity_4]
      ,[NPC_Quote_Net_Item_Cost_4]
      ,[NPC_Quote_Quantity_5]
      ,[NPC_Quote_Net_Item_Cost_5]
      ,[NPC_Quote_Quantity_6]
      ,[NPC_Quote_Net_Item_Cost_6]
      ,[NPC_Quote_Quantity_7]
      ,[NPC_Quote_Net_Item_Cost_7]
      ,[HTS_Code]
      ,[Features_BPA_Free]
      ,[Features_Eco_Friendly]
      ,[Features_FDA_Compliant]
      ,[Features_Lead_Free]
      ,[Features_Prop_65_Label_Required]
      ,[Features_Recyclable]
      ,[Features_Hazardous_Shipping]
      ,[Hazardous_Shipping_Charge_NET]
	  ,[Rush_Production_Available]
	  ,[Rush_TAT]
	  ,[Rush_Charge]
	  ,[MCP_Product_Ref_ID]
	  ,[MCP_SKU_ID]
from @ProductsTable
order by ProductID





















GO
