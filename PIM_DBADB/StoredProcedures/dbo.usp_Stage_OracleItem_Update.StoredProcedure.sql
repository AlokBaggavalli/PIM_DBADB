CREATE Procedure [dbo].[usp_Stage_OracleItem_Update]

as 

set nocount on

update a
set a.ItemID = b.Inventory_Item_ID
from PIM_ETL_STAGE.dbo.Stage_OracleItem a
	join PIM_ETL_STAGE.dbo.Stage_OracleItemProcess b
		on a.Item = b.Segment1
where a.ItemID is null
GO
