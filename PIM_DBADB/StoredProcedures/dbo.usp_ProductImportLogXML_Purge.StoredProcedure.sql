Create Procedure [dbo].[usp_ProductImportLogXML_Purge]
	@PurgeDaysBack	int,
	@DeleteBatch	int
	
as

set nocount on

Create Table #tmpIDHold	(
							dID	int Primary Key
						)


insert #tmpIDHold(dID)
select	top (@DeleteBatch) ID
from dbo.ProductImportLogXML
where LoadDate < GETDATE() - @PurgeDaysBack



delete p
from dbo.ProductImportLogXML p
	join #tmpIDHold t
		on p.ID = t.dID




drop table #tmpIDHold
GO
