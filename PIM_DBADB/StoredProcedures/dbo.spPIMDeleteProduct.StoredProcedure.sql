--#endregion
-- ================================================
-- This script will ..
--	Delete an existing product from Products table and all associated tables.
-- ================================================
CREATE PROCEDURE [dbo].[spPIMDeleteProduct]
	@ProductID			int,
	@DeleteProduct		varchar(1)
AS
BEGIN
       SET NOCOUNT ON;
	   SET XACT_ABORT ON;
       ----------------------------------------------------------------------------------------
       --     Declare/set defaults
       ----------------------------------------------------------------------------------------
       Declare       @error varchar(max)
       
       Begin Try
              Begin Tran
              ----------------------------------------------------------------------------------------
              --     Delete
              ----------------------------------------------------------------------------------------
              Delete ProductAccessories where ProductID = @ProductID
              Delete ProductAccessories where RelatedProductID = @ProductID

              Delete ProductArtTemplates where ProductID = @ProductID

              Delete ProductSkuAttributes where ProductID = @ProductID
              Delete ProductSKUBillofMaterials where ProductID = @ProductID
              Delete ProductSkuChannels where ProductID = @ProductID
              Delete ProductSKUs where ProductID = @ProductID

              Delete ProductAttributeSizes where ProductID = @ProductID
              Delete ProductAttributeTypeTranslations where ProductID = @ProductID
              Delete ProductAttributeTypes where ProductID = @ProductID
              Delete ProductAttributeColorTranslations where ProductID = @ProductID
              Delete ProductAttributeColors where ProductID = @ProductID
              Delete ProductAttributeTranslations where ProductID = @ProductID
              Delete ProductAttributes where ProductID = @ProductID

              Delete ProductSubCategoryTranslations where ProductID = @ProductID
              Delete ProductSubCategories where ProductID = @ProductID

              Delete ProductCategoryTranslations where ProductID = @ProductID
              Delete ProductCategories where ProductID = @ProductID

              Delete ProductDesignTranslations where ProductID = @ProductID
              Delete ProductDesigns where ProductID = @ProductID

              Delete ProductFOBPriceTiers where ProductID = @ProductID
              Delete ProductFOBAdditionalCharges where ProductID = @ProductID
              Delete ProductFOBMaterialCosts where ProductID = @ProductID
              Delete ProductFOBs where ProductID = @ProductID

              Delete ProductImages where ProductID = @ProductID

              Delete ProductImprintAreaColorTranslations where ProductID = @ProductID
              Delete ProductImprintAreaColors where ProductID = @ProductID
              Delete ProductImprintAreaFontTranslations where ProductID = @ProductID
              Delete ProductImprintAreaFonts where ProductID = @ProductID
              Delete ProductImprintAreaStyles where ProductID = @ProductID
              Delete ProductImprintAreaTranslations where ProductID = @ProductID
              Delete ProductImprintAreas where ProductID = @ProductID

              Delete ProductMerchCategories where ProductID = @ProductID
              Delete ProductMerchCatKeys where ProductID = @ProductID

              Delete ProductPackagingDetails where ProductID = @ProductID

              Delete ProductShipOrgs where ProductID = @ProductID

              Delete ProductTranslations where ProductID = @ProductID

              if @DeleteProduct = 'Y' Begin
                     Delete ProductWebSpecs where ProductID = @ProductID
                     Delete ProductSpecialCharacters where ProductID = @ProductID
                     Delete ProductSpecs where ProductID = @ProductID
                     Delete BatchProductInfo where ProductID = @ProductID
                     Delete ProductChannels where ProductID = @ProductID

                     Delete ProductFamilyChannels where ProductID = @ProductID
                     Delete ProductFamilys where ProductID = @ProductID

					Delete ProductJigs where ProductID = @ProductID

                     Delete ProductPriceListChargeTranslations where ProductID = @ProductID
                     Delete ProductPriceListCharges where ProductID = @ProductID
                     Delete ProductPriceListTiers where ProductID = @ProductID
                     Delete ProductPriceLists where ProductID = @ProductID

                     Delete ProductRevisions where ProductID = @ProductID
                     Delete ProductSpecialNotes where ProductID = @ProductID

                     Delete ProductBatches where ProductID = @ProductID
                     Delete Products where ID = @ProductID
              end

       End Try
       Begin Catch   
              IF @@TRANCOUNT > 0 ROLLBACK TRAN
              set @error = @@error
              select @error
       End Catch
       
       IF @@TRANCOUNT > 0 Begin
              commit tran
              select 'ok'
       End
End

GO
