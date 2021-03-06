Create Procedure [dbo].[Test_usp_PLMControl_populate]

As 
Begin
set nocount on

/***************************************************************************************************
Procedure		: Test_usp_PLMControl_populate        
Create Date		: 04-Oct-2021       
Author			: Le, Nhan & Thippesha, Alok.        
Description		: PLMControl data populate for different warehouse and channels.
Usage			: EXEC [dbo].[Test_usp_PLMControl_populate]  @WarehouseID =   -- ( 3-IRL, 11-PLM, 13-TNS, 127-CZE, 128-JPN )
				: EXEC [dbo].[Test_usp_PLMControl_populate] ?

****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
2021-10-04          Alok Thippesha      Reviewed and included the changes.
2021-10-04          Nhan le			    Code Review and Approved.

****************************************************************************************************/

Declare @WarehouseID int
Declare @ChannelID	int = 0
Declare	@LocaleID	int = 0
Declare @InsertQuery varchar(max)
Declare @SelectQuery varchar(max)
Declare @FinalQuery varchar(max)
Declare @WarehouseName varchar(10) = ''


-- Create a temp table to pull initial data

If Object_ID('tempdb..#tempStart') is Not Null
Begin
	Drop table #tempStart;
End

	Create table #tempStart(
			UniqueID			int identity(1,1) Primary Key,
			ProductID			int,
			NPProductCode		nvarchar(50),
			Family				nvarchar(100),
			Channel				nvarchar(10),
			[Status]			nvarchar(50),
			TNS					int,
			PLM					int,
			IRL					int,
			JPN					int,
			CZE					int,
			ProductClass		nvarchar(10),
			RelatedProductCode	nvarchar(50),
			GroupingCode		nvarchar(10),
			FamilyVersion		nvarchar(100),
			NPProductName		nvarchar(255),
			ProductCreateDate	datetime,
			DefaultURL			nvarchar(255),
			DecoMethod			nvarchar(60),
			FrozenCost			float,
			WarehouseID			int,
			Warehouse			nvarchar(60)
		)

--Insert data into table #tempStart

	Set @InsertQuery = 'Insert into #tempStart
								(
									ProductID
									,NPProductCode
									,Family
									,Channel
									,[Status]
									,TNS
									,PLM
									,IRL
									,JPN
									,CZE
									,ProductClass
									,RelatedProductCode
									,GroupingCode
									,FamilyVersion
									,NPProductName
									,ProductCreateDate
									,DefaultURL
									,WarehouseID
									,Warehouse
								)'



-- Looping through multiple warehouseID

Declare @Warehouse table (
							Seq int identity(1,1)
						   ,WarehouseID int
						   )
Insert into @Warehouse(WarehouseID)
	Select 3
	union
	Select 11
	union
	Select 13
	union
	Select 127
	union
	Select 128
--Select * from @Warehouse

		DECLARE @Counter INT = 1
		WHILE ( @Counter <= (Select max(Seq) from @Warehouse))
		BEGIN
				Set @WarehouseID = (Select WarehouseID from @Warehouse where Seq = @Counter)
				Set @SelectQuery = 'Select   p.ID as ProductID
								,p.NPProductCode
								,pf.Family
								,dc.Channel
								,i.Status
								,pfc.TNS 
								,pfc.PLM 
								,pfc.IRL 
								,pfc.JPN
								,pfc.CZE
								,c.Class
								,rel.RelatedProductCode
								,p.GroupingCode
								,pf.[Version]
								,pt.NPProductName
								,p.CreationDate
								,''https://pim.pens.com/VAPDetail.aspx?productID='' + convert(nvarchar(20),p.ID) + ''&channelID=1&localeID=12'' as DefaultURL
								,'+Cast(@WarehouseID as Varchar(10))+' as WarehouseID 
								,'''+Case when @WarehouseID = 3   then 'IRL'
										  when @WarehouseID = 11  then 'PLM' 
										  when @WarehouseID = 13  then 'TNS' 
										  when @WarehouseID = 127 then 'CZE' 
										  when @WarehouseID = 128 then 'JPN' 
									 End+''' as Warehouse
						from [ProductFamilyChannels] pfc
						join Products p on pfc.ProductID = p.ID
						join ProductFamilys pf on pfc.ProductFamilyID = pf.ID and pf.Family not like ''%sam%'' and ISNULL(pf.Family,'''') <> ''''
						left join DistributionChannels dc on dc.ID = pfc.ChannelID
						left join ItemStatuses i on i.ID = isnull(pfc.StatusID, 4)
						left join Classes c on p.Class = c.ID
						left join (-- exclude Virtual
									select	RelatedProductID
									from ProductAccessories 
									where RelationTypeID = 2
									group by RelatedProductID
									) excl on p.ID = excl.RelatedProductID	
						left join (Select	a.ProductID
											,a.RelatedProductID
											,b.NPProductCode as ProductCode
											,c.NPProductCode as RelatedProductCode
											,d.ID as FamilyID
											,d.Family
									from ProductAccessories a
									join Products b on a.ProductID = b.ID
									left join Products c on a.RelatedProductID = c.ID
									left join ProductFamilys d on a.RelatedProductID = d.ProductID
									where a.RelationTypeID = 2 and ISNULL(d.Family,'''') <> ''''
								   ) rel on p.ID = rel.ProductID and pf.Family = rel.Family
						left join ProductTranslations pt on p.ID = pt.ProductID
									and pt.LocaleID = '+Cast(@LocaleID as Varchar(10))+'
									and pt.ChannelID = '+Cast(@ChannelID as Varchar(10))+'
						where StatusID in (5,7,13,14,15)
							and pfc.ChannelID <> 2  --ATLAS
							and excl.RelatedProductID is null
							and ISNULL(pfc.'+Case when @WarehouseID = 3   then 'IRL'
												  when @WarehouseID = 11  then 'PLM' 
												  when @WarehouseID = 13  then 'TNS' 
												  when @WarehouseID = 127 then 'CZE' 
												  when @WarehouseID = 128 then 'JPN' 
											End+',0) > 0'
			Set @FinalQuery = @InsertQuery +' '+ @SelectQuery
			Exec(@FinalQuery)
			SET @Counter  = @Counter  + 1
		END

-- Select * from #tempStart

-- DecoMethod calculation

If Object_ID('tempdb..#DecoMethodTable') is Not Null
Begin
	Drop table #DecoMethodTable;
End
Create table #DecoMethodTable (	
								UniqueID	int identity(1,1) Primary Key
								,ProductID	int
								,ProdFamily	nvarchar(60)
								,DecoMethod	nvarchar(60)
							   )

	Insert into #DecoMethodTable(ProductID, ProdFamily, DecoMethod)
		Select	ps.ProductID, ps.ProdFamily, ps.DecoMethod
		from #tempStart t
		join ProductSKUs ps on t.ProductID = ps.ProductID and t.Family = ps.ProdFamily
		group by ps.ProductID, ps.ProdFamily, ps.DecoMethod
		order by ps.ProductID, ps.ProdFamily, ps.DecoMethod
	
	-- Keep only 1st deco method for each Prod Family
	Delete m 
	from #DecoMethodTable m
    join(Select	ProductID,ProdFamily,MIN(UniqueID) as MinID
		 from #DecoMethodTable
		 group by ProductID,ProdFamily
		) d on m.ProductID = d.ProductID and m.ProdFamily = d.ProdFamily and m.UniqueID <> d.MinID

	Update t1 set t1.DecoMethod = t2.DecoMethod
	from #tempStart t1
	join #DecoMethodTable t2
	on t1.ProductID = t2.ProductID and t1.Family = t2.ProdFamily

-- Frozencost calculation
If Object_ID('tempdb..#FozenCostTable') is Not Null
Begin
	Drop table #FozenCostTable;
End
Create table #FozenCostTable (
							   UniqueID	int identity(1,1) Primary Key
							   ,ProdFamily	nvarchar(100)
							   ,OracleID	nvarchar(255)
							   ,OrgID		int
							   ,ItemCost	float
							  )
		Insert into #FozenCostTable(ProdFamily,OracleID,OrgID,ItemCost)
		Select	ProdFamily,OracleID,OrgID,ItemCost
		from (
			  Select a.ProdFamily, a.OracleID, b.OrgID, b.ItemCost,ROW_NUMBER() OVER (PARTITION BY a.ProdFamily,b.OrgID ORDER BY a.OracleID) as RowNumber
			  from (
					Select Family
					from #tempStart
					group by Family
				   ) m
			  join ProductSKUs a on m.Family = a.ProdFamily
			  join CSTItemCost b on a.OracleID = b.ItemNumber
		) t
		where RowNumber = 1
		order by ProdFamily,OracleID,OrgID

		Update m set m.FrozenCost = t.ItemCost
		from #tempStart m
		join #FozenCostTable t on m.Family = t.ProdFamily

-- Load main table

If Object_ID('tempdb..#tempFinal') is Not Null
Begin
	Drop table #tempFinal;
End
	Create table #tempFinal
		(
			UniqueID			int identity(1,1) Primary Key,
			ProductID			int,
			ProductClass		nvarchar(10),
			ABCCode				nvarchar(10),
			NPProductCode		nvarchar(50),
			Family				nvarchar(100),
			GroupingCode		nvarchar(10),
			VirtualCode			nvarchar(4000),
			ProductDescription	nvarchar(255),
			ProductCreateDate	datetime,
			DecoMethod			nvarchar(60),
			FrozenCost			float,
			NADM				nvarchar(50),
			NPL					nvarchar(50),
			GSNA				nvarchar(50),
			GSEU				nvarchar(50),
			AUNZ				nvarchar(50),
			JAPAN				nvarchar(50),
			PIMLink				nvarchar(255),
			MainFlag			int default(0),
			WarehouseID			int,
			Warehouse			nvarchar(60)
		)

		Insert #tempFinal (ProductID,ProductClass,ABCCode,NPProductCode,Family,GroupingCode,ProductDescription,ProductCreateDate,DecoMethod
						   ,FrozenCost,PIMLink,MainFlag,WarehouseID,Warehouse)
		Select	distinct ProductID, ProductClass, null as ABC, NPProductCode as ProductCode ,null as Family ,GroupingCode ,NPProductName as ProdDescription
						,ProductCreateDate ,null as DecoMethod ,null as FrozenCost ,DefaultURL as PIMLink ,1 as MainFlag ,WarehouseID ,Warehouse
		from #tempStart
		union
		select	a.ProductID, a.ProductClass, null as ABC, a.NPProductCode as ProductCode, a.Family, a.GroupingCode, a.FamilyVersion as ProdDescription,
				null as ProductCreateDate, a.DecoMethod, a.FrozenCost, null as PIMLink, 2 as MainFlag, a.WarehouseID, a.Warehouse
		from #tempStart a
		join(Select	ProductID,Family,MIN(UniqueID) as MinUniqueID
					from #tempStart
					group by ProductID,Family
		) b on a.UniqueID = b.MinUniqueID

		
		Update t1 set t1.GSEU = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'GS-EU'
	
		update t1 set t1.AUNZ = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'AU/NZ'
	
		update t1 set t1.NADM = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'NADM'
	
		update t1 set t1.JAPAN = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'JAPAN'
	
		update t1 set t1.NPL = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'NPL'
	
		update t1 set t1.GSNA = t2.[Status]
		from #tempFinal t1
		join #tempStart t2 on t1.ProductID = t2.ProductID and t1.Family = t2.Family
		where t1.MainFlag <> 1 and t2.Channel = 'GS-NA'

		Update t1 set t1.FrozenCost = t2.AVG_Frozen
		from #tempFinal t1
		join (
				select	ProductID, avg(ISNULL(FrozenCost,0)) as AVG_Frozen
				from #tempStart
				where FrozenCost is not null
				group by ProductID
			  ) t2 on t1.ProductID = t2.ProductID and t1.MainFlag = 1

-- Virtual Code calculation: 

		If Object_ID('tempdb..#VirtualTableProduct') is Not Null
		Begin
			Drop table #VirtualTableProduct;
		End
		Create table #VirtualTableProduct(ProductID int)

			Insert into #VirtualTableProduct
			Select ProductID
			from #tempStart
			where ISNULL(RelatedProductCode,'') <> ''
			group by ProductID

			;With CTE As(
						 Select Distinct B.ProductID
										,RelatedProductCode =  STUFF((select Distinct ','+A.RelatedProductCode from #tempStart A where A.ProductID = B.ProductID FOR XML PATH('')), 1, 1, '') 
						 from #VirtualTableProduct B
						 )
			Update A set A.VirtualCode = B.RelatedProductCode
			from #tempFinal A
			Join CTE B on A.ProductID = B.ProductID
			where A.MainFlag = 1 

		If Object_ID('tempdb..#VirtualTableFamily') is Not Null
		Begin
			Drop table #VirtualTableFamily;
		End
		Create table #VirtualTableFamily(ProductID int, Family nvarchar(60))

			Insert into #VirtualTableFamily(ProductID,Family)
			select	ProductID, Family
			from #tempStart
			where ISNULL(RelatedProductCode,'') <> ''
			group by ProductID,Family

			;With CTE As(
						 Select Distinct B.ProductID,B.Family
										,RelatedProductCode =  STUFF((select Distinct ','+A.RelatedProductCode from #tempStart A where A.ProductID = B.ProductID and A.Family = B.Family FOR XML PATH('')), 1, 1, '') 
						 from #VirtualTableFamily B
						 )
			Update A set A.VirtualCode = B.RelatedProductCode
			from #tempFinal A
			Join CTE B on A.ProductID = B.ProductID and A.Family = B.Family
			where A.MainFlag != 1 

-- Final DecoMethod Calculation

			;With CTE As(
						 Select Distinct B.ProductID
										,DecoMethod =  STUFF((select Distinct ','+A.DecoMethod from #DecoMethodTable A where A.ProductID = B.ProductID FOR XML PATH('')), 1, 1, '' ) 
						 from #tempStart B where ISNULL(DecoMethod,'') <> ''
						 )
			Update A set A.DecoMethod = B.DecoMethod
			from #tempFinal A
			Join CTE B on A.ProductID = B.ProductID
			where A.MainFlag = 1 

-- Inserting into Main Table
	Insert into PIM_ETL_STAGE.dbo.Stage_PLMControl_P1
		(
			ProductID
			,ProductClass
			,ABCCode
			,NPProductCode
			,Family
			,GroupingCode
			,VirtualCode
			,ProductDescription
			,ProductCreateDate
			,DecoMethod
			,FrozenCost
			,NADM
			,NPL
			,GSNA
			,GSEU
			,AUNZ
			,JAPAN
			,PIMLink
			,MainFlag
			,WarehouseID
			,Warehouse
		)
	select  ProductID
			,ProductClass
			,ABCCode
			,NPProductCode
			,Family
			,GroupingCode
			,VirtualCode
			,ProductDescription
			,ProductCreateDate
			,DecoMethod
			,FrozenCost
			,NADM
			,NPL
			,GSNA
			,GSEU
			,AUNZ
			,JAPAN
			,PIMLink	
			,MainFlag
			,WarehouseID
			,Warehouse
	from #tempFinal
	order by NPProductCode,MainFlag,ProductClass,Family


End




GO
