CREATE Procedure [dbo].[usp_Stage_OracleBOMForExport_Delete]
	@BatchID			varchar(10)
	
As

set nocount on

delete PIM_ETL_STAGE.dbo.Stage_OracleBOMForExport
where BatchID = @BatchID







GO
