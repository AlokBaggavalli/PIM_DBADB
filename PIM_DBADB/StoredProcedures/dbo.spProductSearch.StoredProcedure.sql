-- ================================================
-- This script will ..
--	return products found depending on parameters.
-- ================================================
CREATE PROCEDURE [dbo].[spProductSearch]
	@SupplierID			int,
	@USAMade			varchar(1),
	@Material			varchar(max),
	@COO				varchar(10),
	@SkuPartNumber		varchar(60),
	@SkuDescription		varchar(255),
	@Catagory			varchar(100),
	@SubCatagory		varchar(100),
	@Keyword			varchar(60),
	@ImpAreaMethod		varchar(255),
	@ImpAreaColor		varchar(255),
	@ImpAreaMaxLines	int,
	@ImpAreaMaxChars	int,
	@SeqStart		varchar(6),
	@PerPage		varchar(3),
	@PreviousPage	varchar(1)	
AS
BEGIN
	SET NOCOUNT ON;
	
--#region Testing
/* Testing

use pid
declare 	
	@SupplierID			int,
	@USAMade			varchar(1),
	@Material			varchar(max),
	@COO				varchar(10),
	@SkuPartNumber		varchar(60),
	@SkuDescription		varchar(255),
	@Catagory			varchar(100),
	@SubCatagory		varchar(100),
	@Keyword			varchar(60),
	@ImpAreaMethod		varchar(255),
	@ImpAreaColor		varchar(255),
	@ImpAreaMaxLines	int,
	@ImpAreaMaxChars	int		
	
set	@SupplierID			= 61125
set	@USAMade			= 'Y'
set	@Material			= 'test'
set	@COO				= 'cn'
set	@SkuPartNumber		= ''
set	@SkuDescription		= ''
set	@Catagory			= ''
set	@SubCatagory		= ''
set	@Keyword			= ''
set	@ImpAreaMethod		= ''
set	@ImpAreaColor		= ''
set	@ImpAreaMaxLines	= 0
set	@ImpAreaMaxChars	= 0

exec spProductSearch @SupplierID, @USAMade, @Material, @COO, @SkuPartNumber, @SkuDescription, @Catagory, @SubCatagory, @Keyword, @ImpAreaMethod, @ImpAreaColor, @ImpAreaMaxLines, @ImpAreaMaxChars

*/
--#endregion

----------------------------------------------------------------------------------------
--	Declare/set defaults
----------------------------------------------------------------------------------------
declare	
	@Select			varchar(1000),
	@From			varchar(1000),
	@Where			varchar(1000),
	@OrderBy		varchar(500),
	@Distinct		varchar(8),
	@TopNumber		varchar(10)
	
set	@Distinct		= 'Distinct'
set @Where			= ''	
set @OrderBy		= ''

----------------------------------------------------------------------------------------
--	Conditionals
----------------------------------------------------------------------------------------
--#region Conditionals
if @USAMade <> '' Begin
	set @Where = @Where + ' and p.UsaMade'
	if charindex('Equals|', @USAMade) > 0 set @USAMade = replace(@USAMade, 'Equals|', ' = ''')
	if charindex('Not Equals|', @USAMade) > 0 set @USAMade = replace(@USAMade, 'Not Equals|', ' <> ''')
	if charindex('Like|', @USAMade) > 0 set @USAMade = replace(@USAMade, 'Like|', ' Like ''%')
	set @Where = @Where + @USAMade + ''''
end
if @Material <> '' Begin
	set @Where = @Where + ' and p.Material like ''%' + @Material + '%'''
end
if @COO <> '' Begin
	set @Where = @Where + ' and p.Coo like ''%' + @COO + '%'''
end
if @SkuPartNumber <> '' Begin
	set @Where = @Where + ' and sku.PartNumber like ''%' + @SkuPartNumber + '%'''
end
if @SkuDescription <> '' Begin
	set @Where = @Where + ' and sku.Description like ''%' + @SkuDescription + '%'''
end
if @Catagory <> '' Begin
	set @Where = @Where + ' and pc.Name like ''%' + @Catagory + '%'''
end
if @SubCatagory <> '' Begin
	set @Where = @Where + ' and psc.Name like ''%' + @SubCatagory + '%'''
end
if @Keyword <> '' Begin
	set @Where = @Where + ' and pk.Name like ''%' + @Keyword + '%'''
end
if @ImpAreaMethod <> '' Begin
	set @Where = @Where + ' and pia.Method like ''%' + @ImpAreaMethod + '%'''
end
if @ImpAreaColor <> '' Begin
	set @Where = @Where + ' and c.Name like ''%' + @ImpAreaColor + '%'''
end
if @ImpAreaMaxLines <> '' Begin
	set @Where = @Where + ' and pia.MaxLines = ''' + cast(@ImpAreaMaxLines as varchar) + ''''
end
if @ImpAreaMaxChars <> '' Begin
	set @Where = @Where + ' and pia.MaxChars = ''' + cast(@ImpAreaMaxChars as varchar) + ''''
end

--set @SeqStartWhere = ' and lm.seqno >= ' + @SeqStart + ' '
--if @PreviousPage = 'Y' set @SeqStartWhere = ' and lm.seqno <= ' + @SeqStart + ' '
--if @PreviousPage = 'Y' set @PrevPageWhere = ' desc '

--#endregion
----------------------------------------------------------------------------------------
--	Build query
----------------------------------------------------------------------------------------
--set @Select = ' Select distinct top 10 p.VendorProductID, p.Name ProductName, p.NPProductCode, pc.Name Category'
set @Select = ' Select ' + @Distinct + ' top ' + @PerPage + ' p.VendorProductID, p.Name ProductName, p.NPProductCode, pc.Name Category '

set @From =
	' from Products p ' +
	' join ProductSKUs sku			on sku.ProductID = p.ID ' +
	' join ProductCategories pc		on pc.ProductID = p.ID ' +
	' join ProductSubCategories psc	on psc.ProductCategoryID = pc.ID ' +
	' join ProductKeywords pk		on pk.ProductID = p.ID ' +
	' join ProductImprintAreas pia	on pia.ProductID = p.ID ' +
	' join ProductImprintAreaColors c on c.ProductImprintAreaID = pia.ID '

set @Where = ' Where p.SupplierID = ' + cast(@SupplierID as varchar) + @Where

set @OrderBy = ' Order by p.VendorProductID '

insert into DebugLog select @select
insert into DebugLog select @from
insert into DebugLog select @where
insert into DebugLog select @Orderby

Declare @SelectLine nvarchar(4000)
set @SelectLine = @select + @from + @where + @orderby

exec sp_executesql @SelectLine
	
End
GO
