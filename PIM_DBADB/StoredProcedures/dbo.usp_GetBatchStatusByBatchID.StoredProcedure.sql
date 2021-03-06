Create Procedure [dbo].[usp_GetBatchStatusByBatchID]
	@BatchType				varchar(50),
	@BatchID				varchar(10),
	@ExtractCompleted		varchar(50) output,
	@ExtractRunning			varchar(50) output
	
as

set nocount on


declare @CurrentExtractStatus	int

-- Check Current Extract Status
select @CurrentExtractStatus = [Status] from BatchExtracts where BatchID = @BatchID and [Type] = @BatchType

if @CurrentExtractStatus = 1
begin
	select @ExtractCompleted = '3'
	select @ExtractRunning = '2'
end

if @CurrentExtractStatus = 5
begin
	select @ExtractCompleted = '7'
	select @ExtractRunning = '6'
end
GO
