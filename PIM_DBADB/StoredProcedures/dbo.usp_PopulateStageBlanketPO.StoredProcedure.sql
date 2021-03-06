CREATE Procedure [dbo].[usp_PopulateStageBlanketPO]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on 

Declare @ProdFob	Table	(
								UniqueID				int identity(1,1) Primary Key,
								docoument_number		varchar(50),
								Org						varchar(50),
								vendor_name				varchar(255),
								vendor_site_code		varchar(50),
								item					varchar(50),
								vendor_product_num		varchar(50),
								Unit_Price				varchar(50),								
								ProductID				int,
								ProductFobID			int,
								QtyStart				int,
								NPQuote					decimal(10,3),
								NOTE_TO_VENDOR			varchar(50),
								EXPIRATION_DATE			varchar(50),
								[Action]				varchar(50),
								RowNum					int
							)
							
Declare @ProdFobFinal	Table	(
									UniqueID				int identity(1,1) Primary Key,
									docoument_number		varchar(50),
									Org						varchar(50),
									vendor_name				varchar(255),
									vendor_site_code		varchar(50),
									item					varchar(50),
									vendor_product_num		varchar(50),
									Unit_Price				varchar(50),	
									ProductID				int,
									ProductFobID			int,
									quantity1				int,
									quantity2				int,
									quantity3				int,
									quantity4				int,
									quantity5				int,
									quantity6				int,
									unit_price1				decimal(10,3),
									unit_price2				decimal(10,3),
									unit_price3				decimal(10,3),
									unit_price4				decimal(10,3),
									unit_price5				decimal(10,3),
									unit_price6				decimal(10,3),
									NOTE_TO_VENDOR			varchar(50),
									EXPIRATION_DATE			varchar(50),
									[Action]				varchar(50)
								)
								
declare	@UniqueID				int,
		@ProductID				int,
		@ProductFobID			int,
		@quantity1				int,
		@quantity2				int,
		@quantity3				int,
		@quantity4				int,
		@quantity5				int,
		@quantity6				int,
		@unit_price1			decimal(10,3),
		@unit_price2			decimal(10,3),
		@unit_price3			decimal(10,3),
		@unit_price4			decimal(10,3),
		@unit_price5			decimal(10,3),
		@unit_price6			decimal(10,3),
		@RowNum					int,
		@docoument_number		varchar(50),
		@Org					varchar(50),
		@vendor_name			varchar(255),
		@vendor_site_code		varchar(50),
		@item					varchar(50),
		@vendor_product_num		varchar(50),
		@Unit_Price				varchar(50),
		@NOTE_TO_VENDOR			varchar(50),
		@EXPIRATION_DATE		varchar(50),
		@Action 				varchar(50),
		@LocaleID				int,
		@BType					varchar(50),
		@MinID					int,
		@BatchStatus			int
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @BType = '13'



select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @BType
						and [Status] in('2','6')
				)
				
select @BatchStatus = [Status] from BatchExtracts where ID = @MinID
		

if @BatchStatus = 2
begin
	insert @ProdFob	
		(
			docoument_number,
			Org,
			vendor_name,
			vendor_site_code,
			item,
			vendor_product_num,
			Unit_Price,			
			ProductID,
			ProductFobID,
			QtyStart,
			NPQuote,
			NOTE_TO_VENDOR,
			EXPIRATION_DATE,
			[Action],
			RowNum
		)
	select	'' as docoument_number,
			'ZCA' as Org,
			s.Name as vendor_name,
			'' as vendor_site_code,
			p.NPProductCode as item,
			p.SupplierProductID as vendor_product_num,
			'' as Unit_Price,		
			pf.ProductID,
			pf.ProductFobID,
			pf.QtyStart,
			pf.NPQuote,
			'' as NOTE_TO_VENDOR,
			'' AS EXPIRATION_DATE,
			'ADD_ITEM' AS [Action],
			ROW_NUMBER() over (Partition By pf.ProductID,pf.ProductFobID Order By pf.ProductID,pf.ProductFobID,pf.QtyStart) as RowNum
	from ProductFOBPriceTiers pf
		join dbo.ProductFOBs pfob
			on pf.ProductID = pfob.ProductID
				and pfob.Country = 'US'
				and pfob.Currency = 'USD'
				and pfob.ID = pf.ProductFobID
		join Products p
			on pf.ProductID = p.ID
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join Suppliers s
			on p.SupplierID = s.ID
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by pf.ProductID,pf.ProductFobID,pf.QtyStart
end


if @BatchStatus = 6
begin
	insert @ProdFob	
		(
			docoument_number,
			Org,
			vendor_name,
			vendor_site_code,
			item,
			vendor_product_num,
			Unit_Price,			
			ProductID,
			ProductFobID,
			QtyStart,
			NPQuote,
			NOTE_TO_VENDOR,
			EXPIRATION_DATE,
			[Action],
			RowNum
		)
	select	'' as docoument_number,
			'ZCA' as Org,
			s.Name as vendor_name,
			'' as vendor_site_code,
			p.NPProductCode as item,
			p.SupplierProductID as vendor_product_num,
			'' as Unit_Price,		
			pf.ProductID,
			pf.ProductFobID,
			pf.QtyStart,
			pf.NPQuote,
			'' as NOTE_TO_VENDOR,
			'' AS EXPIRATION_DATE,
			'ADD_ITEM' AS [Action],
			ROW_NUMBER() over (Partition By pf.ProductID,pf.ProductFobID Order By pf.ProductID,pf.ProductFobID,pf.QtyStart) as RowNum
	from ProductFOBPriceTiers pf
		join dbo.ProductFOBs pfob
			on pf.ProductID = pfob.ProductID
				and pfob.Country = 'US'
				and pfob.Currency = 'USD'
				and pfob.ID = pf.ProductFobID
		join Products p
			on pf.ProductID = p.ID		
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join Suppliers s
			on p.SupplierID = s.ID
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where be.[Status] = '6'
		and be.ID = @MinID
	order by pf.ProductID,pf.ProductFobID,pf.QtyStart
end



while exists (select top 1 * from @ProdFob)
begin
	select	@UniqueID = (select top 1 UniqueID from @ProdFob order by UniqueID)
	select	@ProductID = ProductID,
			@ProductFobID = ProductFobID,
			@RowNum = RowNum,
			@docoument_number = docoument_number,
			@Org = Org,
			@vendor_name = vendor_name,
			@vendor_site_code = vendor_site_code,
			@item = item,
			@vendor_product_num = vendor_product_num,
			@Unit_Price = Unit_Price,
			@NOTE_TO_VENDOR = NOTE_TO_VENDOR,
			@EXPIRATION_DATE = EXPIRATION_DATE,
			@Action = [Action]
	from @ProdFob 
	where UniqueID = @UniqueID
	
	if @RowNum = 1
	begin
		select	@quantity1 = QtyStart,
				@unit_price1 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity1,@unit_price1,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity1 = @quantity1,
				unit_price1 = @unit_price1
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	if @RowNum = 2
	begin
		select	@quantity2 = QtyStart,
				@unit_price2 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity2,@unit_price2,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity2 = @quantity2,
				unit_price2 = @unit_price2
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	if @RowNum = 3
	begin
		select	@quantity3 = QtyStart,
				@unit_price3 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity3,@unit_price3,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity3 = @quantity3,
				unit_price3 = @unit_price3
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	if @RowNum = 4
	begin
		select	@quantity4 = QtyStart,
				@unit_price4 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity4,@unit_price4,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity4 = @quantity4,
				unit_price4 = @unit_price4
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	if @RowNum = 5
	begin
		select	@quantity5 = QtyStart,
				@unit_price5 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity5,@unit_price5,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity5 = @quantity5,
				unit_price5 = @unit_price5
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	if @RowNum = 6
	begin
		select	@quantity6 = QtyStart,
				@unit_price6 = NPQuote
		from @ProdFob 
		where UniqueID = @UniqueID
			and RowNum = @RowNum
		
		
		if not exists	(
							select *
							from @ProdFobFinal 
							where ProductID = @ProductID
								and ProductFobID = @ProductFobID
						)
		begin
			insert @ProdFobFinal
				(
					docoument_number,
					Org,
					vendor_name,
					vendor_site_code,
					item,
					vendor_product_num,
					Unit_Price,	
					ProductID,
					ProductFobID,
					quantity1,
					unit_price1,
					NOTE_TO_VENDOR,
					EXPIRATION_DATE,
					[Action]
				)
			values(@docoument_number,@Org,@vendor_name,@vendor_site_code,@item,@vendor_product_num,@Unit_Price,@ProductID,@ProductFobID,@quantity6,@unit_price6,
				   @NOTE_TO_VENDOR,@EXPIRATION_DATE,@Action)
		end
		else
		begin
			update @ProdFobFinal
			set quantity6 = @quantity6,
				unit_price6 = @unit_price6
			where ProductID = @ProductID
				and ProductFobID = @ProductFobID
		end
	end
	
	
	
	delete @ProdFob where UniqueID = @UniqueID
	
	set @ProductFobID = 0
	set @ProductID = 0
	set @RowNum = 0
end


insert PIM_ETL_STAGE.dbo.Stage_BlanketPO
	(
	   [document_number]
      ,[Org]
      ,[vendor_name]
      ,[vendor_site_code]
      ,[item]
      ,[vendor_product_num]
      ,[Unit_Price]
      ,[ProductID]
      ,[ProductFobID]
      ,[quantity1]
      ,[quantity2]
      ,[quantity3]
      ,[quantity4]
      ,[quantity5]
      ,[quantity6]
      ,[unit_price1]
      ,[unit_price2]
      ,[unit_price3]
      ,[unit_price4]
      ,[unit_price5]
      ,[unit_price6]
      ,[NOTE_TO_VENDOR]
      ,[EXPIRATION_DATE]
      ,[Action]
	)

select [docoument_number]
      ,[Org]
      ,[vendor_name]
      ,[vendor_site_code]
      ,[item]
      ,'''' + [vendor_product_num] + '''' as [vendor_product_num]
      ,[Unit_Price]
      ,[ProductID]
      ,[ProductFobID]
      ,[quantity1]
      ,[quantity2]
      ,[quantity3]
      ,[quantity4]
      ,[quantity5]
      ,[quantity6]
      ,[unit_price1]
      ,[unit_price2]
      ,[unit_price3]
      ,[unit_price4]
      ,[unit_price5]
      ,[unit_price6]
      ,[NOTE_TO_VENDOR]
      ,[EXPIRATION_DATE]
      ,[Action] 
from @ProdFobFinal
order by vendor_name,item




if exists(select top 1 * from @ProdFobFinal)
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
else
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








GO
