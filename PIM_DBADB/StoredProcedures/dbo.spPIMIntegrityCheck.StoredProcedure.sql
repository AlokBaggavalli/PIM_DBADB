CREATE PROCEDURE [dbo].[spPIMIntegrityCheck]

AS
BEGIN
	SET NOCOUNT ON;

	------------------------------------------------------------------------------------------
	-- Temp fix for ImportManager
	------------------------------------------------------------------------------------------
	update importmanager
	set statusID = 6
	where statusid = 3
	----------------------------------------------------------------------------------------
	--	Declare/set defaults
	----------------------------------------------------------------------------------------
	Declare	@error varchar(max)
	Declare @ToGroup varchar(400)
	Declare @WithNPI varchar(400)

	set	@ToGroup = 'David.Light@pens.com'	
	set @WithNPI = @ToGroup + ';NPI_Loading@pens.com'

	------------------------------------------------------------------------------------------
	-- Clean mailer
	------------------------------------------------------------------------------------------
	DELETE FROM [dbo].[Mailer] WHERE [DateLoaded] < DateAdd(DD,-30,GETDATE());
	------------------------------------------------------------------------------------------
	-- Orphan WF records
	------------------------------------------------------------------------------------------
	select w.id WFid, w.ProductID, w.BatchID
	into #temp1
	from ProductWFStatus w (nolock)
	left join batches b (nolock) on b.ID = w.BatchID --and b.ChannelID = w.Channel
	where b.ID is null

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'Orphans in WorkFlow --' + 
					' WFid:' + cast(WFid as varchar), 
					' ProductID:' + cast(ProductID as varchar) + 
					' WFBatchID:' + cast(BatchID as varchar) + 
				null, null, getdate(), null, 0, null, null
		from #temp1
	End
	drop table #temp1
	------------------------------------------------------------------------------------------
	-- Orphan Family Channel records
	------------------------------------------------------------------------------------------
	select c.ID FamilyChannelID, c.ProductID, c.ProductFamilyID, c.ChannelID
	into #temp2
	from ProductFamilyChannels c (nolock)
	left join ProductFamilys f (nolock) on f.ID = c.ProductFamilyID
	where f.id is null
	order by c.ProductID, c.ProductFamilyID, c.ChannelID

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'Orphans in Family Channel --' +
					' FamilyChannelID:' + cast(FamilyChannelID as varchar) + 
					' ProductID:' + cast(ProductID as varchar) + 
					' ProductFamilyID:' + cast(ProductFamilyID as varchar) + 
					' ChannelID:' + cast(ChannelID as varchar), 
				null, null, getdate(), null, 0, null, null
		from #temp2
	End
	drop table #temp2

	--delete ProductFamilyChannels
	--where id in (
	--	   select c.ID
	--	   from ProductFamilyChannels c 
	--	   left join ProductFamilys f on f.ID = c.ProductFamilyID
	--	   where f.id is null
	--)
	------------------------------------------------------------------------------------------
	-- Duplicate WF records
	------------------------------------------------------------------------------------------
	select *
	into #temp3
	from ProductWFStatus w (nolock)
	where exists (select BatchID, ProductID from ProductWFStatus where BatchID = w.BatchID and ProductID = w.ProductID and ID <> w.ID)
	order by batchid, ProductID

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'Orphans in WorkFlow --' + 
					' ProductID:' + cast(ProductID as varchar) + 
					' BatchID:' + cast(BatchID as varchar) + 
					' ID:' + cast(ID as varchar), 
				null, null, getdate(), null, 0, null, null
		from #temp3
	End
	drop table #temp3
	------------------------------------------------------------------------------------------
	-- No family for sku
	------------------------------------------------------------------------------------------
	select p.ID ProductID, p.NPProductCode, f.ID FamilyID, f.Family, s.ProdFamily SkuProdFamily, s.OracleID, s.ID SkuID, s.ProductFamilyID
	into #temp4
	from ProductSKUs s (nolock)
	left join ProductFamilys f (nolock) on f.ID = s.ProductFamilyID
	join Products p (nolock) on  p.ID = s.ProductID
	where isnull(s.ProdFamily,'') <> isnull(f.Family,'')
	and s.ProductFamilyID is not  null
	and p.ItemType = 'Product'
	and p.SupplierID = 12
	order by p.NPProductCode

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @WithNPI, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'No family for sku --' + 
					' ProductID:' + cast(ProductID as varchar) + 
					' ProductCode:' + cast(NPProductCode as varchar) + 
					' FamilyID:' + cast(FamilyID as varchar) + 
					' Family:' + cast(Family as varchar) + 
					' SkuID:' + cast(SkuID as varchar) + 
					' Family:' + cast(Family as varchar) + 
					' OracleID:' + cast(OracleID as varchar), 
				null, null, getdate(), null, 0, null, null
		from #temp4
	End
	drop table #temp4
	------------------------------------------------------------------------------------------
	-- Concept status in a batch .. Apparently they are doing this on purpose. Commentting until researched further
	------------------------------------------------------------------------------------------
	--select distinct b.ID BatchID, b.channel, s.Name
	--into #temp5
	--from ProductChannels pc (nolock)
	--join ProductBatches pb (nolock) on pb.ProductID = pc.ProductID and pb.ChannelID = pc.ChannelID
	--join Batches b (nolock) on pb.BatchID = b.ID
	--join Products p (nolock) on p.ID = pb.ProductID
	--join suppliers s (nolock) on s.ID = p.SupplierID
	--where b.Channel = pc.ChannelID
	--and pc.ItemStatusID = 1
	--order by b.ID

	--if @@ROWCOUNT > 0 Begin
	--	insert into Mailer 
	--		(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
	--	select @WithNPI, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
	--			'Products in concept status in a batch --' + 
	--				' BatchID:' + cast(BatchID as varchar),
	--			null, null, getdate(), null, 0, null, null
	--	from #temp5
	--End
	--drop table #temp5
	------------------------------------------------------------------------------------------
	-- ProductBatches out of sync with WF
	------------------------------------------------------------------------------------------
	select *
	into #temp6
	from Batches b (nolock)
	where (select count(id) from ProductBatches where BatchID = b.ID)
	<> (select count(ID) from ProductWFStatus where BatchID = b.ID)

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'ProductBatches out of sync with WF --' + 
					' BatchID:' + cast(ID as varchar),
				null, null, getdate(), null, 0, null, null
		from #temp6
	End
	drop table #temp6
	------------------------------------------------------------------------------------------
	-- Product Accessories with null productid's
	------------------------------------------------------------------------------------------
	select *
	into #temp7
	from productAccessories (nolock)
	where productid is null

	if @@ROWCOUNT > 0 Begin
		insert into Mailer 
			(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
		select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
				'Product Accessories with null productids --' + 
					' RelatedProductID:' + cast(RelatedProductID as varchar),
				null, null, getdate(), null, 0, null, null
		from #temp7
	End
	drop table #temp7
	------------------------------------------------------------------------------------------
	-- Batch live but not approved
	------------------------------------------------------------------------------------------
	--select distinct BatchID
	--into #temp8
	--from ProductWFStatus 
	--where isnull(Approval,0) = 0
	--and isnull(live,0) = 1
	--order by BatchID

	--if @@ROWCOUNT > 0 Begin
	--	insert into Mailer 
	--		(MailTo, MailCC, MailFrom, MailSubject, MailBody, Attachments, DeleteAttachments, DateLoaded, DateMailed, ProcessGroup, GroupHeading, GroupFooter)
	--	select @ToGroup, '', 'PIM@pens.com', 'PIMIntegrityCheck', 
	--			'Batch live but not approved --' + 
	--				' BatchID:' + cast(BatchID as varchar),
	--			null, null, getdate(), null, 0, null, null
	--	from #temp8
	--End
	--drop table #temp8

	------------------------------------------------------------------------------------------
	select 'Completed'
	------------------------------------------------------------------------------------------
End
GO
