Create Procedure [dbo].[usp_ProductAvailability_PLM_Sku_Rationalization_populate]

as

set nocount on


update m
set m.ReceivedDate = t.ReceivedDate
from ProductAvailability_Sku_Rationalization m
	join
		(
			select	a.ProductID,
					c.Organization_ID as OracleOrgID,
					min(c.Transaction_Date) as ReceivedDate
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 a
				join ProductFOBCostComponents b
					on a.ProductID = b.ProductID
				join PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_OracleTran c
					on b.Component = c.SEGMENT1
			where a.MainFlag = 1
			group by	a.ProductID,
						c.Organization_ID
		) t
	on m.ProductID = t.ProductID
		and m.OracleOrgID = t.OracleOrgID
where isnull(m.ReceivedDate,GETDATE()) > isnull(t.ReceivedDate,GETDATE())


insert ProductAvailability_Sku_Rationalization(ProductID,OracleOrgID,ReceivedDate)
select	a.ProductID,
		c.Organization_ID as OracleOrgID,
		min(c.Transaction_Date) as ReceivedDate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 a
	join ProductFOBCostComponents b
		on a.ProductID = b.ProductID
	join PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_OracleTran c
		on b.Component = c.SEGMENT1
	left join ProductAvailability_Sku_Rationalization d
		on a.ProductID = d.ProductID
			and c.Organization_ID = d.OracleOrgID
where a.MainFlag = 1
	and d.ID is null
group by	a.ProductID,
			c.Organization_ID




update m
set m.FuturePODate = t.FuturePODate
from ProductAvailability_Sku_Rationalization m
	join
		(
			select	a.ProductID,
					c.Organization_ID as OracleOrgID,
					min(c.Delivery_Schedule_Date) as FuturePODate
			from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 a
				join ProductFOBCostComponents b
					on a.ProductID = b.ProductID
				join PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_OraclePO c
					on b.Component = c.SEGMENT1
			where a.MainFlag = 1
			group by	a.ProductID,
						c.Organization_ID
		) t
	on m.ProductID = t.ProductID
		and m.OracleOrgID = t.OracleOrgID
where isnull(m.FuturePODate,GETDATE()) > isnull(t.FuturePODate,GETDATE())



insert ProductAvailability_Sku_Rationalization(ProductID,OracleOrgID,FuturePODate)
select	a.ProductID,
		c.Organization_ID as OracleOrgID,
		min(c.Delivery_Schedule_Date) as FuturePODate
from PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_P2 a
	join ProductFOBCostComponents b
		on a.ProductID = b.ProductID
	join PIM_ETL_Stage.dbo.Stage_PLM_Sku_Rationalization_OraclePO c
		on b.Component = c.SEGMENT1
	left join ProductAvailability d
		on a.ProductID = d.ProductID
			and c.Organization_ID = d.OracleOrgID
where a.MainFlag = 1
	and d.ID is null
group by	a.ProductID,
			c.Organization_ID




GO
