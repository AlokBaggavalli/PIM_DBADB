CREATE Procedure [dbo].[usp_ATGCompSKUColorMapper_Populate]

as

set nocount on


Truncate Table dbo.ATGCompSKUColorMapper


insert dbo.ATGCompSKUColorMapper
	(
		CompSKU_ID,
		Color_ID,
		Color_Value,
		Color_Name,
		Display_Name
	)
select	CompSKU_ID,
		Color_ID,
		Color_Value,
		Color_Name,
		Display_Name
from [PIM_ETL_STAGE].[dbo].[Stage_ATGCompSKUColorMapper]

GO
