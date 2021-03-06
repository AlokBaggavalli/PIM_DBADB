CREATE Procedure [dbo].[usp_ImportManager_Update]
	@Type	int 
	
as

set nocount on


If @Type = 1
begin
	update m
	set UpdateStart = GETDATE()
	from ImportManager m
		join PIM_ETL_STAGE.dbo.Stage_Import_SuppliersToProcess s
			on m.ID = s.ImportManagerID
end


If @Type = 2
begin
	update m
	set UpdateEnd = GETDATE(),
		StatusID = 4
	from ImportManager m
		join PIM_ETL_STAGE.dbo.Stage_Import_SuppliersToProcess s
			on m.ID = s.ImportManagerID
end


If @Type = 6
begin
	update m
	set UpdateEnd = GETDATE(),
		StatusID = 6
	from ImportManager m
		join PIM_ETL_STAGE.dbo.Stage_Import_SuppliersToProcess s
			on m.ID = s.ImportManagerID
end

GO
