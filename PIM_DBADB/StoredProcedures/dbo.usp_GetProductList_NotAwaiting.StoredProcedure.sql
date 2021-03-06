Create Procedure [dbo].[usp_GetProductList_NotAwaiting]

as

set nocount on

select	p.SupplierID,
		p.VendorProductID
from Products p
	join
		(
			select ProductID
			from ProductChannels
			where ProcessStatusID <> 1
			group by ProductID
		) t
	on p.ID = t.ProductID
group by p.SupplierID,p.VendorProductID
GO
