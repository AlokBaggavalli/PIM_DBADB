Create Procedure [dbo].[usp_PopulateStage_OracleBOMSkuOperationsForExportByBatchID]
	@BatchID			varchar(10)
as

set nocount on

declare @Orgs table (OrgID int,Org varchar(50))

		
Create Table #tmpSkuOperations	(
									UniqueID	int identity(1,1) Primary Key,
									BatchID		int,
									ORG_ID		int,
									ITEM		nvarchar(255),
									SEQ			int,
									CODE		nvarchar(50),
									COMP_SUBINV	nvarchar(50),
									NEW_SEQ		int
								)
								
Create Table #tmpSkuOperations_Final	(
											UniqueID	int Primary Key,
											BatchID		int,
											ORG_ID		int,
											ITEM		nvarchar(255),
											SEQ			int,
											CODE		nvarchar(50),
											COMP_SUBINV	nvarchar(50),
											NEW_SEQ		int
										)
										
Create Table #tmpConstant	(
								SEQ		int,
								CODE	nvarchar(50)
							)
	
insert #tmpConstant
values(40,'4000')
insert #tmpConstant
values(75,'OOS')
insert #tmpConstant
values(100,'CLFY')
insert #tmpConstant
values(800,'FUTR')
insert #tmpConstant
values(900,'2SHP')	



insert @Orgs
values(3,'IRL')
insert @Orgs
values(11,'PLM')
insert @Orgs
values(13,'TNS')
insert @Orgs
values(107,'GER')
insert @Orgs
values(127,'CZE')
insert @Orgs
values(128,'JPN')


insert #tmpSkuOperations	
(
	BatchID,
	ORG_ID,
	ITEM,
	SEQ,
	CODE,
	COMP_SUBINV
)
select	@BatchID as BatchID,
		t.OrgID as ORG_ID,
		ps.OracleID as ITEM,
		oo.Dept as SEQ,
		oo.Code as CODE,
		case
			when ps.OracleID like '%-sam-%'
				then 'MAIL_FGI'
			else
				'FGI'
		end as COMP_SUBINV
from BatchExtractPartial bp
	join ProductSKUs ps
		on bp.ProductID = ps.ProductID
			and bp.SkuID = ps.ID
	join ProductSkuOperations pso
		on ps.ProductID = pso.ProductID
			and ps.ID = pso.ProductSkuID
	join OrgOperations oo
		on pso.OrgOperationsID = oo.ID
	join Orgs o
		on oo.OrgID = o.ID
	left join @Orgs t
		on o.Org = t.Org
where bp.Type = 20
	and bp.BatchID = @BatchID
order by ps.OracleID,oo.Dept,oo.Code
	
	
-- Assign New SEQ for Dupes
update m
set m.NEW_SEQ = m.SEQ + d.RowNumber
from #tmpSkuOperations m
	join
		(
			select	t.UniqueID,
					t.BatchID,
					t.ORG_ID,
					t.ITEM,
					t.SEQ,
					t.CODE,
					t.COMP_SUBINV,
					t.RowNumber - 1 as RowNumber
			from
				(
					select	b.*,
							ROW_NUMBER() OVER(ORDER BY b.UniqueID ASC) as RowNumber
					from
						(
							select	ITEM,
									SEQ as Old_SEQ
							from #tmpSkuOperations	
							group by ITEM,SEQ
							having COUNT(*) > 1
						) a
						join #tmpSkuOperations b
							on a.ITEM = b.ITEM
								and a.Old_SEQ = b.SEQ
				) t
		) d
	on m.UniqueID = d.UniqueID
	
	
insert #tmpSkuOperations_Final
(
	UniqueID,
	BatchID,
	ORG_ID,
	ITEM,
	SEQ,
	CODE,
	COMP_SUBINV,
	NEW_SEQ
)
select	UniqueID,
		BatchID,
		ORG_ID,
		ITEM,
		SEQ,
		CODE,
		COMP_SUBINV,
		isnull(NEW_SEQ,SEQ) as NEW_SEQ
from #tmpSkuOperations
order by UniqueID


delete PIM_ETL_STAGE.dbo.Stage_OracleBOMSkuOperationsForExport
where BatchID = @BatchID


insert into PIM_ETL_STAGE.dbo.Stage_OracleBOMSkuOperationsForExport
(
	BatchID,
	ORG_ID,
	ITEM,
	SEQ,
	CODE,
	COMP_SUBINV
)
select	BatchID,
		ORG_ID,
		ITEM,
		NEW_SEQ as SEQ,
		CODE,
		COMP_SUBINV
from #tmpSkuOperations_Final

union

select	a.BatchID,
		a.ORG_ID,
		a.ITEM,
		b.SEQ,
		b.CODE,
		a.COMP_SUBINV
from #tmpSkuOperations_Final a
	join #tmpConstant b
		on 1 = 1
GO
