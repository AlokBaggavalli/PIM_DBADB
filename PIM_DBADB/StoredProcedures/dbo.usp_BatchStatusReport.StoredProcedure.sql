Create Procedure [dbo].[usp_BatchStatusReport]
AS
BEGIN

DECLARE @Query [nvarchar](max); 
DECLARE  @Pivot_ColumnNames [nvarchar](max);  
SELECT @Pivot_ColumnNames =  COALESCE(@Pivot_ColumnNames+',','')+ QUOTENAME(DESCRIPTION) FROM  
(SELECT Description, sortorder from WFTASKS) tab8  order by sortorder


SELECT @Query=' SELECT BatchID AS Batch#,Channel,
case Priority when 1 then ''Normal'' when 2 then ''Rush'' else '''' end ''Priority'',
case Type when 1 then ''Web'' when 2 then ''Mail'' else '''' end ''Type'',
case Type2 when 1 then ''New'' when 2 then ''Existing'' when 2 then ''Other'' else '''' end ''Type2'',
case Type3 when 1 then ''House'' when 2 then ''Vendor'' else '''' end ''Type3'',
NPproductCode,WebCode,ProcessStatus,ItemStatus,SellToCountries,Supplier,CreatedDate,TargetDate,
'+@Pivot_ColumnNames +'  FROM   
(SELECT  bp.BatchID,dc.Channel,b.Priority,b.Type,b.Type2,b.Type3,b.CreatedDate,b.TargetDate,p.NPProductCode,p.selltocountries,pc.WebCode,
ps.Status ProcessStatus,i.Status ItemStatus,s.Name Supplier, bp.ProductID, t.Description ,

Case (StatusID)  when 1 then ''NotStarted'' when 2 then ''InProcess'' when 3 then ''Completed'' else ''Not Applicable''
end ''StatusID''
FROM BatchProductInfo bp JOIN WFTasks t on t.id = bp.TaskID
JOIN BATCHES b on b.ID = bp.BatchID
JOIN PRODUCTS p on p.ID = bp.ProductID
join ProductChannels pc (nolock) on pc.ProductID = p.ID and pc.ChannelID = b.Channel 
left join ProcessStatuses ps (nolock) on ps.ID = pc.ProcessStatusID 
left join Itemstatuses i (nolock) on i.ID = pc.ItemStatusID 
join Suppliers s (nolock) on s.ID = p.SupplierID 
left join DistributionChannels dc (nolock) on dc.ID = b.Channel
)Tab1 
PIVOT  
(  
 max(StatusID) FOR Description IN ('+@Pivot_ColumnNames+')) AS Tab2  
 ORDER BY Tab2.BatchID,TAB2.Channel,TAB2.Supplier,TAB2.NPProductCode'  

EXEC  sp_executesql  @Query 

END
GO
