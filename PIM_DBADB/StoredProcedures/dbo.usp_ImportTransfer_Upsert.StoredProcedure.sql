Create Procedure [dbo].[usp_ImportTransfer_Upsert]

as

set nocount on


-- Products Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_Products)
begin
	update m
	set	   m.[COO] = c.[COO]
		  ,m.[MOQquoted] = c.[MOQquoted]
		  ,m.[MOQcatalogSTD] = c.[MOQcatalogSTD]
		  ,m.[UOM] = c.[UOM]
		  ,m.[UOMcount] = c.[UOMcount]
		  ,m.[LOTsize] = c.[LOTsize]
		  ,m.[GeneralComment] = c.[GeneralComment]
		  ,m.[NPProductCode] = c.[NPProductCode]
		  ,m.[ItemType] = c.[ItemType]
		  ,m.[NPGeneralComments] = c.[NPGeneralComments]
		  ,m.[RootProductCode] = c.[RootProductCode]
		  ,m.[RootProductName] = c.[RootProductName]
		  ,m.[Originator] = c.[Originator]
		  ,m.[Department] = c.[Department]
		  ,m.[CreationDate] = c.[CreationDate]
		  ,m.[LastUpdateDate] = c.[LastUpdateDate]
		  ,m.[UpdatedBy] = c.[UpdatedBy]
		  ,m.[OracleCatalog1] = c.[OracleCatalog1]
		  ,m.[OracleCatalog2] = c.[OracleCatalog2]
		  ,m.[OracleCatalog3] = c.[OracleCatalog3]
		  ,m.[OracleCatalog4] = c.[OracleCatalog4]
		  ,m.[OracleCategoryCode] = c.[OracleCategoryCode]
		  ,m.[URL] = c.[URL]
		  ,m.[Height] = c.[Height]
		  ,m.[Width] = c.[Width]
		  ,m.[Depth] = c.[Depth]
		  ,m.[Diameter] = c.[Diameter]
		  ,m.[SizeUOM] = c.[SizeUOM]
		  ,m.[Weight] = c.[Weight]
		  ,m.[WeightUOM] = c.[WeightUOM]
		  ,m.[DimensionsComment] = c.[DimensionsComment]
		  ,m.[ItemUserTypeID] = c.[ItemUserTypeID]
		  ,m.[Class] = c.[Class]
		  ,m.[GroupingCode] = c.[GroupingCode]
		  ,m.[TarriffCode] = c.[TarriffCode]
		  ,m.[PatentNumbers] = c.[PatentNumbers]
		  ,m.[SellToCountries] = c.[SellToCountries]
		  ,m.[AvailableCountries] = c.[AvailableCountries]
		  ,m.[BrandedName] = c.[BrandedName]
		  ,m.[VideoLinkURL] = c.[VideoLinkURL]
		  ,m.[DataSource] = c.[DataSource]
		  ,m.[CostOfGoodsAccount] = c.[CostOfGoodsAccount]
		  ,m.[SalesAccount] = c.[SalesAccount]
		  ,m.[LoadGroupID] = c.[LoadGroupID]
		  ,m.[AttributeComment] = c.[AttributeComment]
		  ,m.[ItemSchematic] = c.[ItemSchematic]
		  ,m.[OracleCatalog5] = c.[OracleCatalog5]
		  ,m.[OracleCatalog6] = c.[OracleCatalog6]
		  ,m.[VerticalTemplate] = c.[VerticalTemplate]
		  ,m.[ShipCategory] = c.[ShipCategory]
		  ,m.[ImportNotes] = c.[ImportNotes]
		  ,m.[SupplierProductID] = c.[SupplierProductID]
		  ,m.[LoadDate] = c.[LoadDate]
		  ,m.[IsNew] = c.[IsNew]
		  ,m.[SageProductID] = c.[SageProductID]
		  ,m.[SageProductCode] = c.[SageProductCode]
		  ,m.[ProductXML] = c.[ProductXML]
		  ,m.[ProductXMLCrc] = c.[ProductXMLCrc]
		  ,m.[Features] = c.[Features]
		  ,m.[UpdateDataSource] = c.[UpdateDataSource]
		  ,m.[AttributeComboKey] = c.[AttributeComboKey]
		  ,m.[AttributeComboValue] = c.[AttributeComboValue]
		  ,m.[COOLocation] = c.[COOLocation]
		  ,m.[TechSpec] = c.[TechSpec]
		  ,m.[ImprintAreaNotes] = c.[ImprintAreaNotes]
		  ,m.[PatentInfo] = c.[PatentInfo]
		  ,m.[MaterialClassID] = c.[MaterialClassID]
		  ,m.[WebCatLevel1] = c.[WebCatLevel1]
		  ,m.[WebCatLevel2] = c.[WebCatLevel2]
		  ,m.[WebCatLevel3] = c.[WebCatLevel3]
		  ,m.[WebCatLevel4] = c.[WebCatLevel4]
		  ,m.[WebCatLevel5] = c.[WebCatLevel5]
		  ,m.[MetricHeight] = c.[MetricHeight]
		  ,m.[MetricWidth] = c.[MetricWidth]
		  ,m.[MetricDepth] = c.[MetricDepth]
		  ,m.[MetricDiameter] = c.[MetricDiameter]
		  ,m.[MetricSizeUOM] = c.[MetricSizeUOM]
		  ,m.[MetricWeight] = c.[MetricWeight]
		  ,m.[MetricWeightUOM] = c.[MetricWeightUOM]
		  ,m.[LicensorID] = c.[LicensorID]
		  ,m.[MCPFamilyRefID] = c.[MCPFamilyRefID]
		  ,m.[MCPFamilyNodeID] = c.[MCPFamilyNodeID]
		  ,m.[PreOrderMonth] = c.[PreOrderMonth]
		  ,m.[Section321Qualified] = c.[Section321Qualified]
		  ,m.[StockUpdateDate] = c.[StockUpdateDate]
		  ,m.[MCPType] = c.[MCPType]
		  ,m.[MCPFamilyLocationID] = c.[MCPFamilyLocationID]
		  ,m.[TSCAep4Cert] = c.[TSCAep4Cert]
		  ,m.[MCPTypeName] = c.[MCPTypeName]
		  ,m.[MCPAccessoryListID] = c.[MCPAccessoryListID]
		  ,m.[AllowFlexiblePricing] = c.[AllowFlexiblePricing]
		  ,m.[FixedOrderModifier] = c.[FixedOrderModifier]
		  ,m.[CreatedDate] = c.[CreatedDate]
		  ,m.[CreatedBy] = c.[CreatedBy]
		  ,m.[ModifiedDate] = c.[ModifiedDate]
		  ,m.[ModifiedBy] = c.[ModifiedBy]
		  ,m.[EUTarriffCode] = c.[EUTarriffCode]
		  ,m.[MaterialSupplierId] = c.[MaterialSupplierId]
		  ,m.[SupplierRightsExpirationDate] = c.[SupplierRightsExpirationDate]
		  ,m.[SupplierTATmin] = c.[SupplierTATmin]
		  ,m.[SupplierTATmax] = c.[SupplierTATmax]
	from Products m
		join PIM_ETL_STAGE.dbo.Stage_Import_Products b
			on m.ID = b.CurrentPimProductID
		join PIM_Import.dbo.Products c
			on b.CurrentImportProductID = c.ID
	where b.ProductType = 'Existing'


	set identity_insert Products on

	insert Products
		(
		   [ID]
		  ,[SupplierID]
		  ,[VendorProductID]
		  ,[COO]
		  ,[MOQquoted]
		  ,[MOQcatalogSTD]
		  ,[UOM]
		  ,[UOMcount]
		  ,[LOTsize]
		  ,[GeneralComment]
		  ,[NPProductCode]
		  ,[ItemType]
		  ,[NPGeneralComments]
		  ,[RootProductCode]
		  ,[RootProductName]
		  ,[Originator]
		  ,[Department]
		  ,[CreationDate]
		  ,[LastUpdateDate]
		  ,[UpdatedBy]
		  ,[OracleCatalog1]
		  ,[OracleCatalog2]
		  ,[OracleCatalog3]
		  ,[OracleCatalog4]
		  ,[OracleCategoryCode]
		  ,[URL]
		  ,[Height]
		  ,[Width]
		  ,[Depth]
		  ,[Diameter]
		  ,[SizeUOM]
		  ,[Weight]
		  ,[WeightUOM]
		  ,[DimensionsComment]
		  ,[ItemUserTypeID]
		  ,[Class]
		  ,[GroupingCode]
		  ,[TarriffCode]
		  ,[PatentNumbers]
		  ,[SellToCountries]
		  ,[AvailableCountries]
		  ,[BrandedName]
		  ,[VideoLinkURL]
		  ,[DataSource]
		  ,[CostOfGoodsAccount]
		  ,[SalesAccount]
		  ,[LoadGroupID]
		  ,[AttributeComment]
		  ,[ItemSchematic]
		  ,[OracleCatalog5]
		  ,[OracleCatalog6]
		  ,[VerticalTemplate]
		  ,[ShipCategory]
		  ,[ImportNotes]
		  ,[SupplierProductID]
		  ,[LoadDate]
		  ,[IsNew]
		  ,[SageProductID]
		  ,[SageProductCode]
		  ,[ProductXML]
		  ,[ProductXMLCrc]
		  ,[Features]
		  ,[UpdateDataSource]
		  ,[AttributeComboKey]
		  ,[AttributeComboValue]
		  ,[COOLocation]
		  ,[TechSpec]
		  ,[ImprintAreaNotes]
		  ,[PatentInfo]
		  ,[MaterialClassID]
		  ,[WebCatLevel1]
		  ,[WebCatLevel2]
		  ,[WebCatLevel3]
		  ,[WebCatLevel4]
		  ,[WebCatLevel5]
		  ,[MetricHeight]
		  ,[MetricWidth]
		  ,[MetricDepth]
		  ,[MetricDiameter]
		  ,[MetricSizeUOM]
		  ,[MetricWeight]
		  ,[MetricWeightUOM]
		  ,[LicensorID]
		  ,[MCPFamilyRefID]
		  ,[MCPFamilyNodeID]
		  ,[PreOrderMonth]
		  ,[Section321Qualified]
		  ,[StockUpdateDate]
		  ,[MCPType]
		  ,[MCPFamilyLocationID]
		  ,[TSCAep4Cert]
		  ,[MCPTypeName]
		  ,[MCPAccessoryListID]
		  ,[AllowFlexiblePricing]
		  ,[FixedOrderModifier]
		  ,[CreatedDate]
		  ,[CreatedBy]
		  ,[ModifiedDate]
		  ,[ModifiedBy]
		  ,[EUTarriffCode]
		  ,[MaterialSupplierId]
		  ,[SupplierRightsExpirationDate]
		  ,[SupplierTATmin]
		  ,[SupplierTATmax]
		)
	select b.NewProductID as [ID]
		  ,m.[SupplierID]
		  ,m.[VendorProductID]
		  ,m.[COO]
		  ,m.[MOQquoted]
		  ,m.[MOQcatalogSTD]
		  ,m.[UOM]
		  ,m.[UOMcount]
		  ,m.[LOTsize]
		  ,m.[GeneralComment]
		  ,m.[NPProductCode]
		  ,m.[ItemType]
		  ,m.[NPGeneralComments]
		  ,m.[RootProductCode]
		  ,m.[RootProductName]
		  ,m.[Originator]
		  ,m.[Department]
		  ,m.[CreationDate]
		  ,m.[LastUpdateDate]
		  ,m.[UpdatedBy]
		  ,m.[OracleCatalog1]
		  ,m.[OracleCatalog2]
		  ,m.[OracleCatalog3]
		  ,m.[OracleCatalog4]
		  ,m.[OracleCategoryCode]
		  ,m.[URL]
		  ,m.[Height]
		  ,m.[Width]
		  ,m.[Depth]
		  ,m.[Diameter]
		  ,m.[SizeUOM]
		  ,m.[Weight]
		  ,m.[WeightUOM]
		  ,m.[DimensionsComment]
		  ,m.[ItemUserTypeID]
		  ,m.[Class]
		  ,m.[GroupingCode]
		  ,m.[TarriffCode]
		  ,m.[PatentNumbers]
		  ,m.[SellToCountries]
		  ,m.[AvailableCountries]
		  ,m.[BrandedName]
		  ,m.[VideoLinkURL]
		  ,m.[DataSource]
		  ,m.[CostOfGoodsAccount]
		  ,m.[SalesAccount]
		  ,m.[LoadGroupID]
		  ,m.[AttributeComment]
		  ,m.[ItemSchematic]
		  ,m.[OracleCatalog5]
		  ,m.[OracleCatalog6]
		  ,m.[VerticalTemplate]
		  ,m.[ShipCategory]
		  ,m.[ImportNotes]
		  ,m.[SupplierProductID]
		  ,m.[LoadDate]
		  ,m.[IsNew]
		  ,m.[SageProductID]
		  ,m.[SageProductCode]
		  ,m.[ProductXML]
		  ,m.[ProductXMLCrc]
		  ,m.[Features]
		  ,m.[UpdateDataSource]
		  ,m.[AttributeComboKey]
		  ,m.[AttributeComboValue]
		  ,m.[COOLocation]
		  ,m.[TechSpec]
		  ,m.[ImprintAreaNotes]
		  ,m.[PatentInfo]
		  ,m.[MaterialClassID]
		  ,m.[WebCatLevel1]
		  ,m.[WebCatLevel2]
		  ,m.[WebCatLevel3]
		  ,m.[WebCatLevel4]
		  ,m.[WebCatLevel5]
		  ,m.[MetricHeight]
		  ,m.[MetricWidth]
		  ,m.[MetricDepth]
		  ,m.[MetricDiameter]
		  ,m.[MetricSizeUOM]
		  ,m.[MetricWeight]
		  ,m.[MetricWeightUOM]
		  ,m.[LicensorID]
		  ,m.[MCPFamilyRefID]
		  ,m.[MCPFamilyNodeID]
		  ,m.[PreOrderMonth]
		  ,m.[Section321Qualified]
		  ,m.[StockUpdateDate]
		  ,m.[MCPType]
		  ,m.[MCPFamilyLocationID]
		  ,m.[TSCAep4Cert]
		  ,m.[MCPTypeName]
		  ,m.[MCPAccessoryListID]
		  ,m.[AllowFlexiblePricing]
		  ,m.[FixedOrderModifier]
		  ,m.[CreatedDate]
		  ,m.[CreatedBy]
		  ,m.[ModifiedDate]
		  ,m.[ModifiedBy]
		  ,m.[EUTarriffCode]
		  ,m.[MaterialSupplierId]
		  ,m.[SupplierRightsExpirationDate]
		  ,m.[SupplierTATmin]
		  ,m.[SupplierTATmax]
	from PIM_Import.dbo.Products m
		join PIM_ETL_STAGE.dbo.Stage_Import_Products b
			on m.ID = b.CurrentImportProductID
	where b.ProductType = 'New'

	set identity_insert Products off
end
else
begin
	GOTO DONE
end
-- Products End


-- ProductArtTemplates Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductArtTemplates)
begin
	set identity_insert ProductArtTemplates on

	insert ProductArtTemplates
		(
		   [ID]
		  ,[ProductID]
		  ,[Name]
		  ,[Path]
		  ,[ChannelID]
		)
	select	s.NewPimArtTemplateID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[Name]
			,m.[Path]
			,m.[ChannelID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductArtTemplates s
		join PIM_Import.dbo.ProductArtTemplates m
			on s.CurrentImportArtTemplateID = m.ID
			
	set identity_insert ProductArtTemplates off
end
-- ProductArtTemplates End


-- ProductAttributes Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributes)
begin
	set identity_insert ProductAttributes on

	insert ProductAttributes
		(
		   [ID]
		  ,[ProductID]
		  ,[Selected]
		  ,[SchematicField]
		  ,[CreatedDate]
		  ,[CreatedBy]
		  ,[ModifiedDate]
		  ,[ModifiedBy]
		  ,[Primary]
		  ,[Derived]
		)
	select	s.NewPimAttributeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[Selected]
			,m.[SchematicField]
			,m.[CreatedDate]
			,m.[CreatedBy]
			,m.[ModifiedDate]
			,m.[ModifiedBy]
			,m.[Primary]
			,m.[Derived]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributes s
		join PIM_Import.dbo.ProductAttributes m
			on s.CurrentImportAttributeID = m.ID
			
	set identity_insert ProductAttributes off
end
-- ProductAttributes End


-- ProductAttributeSizes Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeSizes)
begin
	set identity_insert ProductAttributeSizes on

	insert ProductAttributeSizes
		(
		   [ID]
		  ,[ProductID]
		  ,[ProductAttributeID]
		  ,[Value]
		  ,[UOM]
		  ,[Selected]
		  ,[CreatedDate]
		  ,[CreatedBy]
		  ,[ModifiedDate]
		  ,[ModifiedBy]
		)
	select	s.NewPimAttributeSizeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,m.[Value]
			,m.[UOM]
			,m.[Selected]
			,m.[CreatedDate]
			,m.[CreatedBy]
			,m.[ModifiedDate]
			,m.[ModifiedBy]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeSizes s
		join PIM_Import.dbo.ProductAttributeSizes m
			on s.CurrentImportAttributeSizeID = m.ID
			
	set identity_insert ProductAttributeSizes off
end
-- ProductAttributeSizes End


-- ProductAttributeTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTranslations)
begin
	set identity_insert ProductAttributeTranslations on

	insert ProductAttributeTranslations
		(
		   [ID]
		  ,[ProductID]
		  ,[ProductAttributeID]
		  ,[LocaleID]
		  ,[Name]
		)
	select	s.NewPimAttributeTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTranslations s
		join PIM_Import.dbo.ProductAttributeTranslations m
			on s.CurrentImportAttributeTranslationID = m.ID
			
	set identity_insert ProductAttributeTranslations off
end
-- ProductAttributeTranslations End


-- ProductAttributeTypes Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTypes)
begin
	set identity_insert ProductAttributeTypes on

	insert ProductAttributeTypes
		(
		     [ID]
			,[ProductID]
			,[ProductAttributeID]
			,[Selected]
		)
	select	s.NewPimAttributeTypeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,m.[Selected]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTypes s
		join PIM_Import.dbo.ProductAttributeTypes m
			on s.CurrentImportAttributeTypeID = m.ID
			
	set identity_insert ProductAttributeTypes off
end
-- ProductAttributeTypes End


-- ProductAttributeTypeTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTypeTranslations)
begin
	set identity_insert ProductAttributeTypeTranslations on

	insert ProductAttributeTypeTranslations
		(
		     [ID]
			,[ProductID]
			,[ProductAttributeID]
			,[ProductAttributeTypeID]
			,[LocaleID]
			,[Name]
		)
	select	s.NewPimAttributeTypeTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,s.NewPimAttributeTypeID as [ProductAttributeTypeID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeTypeTranslations s
		join PIM_Import.dbo.ProductAttributeTypeTranslations m
			on s.CurrentImportAttributeTypeTranslationID = m.ID
			
	set identity_insert ProductAttributeTypeTranslations off
end
-- ProductAttributeTypeTranslations End


-- ProductAttributeColors Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeColors)
begin
	set identity_insert ProductAttributeColors on

	insert ProductAttributeColors
		(
		     [ID]
			,[ProductID]
			,[ProductAttributeID]
			,[StartHexCode]
			,[EndHexCode]
			,[Selected]
			,[ColorClassID]
			,[PMSCodeStart]
		)
	select	s.NewPimAttributeColorID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,m.[StartHexCode]
			,m.[EndHexCode]
			,m.[Selected]
			,m.[ColorClassID]
			,m.[PMSCodeStart]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeColors s
		join PIM_Import.dbo.ProductAttributeColors m
			on s.CurrentImportAttributeColorID = m.ID
			
	set identity_insert ProductAttributeColors off
end
-- ProductAttributeColors End


-- ProductAttributeColorTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeColorTranslations)
begin
	set identity_insert ProductAttributeColorTranslations on

	insert ProductAttributeColorTranslations
		(
		     [ID]
			,[ProductID]
			,[ProductAttributeID]
			,[ProductAttributeColorID]
			,[LocaleID]
			,[Start]
			,[End]
			,[ChannelID]
		)
	select	s.NewPimAttributeColorTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimAttributeID as [ProductAttributeID]
			,s.NewPimAttributeColorID as [ProductAttributeColorID]
			,m.[LocaleID]
			,m.[Start]
			,m.[End]
			,m.[ChannelID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAttributeColorTranslations s
		join PIM_Import.dbo.ProductAttributeColorTranslations m
			on s.CurrentImportAttributeColorTranslationID = m.ID
			
	set identity_insert ProductAttributeColorTranslations off
end
-- ProductAttributeColorTranslations End


-- ProductBatches Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductBatches)
begin
	set identity_insert ProductBatches on

	insert ProductBatches
		(
		     [ID]
			,[ProductID]
			,[BatchID]
			,[ChannelID]
		)
	select	s.NewPimBatchID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[BatchID]
			,m.[ChannelID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductBatches s
		join PIM_Import.dbo.ProductBatches m
			on s.CurrentImportBatchID = m.ID
			
	set identity_insert ProductBatches off
end
-- ProductBatches End


-- ProductCategories Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductCategories)
begin
	set identity_insert ProductCategories on

	insert ProductCategories
		(
		     [ID]
			,[ProductID]
		)
	select	s.NewPimCategoryID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductCategories s
		join PIM_Import.dbo.ProductCategories m
			on s.CurrentImportCategoryID = m.ID
			
	set identity_insert ProductCategories off
end
-- ProductCategories End


-- ProductCategoryTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductCategoryTranslations)
begin
	set identity_insert ProductCategoryTranslations on

	insert ProductCategoryTranslations
		(
		     [ID]
			,[ProductID]
			,[ProductCategoryID]
			,[LocaleID]
			,[Name]
		)
	select	s.NewPimCategoryTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimCategoryID as [ProductCategoryID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductCategoryTranslations s
		join PIM_Import.dbo.ProductCategoryTranslations m
			on s.CurrentImportCategoryTranslationID = m.ID
			
	set identity_insert ProductCategoryTranslations off
end
-- ProductCategoryTranslations End


-- ProductChannels Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductChannels)
begin
	set identity_insert ProductChannels on

	insert ProductChannels
		(
			 [ID]
			,[ProductID]
			,[ChannelID]
			,[ABCID]
			,[TargetDate]
			,[ReleaseDate]
			,[ReleasedBy]
			,[TATmin]
			,[TATmax]
			,[TATrangeID]
			,[ProcessStatusID]
			,[ItemStatusID]
			,[WebCode]
			,[ABCChanged]
			,[ChangedBy]
			,[Marketable]
		)
	select	s.NewPimProductChannelID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[ChannelID]
			,m.[ABCID]
			,m.[TargetDate]
			,m.[ReleaseDate]
			,m.[ReleasedBy]
			,m.[TATmin]
			,m.[TATmax]
			,m.[TATrangeID]
			,m.[ProcessStatusID]
			,m.[ItemStatusID]
			,m.[WebCode]
			,m.[ABCChanged]
			,m.[ChangedBy]
			,m.[Marketable]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductChannels s
		join PIM_Import.dbo.ProductChannels m
			on s.CurrentImportProductChannelID = m.ID
			
	set identity_insert ProductChannels off
end
-- ProductChannels End


-- ProductDesigns Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductDesigns)
begin
	set identity_insert ProductDesigns on

	insert ProductDesigns
		(
			 [ID]
			,[ProductID]
			,[DesignName]
			,[DesignCode]
			,[MaxLines]
			,[MaxPoint]
			,[MaxChars]
			,[AllowFormat]
			,[Casino]
			,[Holo]
			,[ImpReq]
			,[Logo]
			,[Filename]
			,[Template]
			,[TempName]
			,[ImpDesignCode]
			,[Font]
			,[Color]
			,[Orient]
			,[LineSpace]
			,[Outline]
			,[OutlineColor]
			,[TextboxWidth]
			,[TexboxHeight]
			,[TextboxXLoc]
			,[TextboxYLoc]
			,[VerticalText]
			,[AlphaChannel]
			,[AllowColor]
			,[PresFormat]
			,[ProdFormat]
			,[ProdOutputRes]
			,[ProdOutputColor]
			,[ImpMaxPoint]
			,[TextRotation]
			,[FilePath]
			,[DimensionsWidth]
			,[DimensionsHeight]
			,[BoundingBoxX]
			,[BoundingBoxY]
			,[BoundingBoxWidth]
			,[BoundingBoxHeight]
			,[VignetteExists]
			,[IsSeries]
			,[SeriesCount]
			,[InScene7]
			,[BaseUrl]
			,[SampleUrl]
			,[ImageName]
			,[ImageDesc]
			,[ImageFileName]
			,[ImagePresFormat]
			,[ImageProdFormat]
			,[ImageProdColorSpace]
			,[ImageProdOutRes]
			,[ImageSeries]
			,[ImageSeriesCount]
			,[ImageAlpha]
			,[ImageAllowColorChoice]
			,[ImpCenterPointX]
			,[ImpCenterPointY]
			,[ImpFontColor]
			,[ImpFontName]
			,[ImpSize]
			,[ImpJustification]
			,[ImpLineSpacing]
			,[ImpTextRotation]
			,[ImpVerticalText]
			,[ProductMethodology]
			,[RoyaltyDesign]
			,[DesignUrl]
			,[DistChannel]
			,[ColorName]
		)
	select	s.NewPimProductDesignID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[DesignName]
			,m.[DesignCode]
			,m.[MaxLines]
			,m.[MaxPoint]
			,m.[MaxChars]
			,m.[AllowFormat]
			,m.[Casino]
			,m.[Holo]
			,m.[ImpReq]
			,m.[Logo]
			,m.[Filename]
			,m.[Template]
			,m.[TempName]
			,m.[ImpDesignCode]
			,m.[Font]
			,m.[Color]
			,m.[Orient]
			,m.[LineSpace]
			,m.[Outline]
			,m.[OutlineColor]
			,m.[TextboxWidth]
			,m.[TexboxHeight]
			,m.[TextboxXLoc]
			,m.[TextboxYLoc]
			,m.[VerticalText]
			,m.[AlphaChannel]
			,m.[AllowColor]
			,m.[PresFormat]
			,m.[ProdFormat]
			,m.[ProdOutputRes]
			,m.[ProdOutputColor]
			,m.[ImpMaxPoint]
			,m.[TextRotation]
			,m.[FilePath]
			,m.[DimensionsWidth]
			,m.[DimensionsHeight]
			,m.[BoundingBoxX]
			,m.[BoundingBoxY]
			,m.[BoundingBoxWidth]
			,m.[BoundingBoxHeight]
			,m.[VignetteExists]
			,m.[IsSeries]
			,m.[SeriesCount]
			,m.[InScene7]
			,m.[BaseUrl]
			,m.[SampleUrl]
			,m.[ImageName]
			,m.[ImageDesc]
			,m.[ImageFileName]
			,m.[ImagePresFormat]
			,m.[ImageProdFormat]
			,m.[ImageProdColorSpace]
			,m.[ImageProdOutRes]
			,m.[ImageSeries]
			,m.[ImageSeriesCount]
			,m.[ImageAlpha]
			,m.[ImageAllowColorChoice]
			,m.[ImpCenterPointX]
			,m.[ImpCenterPointY]
			,m.[ImpFontColor]
			,m.[ImpFontName]
			,m.[ImpSize]
			,m.[ImpJustification]
			,m.[ImpLineSpacing]
			,m.[ImpTextRotation]
			,m.[ImpVerticalText]
			,m.[ProductMethodology]
			,m.[RoyaltyDesign]
			,m.[DesignUrl]
			,m.[DistChannel]
			,m.[ColorName]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductDesigns s
		join PIM_Import.dbo.ProductDesigns m
			on s.CurrentImportProductDesignID = m.ID
			
	set identity_insert ProductDesign off
end
-- ProductDesigns End


-- ProductDesignTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductDesignTranslations)
begin
	set identity_insert ProductDesignTranslations on

	insert ProductDesignTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductDesignID]
			,[LocaleID]
			,[CatLevel1]
			,[CatLevel2]
			,[Keywords]
			,[WebDesc]
			,[MktDesc]
		)
	select	s.NewPimProductDesignTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductDesignID as [ProductDesignID]
			,m.[LocaleID]
			,m.[CatLevel1]
			,m.[CatLevel2]
			,m.[Keywords]
			,m.[WebDesc]
			,m.[MktDesc]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductDesignTranslations s
		join PIM_Import.dbo.ProductDesignTranslations m
			on s.CurrentImportProductDesignTranslationID = m.ID
			
	set identity_insert ProductDesignTranslations off
end
-- ProductDesignTranslations End


-- ProductFamilys Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFamilys)
begin
	set identity_insert ProductFamilys on

	insert ProductFamilys
		(
			 [ID]
			,[ProductID]
			,[Family]
			,[Version]
			,[DemantraItemID]
		)
	select	s.NewPimProductFamilyID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[Family]
			,m.[Version]
			,m.[DemantraItemID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFamilys s
		join PIM_Import.dbo.ProductFamilys m
			on s.CurrentImportProductFamilyID = m.ID
			
	set identity_insert ProductFamilys off
end
-- ProductFamilys End


-- ProductFamilyChannels Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFamilyChannels)
begin
	set identity_insert ProductFamilyChannels on

	insert ProductFamilyChannels
		(
			 [ID]
			,[ProductID]
			,[ProductFamilyID]
			,[ChannelID]
			,[StatusID]
			,[CommentID]
			,[TNS]
			,[PLM]
			,[IRL]
			,[ChangedBy]
			,[UpdateDate]
			,[JPN]
		)
	select	s.NewPimProductFamilyChannelID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductFamilyID as [ProductFamilyID]
			,m.[ChannelID]
			,m.[StatusID]
			,m.[CommentID]
			,m.[TNS]
			,m.[PLM]
			,m.[IRL]
			,m.[ChangedBy]
			,m.[UpdateDate]
			,m.[JPN]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFamilyChannels s
		join PIM_Import.dbo.ProductFamilyChannels m
			on s.CurrentImportProductFamilyChannelID = m.ID
			
	set identity_insert ProductFamilyChannels off
end
-- ProductFamilyChannels End


-- ProductFOBs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBs)
begin
	set identity_insert ProductFOBs on

	insert ProductFOBs
		(
			 [ID]
			,[ProductID]
			,[City]
			,[StateProvinceCounty]
			,[Zipcode]
			,[Country]
			,[Currency]
			,[Type]
			,[Qualifier]
			,[DecoMethod]
			,[ItemCode]
			,[ColorCount]
			,[QualifierValue]
		)
	select	s.NewPimProductFobID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[City]
			,m.[StateProvinceCounty]
			,m.[Zipcode]
			,m.[Country]
			,m.[Currency]
			,m.[Type]
			,m.[Qualifier]
			,m.[DecoMethod]
			,m.[ItemCode]
			,m.[ColorCount]
			,m.[QualifierValue]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBs s
		join PIM_Import.dbo.ProductFOBs m
			on s.CurrentImportProductFobID = m.ID
			
	set identity_insert ProductFOBs off
end
-- ProductFOBs End


-- ProductFOBAdditionalCharges Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBAdditionalCharges)
begin
	set identity_insert ProductFOBAdditionalCharges on

	insert ProductFOBAdditionalCharges
		(
			 [ID]
			,[ProductID]
			,[ProductFobID]
			,[Name]
			,[ApplicationMethod]
			,[NPQuote]
			,[STDCatalogNet]
			,[STDCatalogPrice]
			,[PriceCode]
			,[PriceCodePct]
			,[OracleChargeSkuID]
		)
	select	s.NewPimProductFobAdditionalChargeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductFobID as [ProductFobID]
			,m.[Name]
			,m.[ApplicationMethod]
			,m.[NPQuote]
			,m.[STDCatalogNet]
			,m.[STDCatalogPrice]
			,m.[PriceCode]
			,m.[PriceCodePct]
			,m.[OracleChargeSkuID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBAdditionalCharges s
		join PIM_Import.dbo.ProductFOBAdditionalCharges m
			on s.CurrentImportProductFobAdditionalChargeID = m.ID
			
	set identity_insert ProductFOBAdditionalCharges off
end
-- ProductFOBAdditionalCharges End


-- ProductFOBPriceTiers Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBPriceTiers)
begin
	set identity_insert ProductFOBPriceTiers on

	insert ProductFOBPriceTiers
		(
			 [ID]
			,[ProductID]
			,[ProductFobID]
			,[QtyStart]
			,[NPQuote]
			,[STDCatalogNet]
			,[STDCatalogPrice]
			,[PriceCode]
			,[PriceCodePct]
		)
	select	s.NewPimProductFobPriceTierID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductFobID as [ProductFobID]
			,m.[QtyStart]
			,m.[NPQuote]
			,m.[STDCatalogNet]
			,m.[STDCatalogPrice]
			,m.[PriceCode]
			,m.[PriceCodePct]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBPriceTiers s
		join PIM_Import.dbo.ProductFOBPriceTiers m
			on s.CurrentImportProductFobPriceTierID = m.ID
			
	set identity_insert ProductFOBPriceTiers off
end
-- ProductFOBPriceTiers End


-- ProductFOBMaterialCosts Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBMaterialCosts)
begin
	set identity_insert ProductFOBMaterialCosts on

	insert ProductFOBMaterialCosts
		(
			 [ID]
			,[ProductID]
			,[ProductFobID]
			,[MaterialSupplierID]
			,[PartNumber]
			,[EffectiveFrom]
			,[EffectiveTo]
			,[ItemCost]
			,[AdditionalComments]
			,[BuyerID]
			,[COO]
		)
	select	s.NewPimProductFobMaterialCostID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductFobID as [ProductFobID]
			,m.[MaterialSupplierID]
			,m.[PartNumber]
			,m.[EffectiveFrom]
			,m.[EffectiveTo]
			,m.[ItemCost]
			,m.[AdditionalComments]
			,m.[BuyerID]
			,m.[COO]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBMaterialCosts s
		join PIM_Import.dbo.ProductFOBMaterialCosts m
			on s.CurrentImportProductFobMaterialCostID = m.ID
			
	set identity_insert ProductFOBMaterialCosts off
end
-- ProductFOBMaterialCosts End


-- ProductFOBCostComponents Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBCostComponents)
begin
	set identity_insert ProductFOBCostComponents on

	insert ProductFOBCostComponents
		(
			 [ID]
			,[ProductID]
			,[ProductFobID]
			,[ProductFobMaterialCostsID]
			,[Component]
			,[Description]
			,[UOMID]
			,[InventoryCategoryID]
		)
	select	s.NewPimProductFobCostComponentID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductFobID as [ProductFobID]
			,s.NewPimProductFobMaterialCostID as [ProductFobMaterialCostsID]
			,m.[Component]
			,m.[Description]
			,m.[UOMID]
			,m.[InventoryCategoryID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductFOBCostComponents s
		join PIM_Import.dbo.ProductFOBCostComponents m
			on s.CurrentImportProductFobCostComponentID = m.ID
			
	set identity_insert ProductFOBCostComponents off
end
-- ProductFOBCostComponents End


-- ProductImages Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImages)
begin
	set identity_insert ProductImages on

	insert ProductImages
		(
			 [ID]
			,[ProductID]
			,[LocaleID]
			,[Name]
			,[Path]
			,[Default]
			,[MCP]
			,[MCPSceneUri]
			,[MCPcompositeSceneUri]
			,[Type]
			,[ChannelID]
			,[Family]
			,[MCPActionID]
		)
	select	s.NewPimProductImageID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[LocaleID]
			,m.[Name]
			,m.[Path]
			,m.[Default]
			,m.[MCP]
			,m.[MCPSceneUri]
			,m.[MCPcompositeSceneUri]
			,m.[Type]
			,m.[ChannelID]
			,m.[Family]
			,m.[MCPActionID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImages s
		join PIM_Import.dbo.ProductImages m
			on s.CurrentImportProductImageID = m.ID
			
	set identity_insert ProductImages off
end
-- ProductImages End


-- ProductImprintAreas Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreas)
begin
	set identity_insert ProductImprintAreas on

	insert ProductImprintAreas
		(
			 [ID]
			,[ProductID]
			,[Type]
			,[Height]
			,[Width]
			,[UOM]
			,[MaxLines]
			,[MaxChars]
			,[IncludedColors]
			,[ColorMax]
			,[DefaultFont]
			,[DefaultFontSize]
			,[FontMin]
			,[FontMax]
			,[Justification]
			,[CategoryID]
			,[Qualifier1]
			,[Qualifier2]
			,[BoxHeight]
			,[BoxWidth]
			,[BoxUOM]
			,[LocationClassID]
			,[ProcessClassID]
			,[Channels]
			,[MetricHeight]
			,[MetricWidth]
			,[MetricUOM]
			,[SafetyMarginLeft]
			,[SafetyMarginRight]
			,[SafetyMarginTop]
			,[SafetyMarginBottom]
			,[BleedMarginLeft]
			,[BleedMarginRight]
			,[BleedMarginTop]
			,[BleedMarginBottom]
			,[ImprintDiameter]
			,[MetricDiameter]
			,[SafetyUOM]
			,[BleedUOM]
			,[TATrangeID]
		)
	select	s.NewPimProductImprintAreaID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[Type]
			,m.[Height]
			,m.[Width]
			,m.[UOM]
			,m.[MaxLines]
			,m.[MaxChars]
			,m.[IncludedColors]
			,m.[ColorMax]
			,m.[DefaultFont]
			,m.[DefaultFontSize]
			,m.[FontMin]
			,m.[FontMax]
			,m.[Justification]
			,m.[CategoryID]
			,m.[Qualifier1]
			,m.[Qualifier2]
			,m.[BoxHeight]
			,m.[BoxWidth]
			,m.[BoxUOM]
			,m.[LocationClassID]
			,m.[ProcessClassID]
			,m.[Channels]
			,m.[MetricHeight]
			,m.[MetricWidth]
			,m.[MetricUOM]
			,m.[SafetyMarginLeft]
			,m.[SafetyMarginRight]
			,m.[SafetyMarginTop]
			,m.[SafetyMarginBottom]
			,m.[BleedMarginLeft]
			,m.[BleedMarginRight]
			,m.[BleedMarginTop]
			,m.[BleedMarginBottom]
			,m.[ImprintDiameter]
			,m.[MetricDiameter]
			,m.[SafetyUOM]
			,m.[BleedUOM]
			,m.[TATrangeID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreas s
		join PIM_Import.dbo.ProductImprintAreas m
			on s.CurrentImportProductImprintAreaID = m.ID
			
	set identity_insert ProductImprintAreas off
end
-- ProductImprintAreas End


-- ProductImprintAreaColors Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaColors)
begin
	set identity_insert ProductImprintAreaColors on

	insert ProductImprintAreaColors
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[HexCode]
			,[Default]
			,[ClassID]
			,[PMS]
		)
	select	s.NewPimProductImprintAreaColorID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,m.[HexCode]
			,m.[Default]
			,m.[ClassID]
			,m.[PMS]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaColors s
		join PIM_Import.dbo.ProductImprintAreaColors m
			on s.CurrentImportProductImprintAreaColorID = m.ID
			
	set identity_insert ProductImprintAreaColors off
end
-- ProductImprintAreaColors End


-- ProductImprintAreaColorTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaColorTranslations)
begin
	set identity_insert ProductImprintAreaColorTranslations on

	insert ProductImprintAreaColorTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[ProductImprintAreaColorID]
			,[LocaleID]
			,[Name]
		)
	select	s.NewPimProductImprintAreaColorTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,s.NewPimProductImprintAreaColorID as [ProductImprintAreaColorID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaColorTranslations s
		join PIM_Import.dbo.ProductImprintAreaColorTranslations m
			on s.CurrentImportProductImprintAreaColorTranslationID = m.ID
			
	set identity_insert ProductImprintAreaColorTranslations off
end
-- ProductImprintAreaColorTranslations End


-- ProductImprintAreaFonts Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaFonts)
begin
	set identity_insert ProductImprintAreaFonts on

	insert ProductImprintAreaFonts
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
		)
	select	s.NewPimProductImprintAreaFontID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaFonts s
		join PIM_Import.dbo.ProductImprintAreaFonts m
			on s.CurrentImportProductImprintAreaFontID = m.ID
			
	set identity_insert ProductImprintAreaFonts off
end
-- ProductImprintAreaFonts End


-- ProductImprintAreaFontTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaFontTranslations)
begin
	set identity_insert ProductImprintAreaFontTranslations on

	insert ProductImprintAreaFontTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[ProductImprintAreaFontID]
			,[LocaleID]
			,[Name]
		)
	select	s.NewPimProductImprintAreaFontTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,s.NewPimProductImprintAreaFontID as [ProductImprintAreaFontID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaFontTranslations s
		join PIM_Import.dbo.ProductImprintAreaFontTranslations m
			on s.CurrentImportProductImprintAreaFontTranslationID = m.ID
			
	set identity_insert ProductImprintAreaFontTranslations off
end
-- ProductImprintAreaFontTranslations End


-- ProductImprintAreaLasers Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaLasers)
begin
	set identity_insert ProductImprintAreaLasers on

	insert ProductImprintAreaLasers
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[LaserTypeID]
			,[LaserAttributeID]
			,[Value]
			,[Notes]
		)
	select	s.NewPimProductImprintAreaLaserID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,m.[LaserTypeID]
			,m.[LaserAttributeID]
			,m.[Value]
			,m.[Notes]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaLasers s
		join PIM_Import.dbo.ProductImprintAreaLasers m
			on s.CurrentImportProductImprintAreaLaserID = m.ID
			
	set identity_insert ProductImprintAreaLasers off
end
-- ProductImprintAreaLasers End


-- ProductImprintAreaStyles Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaStyles)
begin
	set identity_insert ProductImprintAreaStyles on

	insert ProductImprintAreaStyles
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[Name]
		)
	select	s.NewPimProductImprintAreaStyleID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaStyles s
		join PIM_Import.dbo.ProductImprintAreaStyles m
			on s.CurrentImportProductImprintAreaStyleID = m.ID
			
	set identity_insert ProductImprintAreaStyles off
end
-- ProductImprintAreaStyles End


-- ProductImprintAreaTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaTranslations)
begin
	set identity_insert ProductImprintAreaTranslations on

	insert ProductImprintAreaTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductImprintAreaID]
			,[LocaleID]
			,[Location]
			,[Method]
		)
	select	s.NewPimProductImprintAreaTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductImprintAreaID as [ProductImprintAreaID]
			,m.[LocaleID]
			,m.[Location]
			,m.[Method]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductImprintAreaTranslations s
		join PIM_Import.dbo.ProductImprintAreaTranslations m
			on s.CurrentImportProductImprintAreaTranslationID = m.ID
			
	set identity_insert ProductImprintAreaTranslations off
end
-- ProductImprintAreaTranslations End


-- ProductJigs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductJigs)
begin
	set identity_insert ProductJigs on

	insert ProductJigs
		(
			 [ID]
			,[ProductId]
			,[JigId]
			,[Comments]
		)
	select	s.NewPimProductJigID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[JigId]
			,m.[Comments]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductJigs s
		join PIM_Import.dbo.ProductJigs m
			on s.CurrentImportProductJigID = m.ID
			
	set identity_insert ProductJigs off
end
-- ProductJigs End


-- ProductMerchCategories Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductMerchCategories)
begin
	set identity_insert ProductMerchCategories on

	insert ProductMerchCategories
		(
			 [ID]
			,[ProductID]
			,[MerchCatID]
		)
	select	s.NewPimProductMerchCategoryID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[MerchCatID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductMerchCategories s
		join PIM_Import.dbo.ProductMerchCategories m
			on s.CurrentImportProductMerchCategoryID = m.ID
			
	set identity_insert ProductMerchCategories off
end
-- ProductMerchCategories End


-- ProductMerchCatKeys Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductMerchCatKeys)
begin
	set identity_insert ProductMerchCatKeys on

	insert ProductMerchCatKeys
		(
			 [ID]
			,[ProductID]
			,[ProductMerchCatID]
			,[MerchCatID]
			,[MerchCatKeyID]
			,[MerchCatKeyListID]
			,[Description]
		)
	select	s.NewPimProductMerchCatKeyID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductMerchCategoryID as [ProductMerchCatID]
			,m.[MerchCatID]
			,m.[MerchCatKeyID]
			,m.[MerchCatKeyListID]
			,m.[Description]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductMerchCatKeys s
		join PIM_Import.dbo.ProductMerchCatKeys m
			on s.CurrentImportProductMerchCatKeyID = m.ID
			
	set identity_insert ProductMerchCatKeys off
end
-- ProductMerchCatKeys End


-- ProductPackagingDetails Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductPackagingDetails)
begin
	set identity_insert ProductPackagingDetails on

	insert ProductPackagingDetails
		(
			 [ID]
			,[ProductID]
			,[PackageType]
			,[QtyPerBox]
			,[QtyUOM]
			,[Height]
			,[Width]
			,[Depth]
			,[SizeUOM]
			,[BoxWeight]
			,[WeightUOM]
			,[BoxGrWeight]
			,[Category]
		)
	select	s.NewPimProductPackagingDetailID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[PackageType]
			,m.[QtyPerBox]
			,m.[QtyUOM]
			,m.[Height]
			,m.[Width]
			,m.[Depth]
			,m.[SizeUOM]
			,m.[BoxWeight]
			,m.[WeightUOM]
			,m.[BoxGrWeight]
			,m.[Category]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductPackagingDetails s
		join PIM_Import.dbo.ProductPackagingDetails m
			on s.CurrentImportProductPackagingDetailID = m.ID
			
	set identity_insert ProductPackagingDetails off
end
-- ProductPackagingDetails End


-- ProductPriceLists Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceLists)
begin
	set identity_insert ProductPriceLists on

	insert ProductPriceLists
		(
			 [ID]
			,[ProductID]
			,[PriceListNameID]
			,[ListPrice]
			,[UnitPrice]
			,[FreePercent]
			,[PriceTier]
		)
	select	s.NewPimProductPriceListID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[PriceListNameID]
			,m.[ListPrice]
			,m.[UnitPrice]
			,m.[FreePercent]
			,m.[PriceTier]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceLists s
		join PIM_Import.dbo.ProductPriceLists m
			on s.CurrentImportProductPriceListID = m.ID
			
	set identity_insert ProductPriceLists off
end
-- ProductPriceLists End


-- ProductPriceListCharges Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListCharges)
begin
	set identity_insert ProductPriceListCharges on

	insert ProductPriceListCharges
		(
			 [ID]
			,[ProductID]
			,[ProductPriceListID]
			,[PriceListChargeID]
			,[PriceListApplicationTypeID]
			,[PriceListSelectionModeID]
			,[Amount]
			,[MatchSkuQty]
			,[Visible]
		)
	select	s.NewPimProductPriceListChargeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductPriceListID as [ProductPriceListID]
			,m.[PriceListChargeID]
			,m.[PriceListApplicationTypeID]
			,m.[PriceListSelectionModeID]
			,m.[Amount]
			,m.[MatchSkuQty]
			,m.[Visible]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListCharges s
		join PIM_Import.dbo.ProductPriceListCharges m
			on s.CurrentImportProductPriceListChargeID = m.ID
			
	set identity_insert ProductPriceListCharges off
end
-- ProductPriceListCharges End


-- ProductPriceListChargeTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListChargeTranslations)
begin
	set identity_insert ProductPriceListChargeTranslations on

	insert ProductPriceListChargeTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductPriceListID]
			,[ProductPriceListChargeID]
			,[LocaleID]
			,[DisplayName]
		)
	select	s.NewPimProductPriceListChargeTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductPriceListID as [ProductPriceListID]
			,s.NewPimProductPriceListChargeID as [ProductPriceListChargeID]
			,m.[LocaleID]
			,m.[DisplayName]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListChargeTranslations s
		join PIM_Import.dbo.ProductPriceListChargeTranslations m
			on s.CurrentImportProductPriceListChargeTranslationID = m.ID
			
	set identity_insert ProductPriceListChargeTranslations off
end
-- ProductPriceListChargeTranslations End


-- ProductPriceListTiers Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListTiers)
begin
	set identity_insert ProductPriceListTiers on

	insert ProductPriceListTiers
		(
			 [ID]
			,[ProductID]
			,[ProductPriceListID]
			,[QtyBreaks]
			,[PriceBreaks]
			,[UpsellQty]
			,[UpsellPrice]
			,[Free]
			,[Premium]
		)
	select	s.NewPimProductPriceListTierID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductPriceListID as [ProductPriceListID]
			,m.[QtyBreaks]
			,m.[PriceBreaks]
			,m.[UpsellQty]
			,m.[UpsellPrice]
			,m.[Free]
			,m.[Premium]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductPriceListTiers s
		join PIM_Import.dbo.ProductPriceListTiers m
			on s.CurrentImportProductPriceListTierID = m.ID
			
	set identity_insert ProductPriceListTiers off
end
-- ProductPriceListTiers End


-- ProductShipOrgs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductShipOrgs)
begin
	set identity_insert ProductShipOrgs on

	insert ProductShipOrgs
		(
			 [ID]
			,[ProductID]
			,[OrgID]
			,[ShipOrgID]
			,[Active]
			,[Sample]
		)
	select	s.NewPimProductShipOrgID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[OrgID]
			,m.[ShipOrgID]
			,m.[Active]
			,m.[Sample]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductShipOrgs s
		join PIM_Import.dbo.ProductShipOrgs m
			on s.CurrentImportProductShipOrgID = m.ID
			
	set identity_insert ProductShipOrgs off
end
-- ProductShipOrgs End


-- ProductSKUs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSKUs)
begin
	set identity_insert ProductSKUs on

	insert ProductSKUs
		(
			 [ID]
			,[ProductID]
			,[PartNumber]
			,[Description]
			,[ATP]
			,[LastUpdate]
			,[OracleID]
			,[OracleDesc]
			,[ProdFamily]
			,[DecoMethod]
			,[ProdColor]
			,[BarrelType]
			,[InkColor]
			,[PackSize]
			,[Royalty]
			,[RoyaltySub]
			,[Colors]
			,[Component]
			,[SkuFormatID]
			,[CrossRef]
			,[DistChannel]
			,[ProductFamilyID]
			,[SampleTNS]
			,[SamplePLM]
			,[SampleIRL]
			,[MCPsku]
			,[MCPSkuFamilyID]
			,[MCPRuleSetID]
			,[MCPSurfaceTemplateRefID]
			,[MCPSurfaceSetID]
			,[MCPDataSheetID]
			,[MCPContractID]
			,[OracleInventoryItemID]
			,[MCPstatusID]
			,[MCPUpdated]
			,[SampleGER]
			,[DecoSubClass]
		)
	select	s.NewPimProductSkuID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[PartNumber]
			,m.[Description]
			,m.[ATP]
			,m.[LastUpdate]
			,m.[OracleID]
			,m.[OracleDesc]
			,m.[ProdFamily]
			,m.[DecoMethod]
			,m.[ProdColor]
			,m.[BarrelType]
			,m.[InkColor]
			,m.[PackSize]
			,m.[Royalty]
			,m.[RoyaltySub]
			,m.[Colors]
			,m.[Component]
			,m.[SkuFormatID]
			,m.[CrossRef]
			,m.[DistChannel]
			,m.[ProductFamilyID]
			,m.[SampleTNS]
			,m.[SamplePLM]
			,m.[SampleIRL]
			,m.[MCPsku]
			,m.[MCPSkuFamilyID]
			,m.[MCPRuleSetID]
			,m.[MCPSurfaceTemplateRefID]
			,m.[MCPSurfaceSetID]
			,m.[MCPDataSheetID]
			,m.[MCPContractID]
			,m.[OracleInventoryItemID]
			,m.[MCPstatusID]
			,m.[MCPUpdated]
			,m.[SampleGER]
			,m.[DecoSubClass]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSKUs s
		join PIM_Import.dbo.ProductSKUs m
			on s.CurrentImportProductSkuID = m.ID
			
	set identity_insert ProductSKUs off
end
-- ProductSKUs End


-- ProductSkuImages Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuImages)
begin
	set identity_insert ProductSkuImages on

	insert ProductSkuImages
		(
			 [ID]
			,[ProductID]
			,[ProductSkuID]
			,[Name]
			,[Path]
			,[MCPSceneUri]
			,[Default]
			,[MCP]
			,[MCPcompositeSceneUri]
			,[Type]
			,[ChannelID]
			,[MCPActionID]
		)
	select	s.NewPimProductSkuImageID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductSkuID as [ProductSkuID]
			,m.[Name]
			,m.[Path]
			,m.[MCPSceneUri]
			,m.[Default]
			,m.[MCP]
			,m.[MCPcompositeSceneUri]
			,m.[Type]
			,m.[ChannelID]
			,m.[MCPActionID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuImages s
		join PIM_Import.dbo.ProductSkuImages m
			on s.CurrentImportProductSkuImageID = m.ID
			
	set identity_insert ProductSkuImages off
end
-- ProductSkuImages End


-- ProductSkuChannels Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuChannels)
begin
	set identity_insert ProductSkuChannels on

	insert ProductSkuChannels
		(
			 [ID]
			,[ProductID]
			,[ProductSkuID]
			,[ChannelID]
			,[Marketable]
		)
	select	s.NewPimProductSkuChannelID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductSkuID as [ProductSkuID]
			,m.[ChannelID]
			,m.[Marketable]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuChannels s
		join PIM_Import.dbo.ProductSkuChannels m
			on s.CurrentImportProductSkuChannelID = m.ID
			
	set identity_insert ProductSkuChannels off
end
-- ProductSkuChannels End


-- ProductSkuBillOfMaterials Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuBillOfMaterials)
begin
	set identity_insert ProductSkuBillOfMaterials on

	insert ProductSkuBillOfMaterials
		(
			 [ID]
			,[ProductID]
			,[ProductSkuID]
			,[OrgID]
			,[UOMID]
			,[ItemSeq]
			,[OperatingSeq]
			,[Component]
			,[Quantity]
			,[SupplyType]
			,[SubInventory]
			,[Critical]
		)
	select	s.NewPimProductSkuBillOfMaterialID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductSkuID as [ProductSkuID]
			,m.[OrgID]
			,m.[UOMID]
			,m.[ItemSeq]
			,m.[OperatingSeq]
			,m.[Component]
			,m.[Quantity]
			,m.[SupplyType]
			,m.[SubInventory]
			,m.[Critical]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuBillOfMaterials s
		join PIM_Import.dbo.ProductSkuBillOfMaterials m
			on s.CurrentImportProductSkuBillOfMaterialID = m.ID
			
	set identity_insert ProductSkuBillOfMaterials off
end
-- ProductSkuBillOfMaterials End


-- ProductSkuAttributes Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuAttributes)
begin
	set identity_insert ProductSkuAttributes on

	insert ProductSkuAttributes
		(
			 [ID]
			,[ProductID]
			,[ProductSkuID]
			,[AttributeID]
			,[Value]
		)
	select	s.NewPimProductSkuAttributeID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductSkuID as [ProductSkuID]
			,s.ProductAttributeID as [AttributeID]
			,m.[Value]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSkuAttributes s
		join PIM_Import.dbo.ProductSkuAttributes m
			on s.CurrentImportProductSkuAttributeID = m.ID
			
	set identity_insert ProductSkuAttributes off
end
-- ProductSkuAttributes End


-- ProductSpecialCharacters Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecialCharacters)
begin
	set identity_insert ProductSpecialCharacters on

	insert ProductSpecialCharacters
		(
			 [ID]
			,[ProductID]
			,[LocaleID]
			,[SeqNumber]
			,[Code]
			,[Char]
		)
	select	s.NewPimProductSpecialCharacterID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[LocaleID]
			,m.[SeqNumber]
			,m.[Code]
			,m.[Char]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecialCharacters s
		join PIM_Import.dbo.ProductSpecialCharacters m
			on s.CurrentImportProductSpecialCharacterID = m.ID
			
	set identity_insert ProductSpecialCharacters off
end
-- ProductSpecialCharacters End


-- ProductSpecialNotes Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecialNotes)
begin
	set identity_insert ProductSpecialNotes on

	insert ProductSpecialNotes
		(
			 [ID]
			,[ProductID]
			,[ImageURL]
			,[Comments]
		)
	select	s.NewPimProductSpecialNoteID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[ImageURL]
			,m.[Comments]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecialNotes s
		join PIM_Import.dbo.ProductSpecialNotes m
			on s.CurrentImportProductSpecialNoteID = m.ID
			
	set identity_insert ProductSpecialNotes off
end
-- ProductSpecialNotes End


-- ProductSpecs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecs)
begin
	set identity_insert ProductSpecs on

	insert ProductSpecs
		(
			 [ID]
			,[ProductID]
			,[LocaleID]
			,[Priority]
			,[Key]
			,[Value]
		)
	select	s.NewPimProductSpecID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[LocaleID]
			,m.[Priority]
			,m.[Key]
			,m.[Value]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSpecs s
		join PIM_Import.dbo.ProductSpecs m
			on s.CurrentImportProductSpecID = m.ID
			
	set identity_insert ProductSpecs off
end
-- ProductSpecs End


-- ProductSubCategories Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSubCategories)
begin
	set identity_insert ProductSubCategories on

	insert ProductSubCategories
		(
			 [ID]
			,[ProductID]
			,[ProductCategoryID]
		)
	select	s.NewPimProductSubCategoryID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductCategoryID as [ProductCategoryID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSubCategories s
		join PIM_Import.dbo.ProductSubCategories m
			on s.CurrentImportProductSubCategoryID = m.ID
			
	set identity_insert ProductSubCategories off
end
-- ProductSubCategories End


-- ProductSubCategoryTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductSubCategoryTranslations)
begin
	set identity_insert ProductSubCategoryTranslations on

	insert ProductSubCategoryTranslations
		(
			 [ID]
			,[ProductID]
			,[ProductCategoryID]
			,[ProductSubCategoryID]
			,[LocaleID]
			,[Name]
		)
	select	s.NewPimProductSubCategoryTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,s.NewPimProductCategoryID as [ProductCategoryID]
			,s.NewPimProductSubCategoryID as [ProductSubCategoryID]
			,m.[LocaleID]
			,m.[Name]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductSubCategoryTranslations s
		join PIM_Import.dbo.ProductSubCategoryTranslations m
			on s.CurrentImportProductSubCategoryTranslationID = m.ID
			
	set identity_insert ProductSubCategoryTranslations off
end
-- ProductSubCategoryTranslations End


-- ProductTranslations Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductTranslations)
begin
	set identity_insert ProductTranslations on

	insert ProductTranslations
		(
			 [ID]
			,[ProductID]
			,[LocaleID]
			,[NPProductName]
			,[Name]
			,[Description]
			,[SubHeader]
			,[LongDescriptionCopy]
			,[WebName]
			,[Material]
			,[Keywords]
			,[NPurl]
			,[SEOTitle]
			,[SEODescription]
			,[SEOText]
			,[NPWebNotes]
			,[SageThemes]
			,[NPKeywords]
			,[ChannelID]
		)
	select	s.NewPimProductTranslationID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[LocaleID]
			,m.[NPProductName]
			,m.[Name]
			,m.[Description]
			,m.[SubHeader]
			,m.[LongDescriptionCopy]
			,m.[WebName]
			,m.[Material]
			,m.[Keywords]
			,m.[NPurl]
			,m.[SEOTitle]
			,m.[SEODescription]
			,m.[SEOText]
			,m.[NPWebNotes]
			,m.[SageThemes]
			,m.[NPKeywords]
			,m.[ChannelID]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductTranslations s
		join PIM_Import.dbo.ProductTranslations m
			on s.CurrentImportProductTranslationID = m.ID
			
	set identity_insert ProductTranslations off
end
-- ProductTranslations End


-- ProductWebSpecs Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductWebSpecs)
begin
	set identity_insert ProductWebSpecs on

	insert ProductWebSpecs
		(
			 [ID]
			,[ProductID]
			,[Priority]
			,[Key]
			,[Value]
		)
	select	s.NewPimProductWebSpecID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[Priority]
			,m.[Key]
			,m.[Value]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductWebSpecs s
		join PIM_Import.dbo.ProductWebSpecs m
			on s.CurrentImportProductWebSpecID = m.ID
			
	set identity_insert ProductWebSpecs off
end
-- ProductWebSpecs End


-- ProductAccessories Start
if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_Import_ProductAccessories)
begin
	set identity_insert ProductAccessories on

	insert ProductAccessories
		(
			 [ID]
			,[ProductID]
			,[QtyMatch]
			,[RelationTypeID]
			,[RelatedProductID]
			,[MCPUpdated]
		)
	select	s.NewPimProductAccessoryID as [ID]
			,isnull(s.NewProductID,m.ProductID) as [ProductID]
			,m.[QtyMatch]
			,m.[RelationTypeID]
			,s.RelatedProductID as [RelatedProductID]
			,m.[MCPUpdated]
	from PIM_ETL_STAGE.dbo.Stage_Import_ProductAccessories s
		join PIM_Import.dbo.ProductAccessories m
			on s.CurrentImportProductAccessoryID = m.ID
			
	set identity_insert ProductAccessories off
end
-- ProductAccessories End



DONE:


GO
