CREATE Procedure [dbo].[usp_StageProductPriceListRemoveExportToOracle]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50)
	
as

set nocount on


if @ExtractCompleted in('4','8')
begin
	Delete PIM_ETL_STAGE.dbo.Stage_ProductPriceListForCSVExport where BatchID = @BatchID
end
