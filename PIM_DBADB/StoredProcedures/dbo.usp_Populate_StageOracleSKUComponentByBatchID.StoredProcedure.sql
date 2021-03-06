CREATE Procedure [dbo].[usp_Populate_StageOracleSKUComponentByBatchID]
	@BatchID		varchar(10)
	
as


set nocount on

declare @Component	table(ProductID int,Component nvarchar(100))
declare @Orgs table (OrgID int,Org varchar(50))
declare @Cost table (uniqueid int identity(1,1),CostType varchar(50),CostElement varchar(50),SubElement varchar(50),Basis varchar(50))
declare @FinalTable	table	(
								UniqueID				int identity(1,1) Primary Key,
								Org_ID					int,
								NPProductCode			nvarchar(60),
								Item					nvarchar(60),
								CostType				nvarchar(50),
								Cost_Element			nvarchar(50),
								Sub_Element				nvarchar(50),
								Basis					nvarchar(50),
								Value					decimal(20,5),
								CreatedDate				datetime default(getdate()),
								BatchID					int
							)
							
declare @YearToUse		int

select @YearToUse = case
						when MONTH(GETDATE()) > 6
							then Year(DATEADD(YEAR,1,GETDATE()))
						else
							YEAR(GETDATE())
					end



insert @Component(ProductID,Component)
select	ProductID,[Description]
from BatchExtractPartial
where Type = 5
	and BatchID = @BatchID

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


insert @Cost(CostType,CostElement,SubElement,Basis)
values('Pending','Material','MATERIAL','Item')
insert @Cost(CostType,CostElement,SubElement,Basis)
values('Pending','Material Overhead','FREIGHT','Total Value')
insert @Cost(CostType,CostElement,SubElement,Basis)
values('Pending','Material Overhead','DUTY','Item')
insert @Cost(CostType,CostElement,SubElement,Basis)
values('Pending','Material Overhead','DUTY','Total Value')


insert @FinalTable	(
						Org_ID,
						NPProductCode,
						Item,
						CostType,
						Cost_Element,
						Sub_Element,
						Basis,
						Value,
						BatchID
					)
select	OrgID as Org_ID,
		NPProductCode,
		NpComponent as Item,
		CostType as Cost_Type,
		CostElement as Cost_Element,
		SubElement as Sub_Element,
		Basis,
		Case
			when uniqueid = 1
				then isnull(ItemCost,0)
			when uniqueid = 2
				then isnull(Freight,0)
			when uniqueid = 3
				then isnull(Duty1,0)
			when uniqueid = 4
				then isnull(Duty,0)
			else
				0
		end as Value,
		@BatchID as BatchID
from
	(
		SELECT  distinct p.NPProductCode, 
				org.OrgID,
				org.Org,
				ct.uniqueid,
				ct.CostType,
				ct.CostElement,
				ct.SubElement,
				ct.Basis,
				ccp.Country ProductCOO , 
				ccmc.Country MaterialCOO, 
				ms.Supplier , 
				mb.Buyer , 
				mc.PartNumber SupplierPart,  
				cc.Component NpComponent,  
				uom.Code UOM, 
				mc.ItemCost AS ItemCost, 			
				case
					when org.Org = 'TNS'
						then ccp.TNS
					when org.Org = 'PLM'
						then ccp.PLM
					when org.Org = 'IRL'
						then ccp.IRL
					when org.Org = 'GER'
						then ccp.GER
					when org.Org = 'CZE'
						then ccp.CZE
					when org.Org = 'JPN'
						then ccp.JPN
					else
						0
				end as ProductFreightPct,							
				case
					when org.Org = 'TNS'
						then ccmc.TNS
					when org.Org = 'PLM'
						then ccmc.PLM
					when org.Org = 'IRL'
						then ccmc.IRL
					when org.Org = 'GER'
						then ccmc.GER
					when org.Org = 'CZE'
						then ccmc.CZE
					when org.Org = 'JPN'
						then ccmc.JPN
					else
						0
				end as MaterialFreightPct,			
				case
					when org.Org = 'TNS'
						then isnull(ISNULL(ccmc.TNS,ccp.TNS),0)
					when org.Org = 'PLM'
						then isnull(ISNULL(ccmc.PLM,ccp.PLM),0)
					when org.Org = 'IRL'
						then isnull(ISNULL(ccmc.IRL,ccp.IRL),0)
					when org.Org = 'GER'
						then isnull(ISNULL(ccmc.GER,ccp.GER),0)
					when org.Org = 'CZE'
						then isnull(ISNULL(ccmc.CZE,ccp.CZE),0)
					when org.Org = 'JPN'
						then isnull(ISNULL(ccmc.JPN,ccp.JPN),0)
					else
						0
				end as Freight,
				case
					when org.OrgID in(3,107,127,128)
						then ISNULL(hi.EuDutyPct,0)
					when org.OrgID in(11)
						then ISNULL(hi.MxDutyPct,0)
					else
						ISNULL(hi.UsDutyPct,0)
				end Duty,
				p.EUTarriffCode, 
				p.TarriffCode,
				hi.EuDutyPct,
				hi.UsDutyPct,
				case 
					when org.Org in('TNS') 
						then hi.UsAdditionalCost 
					when org.Org in('PLM') 
						then hi.MxAdditionalCost
					else 
						null 
				end as Duty1
		FROM[dbo].[ProductFOBMaterialCosts] AS mc 
			JOIN @Orgs org
				on 1 = 1
			JOIN @Cost ct
				on 1 = 1
			LEFT JOIN PRODUCTS p 
				ON p.id = mc.ProductID 			
			LEFT JOIN
				(
					select	a.*,
							b.Country
					from [dbo].[FreightCostPercentages] a
						join [dbo].[CountryCodes] b
							on a.COO = b.ID
					where CONVERT(int,FYXX) = @YearToUse
				) ccp
				on ccp.Country = p.COO				
			LEFT JOIN
				(
					select	aa.*,
							bb.Country
					from [dbo].[FreightCostPercentages] aa
						join [dbo].[CountryCodes] bb
							on aa.COO = bb.ID
					where CONVERT(int,FYXX) = @YearToUse
				) ccmc
				on ccmc.Country = mc.COO
				
			LEFT JOIN [dbo].[MaterialSuppliers] ms 
				on ms.ID = mc.MaterialSupplierID 
			LEFT JOIN [dbo].[MaterialBuyers] mb 
				on mb.id = mc.BuyerID 
			LEFT JOIN [dbo].[ProductFOBCostComponents] cc 
				on cc.[ProductFobMaterialCostsID] = mc.ID 
			LEFT JOIN [dbo].[SkuUOM] uom 
				on uom.ID = cc.UOMID 
				
			LEFT JOIN HtsInfo hi
				on p.HtsInfoID = hi.ID		
			JOIN @Component comp
				on cc.ProductID = comp.ProductID
					and cc.Component = comp.Component
		where p.SupplierID = 12  
			and ISNULL(cc.Component,'') <> ''
	) t
order by NPProductCode,Org_ID,Item,uniqueid


delete @FinalTable where Value = 0


delete PIM_ETL_STAGE.dbo.Stage_OracleSKUComponentForEBSExport where BatchID = @BatchID


insert PIM_ETL_STAGE.dbo.Stage_OracleSKUComponentForEBSExport
(
	Org_ID,
	NPProductCode,
	Item,
	CostType,
	Cost_Element,
	Sub_Element,
	Basis,
	Value,
	CreatedDate,
	BatchID

)
select 
	Org_ID,
	NPProductCode,
	Item,
	CostType,
	Cost_Element,
	Sub_Element,
	Basis,
	Value,
	CreatedDate,
	BatchID 
from @FinalTable
order by UniqueID









GO
