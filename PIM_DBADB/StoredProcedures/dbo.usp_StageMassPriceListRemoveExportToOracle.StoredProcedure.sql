CREATE Procedure [dbo].[usp_StageMassPriceListRemoveExportToOracle]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50)
	
as

set nocount on


if @ExtractCompleted = '4'
begin
	Delete dbo.Stage_MassPriceListForCSVExport where 1 = 1
end




GO
