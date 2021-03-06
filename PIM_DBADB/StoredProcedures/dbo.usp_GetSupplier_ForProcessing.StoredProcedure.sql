CREATE Procedure [dbo].[usp_GetSupplier_ForProcessing]

as

set nocount on



select	top 1
		a.ID,
		a.SupplierID,
		isnull(b.MaxDate,convert(datetime,convert(varchar(8),GETDATE(),112))) as MaxDate
from ImportManager a
	left join 
		(
			select	SupplierID,
					MAX(convert(datetime,convert(varchar(8),LastUpdateDate,112))) as MaxDate
			from PIM_Import.dbo.Products
			group by SupplierID	
		) b
	on a.SupplierID = b.SupplierID
where a.StatusID = 3
order by a.ID

GO
