CREATE PROCEDURE [dbo].[spProductSummaryStatusInitialUpdate]
AS
BEGIN
	SET NOCOUNT ON;

Create table #productSummaryChannels(ProductId int, ChannelId int, SummaryStatusId int null)
Create table #prodFamilyStatus(ProductId int, ChannelId int, StatusId int null, Status nvarchar(50) null, SummaryOrder int null)
Create table #productIDs(ProductId int)
DECLARE @productId  int, @channelId int, @summaryStatusId int = NULL, @MinHierarchyOrder int = NULL

INSERT INTO #productIDs Select ID from Products where SupplierID = 12 --National Pen Products

while EXISTS(SELECT TOP 1 * FROM #productIDs)
BEGIN
    SELECT TOP 1 @productId = ProductId FROM #productIDs  
    
	INSERT INTO #productSummaryChannels Select ProductID, ChannelID, SummaryStatusId from ProductChannels where ProductID=@productId

	while EXISTS(SELECT TOP 1 * FROM #productSummaryChannels)
	BEGIN
		SELECT TOP 1 @productId = ProductId, @channelId = ChannelId, @summaryStatusId = SummaryStatusId FROM #productSummaryChannels
		IF(@summaryStatusId is null)
		BEGIN
			INSERT INTO #prodFamilyStatus 
			Select pf.ProductID, pf.ChannelID, pf.StatusID, i.Status, i.SummaryOrder
			FROM ProductFamilyChannels pf join ItemStatuses i on pf.StatusID = i.ID
			WHERE pf.ProductID = @productId and pf.ChannelID = @channelId

			Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatus

			Select top 1 @summaryStatusId = StatusId from #prodFamilyStatus where SummaryOrder = @MinHierarchyOrder

			Update ProductChannels set SummaryStatusId = @summaryStatusId where ProductID = @productId and ChannelID = @channelId

			Select @summaryStatusId = NULL
			Select @MinHierarchyOrder = NULL
			DELETE FROM #prodFamilyStatus
		END
		DELETE FROM #productSummaryChannels WHERE ProductId = @productId and ChannelId = @channelId 
	END
 
    DELETE FROM #productIDs WHERE ProductId = @productId  
END
DROP TABLE #productIDs
DROP TABLE #productSummaryChannels
DROP TABLE #prodFamilyStatus

END
GO
