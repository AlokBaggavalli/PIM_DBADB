CREATE Procedure [dbo].[usp_Stage_OracleSKUForExport_Delete]
	@BatchID			varchar(10)
	
As

set nocount on

delete PIM_ETL_STAGE.dbo.Stage_OracleSKUForExport
where BatchID = @BatchID

delete PIM_ETL_STAGE.dbo.Stage_OracleSKUForEBSExport
where BatchID = @BatchID




GO
