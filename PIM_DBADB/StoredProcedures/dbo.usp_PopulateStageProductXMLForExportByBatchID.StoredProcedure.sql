CREATE Procedure [dbo].[usp_PopulateStageProductXMLForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @DataHolder		Table	(
									UniqueID				int identity(1,1) Primary Key,
									ProductCode				varchar(100),
									ItemID					varchar(50),
									Item					varchar(50),
									[Description]			varchar(200),
									[Status]				varchar(50),
									OrgName					varchar(50),
									OrgStatus				varchar(50),
									OracleLevel1			varchar(100),
									OracleLevel2			varchar(100),
									OracleLevel3			varchar(100),
									OracleLevel4			varchar(100),
									Colors					nvarchar(300)
								)

declare @XMLFinal	Table	(
								UniqueID				int identity(1,1) Primary Key,
								LineVal					varchar(250)
							)
							
declare @Product	Table	(
								ProductID				int identity(1,1) Primary Key,
								ProductCode				varchar(100)
							)
							
declare @SkuColor	Table	(
								UniqueID				int identity(1,1) Primary Key,
								DataHolderID			int,
								ColorProp				varchar(300),
								ColorString				nvarchar(300),
								OrigColorString			nvarchar(300),
								PropNameOrder			int,
								PropName				varchar(100),
								SKU						varchar(50)
							)
							
declare @SkuColorHold	Table	(
									UniqueID			int identity(1,1) Primary Key,
									DataHolderID		int,
									ColorString			nvarchar(300),
									SKU					varchar(50)
								)
								
declare @SkuColorHold2	Table	(
									UniqueID			int identity(1,1) Primary Key,
									DataHolderID		int,
									ColorString			nvarchar(300),
									OrigColorString		nvarchar(300),
									SKU					varchar(50)
								)

							
declare @UniqueID				int,
		@ProductCode			varchar(100),
		@ItemID					varchar(50),
		@Item					varchar(50),
		@Description			varchar(200),
		@Status					varchar(50),
		@OrgName				varchar(50),
		@OrgStatus				varchar(50),
		@OracleLevel1			varchar(100),
		@OracleLevel2			varchar(100),
		@OracleLevel3			varchar(100),
		@OracleLevel4			varchar(100),
		@Header1				varchar(100),
		@Header2				varchar(100),
		@Header3				varchar(100),
		@Header2_E				varchar(100),
		@Header3_E				varchar(100),
		@ProductID				int,		
		@LocaleID				int,
		@Type					varchar(50),
		@MinID					int,
		@BatchStatus			int,
		@ColorString			nvarchar(300),
		@OrigColorString		nvarchar(300),
		@DataHolderID			int,
		@ColorProp				varchar(300),
		@PropName				varchar(100),
		@PropNameOrder			int,
		@SkuColorUniqueID		int,
		@LastDataHolderID		int,
		@LastPropNameOrder		int,
		@SKU					varchar(50)
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '4'


select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('2','6')
				)


select @BatchStatus = [Status] from BatchExtracts where ID = @MinID

		
set @Header1 = '<?xml version="1.0"?>'
set @Header2 = '<products xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"> '
set @Header3 = '  <skus>'
set @Header2_E = '</products>'
set @Header3_E = '  </skus>'



if @BatchStatus = 2
begin
	insert @DataHolder		
	(
		ProductCode,
		ItemID,
		Item,
		[Description],
		[Status],
		OrgName,
		OrgStatus,
		OracleLevel1,
		OracleLevel2,
		OracleLevel3,
		OracleLevel4,
		Colors
	)
	select	p.NPProductCode as ProductCode,
			' ' as ItemID,
			ps.OracleID as Item,
			ps.OracleDesc as [Description],
			'ACTIVE' AS [Status],
			'PPC' as OrgName,
			'ACTIVE' as OrgStatus,
			--OracleCatalog1 as OracleLevel1,
			--OracleCatalog2 as OracleLevel2,
			--OracleCatalog3 as OracleLevel3,
			--OracleCatalog4 as OracleLevel4
			cc1.[Description] as OracleLevel1,
			cc2.[Description] as OracleLevel2,
			cc3.[Description] as OracleLevel3,
			cc4.[Description] as OracleLevel4,
			ps.Colors
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
				and ps.SkuFormatID = 1
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join CategoryCodes cc3
			on p.OracleCatalog3 = cc3.ID
		left join CategoryCodes cc4
			on p.OracleCatalog4 = cc4.ID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end



if @BatchStatus = 6
begin
	insert @DataHolder		
	(
		ProductCode,
		ItemID,
		Item,
		[Description],
		[Status],
		OrgName,
		OrgStatus,
		OracleLevel1,
		OracleLevel2,
		OracleLevel3,
		OracleLevel4,
		Colors
	)
	select	p.NPProductCode as ProductCode,
			' ' as ItemID,
			ps.OracleID as Item,
			ps.OracleDesc as [Description],
			'ACTIVE' AS [Status],
			'PPC' as OrgName,
			'ACTIVE' as OrgStatus,
			--OracleCatalog1 as OracleLevel1,
			--OracleCatalog2 as OracleLevel2,
			--OracleCatalog3 as OracleLevel3,
			--OracleCatalog4 as OracleLevel4
			cc1.[Description] as OracleLevel1,
			cc2.[Description] as OracleLevel2,
			cc3.[Description] as OracleLevel3,
			cc4.[Description] as OracleLevel4,
			ps.Colors
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductSKUs ps
			on p.ID = ps.ProductID
				and ps.SkuFormatID = 1
		left join CategoryCodes cc1
			on p.OracleCatalog1 = cc1.ID
		left join CategoryCodes cc2
			on p.OracleCatalog2 = cc2.ID
		left join CategoryCodes cc3
			on p.OracleCatalog3 = cc3.ID
		left join CategoryCodes cc4
			on p.OracleCatalog4 = cc4.ID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[SkuID] = ps.ID
	where be.[Status] = '6'
		and be.ID = @MinID
	order by p.ID
end



--update t
--set t.ItemID = opi.InventoryItemID
--from @DataHolder t
--	join OracleProductItems opi
--		on t.Item = opi.ItemCode
--			and opi.WarehouseId = 1


update t
set t.ItemID = opi.ItemID
from @DataHolder t
	join PIM_ETL_STAGE.dbo.Stage_OracleItem opi
		on t.Item = opi.Item
where opi.ItemID is not null




if exists(select * from @DataHolder where ItemID = ' ')
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '4'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '8'
	end
end
else
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '3'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '7'
	end
end



insert @Product(ProductCode)
select	distinct ProductCode
from @DataHolder



insert @SkuColorHold
	(
		DataHolderID,
		ColorString,
		SKU
	)
select	UniqueID as DataHolderID,
		Colors,
		Item as SKU 
from @DataHolder
order by UniqueID


set @UniqueID = 0
set @DataHolderID = 0
set @ColorString = ''
set @OrigColorString = ''
set @SKU = ''

while exists(select top 1 UniqueID from @SkuColorHold)
begin
	select	@UniqueID = (select top 1 UniqueID from @SkuColorHold order by UniqueID)
	select	@DataHolderID = DataHolderID,
			@OrigColorString = ColorString,
			@SKU = SKU
	from @SkuColorHold
	where UniqueID = @UniqueID
	
	
	insert @SkuColorHold2
		(
			DataHolderID,
			ColorString,
			OrigColorString,
			SKU
		)
	select	@DataHolderID,
			Data,
			@OrigColorString,
			@SKU
	from dbo.Split(@OrigColorString,',')
	order by ID
	
	
	delete @SkuColorHold where UniqueID = @UniqueID
end


set @UniqueID = 0
set @DataHolderID = 0
set @ColorString = ''
set @OrigColorString = ''
set @SKU = ''

while exists(select top 1 UniqueID from @SkuColorHold2)
begin
	select	@UniqueID = (select top 1 UniqueID from @SkuColorHold2 order by UniqueID)
	select	@DataHolderID = DataHolderID,
			@ColorString = ColorString,
			@OrigColorString = OrigColorString,
			@SKU = SKU
	from @SkuColorHold2
	where UniqueID = @UniqueID
	
	
	insert @SkuColor
		(
			DataHolderID,
			ColorProp,
			ColorString	,
			OrigColorString,
			PropNameOrder,
			SKU
		)
	select	@DataHolderID,
			Upper(Data) as Data,
			@ColorString,
			@OrigColorString,
			ID,
			@SKU
	from dbo.Split(@ColorString,'.')
	order by ID
	
	
	delete @SkuColorHold2 where UniqueID = @UniqueID	
end


update @SkuColor
set PropName = 'propName'
where PropNameOrder = 1

update @SkuColor
set PropName = 'colorCode'
where PropNameOrder = 2

update @SkuColor
set PropName = 'color'
where PropNameOrder = 3

update @SkuColor
set PropName = 'colorHexCode'
where PropNameOrder = 4


update @SkuColor
set ColorProp = replace(ColorProp,'#','0x')
where PropNameOrder = 4



--select * from @Product
--select * from @DataHolder
--select * from @SkuColor


set @UniqueID = 0
set @ColorProp = ''
set @PropName = ''
set @DataHolderID = 0
set @PropNameOrder = 0
set @SkuColorUniqueID = 0
set @LastDataHolderID = 0
set @LastPropNameOrder = 0




insert @XMLFinal(LineVal)
values(@Header1)
insert @XMLFinal(LineVal)
values(@Header2)
insert @XMLFinal(LineVal)
values(@Header3)


while exists(select top 1 ProductID from @Product)
begin
	select	@ProductID = (select top 1 ProductID from @Product order by ProductID)
	select	@ProductCode = ProductCode from @Product where ProductID = @ProductID

	
	while exists(select top 1 UniqueID from @DataHolder where ProductCode = @ProductCode)
	begin
		select	@UniqueID = (select top 1 UniqueID from @DataHolder where ProductCode = @ProductCode order by UniqueID)
		select	@ItemID = ItemID,
				@Item = Item,
				@Description = [Description],
				@Status = [Status],
				@OrgName = OrgName,
				@OrgStatus = OrgStatus,
				@OracleLevel1 = OracleLevel1,
				@OracleLevel2 = OracleLevel2,
				@OracleLevel3 = OracleLevel3,
				@OracleLevel4 = OracleLevel4
		from @DataHolder 
		where UniqueID = @UniqueID
		
		
		insert @XMLFinal(LineVal)
		values('    <sku>')
		
		insert @XMLFinal(LineVal)
		values('      <productCode>' + @ProductCode + '</productCode>')
		
		insert @XMLFinal(LineVal)
		values('      <itemId>' + @ItemID + '</itemId>')
		
		insert @XMLFinal(LineVal)
		values('      <item>' + @Item + '</item>')
			
		insert @XMLFinal(LineVal)
		values('      <description>' + '<![CDATA[' + @Description + ']]>' + '</description>')
		
		insert @XMLFinal(LineVal)
		values('      <status>' + @Status + '</status>')
		
		insert @XMLFinal(LineVal)
		values('      <orgs>')
		
		insert @XMLFinal(LineVal)
		values('        <org>')
		
		insert @XMLFinal(LineVal)
		values('          <name>' + @OrgName + '</name>')
		
		insert @XMLFinal(LineVal)
		values('          <status>' + @OrgStatus + '</status>')
		
		insert @XMLFinal(LineVal)
		values('        </org>')
		
		insert @XMLFinal(LineVal)
		values('      </orgs>')
		
		insert @XMLFinal(LineVal)
		values('      <category>')
		
		
		if isnull(@OracleLevel1,'') <> ''
		begin
			insert @XMLFinal(LineVal)
			values('        <level1>' + '<![CDATA[' + @OracleLevel1 + ']]>' + '</level1>')
		end 
		else
		begin
			insert @XMLFinal(LineVal)
			values('        <level1/>')
		end
		
		
		if isnull(@OracleLevel2,'') <> ''
		begin
			insert @XMLFinal(LineVal)
			values('        <level2>' + '<![CDATA[' + @OracleLevel2 + ']]>' + '</level2>')
		end 
		else
		begin
			insert @XMLFinal(LineVal)
			values('        <level2/>')
		end
		
		
		if isnull(@OracleLevel3,'') <> ''
		begin
			insert @XMLFinal(LineVal)
			values('        <level3>' + '<![CDATA[' + @OracleLevel3 + ']]>' + '</level3>')
		end 
		else
		begin
			insert @XMLFinal(LineVal)
			values('        <level3/>')
		end
		
		
		if isnull(@OracleLevel4,'') <> ''
		begin
			insert @XMLFinal(LineVal)
			values('        <level4>' + '<![CDATA[' + @OracleLevel4 + ']]>' + '</level4>')
		end
		else
		begin
			insert @XMLFinal(LineVal)
			values('        <level4/>')
		end
		
		
		insert @XMLFinal(LineVal)
		values('      </category>')
		
		
		insert @XMLFinal(LineVal)
		values('      <colors>')
		
		-- Loop to Get the colors for each Sku
		while exists(select top 1 UniqueID from @SkuColor where DataHolderID = @UniqueID)
		begin
			select	@SkuColorUniqueID = (select top 1 UniqueID from @SkuColor  where DataHolderID = @UniqueID order by UniqueID)
			select	@DataHolderID = DataHolderID,
					@ColorProp = ColorProp,
					@PropNameOrder = PropNameOrder,
					@PropName = PropName
			from @SkuColor 
			where UniqueID = @SkuColorUniqueID
			
			
					
			if (@PropNameOrder = 1)
			begin
				insert @XMLFinal(LineVal)
				values('        <color>')
			end
			
			if isnull(@ColorProp,'') <> ''
			begin
				insert @XMLFinal(LineVal)
				values('          <' + @PropName + '>' + @ColorProp + '</' + @PropName + '>')
			end
			else
			begin
				insert @XMLFinal(LineVal)
				values('          <' + @PropName + '/>')
			end
			

			if (@PropNameOrder = 4)
			begin
				insert @XMLFinal(LineVal)
				values('        </color>')
			end
			
			
			select @LastDataHolderID = @DataHolderID
			select @LastPropNameOrder = @PropNameOrder
			
			delete @SkuColor where UniqueID = @SkuColorUniqueID
		end
		
		
		insert @XMLFinal(LineVal)
		values('      </colors>')
		
		
		insert @XMLFinal(LineVal)
		values('    </sku>')
		

		delete @DataHolder where UniqueID = @UniqueID
	end
	
	
	delete @Product where ProductID = @ProductID
end

insert @XMLFinal(LineVal)
values(@Header3_E)

insert @XMLFinal(LineVal)
values(@Header2_E)


insert PIM_ETL_STAGE.dbo.Stage_ProductXMLForExport(LineVal)
select LineVal 
from @XMLFinal order by UniqueID












GO
