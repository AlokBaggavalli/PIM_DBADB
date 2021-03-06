Create Procedure [dbo].[usp_Stage_PLM_Sku_Rationalization_P2_update]

as

set nocount on

-- NADM
update m
set m.NADM_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 1 -- NADM
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where NADM is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- NPL
update m
set m.NPL_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 4 -- NPL
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where NPL is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- GSNA
update m
set m.GSNA_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 3 -- GSNA
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where GSNA is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- GSEU
update m
set m.GSEU_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 7 -- GSEU
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where GSEU is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- AUNZ
update m
set m.AUNZ_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 5 -- AUNZ
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where AUNZ is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
	
-- JAPAN
update m
set m.JAPAN_Target_Date = pc.TargetDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join ProductChannels pc
		on m.ProductID = pc.ProductID
			and pc.ChannelID = 6 -- JAPAN
	join
		(
			select	ProductID
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
			where JAPAN is not null
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1

	
-- Unique Combo of Color
update m
set m.Unique_Combination_Colors = t.ColorCount
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
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



-- MOQ
update m
set m.MOQ = t.MinMOQ
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 m
	join
		(
			select	ProductID,
					MIN(MOQ) as MinMOQ
			from ProductComponent
			group by ProductID
		) t
	on m.ProductID = t.ProductID
where m.MainFlag = 1


update PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2
set MOQ_Turns_PerYear = (Forecast_TOTAL_UNITS * 2) / (MOQ * Unique_Combination_Colors)
where MainFlag = 1
	and isnull(Forecast_TOTAL_UNITS,0) <> 0
	and isnull(MOQ,0) <> 0
	and isnull(Unique_Combination_Colors,0) <> 0




GO
