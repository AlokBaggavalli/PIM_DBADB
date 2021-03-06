CREATE Procedure [dbo].[usp_ConversionExchangeRate_Populate]

as

set nocount on


update a
set a.Conversion_Rate = b.Conversion_Rate,
	a.Conversion_Date = b.Conversion_Date
from ConversionExchangeRate a
	join PIM_ETL_STAGE.dbo.Stage_ConversionExchangeRate b
		on a.From_Currency = b.From_Currency
			and a.To_Currency = b.To_Currency
			--and a.Conversion_Date = b.Conversion_Date
--where a.Conversion_Rate <> b.Conversion_Rate



insert ConversionExchangeRate
	(
		From_Currency,
		To_Currency,
		Conversion_Date,
		Conversion_Rate
	)
select	a.From_Currency,
		a.To_Currency,
		a.Conversion_Date,
		a.Conversion_Rate 
from PIM_ETL_STAGE.dbo.Stage_ConversionExchangeRate a
	left join ConversionExchangeRate b
		on a.From_Currency = b.From_Currency
			and a.To_Currency = b.To_Currency
			and a.Conversion_Date = b.Conversion_Date
where b.From_Currency is null



GO
