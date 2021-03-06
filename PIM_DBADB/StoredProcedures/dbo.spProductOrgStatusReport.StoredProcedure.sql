CREATE PROCEDURE [dbo].[spProductOrgStatusReport]
AS
BEGIN
	SET NOCOUNT ON;

Create table #productOrgStatus(NPProductCode nvarchar(50), TNSStatus nvarchar(50) null, PLMStatus nvarchar(50) null, IRLStatus nvarchar(50) null, JPNStatus nvarchar(50) null, CZEStatus nvarchar(50) null)
Create table #prodFamilyStatus(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #productCodes(NPProductCode nvarchar(50))
Create table #prodFamilyStatusForProduct(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #prodFamilyStatusTNS(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #prodFamilyStatusPLM(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #prodFamilyStatusIRL(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #prodFamilyStatusJPN(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
Create table #prodFamilyStatusCZE(NPProductCode nvarchar(50), Family nvarchar(100) null, Channel nvarchar(10) null, StatusID int null, Status nvarchar(50) null, SummaryOrder int null, TNS int null, PLM int null, IRL int null, JPN int null, CZE int null)
DECLARE @productCode  nvarchar(50), @countTNS int, @countPLM int, @countIRL int, @countJPN int, @countCZE int, @MinHierarchyOrder int = NULL, @Status nvarchar(50) = NULL

INSERT INTO #prodFamilyStatus 
SELECT p.NPProductCode ,pf.Family ,ds.Channel ,pfc.[StatusID] ,ims.Status ,ims.SummaryOrder ,pfc.[TNS] ,pfc.[PLM] ,pfc.[IRL], pfc.[JPN], pfc.[CZE]
  FROM [ProductFamilyChannels] pfc
  left join products p on p.id = pfc.ProductID
  left join ItemStatuses ims on ims.id = pfc.statusid
  left join DistributionChannels ds on ds.id = pfc.ChannelID
  left join ProductFamilys pf on pf.ID = pfc.ProductFamilyID
  where p.SupplierID = 12 --National Pen Products
  order by Family asc


INSERT INTO #productCodes Select distinct NPProductCode from #prodFamilyStatus

while EXISTS(SELECT TOP 1 * FROM #productCodes)
BEGIN
    SELECT TOP 1 @productCode = NPProductCode FROM #productCodes  
    
	INSERT INTO #prodFamilyStatusForProduct Select * from #prodFamilyStatus where NPProductCode=@productCode

	INSERT INTO #prodFamilyStatusTNS Select * from #prodFamilyStatusForProduct where TNS <> 0 and TNS is not null
	INSERT INTO #prodFamilyStatusPLM Select * from #prodFamilyStatusForProduct where PLM <> 0 and PLM is not null
	INSERT INTO #prodFamilyStatusIRL Select * from #prodFamilyStatusForProduct where IRL <> 0 and IRL is not null
	INSERT INTO #prodFamilyStatusJPN Select * from #prodFamilyStatusForProduct where JPN <> 0 and JPN is not null
	INSERT INTO #prodFamilyStatusCZE Select * from #prodFamilyStatusForProduct where CZE <> 0 and CZE is not null

	--Get the counts
	select @countTNS = count(*) from #prodFamilyStatusTNS
	select @countPLM = count(*) from #prodFamilyStatusPLM
	select @countIRL = count(*) from #prodFamilyStatusIRL
	select @countJPN = count(*) from #prodFamilyStatusJPN
	select @countCZE = count(*) from #prodFamilyStatusCZE

	INSERT INTO #productOrgStatus(NPProductCode) Select @productCode

	IF(@countTNS > 0)
	BEGIN
		Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatusTNS
		Select top 1 @Status = Status from #prodFamilyStatusTNS where SummaryOrder = @MinHierarchyOrder
		IF(@Status is not null)
		BEGIN
			UPDATE #productOrgStatus set TNSStatus = @Status where NPProductCode = @productCode
		END
	END

	IF(@countPLM > 0)
	BEGIN
		Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatusPLM
		Select top 1 @Status = Status from #prodFamilyStatusPLM where SummaryOrder = @MinHierarchyOrder
		IF(@Status is not null)
		BEGIN
			UPDATE #productOrgStatus set PLMStatus = @Status where NPProductCode = @productCode
		END
	END

	IF(@countIRL > 0)
	BEGIN
		Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatusIRL
		Select top 1 @Status = Status from #prodFamilyStatusIRL where SummaryOrder = @MinHierarchyOrder
		IF(@Status is not null)
		BEGIN
			UPDATE #productOrgStatus set IRLStatus = @Status where NPProductCode = @productCode
		END
	END

	IF(@countJPN > 0)
	BEGIN
		Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatusJPN
		Select top 1 @Status = Status from #prodFamilyStatusJPN where SummaryOrder = @MinHierarchyOrder
		IF(@Status is not null)
		BEGIN
			UPDATE #productOrgStatus set JPNStatus = @Status where NPProductCode = @productCode
		END
	END

	IF(@countCZE > 0)
	BEGIN
		Select @MinHierarchyOrder = MIN(SummaryOrder) from #prodFamilyStatusCZE
		Select top 1 @Status = Status from #prodFamilyStatusCZE where SummaryOrder = @MinHierarchyOrder
		IF(@Status is not null)
		BEGIN
			UPDATE #productOrgStatus set CZEStatus = @Status where NPProductCode = @productCode
		END
	END

    DELETE FROM #productCodes WHERE NPProductCode = @productCode  
    DELETE FROM #prodFamilyStatusForProduct
    DELETE FROM #prodFamilyStatusTNS
    DELETE FROM #prodFamilyStatusPLM
    DELETE FROM #prodFamilyStatusIRL
    DELETE FROM #prodFamilyStatusJPN
    DELETE FROM #prodFamilyStatusCZE
	SET @countTNS=0; SET @countPLM=0; SET @countIRL=0; SET @countJPN=0; SET @countCZE=0;
	SET @MinHierarchyOrder=null; SET @Status=null;
END

SELECT * from #productOrgStatus 
ORDER BY NPProductCode

DROP TABLE #prodFamilyStatus
DROP TABLE #productCodes
DROP TABLE #prodFamilyStatusForProduct
DROP TABLE #prodFamilyStatusTNS
DROP TABLE #prodFamilyStatusPLM
DROP TABLE #prodFamilyStatusIRL
DROP TABLE #prodFamilyStatusJPN
DROP TABLE #prodFamilyStatusCZE
DROP TABLE #productOrgStatus

END
GO
