Create Procedure [dbo].[usp_GetTableIdentity]
	@TableName			varchar(200),
	@CurrentIdentity	int output
	
as

set nocount on

declare @DBName			varchar(100),
		@FullTableName	varchar(200)

select @DBName = DB_NAME()

select @FullTableName = @DBName + '.dbo.' + @TableName


select @CurrentIdentity = ident_current(@FullTableName)
GO
