CREATE Procedure [dbo].[usp_PopulateStageDesignXMLForExportByBatchID]
	@BatchID			varchar(10),
	@ExtractCompleted	varchar(50) output

as

set nocount on


declare @DesignMain		Table	(
									UniqueID				int identity(1,1) Primary Key,
									[ProductID]				int Null,
									[ProductCode]			[nvarchar](50) NULL,
									[ImprintProcess]		[varchar](1) NOT NULL,
									[ImprintColors]			[varchar](1) NOT NULL,
									[ImprintColorInfos]		[varchar](1) NOT NULL,
									[VignetteExists]		[bit] NULL,
									[DesignName]			[nvarchar](3) NULL,
									[DesignCode]			[nvarchar](100) NULL,
									[CatLevel1]				[nvarchar](60) NULL,
									[CatLevel2]				[nvarchar](60) NULL,
									[IsSeriies]				[bit] NULL,
									[SeriesCount]			[int] NULL,
									[InScene7]				[bit] NULL,
									[Keywords]				[nvarchar](1000) NULL,
									[WebDesc]				[nvarchar](240) NULL,
									[BaseUrl]				[nvarchar](500) NULL,
									[SampleUrl]				[nvarchar](500) NULL,
									[Casino]				[bit] NULL,
									[Holo]					[bit] NULL,
									[MktDesc]				[nvarchar](240) NULL,
									[CountryCode]			[nvarchar](255) NULL,
									[LanguageCode]			[nvarchar](255) NULL,
									[ImpReq]				[bit] NULL,
									[ImprintType]			[varchar](13) NOT NULL,
									[Logo]					[bit] NULL,
									[ImageName]				[nvarchar](50) NULL,
									[ImageDesc]				[nvarchar](50) NULL,
									[ImageFileName]			[nvarchar](50) NULL,
									[FilePath]				[nvarchar](255) NULL,
									[ImagePresFormat]		[nvarchar](10) NULL,
									[ImageProdColorSpace]	[nvarchar](10) NULL,
									[ImageProdFormat]		[nvarchar](10) NULL,
									[ImageProdOutRes]		[int] NULL,
									[ImageSeries]			[bit] NULL,
									[ImageSeriesCount]		[int] NULL,
									[ImageAlpha]			[bit] NULL,
									[ImageAllowColorChoice] [bit] NULL,
									[DimensionsWidth]		[int] NULL,
									[DimensionsHeight]		[int] NULL,
									[BoundingBoxX]			[decimal](10, 2) NULL,
									[BoundingBoxY]			[decimal](10, 2) NULL,
									[BoundingBoxWidth]		[decimal](10, 2) NULL,
									[BoundingBoxHeight]		[decimal](10, 2) NULL,
									[ImpCenterPointX]		[decimal](10, 4) NULL,
									[ImpCenterPointY]		[decimal](10, 4) NULL,
									[ImpFontColor]			[nvarchar](100) NULL,
									[ImpFontName]			[nvarchar](50) NULL,
									[ImpSize]				[nvarchar](100) NULL,
									[ImpJustification]		[nvarchar](50) NULL,
									[ImpLineSpacing]		[int] NULL,
									[ImpMaxPoint]			[int] NULL,
									[ImpTextRotation]		[int] NULL,
									[ImpVerticalText]		[bit] NULL,
									[MaxLine]				[int] NULL,
									[MaxPoint]				[int] NULL,
									[MaxChars]				[int] NULL,
									[AllowFormat]			[bit] NULL
								)
								
declare @Product	Table	(
								UniqueID		int identity(1,1) Primary Key,
								ProductID		int,
								ProductCode		nvarchar(50),
								VignetteExists	int
							)
							
declare @Design		Table	(
								UniqueID		int identity(1,1) Primary Key,
								ProductID		int,
								ProductCode		nvarchar(50),
								DesignName		nvarchar(3),
								DesignMainUID	int
							)
							
declare @Image		Table	(
								UniqueID		int identity(1,1) Primary Key,
								ProductID		int,
								ProductCode		nvarchar(50),
								DesignName		nvarchar(3),
								DesignCode		nvarchar(100),
								DesignMainUID	int
							)
							
declare @LocaleID				int,
		@Type					varchar(50),
		@MinID					int,
		@BatchStatus			int


set @LocaleID = 12 -- LOCALE=en_US
set @Type = '8'
select @ExtractCompleted = '3'


select @MinID =	(
					select MIN(ID)
					from BatchExtracts
					where BatchID = @BatchID
						and [Type] = @Type
						and [Status] in('2','6')
				)


select @BatchStatus = [Status] from BatchExtracts where ID = @MinID


if @BatchStatus = 2
begin
	insert	@DesignMain	
		(
			[ProductID],
			[ProductCode],
			[ImprintProcess],
			[ImprintColors],
			[ImprintColorInfos],
			[VignetteExists],
			[DesignName],
			[DesignCode],
			[CatLevel1],
			[CatLevel2],
			[IsSeriies],
			[SeriesCount],
			[InScene7],
			[Keywords],
			[WebDesc],
			[BaseUrl],
			[SampleUrl],
			[Casino],
			[Holo],
			[MktDesc],
			[CountryCode],
			[LanguageCode],
			[ImpReq],
			[ImprintType],
			[Logo],
			[ImageName],
			[ImageDesc],
			[ImageFileName],
			[FilePath],
			[ImagePresFormat],
			[ImageProdColorSpace],
			[ImageProdFormat],
			[ImageProdOutRes],
			[ImageSeries],
			[ImageSeriesCount],
			[ImageAlpha],
			[ImageAllowColorChoice],
			[DimensionsWidth],
			[DimensionsHeight],
			[BoundingBoxX],
			[BoundingBoxY],
			[BoundingBoxWidth],
			[BoundingBoxHeight],
			[ImpCenterPointX],
			[ImpCenterPointY],
			[ImpFontColor],
			[ImpFontName],
			[ImpSize],
			[ImpJustification],
			[ImpLineSpacing],
			[ImpMaxPoint],
			[ImpTextRotation],
			[ImpVerticalText],
			[MaxLine],
			[MaxPoint],
			[MaxChars],
			[AllowFormat]
		)
	select	p.ID as ProductID,
			p.NPProductCode as ProductCode,
			'' as ImprintProcess,
			'' as ImprintColors,
			--'![CDATA[]]' as WebName,
			--'![CDATA[]]' as WebLongDescription,
			--'![CDATA[]]' as WebSkuDescription,
			--'![CDATA[]]' as WebKeywords,
			'' as ImprintColorInfos,
			pd.VignetteExists as VignetteExists,
			pd.DesignName as DesignName,
			pd.DesignCode as DesignCode,
			pdt.CatLevel1 as CatLevel1,
			pdt.CatLevel2 as CatLevel2,
			pd.IsSeries as IsSeriies,
			pd.SeriesCount as SeriesCount,
			pd.InScene7 as InScene7,
			pdt.Keywords as Keywords,
			pdt.WebDesc as WebDesc,
			pd.BaseUrl,
			pd.SampleUrl,
			pd.Casino,
			pd.Holo,
			pdt.MktDesc as MktDesc,
			l.CountryCode as CountryCode,
			l.LanguageCode as LanguageCode,
			pd.ImpReq,
			'Standard Text' as ImprintType,
			pd.Logo as Logo,
			pd.ImageName as ImageName,
			pd.ImageDesc as ImageDesc,
			pd.ImageFileName as ImageFileName,
			pd.FilePath as FilePath,
			pd.ImagePresFormat as ImagePresFormat,
			pd.ImageProdColorSpace as ImageProdColorSpace,
			pd.ImageProdFormat as ImageProdFormat,
			pd.ImageProdOutRes as ImageProdOutRes,
			pd.ImageSeries as ImageSeries,
			pd.ImageSeriesCount as ImageSeriesCount,
			pd.ImageAlpha as ImageAlpha,
			pd.ImageAllowColorChoice as ImageAllowColorChoice,
			pd.DimensionsWidth as DimensionsWidth,
			pd.DimensionsHeight as DimensionsHeight,
			pd.BoundingBoxX as BoundingBoxX,
			pd.BoundingBoxY as BoundingBoxY,
			pd.BoundingBoxWidth as BoundingBoxWidth,
			pd.BoundingBoxHeight as BoundingBoxHeight,
			pd.ImpCenterPointX as ImpCenterPointX,
			pd.ImpCenterPointY as ImpCenterPointY,
			pd.ImpFontColor as ImpFontColor,
			pd.ImpFontName as ImpFontName,
			pd.ImpSize as ImpSize,
			pd.ImpJustification as ImpJustification,
			pd.ImpLineSpacing as ImpLineSpacing,
			pd.ImpMaxPoint as ImpMaxPoint,
			pd.ImpTextRotation as ImpTextRotation,
			pd.ImpVerticalText as ImpVerticalText,
			pd.MaxLines as MaxLine,
			pd.MaxPoint as MaxPoint,
			pd.MaxChars as MaxChars,
			pd.AllowFormat as AllowFormat
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductDesigns pd
			on p.ID = pd.ProductID
		left join ProductDesignTranslations pdt
			on p.ID = pdt.ProductID
				and pd.ID = pdt.ProductDesignID
				and pdt.LocaleID = 12
		left join Locale l
			on l.ID = 12
	where be.[Status] = '2'
		and be.ID = @MinID
	order by p.ID
end


if @BatchStatus = 6
begin
	insert	@DesignMain	
		(
			[ProductID],
			[ProductCode],
			[ImprintProcess],
			[ImprintColors],
			[ImprintColorInfos],
			[VignetteExists],
			[DesignName],
			[DesignCode],
			[CatLevel1],
			[CatLevel2],
			[IsSeriies],
			[SeriesCount],
			[InScene7],
			[Keywords],
			[WebDesc],
			[BaseUrl],
			[SampleUrl],
			[Casino],
			[Holo],
			[MktDesc],
			[CountryCode],
			[LanguageCode],
			[ImpReq],
			[ImprintType],
			[Logo],
			[ImageName],
			[ImageDesc],
			[ImageFileName],
			[FilePath],
			[ImagePresFormat],
			[ImageProdColorSpace],
			[ImageProdFormat],
			[ImageProdOutRes],
			[ImageSeries],
			[ImageSeriesCount],
			[ImageAlpha],
			[ImageAllowColorChoice],
			[DimensionsWidth],
			[DimensionsHeight],
			[BoundingBoxX],
			[BoundingBoxY],
			[BoundingBoxWidth],
			[BoundingBoxHeight],
			[ImpCenterPointX],
			[ImpCenterPointY],
			[ImpFontColor],
			[ImpFontName],
			[ImpSize],
			[ImpJustification],
			[ImpLineSpacing],
			[ImpMaxPoint],
			[ImpTextRotation],
			[ImpVerticalText],
			[MaxLine],
			[MaxPoint],
			[MaxChars],
			[AllowFormat]
		)
	select	p.ID as ProductID,
			p.NPProductCode as ProductCode,
			'' as ImprintProcess,
			'' as ImprintColors,
			--'![CDATA[]]' as WebName,
			--'![CDATA[]]' as WebLongDescription,
			--'![CDATA[]]' as WebSkuDescription,
			--'![CDATA[]]' as WebKeywords,
			'' as ImprintColorInfos,
			pd.VignetteExists as VignetteExists,
			pd.DesignName as DesignName,
			pd.DesignCode as DesignCode,
			pdt.CatLevel1 as CatLevel1,
			pdt.CatLevel2 as CatLevel2,
			pd.IsSeries as IsSeriies,
			pd.SeriesCount as SeriesCount,
			pd.InScene7 as InScene7,
			pdt.Keywords as Keywords,
			pdt.WebDesc as WebDesc,
			pd.BaseUrl,
			pd.SampleUrl,
			pd.Casino,
			pd.Holo,
			pdt.MktDesc as MktDesc,
			l.CountryCode as CountryCode,
			l.LanguageCode as LanguageCode,
			pd.ImpReq,
			'Standard Text' as ImprintType,
			pd.Logo as Logo,
			pd.ImageName as ImageName,
			pd.ImageDesc as ImageDesc,
			pd.ImageFileName as ImageFileName,
			pd.FilePath as FilePath,
			pd.ImagePresFormat as ImagePresFormat,
			pd.ImageProdColorSpace as ImageProdColorSpace,
			pd.ImageProdFormat as ImageProdFormat,
			pd.ImageProdOutRes as ImageProdOutRes,
			pd.ImageSeries as ImageSeries,
			pd.ImageSeriesCount as ImageSeriesCount,
			pd.ImageAlpha as ImageAlpha,
			pd.ImageAllowColorChoice as ImageAllowColorChoice,
			pd.DimensionsWidth as DimensionsWidth,
			pd.DimensionsHeight as DimensionsHeight,
			pd.BoundingBoxX as BoundingBoxX,
			pd.BoundingBoxY as BoundingBoxY,
			pd.BoundingBoxWidth as BoundingBoxWidth,
			pd.BoundingBoxHeight as BoundingBoxHeight,
			pd.ImpCenterPointX as ImpCenterPointX,
			pd.ImpCenterPointY as ImpCenterPointY,
			pd.ImpFontColor as ImpFontColor,
			pd.ImpFontName as ImpFontName,
			pd.ImpSize as ImpSize,
			pd.ImpJustification as ImpJustification,
			pd.ImpLineSpacing as ImpLineSpacing,
			pd.ImpMaxPoint as ImpMaxPoint,
			pd.ImpTextRotation as ImpTextRotation,
			pd.ImpVerticalText as ImpVerticalText,
			pd.MaxLines as MaxLine,
			pd.MaxPoint as MaxPoint,
			pd.MaxChars as MaxChars,
			pd.AllowFormat as AllowFormat
	from Products p
		join ProductBatches pb
			on p.ID = pb.ProductID
				and pb.ChannelID = 1 -- NADM Only
		join dbo.BatchExtracts be
			on pb.BatchID = be.BatchID
		left join ProductDesigns pd
			on p.ID = pd.ProductID
		left join ProductDesignTranslations pdt
			on p.ID = pdt.ProductID
				and pd.ID = pdt.ProductDesignID
				and pdt.LocaleID = 12
		left join Locale l
			on l.ID = 12
		join BatchExtractPartial bep
			on be.BatchID = bep.BatchID
				and be.[Type] = bep.[Type]
				and bep.ProductID = p.ID
				and bep.[DesignID] = pd.ID
	where be.[Status] = '6'
		and be.ID = @MinID
	order by p.ID
end




update t
set t.DesignName = m.DesignName,
	t.CatLevel1 = m.CatLevel1,
	t.CatLevel2 = m.CatLevel2,
	t.Keywords = m.Keywords,
	t.WebDesc = m.WebDesc,
	t.Casino = m.Casino,
	t.Holo = m.Holo,
	t.MktDesc = m.MktDesc,
	t.ImpReq = m.ImpReq,
	t.Logo = m.Logo,
	--t.ImageDesc = m.ImageDesc,
	t.MaxLine = m.MaxLine,
	t.MaxPoint = m.MaxPoint,
	t.MaxChars = m.MaxChars,
	t.AllowFormat = m.AllowFormat
from @DesignMain t
	join
		(
			select a.*,b.UniqueID as UniqueIDtoUpdateFrom
			from @DesignMain a
				join
					(
						select	*
						from @DesignMain
						where ImageSeries = 1
					) b
				on a.ProductCode = b.ProductCode
					and a.DesignCode like '%' + b.DesignCode + '%'
			where a.ImageSeries = 0
		) z
	on t.UniqueID = z.UniqueID
	join 
		(
			select	*
			from @DesignMain
			where ImageSeries = 1
		) m
	on z.UniqueIDtoUpdateFrom = m.UniqueID



insert @Product(ProductID,ProductCode,VignetteExists)
select	ProductID,
		ProductCode,
		VignetteExists
from @DesignMain
group by	ProductID,
			ProductCode,
			VignetteExists
order by ProductCode


insert @Design
	(
		ProductID,
		ProductCode,
		DesignName,
		DesignMainUID
	)
select	ProductID,
		ProductCode,
		DesignName,
		MIN(UniqueID) as DesignMainUID
from @DesignMain
where isnull(DesignName,'') <> ''
group by DesignName,
		 ProductID,
		 ProductCode
order by ProductCode,DesignName


insert @Image
	(
		ProductID,
		ProductCode,
		DesignName,
		DesignCode,
		DesignMainUID
	)
select	ProductID,
		ProductCode,
		Isnull(DesignName,'ZZZ') as DesignName,
		DesignCode,
		MIN(UniqueID) as DesignMainUID
from @DesignMain
group by 	ProductID,
			ProductCode,
			DesignName,
			DesignCode
order by ProductCode,DesignName,DesignMainUID




declare @ProductCode	varchar(50),
		@PUID			int,
		@Header1		varchar(250),
		@Header2		varchar(250),
		@Header2_E		varchar(250),
		@VignetteExists	varchar(50),
		@DesignName		varchar(100),
		@DesignMainUID	int,
		@DUID			int,
		@IUID			int,
		@IDesignMainUID	int,
		@DesignCode		varchar(100),
		@CatLevel1		varchar(100),
		@CatLevel2		varchar(100),
		@IsSeries		varchar(50),
		@SeriesCount	varchar(50),
		@InScene7		varchar(50),
		@Keywords		varchar(500),
		@Description	varchar(250),
		@BaseURL		varchar(250),
		@SampleURL		varchar(250),
		@Casino			varchar(50),
		@Holo			varchar(50),
		@Country		varchar(50),
		@Culture		varchar(50),
		@ImprintRequired		varchar(50),
		@ImprintType			varchar(50),
		@LogoAllowed			varchar(50),
		@ImageName				varchar(100),
		@ImageDesc				varchar(250),
		@ImageFileName			varchar(100),
		@FilePath				varchar(250),
		@ImagePresFormat		varchar(50),
		@ImageProdColorSpace	varchar(50),
		@ImageProdFormat		varchar(50),
		@ImageProdOutRes		varchar(50),
		@ImageSeries			varchar(50),
		@ImageSeriesCount		varchar(50),
		@ImageAlpha				varchar(50),
		@ImageAllowColorChoice	varchar(50),
		@DimensionsWidth		varchar(50),
		@DimensionsHeight		varchar(50),
		@BoundingBoxX			varchar(50),
		@BoundingBoxY			varchar(50),
		@BoundingBoxWidth		varchar(50),
		@BoundingBoxHeight		varchar(50),
		@ImpCenterPointX		varchar(50),
		@ImpCenterPointY		varchar(50),
		@ImpFontColor			varchar(250),
		@ImpFontName			varchar(100),
		@ImpSize				varchar(200),
		@ImpJustification		varchar(100),
		@ImpLineSpacing			varchar(50),
		@ImpMaxPoint			varchar(50),
		@ImpTextRotation		varchar(50),
		@ImpVerticalText		varchar(50),
		@MaxLine				varchar(50),
		@MaxPoint				varchar(50),
		@MaxChars				varchar(50),
		@AllowFormat			varchar(50),
		@MaxIUID				int,
		@MinIUID				int,
		@MaxDUID				int,
		@MinDUID				int
		
	
select @Header1 = '<?xml version="1.0" encoding="UTF-8"?>'
select @Header2 = '<DesignData>'
select @Header2_E = '</DesignData>'


insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
values(@Header1)

insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
values(@Header2)
		

while exists(select top 1 UniqueID from @Product)
begin
	select @PUID = (select top 1 UniqueID from @Product order by UniqueID)
	
	select	@ProductCode = ProductCode,
			@VignetteExists = case when VignetteExists = 1 then 'True' else 'False' end
	from @Product 
	where UniqueID = @PUID
	
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('  <ProductInfo>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <ProductCode>' + @ProductCode + '</ProductCode>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <ImprintProcess/>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <ImprintColors/>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <WebName>' + '<![CDATA[]]>' + '</WebName>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <WebLongDescription>' + '<![CDATA[]]>' + '</WebLongDescription>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <WebSkuDescription>' + '<![CDATA[]]>' + '</WebSkuDescription>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <WebKeywords>' + '<![CDATA[]]>' + '</WebKeywords>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <ImprintColorInfos/>')
	
	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('    <VignetteExists>' + @VignetteExists + '</VignetteExists>')
	
	
	
	select @MaxDUID = MAX(UniqueID) from @Design where ProductCode = @ProductCode
	select @MinDUID = MIN(UniqueID) from @Design where ProductCode = @ProductCode
	
	
	while exists(select top 1 * from @Design where ProductCode = @ProductCode)
	begin
		select @DUID = (select top 1 UniqueID from @Design where ProductCode = @ProductCode order by UniqueID)
		
		select	@DesignName = DesignName,
				@DesignMainUID = DesignMainUID
		from @Design
		where UniqueID = @DUID
		
		
		select	@DesignCode = DesignCode,
				@CatLevel1 = CatLevel1,
				@CatLevel2 = CatLevel2,
				@IsSeries = Case when IsSeriies = 1 then 'True' else 'False' end,
				@SeriesCount = SeriesCount,
				@InScene7 = case when InScene7 = 1 then 'True' else 'False' end,
				@Keywords = Keywords,
				@Description = WebDesc,
				@BaseURL = BaseURL,
				@SampleURL = SampleURL,
				@Casino	= Case when Casino = 1 then 'True' else 'False' end,
				@Holo = Case when Holo = 1 then 'True' else 'False' end,
				@Country = CountryCode,
				@Culture = LanguageCode,
				@ImprintRequired = Case when ImpReq = 1 then 'True' else 'False' end,
				@ImprintType = ImprintType,
				@LogoAllowed = Case when Logo = 1 then 'True' else 'False' end
		from @DesignMain
		where UniqueID = @DesignMainUID
		
		
		if @DUID = @MinDUID
		begin
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('    <Designs>')
		end
		
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('      <DesignInfo>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <ProductCode>' + @ProductCode + '</ProductCode>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <DesignName>' + @DesignName + '</DesignName>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <DesignCode>' + @DesignCode + '</DesignCode>')
		
		if isnull(@CatLevel1,'') = ''
		begin
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('        <CategoryLevel1/>')
		end
		else
		begin 
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('        <CategoryLevel1>' + @CatLevel1 + '</CategoryLevel1>')
		end
		
		
		if isnull(@CatLevel2,'') = ''
		begin
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('        <CategoryLevel2/>')
		end
		else
		begin 
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('        <CategoryLevel2>' + @CatLevel2 + '</CategoryLevel2>')
		end
		
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <AdditionalCategories/>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <IsSeries>' + @IsSeries + '</IsSeries>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <SeriesCount>' + @SeriesCount + '</SeriesCount>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <InScene7>' + @InScene7 + '</InScene7>')
		
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <Keywords>' + '<![CDATA[' + isnull(@Keywords,'') + ']]>' + '</Keywords>')

		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <Description>' + '<![CDATA[' + isnull(@Description,'') + ']]>' + '</Description>')


		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <BaseUrl>' + '<![CDATA[' + isnull(@BaseURL,'') + ']]>' + '</BaseUrl>')
		
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <SampleUrl>' + '<![CDATA[' + 'is{' + isnull(@SampleURL,'') + '}' + ']]>' + '</SampleUrl>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <OracleDesignInfo>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <IsCasino>' + @Casino + '</IsCasino>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <IsHolographic>' + @Holo + '</IsHolographic>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        </OracleDesignInfo>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        <AdditionalMarketingDesignInfo>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <Description>' + '<![CDATA[' + isnull(@Description,'') + ']]>' + '</Description>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <LocalizedDescription>' + '<![CDATA[' + isnull(@Description,'') + ']]>' + '</LocalizedDescription>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <Country>' + @Country + '</Country>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <Culture>' + @Culture + '</Culture>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <ImprintRequired>' + @ImprintRequired + '</ImprintRequired>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <ImprintType>' + @ImprintType + '</ImprintType>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <LogoAllowed>' + @LogoAllowed + '</LogoAllowed>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('          <SkuMask>' + @DesignName + '</SkuMask>')
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('        </AdditionalMarketingDesignInfo>')
		
		
		
		select @MaxIUID = MAX(UniqueID) from @Image where ProductCode = @ProductCode and DesignName = @DesignName
		select @MinIUID = MIN(UniqueID) from @Image where ProductCode = @ProductCode and DesignName = @DesignName
		
		while exists(select top 1 UniqueID from @Image where ProductCode = @ProductCode and DesignName = @DesignName)
		begin
			select	@IUID = (select top 1 UniqueID from @Image where ProductCode = @ProductCode and DesignName = @DesignName order by UniqueID)
			
			select	@DesignCode = DesignCode,
					@IDesignMainUID = DesignMainUID
			from @Image
			where UniqueID = @IUID
			
			
			select
					@ImageName = ImageName,
					@ImageDesc = ImageDesc,
					@ImageFileName = ImageFileName,
					@FilePath = FilePath,
					@ImagePresFormat = ImagePresFormat,
					@ImageProdColorSpace = ImageProdColorSpace,
					@ImageProdFormat = ImageProdFormat,
					@ImageProdOutRes = ImageProdOutRes,
					@ImageSeries = case when ImageSeries = 1 then 'True' else 'False' end,
					@ImageSeriesCount = ImageSeriesCount,
					@ImageAlpha = case when ImageAlpha = 1 then 'True' else 'False' end,
					@ImageAllowColorChoice = case when ImageAllowColorChoice = 1 then 'True' else 'False' end,
					@DimensionsWidth = DimensionsWidth,
					@DimensionsHeight = DimensionsHeight,
					@BoundingBoxX = convert(varchar(10),isnull(BoundingBoxX,0)),
					@BoundingBoxY = convert(varchar(10),isnull(BoundingBoxY,0)),
					@BoundingBoxWidth = convert(varchar(10),isnull(BoundingBoxWidth,0)),
					@BoundingBoxHeight = convert(varchar(10),isnull(BoundingBoxHeight,0)),
					@ImpCenterPointX = ImpCenterPointX,
					@ImpCenterPointY = ImpCenterPointY,
					@ImpFontColor = ImpFontColor,
					@ImpFontName = ImpFontName,
					@ImpSize = ImpSize,
					@ImpJustification = ImpJustification,
					@ImpLineSpacing = ImpLineSpacing,
					@ImpMaxPoint = ImpMaxPoint,
					@ImpTextRotation = ImpTextRotation,
					@ImpVerticalText = case when ImpVerticalText = 1 then 'True' else 'False' end,
					@MaxLine = MaxLine,
					@MaxPoint = MaxPoint,
					@MaxChars = MaxChars,
					@AllowFormat = case when AllowFormat = 1 then 'True' else 'False' end
			from @DesignMain
			where UniqueID = @IDesignMainUID
			
			
			if @IUID = @MinIUID
			begin
				insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
				values('        <ImageInfos>')
			end
			
			
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('          <ImageInfo>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <Name>' + @DesignCode + '</Name>')
			
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <Description>' + '<![CDATA[' + isnull(@ImageDesc,'') + ']]>' + '</Description>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <FileName>' + @ImageFileName + '</FileName>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <FilePath>' + @FilePath + '</FilePath>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <PresentationFormat>' + @ImagePresFormat + '</PresentationFormat>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <PresentationColorspace>' + @ImageProdColorSpace + '</PresentationColorspace>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <ProductionFormat>' + @ImageProdFormat + '</ProductionFormat>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <ProductionOutputResolution>' + @ImageProdOutRes + '</ProductionOutputResolution>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <Series>' + @ImageSeries + '</Series>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <SeriesCount>' + @ImageSeriesCount + '</SeriesCount>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <Alpha>' + @ImageAlpha + '</Alpha>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <AllowColorChoice>' + @ImageAllowColorChoice + '</AllowColorChoice>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <Demensions>' + '{Width=' + @DimensionsWidth + ', Height=' + @DimensionsHeight + '}' + '</Demensions>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <BoundingBox>' + '{X=' + @BoundingBoxX + ',Y=' + @BoundingBoxY + ',Width=' + @BoundingBoxWidth + ',Height=' + @BoundingBoxHeight + '}' + '</BoundingBox>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            <ImprintInfo>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <CenterPoint>' + '{X=' + @ImpCenterPointX + ', Y=' + @ImpCenterPointY + '}' + '</CenterPoint>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <FontColor>' + @ImpFontColor + '</FontColor>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <FontName>' + @ImpFontName + '</FontName>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <ImprintSize>' + @ImpSize + '</ImprintSize>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <Justification>' + @ImpJustification + '</Justification>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <LineSpacing>' + @ImpLineSpacing + '</LineSpacing>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <MaxPointSize>' + @ImpMaxPoint + '</MaxPointSize>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <TextRotation>' + @ImpTextRotation + '</TextRotation>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <VerticalText>' + @ImpVerticalText + '</VerticalText>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              <OracleImprintInfo>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('                <MaxNumberOfLines>' + @MaxLine + '</MaxNumberOfLines>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('                <MaxPointSize>' + @MaxPoint + '</MaxPointSize>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('                <MaxCharactersPerLine>' + @MaxChars + '</MaxCharactersPerLine>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('                <FormattingAllowed>' + @AllowFormat + '</FormattingAllowed>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('              </OracleImprintInfo>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('            </ImprintInfo>')
			
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('          </ImageInfo>')
			
			
			if @IUID = @MaxIUID
			begin
				insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
				values('        </ImageInfos>')
			end
			
			
			
			delete @Image where UniqueID = @IUID
		end
		
		
		insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
		values('      </DesignInfo>')
		
		
		if @DUID = @MaxDUID
		begin
			insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
			values('    </Designs>')
		end
		
			
		delete @Design where UniqueID = @DUID
	end


	insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
	values('  </ProductInfo>')
	
	delete @Product where UniqueID = @PUID
end


insert PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport(LineVal)
values(@Header2_E)


if exists(select top 1 * from PIM_ETL_STAGE.dbo.Stage_DesignXMLForExport where isnull(LineVal,'') = '')
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '4'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '8'
	end
end
else
begin
	if @BatchStatus = 2
	begin
		select @ExtractCompleted = '3'
	end
	
	if @BatchStatus = 6
	begin
		select @ExtractCompleted = '7'
	end
end


/*
select *
from @DesignMain

select *
from @Product

select *
from @Design


select *
from @Image
*/










GO
