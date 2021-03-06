Create Procedure [dbo].[usp_ImportTransfer_Delete]

as

set nocount on


-- BatchExtractPartial Start
delete m
from BatchExtractPartial m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'BatchExtractPartial'
-- BatchExtractPartial End


-- ProductAccessories Start
delete m
from ProductAccessories m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAccessories'
-- ProductAccessories End


-- ProductArtTemplates Start
delete m
from ProductArtTemplates m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductArtTemplates'
-- ProductArtTemplates End


-- ProductAttributeColorTranslations Start
delete m
from ProductAttributeColorTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeColorTranslations'
-- ProductAttributeColorTranslations End


-- ProductAttributeColors Start
delete m
from ProductAttributeColors m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeColors'
-- ProductAttributeColors End


-- ProductAttributeSizes Start
delete m
from ProductAttributeSizes m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeSizes'
-- ProductAttributeSizes End


-- ProductAttributeTypeTranslations Start
delete m
from ProductAttributeTypeTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeTypeTranslations'
-- ProductAttributeTypeTranslations End


-- ProductAttributeTypes Start
delete m
from ProductAttributeTypes m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeTypes'
-- ProductAttributeTypes End


-- ProductAttributeTranslations Start
delete m
from ProductAttributeTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributeTranslations'
-- ProductAttributeTranslations End


-- ProductAttributes Start
delete m
from ProductAttributes m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductAttributes'
-- ProductAttributes End


-- ProductBatches Start
delete m
from ProductBatches m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductBatches'
-- ProductBatches End


-- ProductChannels Start
delete m
from ProductChannels m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductChannels'
-- ProductChannels End


-- ProductDesignTranslations Start
delete m
from ProductDesignTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductDesignTranslations'
-- ProductDesignTranslations End


-- ProductDesigns Start
delete m
from ProductDesigns m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductDesigns'
-- ProductDesigns End


-- ProductFamilyChannels Start
delete m
from ProductFamilyChannels m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFamilyChannels'
-- ProductFamilyChannels End


-- ProductFamilys Start
delete m
from ProductFamilys m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFamilys'
-- ProductFamilys End


-- ProductFOBAdditionalCharges Start
delete m
from ProductFOBAdditionalCharges m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFOBAdditionalCharges'
-- ProductFOBAdditionalCharges End


-- ProductFOBCostComponents Start
delete m
from ProductFOBCostComponents m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFOBCostComponents'
-- ProductFOBCostComponents End


-- ProductFOBMaterialCosts Start
delete m
from ProductFOBMaterialCosts m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFOBMaterialCosts'
-- ProductFOBMaterialCosts End


-- ProductFOBPriceTiers Start
delete m
from ProductFOBPriceTiers m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFOBPriceTiers'
-- ProductFOBPriceTiers End


-- ProductFOBs Start
delete m
from ProductFOBs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductFOBs'
-- ProductFOBs End


-- ProductImages Start
delete m
from ProductImages m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImages'
-- ProductImages End


-- ProductImprintAreaColorTranslations Start
delete m
from ProductImprintAreaColorTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaColorTranslations'
-- ProductImprintAreaColorTranslations End


-- ProductImprintAreaColors Start
delete m
from ProductImprintAreaColors m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaColors'
-- ProductImprintAreaColors End


-- ProductImprintAreaFontTranslations Start
delete m
from ProductImprintAreaFontTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaFontTranslations'
-- ProductImprintAreaFontTranslations End


-- ProductImprintAreaFonts Start
delete m
from ProductImprintAreaFonts m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaFonts'
-- ProductImprintAreaFonts End


-- ProductImprintAreaLasers Start
delete m
from ProductImprintAreaLasers m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaLasers'
-- ProductImprintAreaLasers End


-- ProductImprintAreaStyles Start
delete m
from ProductImprintAreaStyles m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaStyles'
-- ProductImprintAreaStyles End


-- ProductImprintAreaTranslations Start
delete m
from ProductImprintAreaTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreaTranslations'
-- ProductImprintAreaTranslations End


-- ProductImprintAreas Start
delete m
from ProductImprintAreas m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductImprintAreas'
-- ProductImprintAreas End


-- ProductJigs Start
delete m
from ProductJigs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductJigs'
-- ProductJigs End


-- ProductMerchCatKeys Start
delete m
from ProductMerchCatKeys m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductMerchCatKeys'
-- ProductMerchCatKeys End


-- ProductMerchCategories Start
delete m
from ProductMerchCategories m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductMerchCategories'
-- ProductMerchCategories End


-- ProductPackagingDetails Start
delete m
from ProductPackagingDetails m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductPackagingDetails'
-- ProductPackagingDetails End


-- ProductPriceListChargeTranslations Start
delete m
from ProductPriceListChargeTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductPriceListChargeTranslations'
-- ProductPriceListChargeTranslations End


-- ProductPriceListCharges Start
delete m
from ProductPriceListCharges m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductPriceListCharges'
-- ProductPriceListCharges End


-- ProductPriceListTiers Start
delete m
from ProductPriceListTiers m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductPriceListTiers'
-- ProductPriceListTiers End


-- ProductPriceLists Start
delete m
from ProductPriceLists m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductPriceLists'
-- ProductPriceLists End


-- ProductRevisions Start
delete m
from ProductRevisions m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductRevisions'
-- ProductRevisions End


-- ProductShipOrgs Start
delete m
from ProductShipOrgs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductShipOrgs'
-- ProductShipOrgs End


-- ProductSkuAttributes Start
delete m
from ProductSkuAttributes m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSkuAttributes'
-- ProductSkuAttributes End


-- ProductSkuBillOfMaterials Start
delete m
from ProductSkuBillOfMaterials m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSkuBillOfMaterials'
-- ProductSkuBillOfMaterials End


-- ProductSkuChannels Start
delete m
from ProductSkuChannels m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSkuChannels'
-- ProductSkuChannels End


-- ProductSkuImages Start
delete m
from ProductSkuImages m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSkuImages'
-- ProductSkuImages End


-- ProductSKUs Start
delete m
from ProductSKUs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSKUs'
-- ProductSKUs End


-- ProductSpecialCharacters Start
delete m
from ProductSpecialCharacters m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSpecialCharacters'
-- ProductSpecialCharacters End


-- ProductSpecialNotes Start
delete m
from ProductSpecialNotes m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSpecialNotes'
-- ProductSpecialNotes End


-- ProductSpecsStart
delete m
from ProductSpecs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSpecs'
-- ProductSpecs End


-- ProductSubCategoryTranslations
delete m
from ProductSubCategoryTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSubCategoryTranslations'
-- ProductSubCategoryTranslations End


-- ProductSubCategories
delete m
from ProductSubCategories m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductSubCategories'
-- ProductSubCategories End


-- ProductCategoryTranslations Start
delete m
from ProductCategoryTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductCategoryTranslations'
-- ProductCategoryTranslations End


-- ProductCategories Start
delete m
from ProductCategories m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductCategories'
-- ProductCategories End


-- ProductTranslations
delete m
from ProductTranslations m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductTranslations'
-- ProductTranslations End


-- ProductWebSpecs
delete m
from ProductWebSpecs m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductWebSpecs'
-- ProductWebSpecs End


-- ProductWFStatus
delete m
from ProductWFStatus m
	join PIM_ETL_STAGE.dbo.Stage_Import_ProductsDependentTables_Actions t
		on m.ID = t.DestTableID
where t.TableName = 'ProductWFStatus'
-- ProductWFStatus End


GO
