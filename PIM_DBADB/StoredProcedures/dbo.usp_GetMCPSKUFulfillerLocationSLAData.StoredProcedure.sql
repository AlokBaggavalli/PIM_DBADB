CREATE PROCEDURE [dbo].[usp_GetMCPSKUFulfillerLocationSLAData] 
AS
BEGIN



SELECT ps.mcpsku               AS [MCPSKU],
       o.fulfillerlocationcode AS [FulfillmentLocationId],
       t.sla                   AS [TimeValue],
       'DD'                    AS [TimeUnit]
FROM   products p
       JOIN productskus ps
         ON p.id = ps.productid
       LEFT JOIN categorycodes c1
              ON p.oraclecatalog1 = c1.id
       LEFT JOIN categorycodes c2
              ON p.oraclecatalog2 = c2.id
       JOIN orgsladetails t
         ON ps.decomethod = t.decomethod
            AND c1.[description] = t.level1
            AND c2.[description] = t.level2
       JOIN orgs o
         ON t.org = o.org
WHERE  p.SupplierID = 12
	   and isnull(ps.mcpsku,'') <> ''
	   and ps.MCPstatusID <> 1


END
GO
