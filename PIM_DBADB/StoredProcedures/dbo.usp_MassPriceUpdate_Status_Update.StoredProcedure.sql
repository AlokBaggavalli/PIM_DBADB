CREATE Procedure [dbo].[usp_MassPriceUpdate_Status_Update]
	@ExtractCompleted	varchar(50)
	
as

set nocount on


update mpu
set mpu.StatusID = @ExtractCompleted,
	mpu.LastUpdatedDate = GETDATE()
from MassPriceUpdate mpu
	join
		(	
			select	b.ProductID
			from dbo.Stage_MassPriceListForCSVExport a
				join Products p
					on a.ITEM = p.NPProductCode	
				join MassPriceUpdate b
					on p.ID = b.ProductID
			where b.StatusID = 2
			group by b.ProductID
		) t
	on mpu.ProductID = t.ProductID
where mpu.StatusID = 2
GO
