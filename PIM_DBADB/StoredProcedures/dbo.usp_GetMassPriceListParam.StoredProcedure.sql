CREATE Procedure [dbo].[usp_GetMassPriceListParam]
	@BatchType				varchar(50),
	@BatchID				varchar(10),
	@DirToCreate			varchar(200) output,
	@FileToRename			varchar(200) output,
	@CopyFileTo				varchar(200) output,
	@FileToRenamePriority	varchar(200) output,
	@CopyFileToPriority		varchar(200) output

as

set nocount on

declare @Dir		varchar(200),
		@BatchDir	varchar(200),
		@Servername	varchar(200),
		@Date		varchar(8)
		
		
select @Servername = @@SERVERNAME
select @Date = CONVERT(varchar(8),GETDATE(),112)
		
--set @Dir = '\\npcifs\PIM_Extractions\PIMMExtract'
set @Dir = '\\Pens.com\dfs01\Applications\PIM\PIM_Extractions\PIMMExtract'

if @Servername = 'NPPRDPIMDB01'
begin
	--set @BatchDir = '\\npcifs\PIM_Extractions\PIMMBatch\MassPriceUpdate\PROD\'
	set @BatchDir = '\\Pens.com\dfs01\Applications\PIM\PIM_Extractions\PIMMBatch\MassPriceUpdate\PROD\'
end
else
begin
	--set @BatchDir = '\\npcifs\PIM_Extractions\PIMMBatch\MassPriceUpdate\TEST\'
	set @BatchDir = '\\Pens.com\dfs01\Applications\PIM\PIM_Extractions\PIMMBatch\MassPriceUpdate\TEST\'
end




if @BatchType = '100'
begin
	select @DirToCreate = @BatchDir + '\' + @Date
	select @FileToRename = @Dir + '\MassPriceUpdate_Process\' + @Date + '_' + 'MassPricelist.csv'
	select @CopyFileTo = @BatchDir + '\' + @Date + '\' + @Date + '_' + 'MassPricelist.csv'
	select @FileToRenamePriority = @Dir + '\MassPriceUpdate_Process\' + @Date + '_' + 'massatgpricelistdata.xml'
	select @CopyFileToPriority = @BatchDir + '\' + @Date + '\' + @Date + '_' + 'massatgpricelistdata.xml'
end










GO
