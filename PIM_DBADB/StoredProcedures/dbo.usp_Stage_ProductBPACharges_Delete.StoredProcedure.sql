CREATE Procedure [dbo].[usp_Stage_ProductBPACharges_Delete]
	@BatchID			varchar(10)
	
As

set nocount on


delete PIM_ETL_STAGE.dbo.Stage_ProductBPACharges
where BatchID = @BatchID










GO
