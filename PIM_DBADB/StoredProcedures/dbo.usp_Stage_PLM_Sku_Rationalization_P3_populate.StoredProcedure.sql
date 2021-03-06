Create Procedure [dbo].[usp_Stage_PLM_Sku_Rationalization_P3_populate]

as

set nocount on

truncate table [PIM_ETL_STAGE].[dbo].[Stage_PLM_Sku_Rationalization_P3]


insert [PIM_ETL_STAGE].[dbo].[Stage_PLM_Sku_Rationalization_P3]
(
	[UniqueID],
	[ProductID],
	[ProductClass],
	[NPProductCode],
	[Family],
	[GroupingCode],
	[VirtualCode],
	[ProductDescription],
	[ProductCreateDate],
	[DecoMethod],
	[PIMLink],
	[MainFlag],
	[WarehouseID],
	[Warehouse]
)
select	a.UniqueID,
		a.ProductID,
		a.ProductClass,
		a.NPProductCode,
		a.Family,
		a.GroupingCode,
		a.VirtualCode,
		a.ProductDescription,
		a.ProductCreateDate,
		a.DecoMethod,
		a.PIMLink,
		a.MainFlag,
		a.WarehouseID,
		a.Warehouse
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 a
	join
	(
		select	NPProductCode,
				MIN(UniqueID) as MinUniqueID
		from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
		where MainFlag = 1
		group by NPProductCode
	) b
	on a.UniqueID = b.MinUniqueID

union

select	a.UniqueID,
		a.ProductID,
		a.ProductClass,
		a.NPProductCode,
		a.Family,
		a.GroupingCode,
		a.VirtualCode,
		a.ProductDescription,
		a.ProductCreateDate,
		a.DecoMethod,
		a.PIMLink,
		a.MainFlag,
		a.WarehouseID,
		a.Warehouse
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 a
	join
	(
		select	NPProductCode,
				Family,
				MIN(UniqueID) as MinUniqueID
		from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
		where MainFlag <> 1
		group by NPProductCode,
				 Family
	) b
	on a.UniqueID = b.MinUniqueID


-- NADM
update m
set m.NADM = t.NADM
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.NADM is not null


-- SUM_NADM_NE_REV 
update m
set m.SUM_NADM_NE_REV = t.SUM_NADM_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NADM_NE_REV) as SUM_NADM_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NADM_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NADM_NE_REV = t.SUM_NADM_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NADM_NE_REV) as SUM_NADM_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NADM_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NADM_EV_REV 
update m
set m.SUM_NADM_EV_REV = t.SUM_NADM_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NADM_EV_REV) as SUM_NADM_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NADM_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NADM_EV_REV = t.SUM_NADM_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NADM_EV_REV) as SUM_NADM_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NADM_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NADM_NE_UNITS
update m
set m.SUM_NADM_NE_UNITS = t.SUM_NADM_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NADM_NE_UNITS) as SUM_NADM_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NADM_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NADM_NE_UNITS = t.SUM_NADM_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NADM_NE_UNITS) as SUM_NADM_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NADM_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NADM_EV_UNITS 
update m
set m.SUM_NADM_EV_UNITS = t.SUM_NADM_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NADM_EV_UNITS) as SUM_NADM_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NADM_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NADM_EV_UNITS = t.SUM_NADM_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NADM_EV_UNITS) as SUM_NADM_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NADM_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1




-- NPL
update m
set m.NPL = t.NPL
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.NPL is not null


-- SUM_NPL_NE_REV 
update m
set m.SUM_NPL_NE_REV = t.SUM_NPL_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NPL_NE_REV) as SUM_NPL_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NPL_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NPL_NE_REV = t.SUM_NPL_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NPL_NE_REV) as SUM_NPL_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NPL_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NPL_EV_REV 
update m
set m.SUM_NPL_EV_REV = t.SUM_NPL_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NPL_EV_REV) as SUM_NPL_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NPL_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NPL_EV_REV = t.SUM_NPL_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NPL_EV_REV) as SUM_NPL_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NPL_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NPL_NE_UNITS
update m
set m.SUM_NPL_NE_UNITS = t.SUM_NPL_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NPL_NE_UNITS) as SUM_NPL_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NPL_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NPL_NE_UNITS = t.SUM_NPL_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NPL_NE_UNITS) as SUM_NPL_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NPL_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_NPL_EV_UNITS 
update m
set m.SUM_NPL_EV_UNITS = t.SUM_NPL_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_NPL_EV_UNITS) as SUM_NPL_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_NPL_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_NPL_EV_UNITS = t.SUM_NPL_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_NPL_EV_UNITS) as SUM_NPL_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_NPL_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1





-- GSNA
update m
set m.GSNA = t.GSNA
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.GSNA is not null


-- SUM_GSNA_NE_REV 
update m
set m.SUM_GSNA_NE_REV = t.SUM_GSNA_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSNA_NE_REV) as SUM_GSNA_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSNA_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSNA_NE_REV = t.SUM_GSNA_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSNA_NE_REV) as SUM_GSNA_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSNA_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSNA_EV_REV 
update m
set m.SUM_GSNA_EV_REV = t.SUM_GSNA_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSNA_EV_REV) as SUM_GSNA_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSNA_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSNA_EV_REV = t.SUM_GSNA_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSNA_EV_REV) as SUM_GSNA_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSNA_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSNA_NE_UNITS
update m
set m.SUM_GSNA_NE_UNITS = t.SUM_GSNA_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSNA_NE_UNITS) as SUM_GSNA_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSNA_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSNA_NE_UNITS = t.SUM_GSNA_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSNA_NE_UNITS) as SUM_GSNA_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSNA_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSNA_EV_UNITS 
update m
set m.SUM_GSNA_EV_UNITS = t.SUM_GSNA_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSNA_EV_UNITS) as SUM_GSNA_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSNA_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSNA_EV_UNITS = t.SUM_GSNA_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSNA_EV_UNITS) as SUM_GSNA_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSNA_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1





-- GSEU
update m
set m.GSEU = t.GSEU
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.GSEU is not null


-- SUM_GSEU_NE_REV 
update m
set m.SUM_GSEU_NE_REV = t.SUM_GSEU_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSEU_NE_REV) as SUM_GSEU_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSEU_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSEU_NE_REV = t.SUM_GSEU_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSEU_NE_REV) as SUM_GSEU_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSEU_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSEU_EV_REV 
update m
set m.SUM_GSEU_EV_REV = t.SUM_GSEU_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSEU_EV_REV) as SUM_GSEU_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSEU_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSEU_EV_REV = t.SUM_GSEU_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSEU_EV_REV) as SUM_GSEU_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSEU_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSEU_NE_UNITS
update m
set m.SUM_GSEU_NE_UNITS = t.SUM_GSEU_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSEU_NE_UNITS) as SUM_GSEU_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSEU_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSEU_NE_UNITS = t.SUM_GSEU_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSEU_NE_UNITS) as SUM_GSEU_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSEU_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_GSEU_EV_UNITS 
update m
set m.SUM_GSEU_EV_UNITS = t.SUM_GSEU_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_GSEU_EV_UNITS) as SUM_GSEU_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_GSEU_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_GSEU_EV_UNITS = t.SUM_GSEU_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_GSEU_EV_UNITS) as SUM_GSEU_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_GSEU_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1





-- AUNZ
update m
set m.AUNZ = t.AUNZ
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.AUNZ is not null


-- SUM_AUNZ_NE_REV 
update m
set m.SUM_AUNZ_NE_REV = t.SUM_AUNZ_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_AUNZ_NE_REV) as SUM_AUNZ_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_AUNZ_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_AUNZ_NE_REV = t.SUM_AUNZ_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_AUNZ_NE_REV) as SUM_AUNZ_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_AUNZ_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_AUNZ_EV_REV 
update m
set m.SUM_AUNZ_EV_REV = t.SUM_AUNZ_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_AUNZ_EV_REV) as SUM_AUNZ_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_AUNZ_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_AUNZ_EV_REV = t.SUM_AUNZ_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_AUNZ_EV_REV) as SUM_AUNZ_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_AUNZ_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_AUNZ_NE_UNITS
update m
set m.SUM_AUNZ_NE_UNITS = t.SUM_AUNZ_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_AUNZ_NE_UNITS) as SUM_AUNZ_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_AUNZ_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_AUNZ_NE_UNITS = t.SUM_AUNZ_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_AUNZ_NE_UNITS) as SUM_AUNZ_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_AUNZ_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_AUNZ_EV_UNITS 
update m
set m.SUM_AUNZ_EV_UNITS = t.SUM_AUNZ_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_AUNZ_EV_UNITS) as SUM_AUNZ_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_AUNZ_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_AUNZ_EV_UNITS = t.SUM_AUNZ_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_AUNZ_EV_UNITS) as SUM_AUNZ_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_AUNZ_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1




-- JAPAN
update m
set m.JAPAN = t.JAPAN
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2 t
		on m.ProductID = t.ProductID
			and m.Family = t.Family
where t.JAPAN is not null


-- SUM_JAPAN_NE_REV 
update m
set m.SUM_JAPAN_NE_REV = t.SUM_JAPAN_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_JAPAN_NE_REV) as SUM_JAPAN_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_JAPAN_NE_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_JAPAN_NE_REV = t.SUM_JAPAN_NE_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_JAPAN_NE_REV) as SUM_JAPAN_NE_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_JAPAN_NE_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_JAPAN_EV_REV 
update m
set m.SUM_JAPAN_EV_REV = t.SUM_JAPAN_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_JAPAN_EV_REV) as SUM_JAPAN_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_JAPAN_EV_REV is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_JAPAN_EV_REV = t.SUM_JAPAN_EV_REV
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_JAPAN_EV_REV) as SUM_JAPAN_EV_REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_JAPAN_EV_REV is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1
		
		
-- SUM_JAPAN_NE_UNITS
update m
set m.SUM_JAPAN_NE_UNITS = t.SUM_JAPAN_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_JAPAN_NE_UNITS) as SUM_JAPAN_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_JAPAN_NE_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_JAPAN_NE_UNITS = t.SUM_JAPAN_NE_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_JAPAN_NE_UNITS) as SUM_JAPAN_NE_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_JAPAN_NE_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1


-- SUM_JAPAN_EV_UNITS 
update m
set m.SUM_JAPAN_EV_UNITS = t.SUM_JAPAN_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					SUM(SUM_JAPAN_EV_UNITS) as SUM_JAPAN_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag = 1
				and SUM_JAPAN_EV_UNITS is not null
			group by NPProductCode
		) t
	on m.NPProductCode = t.NPProductCode
		and m.MainFlag = 1


update m
set m.SUM_JAPAN_EV_UNITS = t.SUM_JAPAN_EV_UNITS
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join 
		(
			select	NPProductCode,
					Family,
					SUM(SUM_JAPAN_EV_UNITS) as SUM_JAPAN_EV_UNITS
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P2
			where MainFlag <> 1
				and SUM_JAPAN_EV_UNITS is not null
			group by NPProductCode,
					 Family
		) t
	on m.NPProductCode = t.NPProductCode
		and m.Family = t.Family
		and m.MainFlag <> 1
		


-- Total Rev and Total Units
update m
set m.SUM_TOTAL_REV = z.TotalRev,
	m.SUM_TOTAL_UNITS = z.TotalUnits
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
	(
		select	ProductID,
				case
					when SUM(TotalRev) = 0
						then null
					else
						SUM(TotalRev)
				end as TotalRev,
				case
					when SUM(TotalUnits) = 0
						then null
					else
						SUM(TotalUnits)
				end as TotalUnits
		from
			(
				select
							ProductID,
							WarehouseID,
							isnull(SUM_NADM_NE_REV,0) + isnull(SUM_NADM_EV_REV,0) + 
							isnull(SUM_GSNA_NE_REV,0) + isnull(SUM_GSNA_EV_REV,0) +
							isnull(SUM_AUNZ_NE_REV,0) + isnull(SUM_AUNZ_EV_REV,0) + 
							isnull(SUM_JAPAN_NE_REV,0) + isnull(SUM_JAPAN_EV_REV,0) + 
							isnull(SUM_NPL_NE_REV,0) + isnull(SUM_NPL_EV_REV,0) +
							isnull(SUM_GSEU_NE_REV,0) + isnull(SUM_GSEU_EV_REV,0) as TotalRev,
							
							isnull(SUM_NADM_NE_UNITS,0) + isnull(SUM_NADM_EV_UNITS,0) + 
							isnull(SUM_GSNA_NE_UNITS,0) + isnull(SUM_GSNA_EV_UNITS,0) +
							isnull(SUM_AUNZ_NE_UNITS,0) + isnull(SUM_AUNZ_EV_UNITS,0) + 
							isnull(SUM_JAPAN_NE_UNITS,0) + isnull(SUM_JAPAN_EV_UNITS,0) + 
							isnull(SUM_NPL_NE_UNITS,0) + isnull(SUM_NPL_EV_UNITS,0) +
							isnull(SUM_GSEU_NE_UNITS,0) + isnull(SUM_GSEU_EV_UNITS,0) as TotalUnits
					from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3
					where MainFlag = 1		
			) t
		group by ProductID
	) z
	on m.ProductID = z.ProductID	
where m.MainFlag = 1


update m
set m.SUM_TOTAL_REV = z.TotalRev,
	m.SUM_TOTAL_UNITS = z.TotalUnits
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
		(
			select	ProductID,
					Family,
					case
						when SUM(TotalRev) = 0
							then null
						else
							SUM(TotalRev)
					end as TotalRev,
					case
						when SUM(TotalUnits) = 0
							then null
						else
							SUM(TotalUnits)
					end as TotalUnits
			from
				(
					select
							ProductID,
							Family,
							isnull(SUM_NADM_NE_REV,0) + isnull(SUM_NADM_EV_REV,0) + 
							isnull(SUM_GSNA_NE_REV,0) + isnull(SUM_GSNA_EV_REV,0) +
							isnull(SUM_AUNZ_NE_REV,0) + isnull(SUM_AUNZ_EV_REV,0) + 
							isnull(SUM_JAPAN_NE_REV,0) + isnull(SUM_JAPAN_EV_REV,0) + 
							isnull(SUM_NPL_NE_REV,0) + isnull(SUM_NPL_EV_REV,0) +
							isnull(SUM_GSEU_NE_REV,0) + isnull(SUM_GSEU_EV_REV,0) as TotalRev,
							
							isnull(SUM_NADM_NE_UNITS,0) + isnull(SUM_NADM_EV_UNITS,0) + 
							isnull(SUM_GSNA_NE_UNITS,0) + isnull(SUM_GSNA_EV_UNITS,0) +
							isnull(SUM_AUNZ_NE_UNITS,0) + isnull(SUM_AUNZ_EV_UNITS,0) + 
							isnull(SUM_JAPAN_NE_UNITS,0) + isnull(SUM_JAPAN_EV_UNITS,0) + 
							isnull(SUM_NPL_NE_UNITS,0) + isnull(SUM_NPL_EV_UNITS,0) +
							isnull(SUM_GSEU_NE_UNITS,0) + isnull(SUM_GSEU_EV_UNITS,0) as TotalUnits
					from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3
					where MainFlag <> 1
				) t
			group by ProductID,Family
		) z
	on m.ProductID = z.ProductID	
		and m.Family = z.Family
where m.MainFlag <> 1



-- Prod Class
update m
set m.Total_Rev_ProdClass = Case
								when isnull(t.REV,0) = 0
									then null
								else
									t.REV
							End
from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
		(
			select	ProductClass,
					SUM(SUM_TOTAL_REV) as REV
			from [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3
			where MainFlag = 1
			group by ProductClass
		) t
	on m.ProductClass = t.ProductClass
where m.MainFlag = 1


update [PIM_ETL_STAGE].dbo.Stage_PLM_Sku_Rationalization_P3
set Percent_Rev_ProdClass = case
								when ((ISNULL(SUM_TOTAL_REV,0) / Total_Rev_ProdClass) * 100) = 0
									then null
								else
									(ISNULL(SUM_TOTAL_REV,0) / Total_Rev_ProdClass) * 100
							end
where MainFlag = 1
	and isnull(Total_Rev_ProdClass,0) <> 0




declare @Table_Acum		Table	(
									UniqueID				int identity(1,1) Primary Key,
									Orig_UID				int,
									ProductClass			nvarchar(50),
									Percent_Rev_ProdClass	decimal(10,2)
								)
								
insert @Table_Acum 
	(
		Orig_UID,
		ProductClass,
		Percent_Rev_ProdClass
	)								
select	UniqueID,
		ProductClass,
		Percent_Rev_ProdClass
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
where MainFlag = 1
order by ProductClass,Percent_Rev_ProdClass desc


update mm
set mm.Acum_Percent = zz.Acum_Percent
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 mm
	join
		(
			select	m.*,
					t.Percent_Rev_ProdClass as Acum_Percent
			from @Table_Acum m
				join
					(
						select	a.UniqueID,
								a.ProductClass,
								SUM(b.Percent_Rev_ProdClass) as Percent_Rev_ProdClass
						from
							(
								select	UniqueID,
										ProductClass,
										Percent_Rev_ProdClass
								from @Table_Acum
							) a
							left join 
							(
								select	UniqueID,
										ProductClass,
										Percent_Rev_ProdClass
								from @Table_Acum
							) b
							on a.ProductClass = b.ProductClass
								and a.UniqueID >= b.UniqueID
						group by a.UniqueID,a.ProductClass
					) t
				on m.UniqueID = t.UniqueID
		) zz
	on mm.UniqueID = zz.Orig_UID


update m
set m.AVG_Sales_ProdClass = z.AVG_Sales_ProdClass
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
		(
			select	ProductClass,
					case
						when (isnull(Total_Rev_ProdClass,0) / ProdCount) = 0
							then null
						else 
							Total_Rev_ProdClass / ProdCount
					end as AVG_Sales_ProdClass
			from
				(
					select	ProductClass,
							Min(Total_Rev_ProdClass) as Total_Rev_ProdClass,
							COUNT(distinct(ProductID)) as ProdCount
					from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
					where MainFlag = 1
					group by ProductClass
				) t
		) z
	on m.ProductClass = z.ProductClass
where m.MainFlag = 1


update m
set m.Percent_Compared_To_Actual_PC = t.Percent_Compared_To_Actual_PC
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
		(
			select	UniqueID,
					ProductClass,
					case
						when ((isnull(SUM_TOTAL_REV,0) / AVG_Sales_ProdClass) * 100) = 0
							then null
						else
							((isnull(SUM_TOTAL_REV,0) / AVG_Sales_ProdClass) * 100)
					end	as Percent_Compared_To_Actual_PC
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where MainFlag = 1
				and isnull(AVG_Sales_ProdClass,0) <> 0
		) t
	on m.UniqueID = t.UniqueID



update m
set m.Unique_Combination_Colors = t.ColorCount
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join
		(
			select	a.ProductID,
					COUNT(*) as ColorCount
			from ProductAttributes a
				join ProductAttributeColors b
					on a.ProductID = b.ProductID
						and a.ID = b.ProductAttributeID
						and isnull(a.[Primary],0) = 1
			where isnull(b.ColorClassID,0) <> 1
			group by a.ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1


-- NADM
update m
set m.NADM_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 1 -- NADM
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where NADM is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- NPL
update m
set m.NPL_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 4 -- NPL
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where NPL is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- GSNA
update m
set m.GSNA_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 3 -- GSNA
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where GSNA is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- GSEU
update m
set m.GSEU_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 7 -- GSEU
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where GSEU is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- AUNZ
update m
set m.AUNZ_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 5 -- AUNZ
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where AUNZ is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- JAPAN
update m
set m.JAPAN_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 6 -- JAPAN
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P3
			where JAPAN is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1


--select * from [PIM_ETL_Stage].[dbo].[Stage_PLM_Sku_Rationalization_P3] WHERE NPPRODUCTCODE = 'ACD'
GO
