Create Procedure [dbo].[usp_Stage_PLMControl_P2_FirstAvailable_update]

as

set nocount on

update m
set m.FirstAvailableDate = isnull(pa.ReceivedDate,FuturePODate)
from PIM_ETL_Stage.dbo.Stage_PLMControl_P2 m
	join ProductAvailability pa
		on m.ProductID = pa.ProductID
			and m.WarehouseID = pa.OracleOrgID
where m.MainFlag = 1

GO
