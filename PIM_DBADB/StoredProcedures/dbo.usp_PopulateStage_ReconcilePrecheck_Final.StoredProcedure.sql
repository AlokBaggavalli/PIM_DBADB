CREATE Procedure [dbo].[usp_PopulateStage_ReconcilePrecheck_Final]

as

set nocount on

insert PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_Final
	(
		[ProductID]
      ,[NPProductCode]
      ,[Class]
      ,[GroupingCode]
      ,[ProductFamily]
      ,[Version]
      ,[BusinessUnit]
      ,[Status]
      ,[TNS]
      ,[PLM]
      ,[IRL]
      ,[JPN]
	  ,[CZE]
      ,[PF_Status_IRL]
      ,[PF_Status_TNS]
      ,[PF_Status_PLM]
	  ,[PF_Status_JPN]
	  ,[PF_Status_CZE]
      ,[Planned_Item_IRL]
      ,[Planned_Item_TNS]
      ,[Planned_Item_PLM]
	  ,[Planned_Item_JPN]
	  ,[Planned_Item_CZE]
      ,[IRL_BOM]
      ,[TNS_BOM]
      ,[PLM_BOM]
	  ,[JPN_BOM]
	  ,[CZE_BOM]
      ,[PF_In_Demantra]
      ,[ProductClass]
      ,[ProductGroupingCode]
      ,[ProdsRegion]
      ,[ProdsFacility]
      ,[ProdsSet]
      ,[ProdsName]
	)
select	a.ProductID,
		replace(a.NPProductCode,',',':') as NPProductCode,
		replace(cl.Class,',',':') as Class,
		replace(a.GroupingCode,',',':') as GroupingCode,
		replace(a.Family,',',':') as ProductFamily,
		replace(a.[Version],',',':') as [Version],
		replace(a.BusinessUnit,',',':') as BusinessUnit,
		replace(a.[Status],',',':') as [Status],
		a.TNS,
		a.PLM,
		a.IRL,
		a.JPN,
		a.CZE,
		replace(irl.Inventory_Item_Status_Code,',',':') as PF_Status_IRL,
		replace(tns.Inventory_Item_Status_Code,',',':') as PF_Status_TNS,
		replace(plm.Inventory_Item_Status_Code,',',':') as PF_Status_PLM,
		replace(jpn.Inventory_Item_Status_Code,',',':') as PF_Status_JPN,
		replace(cze.Inventory_Item_Status_Code,',',':') as PF_Status_CZE,
		replace(plannedirl.Planned_Item_IRL,',',':') as Planned_Item_IRL,
		replace(plannedtns.Planned_Item_TNS,',',':') as Planned_Item_TNS,
		replace(plannedplm.Planned_Item_PLM,',',':') as Planned_Item_PLM,
		replace(plannedjpn.Planned_Item_JPN,',',':') as Planned_Item_JPN,
		replace(plannedcze.Planned_Item_CZE,',',':') as Planned_Item_CZE,
		replace(bomirl.BomFlag,',',':') as IRL_BOM,
		replace(bomtns.BomFlag,',',':') as TNS_BOM,
		replace(bomplm.BomFlag,',',':') as PLM_BOM,
		replace(bomjpn.BomFlag,',',':') as JPN_BOM,
		replace(bomcze.BomFlag,',',':') as CZE_BOM,
		case
			when isnull(dem.DemantraFamily,'') <> ''
				then 'Yes'
			else
				'No'
		end as PF_In_Demantra,
		--prods.ProductClass,
		--prods.ProductGroupingCode,
		replace(prods.ProductGroupingCode,',',':') as ProductClass,
		replace(prods.ProductClass,',',':') as ProductGroupingCode,
		replace(prods.ProdsRegion,',',':') as ProdsRegion,
		replace(prods.ProdsFacility,',',':') as ProdsFacility,
		replace(prods.ProdsSet,',',':') as ProdsSet,
		replace(prods.ProdsName,',',':') as ProdsName
from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P1 a
	left join Classes cl
		on a.Class = cl.ID
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P2 irl
		on a.Family = irl.Segment1
			and irl.Organization_ID = 3
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P2 plm
		on a.Family = plm.Segment1
			and plm.Organization_ID = 11
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P2 tns
		on a.Family = tns.Segment1
			and tns.Organization_ID = 13
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P2 jpn
		on a.Family = jpn.Segment1
			and jpn.Organization_ID = 128
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P2 cze
		on a.Family = cze.Segment1
			and cze.Organization_ID = 127

	left join 
		(
			select	irlaa.Segment1,
					isnull(irlaa.Component_Item,'') + MultipleCheck as Planned_Item_IRL,
					irlaa.UniqueID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3 irlaa
				join
					(
						select	Segment1,
								Organization_ID,
								MIN(UniqueID) MinUniqueID,
								Case when COUNT(*) > 1 then ' (multiple) ' else '' end MultipleCheck
						from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3
						where Organization_ID = 3
						group by	Segment1,
									Organization_ID
					) irlaai
				on irlaa.UniqueID = irlaai.MinUniqueID	
		) plannedirl
	on a.Family = plannedirl.Segment1

	left join 
		(
			select	tnsaa.Segment1,
					isnull(tnsaa.Component_Item,'') + MultipleCheck as Planned_Item_TNS,
					tnsaa.UniqueID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3 tnsaa
				join
					(
						select	Segment1,
								Organization_ID,
								MIN(UniqueID) MinUniqueID,
								Case when COUNT(*) > 1 then ' (multiple) ' else '' end MultipleCheck
						from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3
						where Organization_ID = 13
						group by	Segment1,
									Organization_ID
					) tnsaai
				on tnsaa.UniqueID = tnsaai.MinUniqueID	
		) plannedtns
	on a.Family = plannedtns.Segment1
	left join 
		(
			select	plmaa.Segment1,
					isnull(plmaa.Component_Item,'') + MultipleCheck as Planned_Item_PLM,
					plmaa.UniqueID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3 plmaa
				join
					(
						select	Segment1,
								Organization_ID,
								MIN(UniqueID) MinUniqueID,
								Case when COUNT(*) > 1 then ' (multiple) ' else '' end MultipleCheck
						from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3
						where Organization_ID = 11
						group by	Segment1,
									Organization_ID
					) plmaai
				on plmaa.UniqueID = plmaai.MinUniqueID	
		) plannedplm
	on a.Family = plannedplm.Segment1
	left join 
		(
			select	jpnaa.Segment1,
					isnull(jpnaa.Component_Item,'') + MultipleCheck as Planned_Item_JPN,
					jpnaa.UniqueID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3 jpnaa
				join
					(
						select	Segment1,
								Organization_ID,
								MIN(UniqueID) MinUniqueID,
								Case when COUNT(*) > 1 then ' (multiple) ' else '' end MultipleCheck
						from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3
						where Organization_ID = 128
						group by	Segment1,
									Organization_ID
					) jpnaai
				on jpnaa.UniqueID = jpnaai.MinUniqueID	
		) plannedjpn
	on a.Family = plannedjpn.Segment1
	left join 
		(
			select	czeaa.Segment1,
					isnull(czeaa.Component_Item,'') + MultipleCheck as Planned_Item_CZE,
					czeaa.UniqueID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3 czeaa
				join
					(
						select	Segment1,
								Organization_ID,
								MIN(UniqueID) MinUniqueID,
								Case when COUNT(*) > 1 then ' (multiple) ' else '' end MultipleCheck
						from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P3
						where Organization_ID = 127
						group by	Segment1,
									Organization_ID
					) czeaai
				on czeaa.UniqueID = czeaai.MinUniqueID	
		) plannedcze
	on a.Family = plannedcze.Segment1
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P4 bomirl
		on a.Family = bomirl.Segment1
			and plannedirl.Planned_Item_IRL = bomirl.Component_Item
			and bomirl.Organization_ID = 3
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P4 bomtns
		on a.Family = bomtns.Segment1
			and plannedtns.Planned_Item_TNS = bomtns.Component_Item
			and bomtns.Organization_ID = 13
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P4 bomplm
		on a.Family = bomplm.Segment1
			and plannedplm.Planned_Item_PLM = bomplm.Component_Item
			and bomplm.Organization_ID = 11
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P4 bomjpn
		on a.Family = bomjpn.Segment1
			and plannedjpn.Planned_Item_JPN = bomjpn.Component_Item
			and bomjpn.Organization_ID = 128
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P4 bomcze
		on a.Family = bomcze.Segment1
			and plannedcze.Planned_Item_CZE = bomcze.Component_Item
			and bomcze.Organization_ID = 127
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P5 dem
		on a.Family = dem.PIMFamily
	left join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P6 prods
		on a.NPProductCode = prods.ProductClass
			and a.BusinessUnit = prods.BusinessUnit	
			
			
-- update LocationInDemantra
update m
set m.LocationInDemantra = 1
from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_Final m
	join
		(
			select	f.UniqueID,
					f.ProductFamily,
					dc.ID as ChannelID,
					dil.DemantraLocationId,
					s.Location_ID
			from PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_Final f
				join PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P5_A s
					on f.ProductFamily = s.Item
				join DistributionChannels dc
					on f.BusinessUnit = dc.Channel
				join DemantraItemLocations dil
					on dc.ID = dil.ChannelID
						and dil.DemantraLocationId = s.Location_ID
		) t
	on m.UniqueID = t.UniqueID		
GO
