CREATE Procedure [dbo].[usp_Stage_MassPriceList_Delete]
	@BatchID			varchar(10)
	
As

set nocount on


delete Stage_MassPriceListForCSVExport


delete Stage_MassPriceListForXMLExport








GO
