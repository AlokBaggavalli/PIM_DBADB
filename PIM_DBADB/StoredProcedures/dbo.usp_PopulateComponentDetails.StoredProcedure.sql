CREATE procedure [dbo].[usp_PopulateComponentDetails]
as
 
Begin 

/***************************************************************************************************
Procedure		: usp_PopulateComponentDetails
Create Date		: 22-Feb-2022
Author			: Baggavalli, Alok.    
Description		: Populate Component details data from oracle to PIM tables.
Usage			: Exec dbo.usp_PopulateComponentDetails
                    
****************************************************************************************************
SUMMARY OF CHANGES:
-------------------
Date(yyyy-mm-dd)    Author              WorkItemID	   Comments 	
------------------- ------------------- -------------- ----------------------------------------------
2022-02-22          Alok Thippesha      Task: 824      Created procedure to populate the component related newly created tables in PIM.


****************************************************************************************************/

-- Stage required Data: 
/*
Truncate table dbo.componentorgdetails;
Delete from dbo.components;
DBCC CHECKIDENT ('PIM.dbo.components', RESEED, 0)
*/

IF Object_id('tempdb..#PLMControlABCStage') IS NOT NULL
  BEGIN
      DROP TABLE #plmcontrolabcstage
  END

	SELECT A.organization_id,
		   A.productfamily,
		   C.NPProductCode,
		   A.component_item,
		   A.UOM,
		   C.abccode
	INTO   #plmcontrolabcstage
	FROM   (Select ORGANIZATION_ID
				  ,PRODUCTFAMILY
				  ,COMPONENT_ITEM
				  ,UOM
		    from [dbo].[plmcontrolworkflow]
			Group by ORGANIZATION_ID
				  ,PRODUCTFAMILY
				  ,COMPONENT_ITEM
				  ,UOM
			) A
		   JOIN [PIM_ETL_STAGE].[dbo].[stage_plmcontrol_p2] C
			 ON A.ORGANIZATION_ID = C.warehouseid
				AND A.PRODUCTFAMILY = C.Family				
	WHERE  Isnull(C.abccode, '') <> ''
	GROUP  BY A.organization_id,
			  A.productfamily,
			  C.NPProductCode,
			  A.component_item,
			  A.UOM,
			  C.abccode
	ORDER  BY A.organization_id,
			  A.productfamily,
			  C.NPProductCode,
			  A.component_item,
			  C.abccode

-- Populate data into Components table
	INSERT INTO dbo.components
				(component, UOM)
	SELECT component_item, 
		   UOM
	FROM   (SELECT A.component_item,
				   A.UOM,
				   B.component
			FROM   #plmcontrolabcstage A
				   LEFT JOIN [dbo].[components] B
						  ON A.component_item = B.component
			WHERE  Isnull(A.component_item, '') <> ''
				   AND B.component IS NULL
			GROUP  BY A.component_item,
					  A.UOM,
					  B.component) A

	-- Update ABC Code with latest values
	UPDATE C
	SET    C.abcid = B.abccode
	FROM   dbo.componentorgdetails C
		   JOIN dbo.components A
			 ON A.id = C.componentid
		   JOIN #plmcontrolabcstage B
			 ON C.componentid = A.id
				AND C.orgid = B.organization_id
				AND C.productfamily = B.productfamily
				AND C.productcode = B.npproductcode
				AND C.abcid <> B.abccode

	-- Insert new components with ABC Code.
	INSERT INTO dbo.componentorgdetails
				(componentid,
				 orgid,
				 productfamily,
				 productcode,
				 abcid)
	SELECT A.id,
		   B.organization_id,
		   B.productfamily,
		   B.npproductcode,
		   B.abccode
	FROM   dbo.components A
		   JOIN #plmcontrolabcstage B
			 ON A.component = B.component_item
		   LEFT JOIN dbo.componentorgdetails C
				  ON A.id = C.componentid
					 AND B.organization_id = C.orgid
					 AND B.productfamily = C.productfamily
					 AND B.npproductcode = C.productcode
	WHERE  C.componentid IS NULL
	ORDER  BY A.id,
			  B.organization_id,
			  B.productfamily,
			  B.npproductcode,
			  B.abccode 

End
GO
