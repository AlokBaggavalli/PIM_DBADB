CREATE Procedure [dbo].[usp_PopulateStageOracleBOMForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @UniqueID			int,
		@OrgID_String		varchar(200),
		@Org				varchar(50),
		@OrgID				int,
		@LocaleID			int,
		@Type				varchar(50),
		@MinID				int,
		@BatchStatus		int
		

create table #tmpBOM	(
							UniqueID			int identity(10,10) Primary Key,
							ProductID			int,
							ProductSkuID		int,
							SKUOrgID			int,
							SKUOrg				varchar(50),
							BatchID				int,
							FINISH_GOODS_SKU	nvarchar(250),
							RAW_MATERIAL_SKU	nvarchar(30),
							ITEM_SEQUENCE		int,
							OPERATION_SEQUENCE	int,
							QUANTITY			decimal(10,6),
							OrgID_String		varchar(200),
							SUB_INVENTORY		nvarchar(25),
							SUPPLY_TYPE			nvarchar(25),
							INCLUDED_IN_COST_ROLLUP	varchar(10),
							SHIPPABLE			varchar(10),
							[STATUS]			varchar(10),
							[ERROR_MESSAGE]		varchar(10),
							CREATION_DATE		varchar(10),
							CREATED_BY			varchar(10),
							LAST_UPDATE_DATE	varchar(10),
							LAST_UPDATED_BY		varchar(10)
						)
						
create table #tmpOrg	(
							UniqueID			int Primary Key,
							OrgID_String		varchar(200)
						)
						
create table #tmpOrgFinal	(
								UniqueID		int,
								Org				varchar(50),
								OrgID			int
							)
							
							
create table #tmpBOMFinal	(
								UniqueID			int identity(1,1) Primary Key,
								ProductID			int,
								ProductSkuID		int,
								BatchID				int,
								FINISH_GOODS_SKU	nvarchar(250),
								RAW_MATERIAL_SKU	nvarchar(30),
								ITEM_SEQUENCE		int,
								OPERATION_SEQUENCE	int,
								QUANTITY			decimal(10,6),
								Org					varchar(50),
								OrgID				int,
								SUB_INVENTORY		nvarchar(25),
								SUPPLY_TYPE			nvarchar(25),
								INCLUDED_IN_COST_ROLLUP	varchar(10),
								SHIPPABLE			varchar(10),
								[STATUS]			varchar(10),
								[ERROR_MESSAGE]		varchar(10),
								CREATION_DATE		varchar(10),
								CREATED_BY			varchar(10),
								LAST_UPDATE_DATE	varchar(10),
								LAST_UPDATED_BY		varchar(10)
							)
							
							
set @LocaleID = 12 -- LOCALE=en_US
set @Type = '20'



select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('6')  -- Partial Extract Only
				)
				
				
select @BatchStatus = [Status] from BatchExtracts where ID = @MinID

select @ExtractCompleted = '7'


insert #tmpBOM	
(
	ProductID,
	ProductSkuID,
	SKUOrgID,
	SKUOrg,
	BatchID,
	FINISH_GOODS_SKU,
	RAW_MATERIAL_SKU,
	ITEM_SEQUENCE,
	OPERATION_SEQUENCE,
	QUANTITY,
	OrgID_String,
	SUB_INVENTORY,
	SUPPLY_TYPE,
	INCLUDED_IN_COST_ROLLUP,
	SHIPPABLE,
	[STATUS],
	[ERROR_MESSAGE],
	CREATION_DATE,
	CREATED_BY,
	LAST_UPDATE_DATE,
	LAST_UPDATED_BY
)
select	p.ID as ProductID,
		psbm.ProductSkuID,
		psbm.OrgID,
		o.Org,
		be.BatchID,
		ps.OracleID as FINISH_GOODS_SKU,
		psbm.Component as RAW_MATERIAL_SKU,
		null as ITEM_SEQUENCE,
		1 AS OPERATION_SEQUENCE,
		psbm.Quantity,
		bep.Value as OrgID_String,
		LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(psbm.SubInventory, CHAR(10),CHAR(32)),CHAR(13), CHAR(32)),CHAR(160), CHAR(32)),CHAR(9),CHAR(32)))) as SUB_INVENTORY,
		psbm.SupplyType as SUPPLY_TYPE,
		'Y' as INCLUDED_IN_COST_ROLLUP,
		'Y' as SHIPPABLE,
		'N' as [STATUS],
		null as [ERROR_MESSAGE],
		null as CREATION_DATE,
		null as CREATED_BY,
		null as LAST_UPDATE_DATE,
		null as LAST_UPDATED_BY
from Products p
	join ProductBatches pb
		on p.ID = pb.ProductID
			--and pb.ChannelID = 1 -- NADM Only (Take All channel for Oracle BOM
	join dbo.BatchExtracts be
		on pb.BatchID = be.BatchID
	left join ProductSKUs ps
			ON p.ID = ps.ProductID
	left join ProductSkuBillOfMaterials psbm
		on p.ID = psbm.ProductID
			and ps.ID = psbm.ProductSkuID
	left join Orgs o
		on psbm.OrgID = o.ID
	join BatchExtractPartial bep
		on be.BatchID = bep.BatchID
			and be.[Type] = bep.[Type]
			and bep.ProductID = p.ID
			and bep.[SkuID] = psbm.ProductSkuID
where be.[Status] = '6'
	and be.ID = @MinID

	
insert #tmpOrg	
(
	UniqueID,
	OrgID_String
)
select	UniqueID,
		OrgID_String
from #tmpBOM
order by UniqueID


while exists(select top 1 UniqueID from #tmpOrg)
begin
	select	@UniqueID = (select top 1 UniqueID from #tmpOrg order by UniqueID)
	select	@OrgID_String = OrgID_String from #tmpOrg where UniqueID = @UniqueID
	
	insert #tmpOrgFinal(UniqueID,Org)
	select @UniqueID,Data from dbo.Split(@OrgID_String,',') order by Data
	
	
	delete #tmpOrg where UniqueID = @UniqueID
end


update #tmpOrgFinal
set OrgID = case
				when Org = 'IRL' then 3
				when Org = 'TNS' then 13
				when Org = 'PLM' then 11
				when Org = 'GER' then 107
				when Org = 'CZE' then 127
				when Org = 'JPN' then 128
			else
				null
			end
where 1 = 1


insert #tmpBOMFinal	
(
	ProductID,
	ProductSkuID,
	BatchID,
	FINISH_GOODS_SKU,
	RAW_MATERIAL_SKU,
	ITEM_SEQUENCE,
	OPERATION_SEQUENCE,
	QUANTITY,
	Org,
	OrgID,
	SUB_INVENTORY,
	SUPPLY_TYPE,
	INCLUDED_IN_COST_ROLLUP,
	SHIPPABLE,
	[STATUS],
	[ERROR_MESSAGE],
	CREATION_DATE,
	CREATED_BY,
	LAST_UPDATE_DATE,
	LAST_UPDATED_BY
)
select 
	a.ProductID,
	a.ProductSkuID,
	a.BatchID,
	a.FINISH_GOODS_SKU,
	a.RAW_MATERIAL_SKU,
	b.UniqueID as ITEM_SEQUENCE,
	a.OPERATION_SEQUENCE,
	a.QUANTITY,
	b.Org,
	b.OrgID,
	a.SUB_INVENTORY,
	a.SUPPLY_TYPE,
	a.INCLUDED_IN_COST_ROLLUP,
	a.SHIPPABLE,
	a.[STATUS],
	a.[ERROR_MESSAGE],
	a.CREATION_DATE,
	a.CREATED_BY,
	a.LAST_UPDATE_DATE,
	a.LAST_UPDATED_BY
from #tmpBOM a
	join #tmpOrgFinal b
		on a.UniqueID = b.UniqueID
			and a.SKUOrg = b.Org
order by a.UniqueID,b.Org




insert PIM_ETL_STAGE.dbo.Stage_OracleBOMForExport
(
	[ProductID]
      ,[ProductSkuID]
      ,[BatchID]
      ,[FINISHED_GOODS_SKU]
      ,[RAW_MATERIAL_SKU]
      ,[ITEM_SEQUENCE]
      ,[OPERATION_SEQUENCE]
      ,[QUANTITY]
      ,[Org]
      ,[OrgID]
      ,[SUB_INVENTORY]
      ,[SUPPLY_TYPE]
      ,[INCLUDED_IN_COST_ROLLUP]
      ,[SHIPPABLE]
      ,[STATUS]
      ,[ERROR_MESSAGE]
      ,[CREATION_DATE]
      ,[CREATED_BY]
      ,[LAST_UPDATE_DATE]
      ,[LAST_UPDATED_BY]
)
select [ProductID]
      ,[ProductSkuID]
      ,[BatchID]
      ,[FINISH_GOODS_SKU]
      ,[RAW_MATERIAL_SKU]
      ,[ITEM_SEQUENCE] * 10 as [ITEM_SEQUENCE]
      ,[OPERATION_SEQUENCE]
      ,[QUANTITY]
      ,[Org]
      ,[OrgID]
      ,[SUB_INVENTORY]
      ,[SUPPLY_TYPE]
      ,[INCLUDED_IN_COST_ROLLUP]
      ,[SHIPPABLE]
      ,[STATUS]
      ,[ERROR_MESSAGE]
      ,[CREATION_DATE]
      ,[CREATED_BY]
      ,[LAST_UPDATE_DATE]
      ,[LAST_UPDATED_BY]
from
	(
		select	
			   [UniqueID]
			  ,[ProductID]
			  ,[ProductSkuID]
			  ,[BatchID]
			  ,[FINISH_GOODS_SKU]
			  ,[RAW_MATERIAL_SKU]
			  ,ROW_NUMBER() OVER(PARTITION BY ProductID,ProductSkuID,Org ORDER BY ORG) AS [ITEM_SEQUENCE]
			  ,[OPERATION_SEQUENCE]
			  ,[QUANTITY]
			  ,[Org]
			  ,[OrgID]
			  ,[SUB_INVENTORY]
			  ,[SUPPLY_TYPE]
			  ,[INCLUDED_IN_COST_ROLLUP]
			  ,[SHIPPABLE]
			  ,[STATUS]
			  ,[ERROR_MESSAGE]
			  ,[CREATION_DATE]
			  ,[CREATED_BY]
			  ,[LAST_UPDATE_DATE]
			  ,[LAST_UPDATED_BY]
		from #tmpBOMFinal
	) t
order by UniqueID



drop table #tmpBOM	
drop table #tmpOrg
drop table #tmpOrgFinal
drop table #tmpBOMFinal





GO
