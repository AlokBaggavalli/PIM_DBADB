CREATE Procedure [dbo].[usp_PopulateStageHexcodeForExportByBatchID]
	@BatchID	varchar(10)
	
as

set nocount on


declare @LocaleID			int,
		@Type				varchar(50),
		@MinID				int,
		@UniqueID			int,
		@ProdAttributeID	int,
		@BatchStatus		int
		
		
declare @MainStart	Table	(
								UniqueID				int identity(1,1) Primary Key,
								NPProductCode			varchar(100),
								Name					varchar(100),
								Start					varchar(100),
								StartHexCode			varchar(100),
								HasProcessed			int default(0),
								Counts					int
							)
							
declare @MainStart_1	Table	(
									UniqueID				int identity(1,1) Primary Key,
									NPProductCode			varchar(100),
									Name					varchar(100),
									Start					varchar(100),
									StartHexCode			varchar(100),
									HasProcessed			int default(0)
								)
							
declare @ProdStart	Table	(
								ProdStartID			int identity(1,1),
								NPProductCode		varchar(100)
							)

							
declare @ProdAttribute	Table	(
									ProdAttributeID		int identity(1,1),
									MinUniqueID			int,
									MaxUniqueID			int,
									NPProductCode		varchar(100),
									Name				varchar(100),
									Counts				int
								)
							
declare @Final1		Table	(
								UniqueID				int identity(1,1) Primary Key,
								ProductCode				varchar(100),
								Attribute1Name			varchar(100),
								Attribute1Color			varchar(100),
								Attribute1Hexcode		varchar(100),
								Attribute1COMPSKU		varchar(100)
							)
							
declare @Final2		Table	(
								UniqueID				int identity(1,1) Primary Key,
								ProductCode				varchar(100),
								Attribute2Name			varchar(100),
								Attribute2Color			varchar(100),
								Attribute2Hexcode		varchar(100),
								Attribute2COMPSKU		varchar(100),
								F1UniqueID				int
							)
declare @Final3		Table	(
								UniqueID				int identity(1,1) Primary Key,
								ProductCode				varchar(100),
								Attribute3Name			varchar(100),
								Attribute3Color			varchar(100),
								Attribute3Hexcode		varchar(100),
								Attribute3COMPSKU		varchar(100),
								F1UniqueID				int
							)
declare @Final4		Table	(
								UniqueID				int identity(1,1) Primary Key,
								ProductCode				varchar(100),
								Attribute4Name			varchar(100),
								Attribute4Color			varchar(100),
								Attribute4Hexcode		varchar(100),
								Attribute4COMPSKU		varchar(100),
								F1UniqueID				int
							)
declare @Final5		Table	(
								UniqueID				int identity(1,1) Primary Key,
								ProductCode				varchar(100),
								Attribute5Name			varchar(100),
								Attribute5Color			varchar(100),
								Attribute5Hexcode		varchar(100),
								Attribute5COMPSKU		varchar(100),
								F1UniqueID				int
							)
							
declare @Final		Table	(
								UniqueID				int Primary Key,
								ProductCode				varchar(100),
								Attribute1Name			varchar(100),
								Attribute1Color			varchar(100),
								Attribute1Hexcode		varchar(100),
								Attribute1COMPSKU		varchar(100),
								Attribute2Name			varchar(100),
								Attribute2Color			varchar(100),
								Attribute2Hexcode		varchar(100),
								Attribute2COMPSKU		varchar(100),
								Attribute3Name			varchar(100),
								Attribute3Color			varchar(100),
								Attribute3Hexcode		varchar(100),
								Attribute3COMPSKU		varchar(100),
								Attribute4Name			varchar(100),
								Attribute4Color			varchar(100),
								Attribute4Hexcode		varchar(100),
								Attribute4COMPSKU		varchar(100),
								Attribute5Name			varchar(100),
								Attribute5Color			varchar(100),
								Attribute5Hexcode		varchar(100),
								Attribute5COMPSKU		varchar(100)
							)
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '3'


select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('2','6')
				)


select @BatchStatus = [Status] from BatchExtracts where ID = @MinID


if @BatchStatus = 2
begin
	insert @MainStart_1
		(
			NPProductCode,
			Name,
			Start,
			StartHexCode
		)
	select	p.NPProductCode,
			pat.Name,
			pact.Start,
			pac.StartHexCode
	from Products p
		join dbo.BatchExtracts be
			on Products.BatchID = be.BatchID
		left join ProductAttributes pa
			on p.ID = pa.ProductID
		left join ProductAttributeTranslations pat
			on p.ID = pat.ProductID
				and pa.ID = pat.ProductAttributeID
				and pat.LocaleID = 12
		left join ProductAttributeColors pac
			on p.ID = pac.ProductID
				and pa.ID = pac.ProductAttributeID
		left join ProductAttributeColorTranslations pact
			on p.ID = pact.ProductID
				and pa.ID = pact.ProductAttributeID
				and pac.ID = pact.ProductAttributeColorID
				and pact.LocaleID = 12
	where be.[Status] = '2'
		and pac.StartHexCode is not null
		and be.ID = @MinID
	order by p.NPProductCode,pat.Name,pact.Start
end


if @BatchStatus = 6
begin
	insert @MainStart_1
		(
			NPProductCode,
			Name,
			Start,
			StartHexCode
		)
	select	p.NPProductCode,
			pat.Name,
			pact.Start,
			pac.StartHexCode
	from Products p
		join dbo.BatchExtracts be
			on Products.BatchID = be.BatchID
		left join ProductAttributes pa
			on p.ID = pa.ProductID
		left join ProductAttributeTranslations pat
			on p.ID = pat.ProductID
				and pa.ID = pat.ProductAttributeID
				and pat.LocaleID = 12
		left join ProductAttributeColors pac
			on p.ID = pac.ProductID
				and pa.ID = pac.ProductAttributeID
		left join ProductAttributeColorTranslations pact
			on p.ID = pact.ProductID
				and pa.ID = pact.ProductAttributeID
				and pac.ID = pact.ProductAttributeColorID
				and pact.LocaleID = 12
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where be.[Status] = '6'
		and pac.StartHexCode is not null
		and be.ID = @MinID
	order by p.NPProductCode,pat.Name,pact.Start
end



insert @MainStart
	(
		NPProductCode,
		Name,
		Start,
		StartHexCode,
		Counts
	)
select	a.NPProductCode,
		a.Name,
		a.Start,
		a.StartHexCode,
		b.Counts
from @MainStart_1 a
	join
		(
			select	NPProductCode,
					Name,
					Count(*) as Counts 
			from @MainStart_1
			group by NPProductCode,
					 Name
		) b
	on a.NPProductCode = b.NPProductCode
		and a.Name = b.Name
order by a.NPProductCode,b.Counts desc,a.Name,a.Start




Insert @ProdStart(NPProductCode)
select	NPProductCode
from @MainStart
group by NPProductCode
order by NPProductCode



insert @ProdAttribute
(
	MinUniqueID,
	MaxUniqueID,
	NPProductCode,
	Name,
	Counts
)
select	MIN(UniqueID) as MinUniqueID,
		MAX(UniqueID) as MaxUniqueID,
		NPProductCode,
		Name,
		Counts
from @MainStart
group by NPProductCode,Name,Counts
order by NPProductCode,Counts DESC,Name




declare @ProdStartID				int,
		@NPProductCode				varchar(100),
		@ProdAttributeCounter		int,
		@PAttributeID				int,
		@Name						varchar(100),
		@F1UniqueID					int,
		@AttributeCount				int



while exists (select top 1 ProdStartID from @ProdStart)
begin
	select @ProdStartID = (select top 1 ProdStartID from @ProdStart order by ProdStartID)
	select @NPProductCode = NPProductCode from @ProdStart where ProdStartID = @ProdStartID
	
	select @ProdAttributeCounter = 0		
	
	
	while exists(select top 1 ProdAttributeID from @ProdAttribute where NPProductCode = @NPProductCode)
	begin
		select @PAttributeID = (select top 1 ProdAttributeID from @ProdAttribute where NPProductCode = @NPProductCode order by ProdAttributeID)
		select @Name = Name from @ProdAttribute where ProdAttributeID = @PAttributeID
		
		select @ProdAttributeCounter = @ProdAttributeCounter + 1
		
		if @ProdAttributeCounter = 1
		begin
			insert @Final1(ProductCode,Attribute1Name,Attribute1Color,Attribute1Hexcode,Attribute1COMPSKU)
			select	NPProductCode,
					Name,
					Start,
					StartHexCode,
					''
			from @MainStart
			where NPProductCode = @NPProductCode 
				and Name = @Name
			order by UniqueID
			
			
			-- CompSKU F1 Update	
			-- Hexcode does not exists in ATG
			update f1
			set f1.Attribute1COMPSKU = 'New Hexcode'
			from @Final1 f1
				left join dbo.ATGCompSKUColorMapper atg
					on replace(f1.Attribute1Hexcode,'#','0x') = atg.Color_Value
			where atg.Color_Value is null
				and f1.ProductCode = @NPProductCode 
				and f1.Attribute1Name = @Name
				
			
			-- Comp Sku match conditional
			update f1
			set f1.Attribute1COMPSKU = z.CompSKU_ID
			from @Final1 f1
				join
					(
						select	Min(atg.CompSKU_ID) CompSKU_ID,
								atg.Color_Value,
								atg.Display_Name,
								--Min(atg.UniqueID) as MinUniqueID,
								MIN(f1.UniqueID) as MinUniqueIDF
						from @Final1 f1
							join dbo.ATGCompSKUColorMapper atg
								on replace(f1.Attribute1Hexcode,'#','0x') = atg.Color_Value
									and f1.Attribute1Color = atg.Display_Name
						where f1.Attribute1COMPSKU = ''
							and f1.ProductCode = @NPProductCode 
							and f1.Attribute1Name = @Name
						group by --atg.CompSKU_ID,
								 atg.Color_Value,
								 atg.Display_Name				
					) z
				on f1.UniqueID = z.MinUniqueIDF	
			where f1.ProductCode = @NPProductCode 
				and f1.Attribute1Name = @Name
				
				
			update @Final1
			set Attribute1COMPSKU = 'New CompSKU'
			where Attribute1COMPSKU = ''	
				and ProductCode = @NPProductCode 
				and Attribute1Name = @Name		
		end
		else
		begin		
			select @F1UniqueID = (select MIN(UniqueID) from @Final1 where ProductCode = @NPProductCode)	
			
		
			if @ProdAttributeCounter = 2
			begin
				insert @Final2(ProductCode,Attribute2Name,Attribute2Color,Attribute2Hexcode,Attribute2COMPSKU,F1UniqueID)
				select	NPProductCode,
						Name,
						Start,
						StartHexCode,
						'',
						@F1UniqueID
				from @MainStart
				where NPProductCode = @NPProductCode 
					and Name = @Name
				order by UniqueID
				
				-- CompSKU F2 Update	
				-- Hexcode does not exists in ATG
				update f2
				set f2.Attribute2COMPSKU = 'New Hexcode'
				from @Final2 f2
					left join dbo.ATGCompSKUColorMapper atg
						on replace(f2.Attribute2Hexcode,'#','0x') = atg.Color_Value
				where atg.Color_Value is null
					and f2.ProductCode = @NPProductCode 
					and f2.Attribute2Name = @Name
					
				
				-- Comp Sku match conditional
				update f2
				set f2.Attribute2COMPSKU = z.CompSKU_ID
				from @Final2 f2
					join
						(
							select	Min(atg.CompSKU_ID) CompSKU_ID,
									atg.Color_Value,
									atg.Display_Name,
									--Min(atg.UniqueID) as MinUniqueID,
									MIN(f2.UniqueID) as MinUniqueIDF
							from @Final2 f2
								join dbo.ATGCompSKUColorMapper atg
									on replace(f2.Attribute2Hexcode,'#','0x') = atg.Color_Value
										and f2.Attribute2Color = atg.Display_Name
							where f2.Attribute2COMPSKU = ''
								and f2.ProductCode = @NPProductCode 
								and f2.Attribute2Name = @Name
							group by --atg.CompSKU_ID,
									 atg.Color_Value,
									 atg.Display_Name				
						) z
					on f2.UniqueID = z.MinUniqueIDF	
				where f2.ProductCode = @NPProductCode 
					and f2.Attribute2Name = @Name
					
					
				update @Final2
				set Attribute2COMPSKU = 'New CompSKU'
				where Attribute2COMPSKU = ''	
					and ProductCode = @NPProductCode 
					and Attribute2Name = @Name		
			end
			
			
			
			if @ProdAttributeCounter = 3
			begin
				insert @Final3(ProductCode,Attribute3Name,Attribute3Color,Attribute3Hexcode,Attribute3COMPSKU,F1UniqueID)
				select	NPProductCode,
						Name,
						Start,
						StartHexCode,
						'',
						@F1UniqueID
				from @MainStart
				where NPProductCode = @NPProductCode 
					and Name = @Name
				order by UniqueID
				
				
				-- CompSKU F3 Update	
				-- Hexcode does not exists in ATG
				update f3
				set f3.Attribute3COMPSKU = 'New Hexcode'
				from @Final3 f3
					left join dbo.ATGCompSKUColorMapper atg
						on replace(f3.Attribute3Hexcode,'#','0x') = atg.Color_Value
				where atg.Color_Value is null
					and f3.ProductCode = @NPProductCode 
					and f3.Attribute3Name = @Name
					
				
				-- Comp Sku match conditional
				update f3
				set f3.Attribute3COMPSKU = z.CompSKU_ID
				from @Final3 f3
					join
						(
							select	Min(atg.CompSKU_ID) CompSKU_ID,
									atg.Color_Value,
									atg.Display_Name,
									--Min(atg.UniqueID) as MinUniqueID,
									MIN(f3.UniqueID) as MinUniqueIDF
							from @Final3 f3
								join dbo.ATGCompSKUColorMapper atg
									on replace(f3.Attribute3Hexcode,'#','0x') = atg.Color_Value
										and f3.Attribute3Color = atg.Display_Name
							where f3.Attribute3COMPSKU = ''
								and f3.ProductCode = @NPProductCode 
								and f3.Attribute3Name = @Name
							group by --atg.CompSKU_ID,
									 atg.Color_Value,
									 atg.Display_Name				
						) z
					on f3.UniqueID = z.MinUniqueIDF	
				where f3.ProductCode = @NPProductCode 
					and f3.Attribute3Name = @Name
					
					
				update @Final3
				set Attribute3COMPSKU = 'New CompSKU'
				where Attribute3COMPSKU = ''	
					and ProductCode = @NPProductCode 
					and Attribute3Name = @Name		
			end
			
		
		
			if @ProdAttributeCounter = 4
				begin
					insert @Final4(ProductCode,Attribute4Name,Attribute4Color,Attribute4Hexcode,Attribute4COMPSKU,F1UniqueID)
					select	NPProductCode,
							Name,
							Start,
							StartHexCode,
							'',
							@F1UniqueID
					from @MainStart
					where NPProductCode = @NPProductCode 
						and Name = @Name
					order by UniqueID
					
					
					-- CompSKU F4 Update	
					-- Hexcode does not exists in ATG
					update f4
					set f4.Attribute4COMPSKU = 'New Hexcode'
					from @Final4 f4
						left join dbo.ATGCompSKUColorMapper atg
							on replace(f4.Attribute4Hexcode,'#','0x') = atg.Color_Value
					where atg.Color_Value is null
						and f4.ProductCode = @NPProductCode 
						and f4.Attribute4Name = @Name
						
					
					-- Comp Sku match conditional
					update f4
					set f4.Attribute4COMPSKU = z.CompSKU_ID
					from @Final4 f4
						join
							(
								select	Min(atg.CompSKU_ID) CompSKU_ID,
										atg.Color_Value,
										atg.Display_Name,
										--Min(atg.UniqueID) as MinUniqueID,
										MIN(f4.UniqueID) as MinUniqueIDF
								from @Final4 f4
									join dbo.ATGCompSKUColorMapper atg
										on replace(f4.Attribute4Hexcode,'#','0x') = atg.Color_Value
											and f4.Attribute4Color = atg.Display_Name
								where f4.Attribute4COMPSKU = ''
									and f4.ProductCode = @NPProductCode 
									and f4.Attribute4Name = @Name
								group by --atg.CompSKU_ID,
										 atg.Color_Value,
										 atg.Display_Name				
							) z
						on f4.UniqueID = z.MinUniqueIDF	
					where f4.ProductCode = @NPProductCode 
						and f4.Attribute4Name = @Name
						
						
					update @Final4
					set Attribute4COMPSKU = 'New CompSKU'
					where Attribute4COMPSKU = ''	
						and ProductCode = @NPProductCode 
						and Attribute4Name = @Name		
				end
				
				
				if @ProdAttributeCounter = 5
				begin
					insert @Final5(ProductCode,Attribute5Name,Attribute5Color,Attribute5Hexcode,Attribute5COMPSKU,F1UniqueID)
					select	NPProductCode,
							Name,
							Start,
							StartHexCode,
							'',
							@F1UniqueID
					from @MainStart
					where NPProductCode = @NPProductCode 
						and Name = @Name
					order by UniqueID
					
					
					-- CompSKU F5 Update	
					-- Hexcode does not exists in ATG
					update f5
					set f5.Attribute5COMPSKU = 'New Hexcode'
					from @Final5 f5
						left join dbo.ATGCompSKUColorMapper atg
							on replace(f5.Attribute5Hexcode,'#','0x') = atg.Color_Value
					where atg.Color_Value is null
						and f5.ProductCode = @NPProductCode 
						and f5.Attribute5Name = @Name
						
					
					-- Comp Sku match conditional
					update f5
					set f5.Attribute5COMPSKU = z.CompSKU_ID
					from @Final5 f5
						join
							(
								select	Min(atg.CompSKU_ID) CompSKU_ID,
										atg.Color_Value,
										atg.Display_Name,
										--Min(atg.UniqueID) as MinUniqueID,
										MIN(f5.UniqueID) as MinUniqueIDF
								from @Final5 f5
									join dbo.ATGCompSKUColorMapper atg
										on replace(f5.Attribute5Hexcode,'#','0x') = atg.Color_Value
											and f5.Attribute5Color = atg.Display_Name
								where f5.Attribute5COMPSKU = ''
									and f5.ProductCode = @NPProductCode 
									and f5.Attribute5Name = @Name
								group by --atg.CompSKU_ID,
										 atg.Color_Value,
										 atg.Display_Name				
							) z
						on f5.UniqueID = z.MinUniqueIDF	
					where f5.ProductCode = @NPProductCode 
						and f5.Attribute5Name = @Name
						
						
					update @Final5
					set Attribute5COMPSKU = 'New CompSKU'
					where Attribute5COMPSKU = ''	
						and ProductCode = @NPProductCode 
						and Attribute5Name = @Name		
				end			
		end
		
		
		delete @ProdAttribute where ProdAttributeID = @PAttributeID 
		
	end
	
	delete @ProdStart where ProdStartID = @ProdStartID
end


-- @Final2 Update
update f
set f.F1UniqueID = z.F1UniqueIDUpdate
from @Final2 f
	join
		(
			select	UniqueID,
					ProductCode,
					Attribute2Name,
					Attribute2Color,
					F1UniqueID,
					RowNum,
					F1UniqueID + (RowNum - 1) as  F1UniqueIDUpdate
			from	
				(
					select	UniqueID,
							ProductCode,
							Attribute2Name,
							Attribute2Color,
							F1UniqueID,
							ROW_NUMBER() over (Partition by ProductCode ORDER BY Attribute2Color) as RowNum
					from @Final2
				) t
		) z
	on f.UniqueID = z.UniqueID



-- @Final3 Update
update f
set f.F1UniqueID = z.F1UniqueIDUpdate
from @Final3 f
	join
		(
			select	UniqueID,
					ProductCode,
					Attribute3Name,
					Attribute3Color,
					F1UniqueID,
					RowNum,
					F1UniqueID + (RowNum - 1) as  F1UniqueIDUpdate
			from	
				(
					select	UniqueID,
							ProductCode,
							Attribute3Name,
							Attribute3Color,
							F1UniqueID,
							ROW_NUMBER() over (Partition by ProductCode ORDER BY Attribute3Color) as RowNum
					from @Final3
				) t
		) z
	on f.UniqueID = z.UniqueID
	
	
	
-- @Final4 Update
update f
set f.F1UniqueID = z.F1UniqueIDUpdate
from @Final4 f
	join
		(
			select	UniqueID,
					ProductCode,
					Attribute4Name,
					Attribute4Color,
					F1UniqueID,
					RowNum,
					F1UniqueID + (RowNum - 1) as  F1UniqueIDUpdate
			from	
				(
					select	UniqueID,
							ProductCode,
							Attribute4Name,
							Attribute4Color,
							F1UniqueID,
							ROW_NUMBER() over (Partition by ProductCode ORDER BY Attribute4Color) as RowNum
					from @Final4
				) t
		) z
	on f.UniqueID = z.UniqueID
	
	
-- @Final5 Update
update f
set f.F1UniqueID = z.F1UniqueIDUpdate
from @Final5 f
	join
		(
			select	UniqueID,
					ProductCode,
					Attribute5Name,
					Attribute5Color,
					F1UniqueID,
					RowNum,
					F1UniqueID + (RowNum - 1) as  F1UniqueIDUpdate
			from	
				(
					select	UniqueID,
							ProductCode,
							Attribute5Name,
							Attribute5Color,
							F1UniqueID,
							ROW_NUMBER() over (Partition by ProductCode ORDER BY Attribute5Color) as RowNum
					from @Final5
				) t
		) z
	on f.UniqueID = z.UniqueID
	




-- Final Start
insert @Final
(
	UniqueID,
	ProductCode,
	Attribute1Name,
	Attribute1Color,
	Attribute1Hexcode,
	Attribute1COMPSKU,
	Attribute2Name,
	Attribute2Color,
	Attribute2Hexcode,
	Attribute2COMPSKU,
	Attribute3Name,
	Attribute3Color,
	Attribute3Hexcode,
	Attribute3COMPSKU,
	Attribute4Name,
	Attribute4Color,
	Attribute4Hexcode,
	Attribute4COMPSKU,
	Attribute5Name,
	Attribute5Color,
	Attribute5Hexcode,
	Attribute5COMPSKU
)
select	f1.UniqueID,
		f1.ProductCode,
		f1.Attribute1Name,
		f1.Attribute1Color,
		f1.Attribute1Hexcode,
		f1.Attribute1COMPSKU,
		f2.Attribute2Name,
		f2.Attribute2Color,
		f2.Attribute2Hexcode,
		f2.Attribute2COMPSKU,
		f3.Attribute3Name,
		f3.Attribute3Color,
		f3.Attribute3Hexcode,
		f3.Attribute3COMPSKU,
		f4.Attribute4Name,
		f4.Attribute4Color,
		f4.Attribute4Hexcode,
		f4.Attribute4COMPSKU,
		f5.Attribute5Name,
		f5.Attribute5Color,
		f5.Attribute5Hexcode,
		f5.Attribute5COMPSKU
from @Final1 f1
	left join @Final2 f2
		on f1.UniqueID = f2.F1UniqueID
	left join @Final3 f3
		on f1.UniqueID = f3.F1UniqueID
	left join @Final4 f4
		on f1.UniqueID = f4.F1UniqueID
	left join @Final5 f5
		on f1.UniqueID = f5.F1UniqueID




-- insert into Real Table
insert [dbo].[Stage_HexcodeExport]
	(
	   [ProductCode]
      ,[Attribute1Name]
      ,[Attribute1Color]
      ,[Attribute1Hexcode]
      ,[Attribute1COMPSKU]
      ,[Attribute2Name]
      ,[Attribute2Color]
      ,[Attribute2Hexcode]
      ,[Attribute2COMPSKU]
      ,[Attribute3Name]
      ,[Attribute3Color]
      ,[Attribute3Hexcode]
      ,[Attribute3COMPSKU]
      ,[Attribute4Name]
      ,[Attribute4Color]
      ,[Attribute4Hexcode]
      ,[Attribute4COMPSKU]
      ,[Attribute5Name]
      ,[Attribute5Color]
      ,[Attribute5Hexcode]
      ,[Attribute5COMPSKU]
	)
select [ProductCode]
      ,[Attribute1Name]
      ,[Attribute1Color]
      ,[Attribute1Hexcode]
      ,[Attribute1COMPSKU]
      ,[Attribute2Name]
      ,[Attribute2Color]
      ,[Attribute2Hexcode]
      ,[Attribute2COMPSKU]
      ,[Attribute3Name]
      ,[Attribute3Color]
      ,[Attribute3Hexcode]
      ,[Attribute3COMPSKU]
      ,[Attribute4Name]
      ,[Attribute4Color]
      ,[Attribute4Hexcode]
      ,[Attribute4COMPSKU]
      ,[Attribute5Name]
      ,[Attribute5Color]
      ,[Attribute5Hexcode]
      ,[Attribute5COMPSKU]
from @Final
order by UniqueID



update dbo.Stage_HexcodeExport
set Attribute1Hexcode = replace(Attribute1Hexcode,'#','0x'),
	Attribute2Hexcode = replace(Attribute2Hexcode,'#','0x'),
	Attribute3Hexcode = replace(Attribute3Hexcode,'#','0x'),
	Attribute4Hexcode = replace(Attribute4Hexcode,'#','0x'),
	Attribute5Hexcode = replace(Attribute5Hexcode,'#','0x')
where 1 = 1










GO
