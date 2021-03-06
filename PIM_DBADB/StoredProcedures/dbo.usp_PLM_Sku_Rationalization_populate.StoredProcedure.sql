Create Procedure [dbo].[usp_PLM_Sku_Rationalization_populate]
	@WarehouseID		int -- ( 3-IRL, 11-PLM, 13-TNS, 127-CZE, 128-JPN )

as

set nocount on


declare @ChannelID	int,
		@LocaleID	int
		
declare @DecoMethodTable	Table	(	
										UniqueID	int identity(1,1) Primary Key,
										ProductID	int,
										ProdFamily	nvarchar(60),
										DecoMethod	nvarchar(60)
									)
									
declare @FozenCostTable		Table	(
										UniqueID	int identity(1,1) Primary Key,
										ProdFamily	nvarchar(100),
										OracleID	nvarchar(255),
										OrgID		int,
										ItemCost	float
									)

		
set @ChannelID = 1
set @LocaleID = 12

create table #tempStart
	(
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
	

create table #tempFinal
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


if @WarehouseID = 3
begin					
	insert into #tempStart
		(
			ProductID,
			NPProductCode,
			Family,
			Channel,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE,
			ProductClass,
			RelatedProductCode,
			GroupingCode,
			FamilyVersion,
			NPProductName,
			ProductCreateDate,
			DefaultURL,
			WarehouseID,
			Warehouse
		)
	select  p.ID as ProductID,
			p.NPProductCode, 
			pf.Family, 
			dc.Channel, 
			i.Status, 
			pfc.TNS, 
			pfc.PLM, 
			pfc.IRL, 
			pfc.JPN, 
			pfc.CZE,
			c.Class,
			rel.RelatedProductCode,
			p.GroupingCode,
			pf.[Version],
			pt.NPProductName,
			p.CreationDate,
			'https://pim.pens.com/VAPDetail.aspx?productID=' + convert(nvarchar(20),p.ID) + '&channelID=1&localeID=12' as DefaultURL,
			@WarehouseID as WarehouseID,
			'IRL' as Warehouse
	from [ProductFamilyChannels] pfc
		join Products p 
			on pfc.ProductID = p.ID
		join ProductFamilys pf 
			on pfc.ProductFamilyID = pf.ID
				and pf.Family not like '%sam%'
				and ISNULL(pf.Family,'') <> ''
		left join DistributionChannels dc 
			on dc.ID = pfc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(pfc.StatusID, 4)
		left join Classes c
			on p.Class = c.ID
		left join
			(
				-- exclude Virtual
				select	RelatedProductID
				from ProductAccessories 
				where RelationTypeID = 2
				group by RelatedProductID
			) excl
		on p.ID = excl.RelatedProductID	
		left join 
			(
				select	a.ProductID,
						a.RelatedProductID,
						b.NPProductCode as ProductCode,
						c.NPProductCode as RelatedProductCode,
						d.ID as FamilyID,
						d.Family
				from ProductAccessories a
					join Products b
						on a.ProductID = b.ID
					left join Products c
						on a.RelatedProductID = c.ID
					left join ProductFamilys d
						on a.RelatedProductID = d.ProductID
				where a.RelationTypeID = 2
					and ISNULL(d.Family,'') <> ''
			) rel
		on p.ID = rel.ProductID
			and pf.Family = rel.Family
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pt.ChannelID = @ChannelID
	where StatusID in (5,7,13,14,15)
		and pfc.ChannelID <> 2  --ATLAS
		and excl.RelatedProductID is null
		and ISNULL(pfc.IRL,0) > 0
end

if @WarehouseID = 11
begin					
	insert into #tempStart
		(
			ProductID,
			NPProductCode,
			Family,
			Channel,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE,
			ProductClass,
			RelatedProductCode,
			GroupingCode,
			FamilyVersion,
			NPProductName,
			ProductCreateDate,
			DefaultURL,
			WarehouseID,
			Warehouse
		)
	select  p.ID as ProductID,
			p.NPProductCode, 
			pf.Family, 
			dc.Channel, 
			i.Status, 
			pfc.TNS, 
			pfc.PLM, 
			pfc.IRL, 
			pfc.JPN, 
			pfc.CZE,
			c.Class,
			rel.RelatedProductCode,
			p.GroupingCode,
			pf.[Version],
			pt.NPProductName,
			p.CreationDate,
			'https://pim.pens.com/VAPDetail.aspx?productID=' + convert(nvarchar(20),p.ID) + '&channelID=1&localeID=12' as DefaultURL,
			@WarehouseID as WarehouseID,
			'PLM' as Warehouse
	from [ProductFamilyChannels] pfc
		join Products p 
			on pfc.ProductID = p.ID
		join ProductFamilys pf 
			on pfc.ProductFamilyID = pf.ID
				and pf.Family not like '%sam%'
				and ISNULL(pf.Family,'') <> ''
		left join DistributionChannels dc 
			on dc.ID = pfc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(pfc.StatusID, 4)
		left join Classes c
			on p.Class = c.ID
		left join
			(
				-- exclude Virtual
				select	RelatedProductID
				from ProductAccessories 
				where RelationTypeID = 2
				group by RelatedProductID
			) excl
		on p.ID = excl.RelatedProductID	
		left join 
			(
				select	a.ProductID,
						a.RelatedProductID,
						b.NPProductCode as ProductCode,
						c.NPProductCode as RelatedProductCode,
						d.ID as FamilyID,
						d.Family
				from ProductAccessories a
					join Products b
						on a.ProductID = b.ID
					left join Products c
						on a.RelatedProductID = c.ID
					left join ProductFamilys d
						on a.RelatedProductID = d.ProductID
				where a.RelationTypeID = 2
					and ISNULL(d.Family,'') <> ''
			) rel
		on p.ID = rel.ProductID
			and pf.Family = rel.Family
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pt.ChannelID = @ChannelID
	where StatusID in (5,7,13,14,15)
		and pfc.ChannelID <> 2  --ATLAS
		and excl.RelatedProductID is null
		and ISNULL(pfc.PLM,0) > 0
end


if @WarehouseID = 13
begin					
	insert into #tempStart
		(
			ProductID,
			NPProductCode,
			Family,
			Channel,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE,
			ProductClass,
			RelatedProductCode,
			GroupingCode,
			FamilyVersion,
			NPProductName,
			ProductCreateDate,
			DefaultURL,
			WarehouseID,
			Warehouse
		)
	select  p.ID as ProductID,
			p.NPProductCode, 
			pf.Family, 
			dc.Channel, 
			i.Status, 
			pfc.TNS, 
			pfc.PLM, 
			pfc.IRL, 
			pfc.JPN, 
			pfc.CZE,
			c.Class,
			rel.RelatedProductCode,
			p.GroupingCode,
			pf.[Version],
			pt.NPProductName,
			p.CreationDate,
			'https://pim.pens.com/VAPDetail.aspx?productID=' + convert(nvarchar(20),p.ID) + '&channelID=1&localeID=12' as DefaultURL,
			@WarehouseID as WarehouseID,
			'TNS' as Warehouse
	from [ProductFamilyChannels] pfc
		join Products p 
			on pfc.ProductID = p.ID
		join ProductFamilys pf 
			on pfc.ProductFamilyID = pf.ID
				and pf.Family not like '%sam%'
				and ISNULL(pf.Family,'') <> ''
		left join DistributionChannels dc 
			on dc.ID = pfc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(pfc.StatusID, 4)
		left join Classes c
			on p.Class = c.ID
		left join
			(
				-- exclude Virtual
				select	RelatedProductID
				from ProductAccessories 
				where RelationTypeID = 2
				group by RelatedProductID
			) excl
		on p.ID = excl.RelatedProductID	
		left join 
			(
				select	a.ProductID,
						a.RelatedProductID,
						b.NPProductCode as ProductCode,
						c.NPProductCode as RelatedProductCode,
						d.ID as FamilyID,
						d.Family
				from ProductAccessories a
					join Products b
						on a.ProductID = b.ID
					left join Products c
						on a.RelatedProductID = c.ID
					left join ProductFamilys d
						on a.RelatedProductID = d.ProductID
				where a.RelationTypeID = 2
					and ISNULL(d.Family,'') <> ''
			) rel
		on p.ID = rel.ProductID
			and pf.Family = rel.Family
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pt.ChannelID = @ChannelID
	where StatusID in (5,7,13,14,15)
		and pfc.ChannelID <> 2  --ATLAS
		and excl.RelatedProductID is null
		and ISNULL(pfc.TNS,0) > 0
end


if @WarehouseID = 127
begin					
	insert into #tempStart
		(
			ProductID,
			NPProductCode,
			Family,
			Channel,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE,
			ProductClass,
			RelatedProductCode,
			GroupingCode,
			FamilyVersion,
			NPProductName,
			ProductCreateDate,
			DefaultURL,
			WarehouseID,
			Warehouse
		)
	select  p.ID as ProductID,
			p.NPProductCode, 
			pf.Family, 
			dc.Channel, 
			i.Status, 
			pfc.TNS, 
			pfc.PLM, 
			pfc.IRL, 
			pfc.JPN, 
			pfc.CZE,
			c.Class,
			rel.RelatedProductCode,
			p.GroupingCode,
			pf.[Version],
			pt.NPProductName,
			p.CreationDate,
			'https://pim.pens.com/VAPDetail.aspx?productID=' + convert(nvarchar(20),p.ID) + '&channelID=1&localeID=12' as DefaultURL,
			@WarehouseID as WarehouseID,
			'CZE' as Warehouse
	from [ProductFamilyChannels] pfc
		join Products p 
			on pfc.ProductID = p.ID
		join ProductFamilys pf 
			on pfc.ProductFamilyID = pf.ID
				and pf.Family not like '%sam%'
				and ISNULL(pf.Family,'') <> ''
		left join DistributionChannels dc 
			on dc.ID = pfc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(pfc.StatusID, 4)
		left join Classes c
			on p.Class = c.ID
		left join
			(
				-- exclude Virtual
				select	RelatedProductID
				from ProductAccessories 
				where RelationTypeID = 2
				group by RelatedProductID
			) excl
		on p.ID = excl.RelatedProductID	
		left join 
			(
				select	a.ProductID,
						a.RelatedProductID,
						b.NPProductCode as ProductCode,
						c.NPProductCode as RelatedProductCode,
						d.ID as FamilyID,
						d.Family
				from ProductAccessories a
					join Products b
						on a.ProductID = b.ID
					left join Products c
						on a.RelatedProductID = c.ID
					left join ProductFamilys d
						on a.RelatedProductID = d.ProductID
				where a.RelationTypeID = 2
					and ISNULL(d.Family,'') <> ''
			) rel
		on p.ID = rel.ProductID
			and pf.Family = rel.Family
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pt.ChannelID = @ChannelID
	where StatusID in (5,7,13,14,15)
		and pfc.ChannelID <> 2  --ATLAS
		and excl.RelatedProductID is null
		and ISNULL(pfc.CZE,0) > 0
end


if @WarehouseID = 128
begin					
	insert into #tempStart
		(
			ProductID,
			NPProductCode,
			Family,
			Channel,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE,
			ProductClass,
			RelatedProductCode,
			GroupingCode,
			FamilyVersion,
			NPProductName,
			ProductCreateDate,
			DefaultURL,
			WarehouseID,
			Warehouse
		)
	select  p.ID as ProductID,
			p.NPProductCode, 
			pf.Family, 
			dc.Channel, 
			i.Status, 
			pfc.TNS, 
			pfc.PLM, 
			pfc.IRL, 
			pfc.JPN, 
			pfc.CZE,
			c.Class,
			rel.RelatedProductCode,
			p.GroupingCode,
			pf.[Version],
			pt.NPProductName,
			p.CreationDate,
			'https://pim.pens.com/VAPDetail.aspx?productID=' + convert(nvarchar(20),p.ID) + '&channelID=1&localeID=12' as DefaultURL,
			@WarehouseID as WarehouseID,
			'JPN' as Warehouse
	from [ProductFamilyChannels] pfc
		join Products p 
			on pfc.ProductID = p.ID
		join ProductFamilys pf 
			on pfc.ProductFamilyID = pf.ID
				and pf.Family not like '%sam%'
				and ISNULL(pf.Family,'') <> ''
		left join DistributionChannels dc 
			on dc.ID = pfc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(pfc.StatusID, 4)
		left join Classes c
			on p.Class = c.ID
		left join
			(
				-- exclude Virtual
				select	RelatedProductID
				from ProductAccessories 
				where RelationTypeID = 2
				group by RelatedProductID
			) excl
		on p.ID = excl.RelatedProductID	
		left join 
			(
				select	a.ProductID,
						a.RelatedProductID,
						b.NPProductCode as ProductCode,
						c.NPProductCode as RelatedProductCode,
						d.ID as FamilyID,
						d.Family
				from ProductAccessories a
					join Products b
						on a.ProductID = b.ID
					left join Products c
						on a.RelatedProductID = c.ID
					left join ProductFamilys d
						on a.RelatedProductID = d.ProductID
				where a.RelationTypeID = 2
					and ISNULL(d.Family,'') <> ''
			) rel
		on p.ID = rel.ProductID
			and pf.Family = rel.Family
		left join ProductTranslations pt
			on p.ID = pt.ProductID
				and pt.LocaleID = @LocaleID
				and pt.ChannelID = @ChannelID
	where StatusID in (5,7,13,14,15)
		and pfc.ChannelID <> 2  --ATLAS
		and excl.RelatedProductID is null
		and ISNULL(pfc.JPN,0) > 0
end



insert into @DecoMethodTable
	(	
		ProductID,
		ProdFamily,
		DecoMethod
	)
select	ps.ProductID,
		ps.ProdFamily,
		ps.DecoMethod
from #tempStart t
	join ProductSKUs ps
		on t.ProductID = ps.ProductID
			and t.Family = ps.ProdFamily
group by ps.ProductID,
		 ps.ProdFamily,
		 ps.DecoMethod
order by ps.ProductID,
		 ps.ProdFamily,
		 ps.DecoMethod
		 

-- Keep only 1st deco method for each Prod Family
delete m
from @DecoMethodTable m
	join
		(
			select	ProductID,
					ProdFamily,
					MIN(UniqueID) as MinID
			from @DecoMethodTable
			group by ProductID,ProdFamily
		) d
	on m.ProductID = d.ProductID
		and m.ProdFamily = d.ProdFamily
		and m.UniqueID <> d.MinID


update t1
set t1.DecoMethod = t2.DecoMethod
from #tempStart t1
	join @DecoMethodTable t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.ProdFamily


-- Frozen Cost
insert into @FozenCostTable		
	(
		ProdFamily,
		OracleID,
		OrgID,
		ItemCost
	)
select	ProdFamily,
		OracleID,
		OrgID,
		ItemCost
from
	(
		select	a.ProdFamily,
				a.OracleID,
				b.OrgID,
				b.ItemCost,
				ROW_NUMBER() OVER (PARTITION BY a.ProdFamily,b.OrgID ORDER BY a.OracleID) as RowNumber
		from 
			(
				select	Family
				from #tempStart
				group by Family
			) m
			join ProductSKUs a
				on m.Family = a.ProdFamily
			join CSTItemCost b
				on a.OracleID = b.ItemNumber
	) t
where RowNumber = 1
order by ProdFamily,OracleID,OrgID


update m
set m.FrozenCost = t.ItemCost
from #tempStart m
	join @FozenCostTable t
		on m.Family = t.ProdFamily
where t.OrgID = @WarehouseID




-- Load Main Table
insert #tempFinal
	(
		ProductID,
		ProductClass,
		ABCCode,
		NPProductCode,
		Family,
		GroupingCode,
		ProductDescription,
		ProductCreateDate,
		DecoMethod,
		FrozenCost,
		PIMLink,
		MainFlag,
		WarehouseID,
		Warehouse
	)
select	distinct
		ProductID,
		ProductClass,
		null as ABC,
		NPProductCode as ProductCode,
		null as Family,
		GroupingCode,
		NPProductName as ProdDescription,
		ProductCreateDate,
		null as DecoMethod,
		null as FrozenCost,
		DefaultURL as PIMLink,
		1 as MainFlag,
		WarehouseID,
		Warehouse
from #tempStart

union

select	a.ProductID,
		a.ProductClass,
		null as ABC,
		a.NPProductCode as ProductCode,
		a.Family,
		a.GroupingCode,
		a.FamilyVersion as ProdDescription,
		null as ProductCreateDate,
		a.DecoMethod,
		a.FrozenCost,
		null as PIMLink,
		2 as MainFlag,
		a.WarehouseID,
		a.Warehouse
from #tempStart a
	join
		(
			select	ProductID,
					Family,
					MIN(UniqueID) as MinUniqueID
			from #tempStart
			group by ProductID,
					 Family
		) b
	on a.UniqueID = b.MinUniqueID



update t1
set t1.GSEU = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'GS-EU'
	
update t1
set t1.AUNZ = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'AU/NZ'
	
update t1
set t1.NADM = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'NADM'
	
update t1
set t1.JAPAN = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'JAPAN'
	
update t1
set t1.NPL = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'NPL'
	
update t1
set t1.GSNA = t2.[Status]
from #tempFinal t1
	join #tempStart t2
		on t1.ProductID = t2.ProductID
			and t1.Family = t2.Family
where t1.MainFlag <> 1
	and t2.Channel = 'GS-NA'
	
	
update t1
set t1.FrozenCost = t2.AVG_Frozen
from #tempFinal t1
	join
		(
			select	ProductID,
					avg(ISNULL(FrozenCost,0)) as AVG_Frozen
			from #tempStart
			where FrozenCost is not null
			group by ProductID
		) t2
	on t1.ProductID = t2.ProductID
		and t1.MainFlag = 1



-- Virtual Code Calculation
declare @VirtualTableFamily	table	(
										UniqueID	int identity(1,1) Primary Key,
										ProductID	int,
										Family		nvarchar(60)
									)
									
declare @VirtualTableProduct	table	(
											UniqueID	int identity(1,1) Primary Key,
											ProductID	int
										)
										
declare @VirtualCode	nvarchar(4000),
		@ProductID		int,
		@Family			nvarchar(60)
										
										
insert into @VirtualTableFamily(ProductID,Family)
select	ProductID,
		Family
from #tempStart
where ISNULL(RelatedProductCode,'') <> ''
group by ProductID,Family


insert into @VirtualTableProduct(ProductID)
select	ProductID
from #tempStart
where ISNULL(RelatedProductCode,'') <> ''
group by ProductID


while exists(select top 1 ProductID from @VirtualTableProduct)
begin
	select @ProductID = (select top 1 ProductID from @VirtualTableProduct order by ProductID)

	select @VirtualCode =	(
								SELECT 
								SUBSTRING
									(
										(
											SELECT distinct ',' + RelatedProductCode 
											FROM #tempStart
											WHERE ProductID = @ProductID
											FOR XML PATH('')
										), 
										2,10000
									) AS Csv
							)

							
	update #tempFinal
	set VirtualCode = @VirtualCode
	where ProductID = @ProductID
		and MainFlag = 1
		
	delete @VirtualTableProduct
	where ProductID = @ProductID
	
	set @ProductID = 0
	set @VirtualCode = ''
end


while exists(select top 1 ProductID from @VirtualTableFamily)
begin
	select @ProductID = (select top 1 ProductID from @VirtualTableFamily order by ProductID)
	select @Family = Family from @VirtualTableFamily where ProductID = @ProductID

	select @VirtualCode =	(
								SELECT 
								SUBSTRING
									(
										(
											SELECT distinct ',' + RelatedProductCode 
											FROM #tempStart
											WHERE ProductID = @ProductID
												and Family = @Family
											FOR XML PATH('')
										), 
										2,10000
									) AS Csv
							)
							
	update #tempFinal
	set VirtualCode = @VirtualCode
	where ProductID = @ProductID
		and Family = @Family
		and MainFlag <> 1
		
	delete @VirtualTableFamily
	where ProductID = @ProductID
		and Family = @Family
	
	set @ProductID = 0
	set @VirtualCode = ''
	set @Family = ''
end



-- Deco Method Calculation								
declare @DecoTableProduct	table	(
											UniqueID	int identity(1,1) Primary Key,
											ProductID	int
										)
										
declare @DecoMethod		nvarchar(4000),
		@ProductID_Deco	int
										
										
insert into @DecoTableProduct(ProductID)
select	ProductID
from #tempStart
where ISNULL(DecoMethod,'') <> ''
group by ProductID


while exists(select top 1 ProductID from @DecoTableProduct)
begin
	select @ProductID_Deco = (select top 1 ProductID from @DecoTableProduct order by ProductID)

	select @DecoMethod =	(
								SELECT 
								SUBSTRING
									(
										(
											SELECT distinct ',' + DecoMethod
											FROM #tempStart
											WHERE ProductID = @ProductID_Deco
											FOR XML PATH('')
										), 
										2,10000
									) AS Csv
							)

							
	update #tempFinal
	set DecoMethod = @DecoMethod
	where ProductID = @ProductID_Deco
		and MainFlag = 1
		
	delete @DecoTableProduct
	where ProductID = @ProductID_Deco
	
	set @ProductID_Deco = 0
	set @DecoMethod = ''
end


-- Insert into Main Table
insert into PIM_ETL_STAGE.dbo.Stage_PLM_Sku_Rationalization_P1
	(
		ProductID,
		ProductClass,
		ABCCode,
		NPProductCode,
		Family,
		GroupingCode,
		VirtualCode,
		ProductDescription,
		ProductCreateDate,
		DecoMethod,
		FrozenCost,
		NADM,
		NPL,
		GSNA,
		GSEU,
		AUNZ,
		JAPAN,
		PIMLink,
		MainFlag,
		WarehouseID,
		Warehouse
	)
select  ProductID,
		ProductClass,
		ABCCode,
		NPProductCode,
		Family,
		GroupingCode,
		VirtualCode,
		ProductDescription,
		ProductCreateDate,
		DecoMethod,
		FrozenCost,
		NADM,
		NPL,
		GSNA,
		GSEU,
		AUNZ,
		JAPAN,
		PIMLink	,
		MainFlag,
		WarehouseID,
		Warehouse
from #tempFinal
order by NPProductCode,MainFlag,ProductClass,Family







drop table #tempStart
drop table #tempFinal

GO
