CREATE Procedure [dbo].[usp_Stage_ProductPriceList_Delete]
	@BatchID			varchar(10)
	
As

set nocount on


delete PIM_ETL_STAGE.dbo.Stage_ProductPriceListForCSVExport
where BatchID = @BatchID



delete PIM_ETL_STAGE.dbo.Stage_ProductPriceListForXMLExport
where BatchID = @BatchID






GO
