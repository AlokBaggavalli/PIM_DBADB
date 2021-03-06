CREATE Procedure [dbo].[usp_GetBatchParam]
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
		@BatchDir	varchar(200)
		
--set @Dir = '\\npcifs\PIM_Extractions\PIMMExtract'
--set @BatchDir = '\\npcifs\PIM_Extractions\PIMMBatch'

set @Dir = '\\pens.com\dfs01\Applications\PIM\PIM_Extractions\PIMMExtract'
set @BatchDir = '\\pens.com\dfs01\Applications\PIM\PIM_Extractions\PIMMBatch'


if @BatchType = '2'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpec.xls'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpec.xls'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '3'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\Hexcode_Process\' + @BatchID + '_' + 'Hexcode.xlsx'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'Hexcode.xlsx'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '4'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ProductXML_Process\' + @BatchID + '_' + 'catalogdata.xml'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'catalogdata.xml'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '5'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\OracleSKU_Process\' + @BatchID + '_' + 'Items.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'Items.csv'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '6'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ProductInfo_Process\' + @BatchID + '_' + 'ProductInfo.xls'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductInfo.xls'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '7'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\PriceList_Process\' + @BatchID + '_' + 'Pricelist.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'Pricelist.csv'
	select @FileToRenamePriority = @Dir + '\PriceList_Process\' + @BatchID + '_' + 'atgpricelistdata.xml'
	select @CopyFileToPriority = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'atgpricelistdata.xml'
end


if @BatchType = '8'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\DesignXML_Process\' + @BatchID + '_' + 'Designdata.xml'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'Designdata.xml'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end



if @BatchType = '9'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ExtraCharges_Process\' + @BatchID + '_' + 'ExtraCharges.xls'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ExtraCharges.xls'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '10'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ItemSchematic_Process\' + @BatchID + '_' + 'ItemSchematic.txt'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ItemSchematic.txt'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '13'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\BlanketPO_Process\' + @BatchID + '_' + 'BlanketPO.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'BlanketPO.csv'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '14'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\MasterDataSheet_Process\' + @BatchID + '_' + 'PIM_PRODUCT_Data_Spreadsheet.xlsx'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'PIM_PRODUCT_Data_Spreadsheet.xlsx'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end



if @BatchType = '15'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ProductBPA_Process\' + @BatchID + '_' + 'BPA_Charges.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'BPA_Charges.csv'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end


if @BatchType = '20'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\OracleBOM_Process\' + @BatchID + '_' + 'OracleBOM.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'OracleBOM.csv'
	select @FileToRenamePriority = @Dir + '\OracleBOM_Process\' + @BatchID + '_' + 'Routings_LoadFile.csv'
	select @CopyFileToPriority = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'Routings_LoadFile.csv'
end




if @BatchType = '26'
begin
	select @DirToCreate = @BatchDir + '\' + @BatchID
	select @FileToRename = @Dir + '\ReconcilePrecheck_Process\' + @BatchID + '_' + 'ReconcilePrecheck.csv'
	select @CopyFileTo = @BatchDir + '\' + @BatchID + '\' + @BatchID + '_' + 'ReconcilePrecheck.csv'
	select @FileToRenamePriority = @Dir + '\ProductSpec_Process\' + @BatchID + '_' + 'ProductSpecPriority.xls'
	select @CopyFileToPriority = @Dir + '\' + @BatchID + '\' + @BatchID + '_' + 'ProductSpecPriority.xls'
end










GO
