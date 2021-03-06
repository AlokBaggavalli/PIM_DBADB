CREATE Procedure [dbo].[usp_PopulateStageReconcilePreCheck_P1]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @Precheck_1	Table	(
								UniqueID						int identity(1,1) Primary Key,
								ProductID						int,
								NPProductCode					nvarchar(50),
								Class							int,
								GroupingCode					nvarchar(10),
								Family							nvarchar(100),
								[Version]						nvarchar(100),
								BusinessUnit					nvarchar(10),
								[Status]						nvarchar(50),
								TNS								int,
								PLM								int,
								IRL								int,
								JPN								int,
								CZE								int
							)
								


declare @LocaleID					int,
		@BType						varchar(50),
		@MinID						int,
		@BatchStatus				int



set @LocaleID = 12 -- LOCALE=en_US
set @BType = '26'




select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @BType
						and [Status] in('2','6')
				)

select @BatchStatus = [Status] from BatchExtracts where ID = @MinID



if @BatchStatus = 2
begin
	insert @Precheck_1
		(
			ProductID,
			NPProductCode,
			Class,
			GroupingCode,
			Family,
			[Version],
			BusinessUnit,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE
		)
	select	p.ID as ProductID,
			p.NPProductCode, 
			p.Class, 
			p.GroupingCode, 
			pf.Family, 
			pf.Version, 
			dc.Channel BusinessUnit, 
			i.Status, 
			fc.TNS, 
			fc.PLM, 
			fc.IRL,
			fc.JPN,
			fc.CZE
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only  (Comment out to Take All Products)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join ProductFamilys pf 
			on pf.ProductID = p.ID
		join ProductFamilyChannels fc 
			on fc.ProductFamilyID = pf.ID
		left join DistributionChannels dc 
			on dc.ID = fc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(fc.StatusID, 4)
	where p.SupplierID = 12
		and be.[Status] = '2'
		and be.ID = @MinID
	order by	p.NPProductCode, 
				pf.Family, 
				pf.Version, 
				dc.Channel
end



if @BatchStatus = 6
begin
	insert @Precheck_1
		(
			ProductID,
			NPProductCode,
			Class,
			GroupingCode,
			Family,
			[Version],
			BusinessUnit,
			[Status],
			TNS,
			PLM,
			IRL,
			JPN,
			CZE
		)
	select	p.ID as ProductID,
			p.NPProductCode, 
			p.Class, 
			p.GroupingCode, 
			pf.Family, 
			pf.Version, 
			dc.Channel BusinessUnit, 
			i.Status, 
			fc.TNS, 
			fc.PLM, 
			fc.IRL,
			fc.JPN,
			fc.CZE
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				--and pb.ChannelID = 1 -- NADM Only (Comment out to Take All Products)
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		join ProductFamilys pf 
			on pf.ProductID = p.ID
		join ProductFamilyChannels fc 
			on fc.ProductFamilyID = pf.ID
		left join DistributionChannels dc 
			on dc.ID = fc.ChannelID
		left join ItemStatuses i 
			on i.ID = isnull(fc.StatusID, 4)
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where p.SupplierID = 12
		and be.[Status] = '6'
		and be.ID = @MinID
	order by	p.NPProductCode, 
				pf.Family, 
				pf.Version, 
				dc.Channel
end



insert PIM_ETL_STAGE.dbo.Stage_ReconcilePrecheck_P1
(
	ProductID,
	NPProductCode,
	Class,
	GroupingCode,
	Family,
	[Version],
	BusinessUnit,
	[Status],
	TNS,
	PLM,
	IRL,
	JPN,
	CZE,
	BatchID
)
select	ProductID,
		NPProductCode,
		Class,
		GroupingCode,
		Family,
		[Version],
		BusinessUnit,
		[Status],
		TNS,
		PLM,
		IRL,
		JPN,
		CZE,
		@BatchID as BatchID
from @Precheck_1
order by UniqueID



if @BatchStatus = 2
begin
	select @ExtractCompleted = '3'
end

if @BatchStatus = 6
begin
	select @ExtractCompleted = '7'
end






GO
