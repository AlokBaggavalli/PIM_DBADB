CREATE Procedure [dbo].[usp_PopulateStageBPAChargesByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on

declare @LocaleID					int,
		@BType						varchar(50),
		@MinID						int,
		@ProductID					int,
		@SellToCountriesString		nvarchar(1000),
		@BatchStatus				int
		

declare @ProductsBPA	Table	(
									ProductID			int Primary Key,
									NPProductCode		nvarchar(50),
									SellToCountries		nvarchar(1000),
									ExtractionDate		datetime default(getdate()),
									CountryProcessed	int default(0)
								)
								
declare @ProductsBPACountries	Table	(
											UniqueID				int identity(1,1) Primary Key,
											ProductID				int,
											Country					nvarchar(100),
											Org						nvarchar(50)
										)
										
										
declare @ProductBPAChargeSku	Table	(
											UniqueID								int identity(1,1) Primary Key,
											ProductID								int,
											ProductFobID							int,
											ProductFobAdditionalChargeID			int,
											AdditionalChargeName					nvarchar(250),
											NPQuote									decimal(10,2),
											OracleChargeSkuID						int,
											OracleChargeSku							nvarchar(100),
											Country									nvarchar(50),
											Currency								nvarchar(50)
										)
										
declare @ProductBPAFinal	Table	(
										UniqueID								int identity(1,1) Primary Key,
										ProductID								int,
										BatchID									int,
										Org										nvarchar(50),
										Item									nvarchar(50),
										[Status]								nvarchar(50),
										EffectiveDateFrom						nvarchar(25),
										EffectiveDateTo							nvarchar(25),
										VEN_SETUP								decimal(10,2),
										VEN_2ND_LOCATION						decimal(10,2),
										VEN_RUN_CHG								decimal(10,2),
										VEN_2X									decimal(10,2),
										VEN_3X									decimal(10,2),
										VEN_4X									decimal(10,2),
										VEN_5X									decimal(10,2),
										VEN_6X									decimal(10,2),
										VEN_EMBROIDERY							decimal(10,2),
										VEN_HEAT_TRANSFER						decimal(10,2),
										VEN_INDIVIDUAL_POLY_BAG_CHARGE			decimal(10,2),
										VEN_INKFLASH							decimal(10,2),
										VEN_LASER_ENGRAVE						decimal(10,2),
										VEN_LOGO								decimal(10,2),
										VEN_TAPE_CHARGE							decimal(10,2),
										VEN_ADD_SETUP							decimal(10,2),
										VEN_ART									decimal(10,2),
										VEN_ASST								decimal(10,2),
										VEN_ATTACHMENT							decimal(10,2),
										VEN_ATTCLIP								decimal(10,2),
										VEN_BREAKAWAY							decimal(10,2),
										VEN_CHANGE_OF_INK						decimal(10,2),
										VEN_CLIP_IMPT							decimal(10,2),
										VEN_COPY_CHANGE							decimal(10,2),
										VEN_DEBOSS								decimal(10,2),
										VEN_DROPSHIP							decimal(10,2),
										VEN_ENVELOPE							decimal(10,2),
										VEN_EPOXY								decimal(10,2),
										VEN_INSERT								decimal(10,2),
										VEN_LTM									decimal(10,2),
										VEN_MAGNET								decimal(10,2),
										VEN_MULTIPLE_IMPT						decimal(10,2),
										VEN_NON_STANDARD_COLOR					decimal(10,2),
										VEN_PAPER_PROOF							decimal(10,2),
										VEN_PERSONALIZATION						decimal(10,2),
										VEN_PLATE								decimal(10,2),
										VEN_PMS_COLOR							decimal(10,2),
										VEN_PROP65								decimal(10,2),
										VEN_RE_SETUP							decimal(10,2),
										VEN_RESTOCK								decimal(10,2),
										VEN_RUSH								decimal(10,2),
										VEN_SCREEN								decimal(10,2),
										VEN_SECOND_SIDE							decimal(10,2),
										VEN_SECOND_COLOR						decimal(10,2),
										VEN_SHARPENING							decimal(10,2),
										VEN_SPEC_SAMPLE							decimal(10,2),
										VEN_SPECIAL_PACKAGING					decimal(10,2),
										VEN_SPIRAL_CHARGE						decimal(10,2),
										VEN_TRANSFER							decimal(10,2),
										VEN_TYPESET								decimal(10,2),
										VEN_XL									decimal(10,2),
										VEN_XCH_VENMISC							decimal(10,2),
										VEN_HAZARD_MATERIAL						decimal(10,2)
									)
		
		
set @LocaleID = 12 -- LOCALE=en_US
set @BType = '15'
set @ExtractCompleted = '3'



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
	insert @ProductsBPA	
		(
			ProductID,
			NPProductCode,
			SellToCountries
		)
	select	p.ID as ProductID,
			p.NPProductCode,
			p.SellToCountries
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join BatchExtracts be
			on pb.BatchID = be.BatchID
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end
	
	
if @BatchStatus = 6
begin
	insert @ProductsBPA	
		(
			ProductID,
			NPProductCode,
			SellToCountries
		)
	select	p.ID as ProductID,
			p.NPProductCode,
			p.SellToCountries
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join BatchExtracts be
			on pb.BatchID = be.BatchID
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[Description] = p.NPProductCode		
	where be.[Status] = '6'
		and be.ID = @MinID
	order by p.ID
end


	
-- Processing Countries for Products
while exists(select top 1 ProductID from @ProductsBPA where CountryProcessed = 0)
begin
	select @ProductID = (select top 1 ProductID from @ProductsBPA where CountryProcessed = 0 order by ProductID)
	
	select @SellToCountriesString = SellToCountries
	from @ProductsBPA 
	where ProductID = @ProductID
	
	insert @ProductsBPACountries(ProductID,Country,Org)
	select	@ProductID as ProductID,
			rtrim(ltrim(Data)),
			Case
				when rtrim(ltrim(Data)) = 'US'
					then 'ZCA'
				when rtrim(ltrim(Data)) = 'CA'
					then 'ZPP'
				else
					''
			End as Org			
	from dbo.Split(@SellToCountriesString,',')
	where Data is not null
		and Data <> ''

	update @ProductsBPA
	set CountryProcessed = 1
	where ProductID = @ProductID	
end


-- Get the Additional Charges
insert @ProductBPAChargeSku
	(
		ProductID,
		ProductFobID,
		ProductFobAdditionalChargeID,
		AdditionalChargeName,
		NPQuote,
		OracleChargeSkuID,
		OracleChargeSku,
		Country,
		Currency
	)
select	p.ProductID,
		pf.ID as ProductFobID,
		pfc.ID as ProductFobAdditionalChargeID,
		pfc.Name as AdditionalChargeName,
		pfc.NPQuote,
		pfc.OracleChargeSkuID,
		ocs.OracleChargeSku,
		pf.Country,
		pf.Currency
from @ProductsBPA p
	left join ProductFOBs pf
		on p.ProductID = pf.ProductID
			and pf.Country = 'US'
			and pf.Currency = 'USD'
	left join ProductFOBAdditionalCharges pfc
		on p.ProductID = pfc.ProductID
			and pf.ID = pfc.ProductFobID
	left join OracleChargeSkus ocs
		on pfc.OracleChargeSkuID = ocs.ID
order by p.ProductID


	

insert @ProductBPAFinal
	(
		ProductID,
		BatchID,
		Org,
		Item,
		[Status],
		EffectiveDateFrom
	)
select	pbc.ProductID as ProductID,
		@BatchID as BatchID,
		pbc.Org,
		p.NPProductCode as Item,
		'Pass' as [Status],
		convert(varchar(10),DAY(p.ExtractionDate)) + '-' + left(DATENAME(month,p.ExtractionDate),3) + '-' +  convert(varchar(10),right(YEAR(p.ExtractionDate),2)) as EffectiveDateTo
from @ProductsBPACountries pbc
	join @ProductsBPA p
		on pbc.ProductID = p.ProductID
order by	pbc.Org,
			p.NPProductCode


-- Update Values
update a
set a.VEN_SETUP = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 43

update a
set a.VEN_2ND_LOCATION = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 1

update a
set a.VEN_RUN_CHG = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 38


update a
set a.VEN_2X = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 2

update a
set a.VEN_3X = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 3

update a
set a.VEN_4X = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 4

update a
set a.VEN_5X = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 5

update a
set a.VEN_6X = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 6

update a
set a.VEN_EMBROIDERY = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 18

update a
set a.VEN_HEAT_TRANSFER = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 21

update a
set a.VEN_INDIVIDUAL_POLY_BAG_CHARGE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 22

update a
set a.VEN_INKFLASH = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 23

update a
set a.VEN_LASER_ENGRAVE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 25

update a
set a.VEN_LOGO = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 26

update a
set a.VEN_TAPE_CHARGE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 48

update a
set a.VEN_ADD_SETUP = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 7

update a
set a.VEN_ART = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 8

update a
set a.VEN_ASST = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 9

update a
set a.VEN_ATTACHMENT = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 10

update a
set a.VEN_ATTCLIP = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 11


update a
set a.VEN_BREAKAWAY = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 12

update a
set a.VEN_CHANGE_OF_INK = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 13


update a
set a.VEN_CLIP_IMPT = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 14

update a
set a.VEN_COPY_CHANGE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 15

update a
set a.VEN_DEBOSS = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 16

update a
set a.VEN_DROPSHIP = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 17

update a
set a.VEN_ENVELOPE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 19


update a
set a.VEN_EPOXY = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 20

update a
set a.VEN_INSERT = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 24

update a
set a.VEN_LTM = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 27


update a
set a.VEN_MAGNET = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 28

update a
set a.VEN_MULTIPLE_IMPT = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 29

update a
set a.VEN_NON_STANDARD_COLOR = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 30

update a
set a.VEN_PAPER_PROOF = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 31

update a
set a.VEN_PERSONALIZATION = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 32

update a
set a.VEN_PLATE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 33

update a
set a.VEN_PMS_COLOR = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 34

update a
set a.VEN_PROP65 = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 35

update a
set a.VEN_RE_SETUP = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 36

update a
set a.VEN_RESTOCK = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 37

update a
set a.VEN_RUSH = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 39

update a
set a.VEN_SCREEN = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 40

update a
set a.VEN_SECOND_SIDE= b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 41

update a
set a.VEN_SECOND_COLOR = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 42

update a
set a.VEN_SHARPENING = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 44

update a
set a.VEN_SPEC_SAMPLE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 45

update a
set a.VEN_SPECIAL_PACKAGING = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 46

update a
set a.VEN_SPIRAL_CHARGE = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 47

update a
set a.VEN_TRANSFER = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 49

update a
set a.VEN_TYPESET = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 50

update a
set a.VEN_XL = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 51

update a
set a.VEN_XCH_VENMISC = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 52

update a
set a.VEN_HAZARD_MATERIAL = b.NPQuote
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.OracleChargeSkuID = 53


-- Check for failed Status
update a
set a.[Status] = 'Failed'
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where b.ProductFobAdditionalChargeID is null


update a
set a.[Status] = 'Failed'
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where	isnull(b.AdditionalChargeName,'') = ''
	
update a
set a.[Status] = 'Failed'
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where	isnull(b.OracleChargeSku,'') = ''

update a
set a.[Status] = 'Failed'
from @ProductBPAFinal a
	join @ProductBPAChargeSku b
		on a.ProductID = b.ProductID
where	b.NPQuote is null

	

if exists(select top 1 * from @ProductBPAFinal where [Status] = 'Failed')
begin
	if @BatchStatus = 2
	begin
		set @ExtractCompleted = '4'
	end
	
	if @BatchStatus = 6
	begin
		set @ExtractCompleted = '8'
	end
end
else
begin
	if @BatchStatus = 2
	begin
		set @ExtractCompleted = '3'
	end
	
	if @BatchStatus = 6
	begin
		set @ExtractCompleted = '7'
	end
end


--select * from @ProductsBPA
--select * from @ProductsBPACountries
--select * from @ProductBPAChargeSku

insert PIM_ETL_STAGE.dbo.Stage_ProductBPACharges
	(
	   [ProductID]
      ,[BatchID]
      ,[Org]
      ,[Item]
      ,[Status]
      ,[EffectiveDateFrom]
      ,[EffectiveDateTo]
      ,[VEN_SETUP]
      ,[VEN_2ND_LOCATION]
      ,[VEN_RUN_CHG]
      ,[VEN_2X]
      ,[VEN_3X]
      ,[VEN_4X]
      ,[VEN_5X]
      ,[VEN_6X]
      ,[VEN_EMBROIDERY]
      ,[VEN_HEAT_TRANSFER]
      ,[VEN_INDIVIDUAL_POLY_BAG_CHARGE]
      ,[VEN_INKFLASH]
      ,[VEN_LASER_ENGRAVE]
      ,[VEN_LOGO]
      ,[VEN_TAPE_CHARGE]
      ,[VEN_ADD_SETUP]
      ,[VEN_ART]
      ,[VEN_ASST]
      ,[VEN_ATTACHMENT]
      ,[VEN_ATTCLIP]
      ,[VEN_BREAKAWAY]
      ,[VEN_CHANGE_OF_INK]
      ,[VEN_CLIP_IMPT]
      ,[VEN_COPY_CHANGE]
      ,[VEN_DEBOSS]
      ,[VEN_DROPSHIP]
      ,[VEN_ENVELOPE]
      ,[VEN_EPOXY]
      ,[VEN_INSERT]
      ,[VEN_LTM]
      ,[VEN_MAGNET]
      ,[VEN_MULTIPLE_IMPT]
      ,[VEN_NON_STANDARD_COLOR]
      ,[VEN_PAPER_PROOF]
      ,[VEN_PERSONALIZATION]
      ,[VEN_PLATE]
      ,[VEN_PMS_COLOR]
      ,[VEN_PROP65]
      ,[VEN_RE_SETUP]
      ,[VEN_RESTOCK]
      ,[VEN_RUSH]
      ,[VEN_SCREEN]
      ,[VEN_SECOND_SIDE]
      ,[VEN_SECOND_COLOR]
      ,[VEN_SHARPENING]
      ,[VEN_SPEC_SAMPLE]
      ,[VEN_SPECIAL_PACKAGING]
      ,[VEN_SPIRAL_CHARGE]
      ,[VEN_TRANSFER]
      ,[VEN_TYPESET]
      ,[VEN_XL]
      ,[VEN_XCH_VENMISC]
      ,[VEN_HAZARD_MATERIAL]
	)
select	[ProductID]
      ,[BatchID]
      ,[Org]
      ,[Item]
      ,[Status]
      ,[EffectiveDateFrom]
      ,[EffectiveDateTo]
      ,[VEN_SETUP]
      ,[VEN_2ND_LOCATION]
      ,[VEN_RUN_CHG]
      ,[VEN_2X]
      ,[VEN_3X]
      ,[VEN_4X]
      ,[VEN_5X]
      ,[VEN_6X]
      ,[VEN_EMBROIDERY]
      ,[VEN_HEAT_TRANSFER]
      ,[VEN_INDIVIDUAL_POLY_BAG_CHARGE]
      ,[VEN_INKFLASH]
      ,[VEN_LASER_ENGRAVE]
      ,[VEN_LOGO]
      ,[VEN_TAPE_CHARGE]
      ,[VEN_ADD_SETUP]
      ,[VEN_ART]
      ,[VEN_ASST]
      ,[VEN_ATTACHMENT]
      ,[VEN_ATTCLIP]
      ,[VEN_BREAKAWAY]
      ,[VEN_CHANGE_OF_INK]
      ,[VEN_CLIP_IMPT]
      ,[VEN_COPY_CHANGE]
      ,[VEN_DEBOSS]
      ,[VEN_DROPSHIP]
      ,[VEN_ENVELOPE]
      ,[VEN_EPOXY]
      ,[VEN_INSERT]
      ,[VEN_LTM]
      ,[VEN_MAGNET]
      ,[VEN_MULTIPLE_IMPT]
      ,[VEN_NON_STANDARD_COLOR]
      ,[VEN_PAPER_PROOF]
      ,[VEN_PERSONALIZATION]
      ,[VEN_PLATE]
      ,[VEN_PMS_COLOR]
      ,[VEN_PROP65]
      ,[VEN_RE_SETUP]
      ,[VEN_RESTOCK]
      ,[VEN_RUSH]
      ,[VEN_SCREEN]
      ,[VEN_SECOND_SIDE]
      ,[VEN_SECOND_COLOR]
      ,[VEN_SHARPENING]
      ,[VEN_SPEC_SAMPLE]
      ,[VEN_SPECIAL_PACKAGING]
      ,[VEN_SPIRAL_CHARGE]
      ,[VEN_TRANSFER]
      ,[VEN_TYPESET]
      ,[VEN_XL]
      ,[VEN_XCH_VENMISC] 
      ,[VEN_HAZARD_MATERIAL]
from @ProductBPAFinal
order by UniqueID






GO
