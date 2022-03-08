
/****** Object:  Table [dbo].[ProductDesigns]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductDesigns](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[DesignName] [nvarchar](3) NULL,
	[DesignCode] [nvarchar](100) NULL,
	[MaxLines] [int] NULL,
	[MaxPoint] [int] NULL,
	[MaxChars] [int] NULL,
	[AllowFormat] [bit] NULL,
	[Casino] [bit] NULL,
	[Holo] [bit] NULL,
	[ImpReq] [bit] NULL,
	[Logo] [bit] NULL,
	[Filename] [nvarchar](100) NULL,
	[Template] [bit] NULL,
	[TempName] [nvarchar](100) NULL,
	[ImpDesignCode] [nvarchar](100) NULL,
	[Font] [nvarchar](60) NULL,
	[Color] [nvarchar](60) NULL,
	[Orient] [nvarchar](10) NULL,
	[LineSpace] [int] NULL,
	[Outline] [int] NULL,
	[OutlineColor] [int] NULL,
	[TextboxWidth] [decimal](10, 2) NULL,
	[TexboxHeight] [decimal](10, 2) NULL,
	[TextboxXLoc] [decimal](10, 2) NULL,
	[TextboxYLoc] [decimal](10, 2) NULL,
	[VerticalText] [bit] NULL,
	[AlphaChannel] [bit] NULL,
	[AllowColor] [bit] NULL,
	[PresFormat] [nvarchar](60) NULL,
	[ProdFormat] [nvarchar](10) NULL,
	[ProdOutputRes] [int] NULL,
	[ProdOutputColor] [nvarchar](10) NULL,
	[ImpMaxPoint] [int] NULL,
	[TextRotation] [int] NULL,
	[FilePath] [nvarchar](255) NULL,
	[DimensionsWidth] [int] NULL,
	[DimensionsHeight] [int] NULL,
	[BoundingBoxX] [decimal](10, 2) NULL,
	[BoundingBoxY] [decimal](10, 2) NULL,
	[BoundingBoxWidth] [decimal](10, 2) NULL,
	[BoundingBoxHeight] [decimal](10, 2) NULL,
	[VignetteExists] [bit] NULL,
	[IsSeries] [bit] NULL,
	[SeriesCount] [int] NULL,
	[InScene7] [bit] NULL,
	[BaseUrl] [nvarchar](500) NULL,
	[SampleUrl] [nvarchar](500) NULL,
	[ImageName] [nvarchar](50) NULL,
	[ImageDesc] [nvarchar](50) NULL,
	[ImageFileName] [nvarchar](50) NULL,
	[ImagePresFormat] [nvarchar](10) NULL,
	[ImageProdFormat] [nvarchar](10) NULL,
	[ImageProdColorSpace] [nvarchar](10) NULL,
	[ImageProdOutRes] [int] NULL,
	[ImageSeries] [bit] NULL,
	[ImageSeriesCount] [int] NULL,
	[ImageAlpha] [bit] NULL,
	[ImageAllowColorChoice] [bit] NULL,
	[ImpCenterPointX] [decimal](10, 4) NULL,
	[ImpCenterPointY] [decimal](10, 4) NULL,
	[ImpFontColor] [nvarchar](100) NULL,
	[ImpFontName] [nvarchar](50) NULL,
	[ImpSize] [nvarchar](100) NULL,
	[ImpJustification] [nvarchar](50) NULL,
	[ImpLineSpacing] [int] NULL,
	[ImpTextRotation] [int] NULL,
	[ImpVerticalText] [bit] NULL,
	[ProductMethodology] [nvarchar](50) NULL,
	[RoyaltyDesign] [bit] NULL,
	[DesignUrl] [nvarchar](512) NULL,
	[DistChannel] [nvarchar](100) NULL,
	[ColorName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductDesigns] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
