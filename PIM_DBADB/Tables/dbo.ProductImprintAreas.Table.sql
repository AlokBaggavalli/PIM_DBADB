
/****** Object:  Table [dbo].[ProductImprintAreas]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductImprintAreas](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Type] [nvarchar](10) NULL,
	[Height] [decimal](10, 3) NULL,
	[Width] [decimal](10, 3) NULL,
	[UOM] [nvarchar](40) NULL,
	[MaxLines] [int] NULL,
	[MaxChars] [int] NULL,
	[IncludedColors] [int] NULL,
	[ColorMax] [int] NULL,
	[DefaultFont] [nvarchar](60) NULL,
	[DefaultFontSize] [decimal](10, 2) NULL,
	[FontMin] [decimal](10, 2) NULL,
	[FontMax] [decimal](10, 2) NULL,
	[Justification] [nvarchar](10) NULL,
	[CategoryID] [int] NULL,
	[Qualifier1] [nvarchar](30) NULL,
	[Qualifier2] [nvarchar](30) NULL,
	[BoxHeight] [decimal](10, 3) NULL,
	[BoxWidth] [decimal](10, 3) NULL,
	[BoxUOM] [nvarchar](10) NULL,
	[LocationClassID] [int] NULL,
	[ProcessClassID] [int] NULL,
	[Channels] [nvarchar](100) NULL,
	[MetricHeight] [decimal](10, 3) NULL,
	[MetricWidth] [decimal](10, 3) NULL,
	[MetricUOM] [nvarchar](10) NULL,
	[SafetyMarginLeft] [decimal](10, 5) NULL,
	[SafetyMarginRight] [decimal](10, 5) NULL,
	[SafetyMarginTop] [decimal](10, 5) NULL,
	[SafetyMarginBottom] [decimal](10, 5) NULL,
	[BleedMarginLeft] [decimal](10, 5) NULL,
	[BleedMarginRight] [decimal](10, 5) NULL,
	[BleedMarginTop] [decimal](10, 5) NULL,
	[BleedMarginBottom] [decimal](10, 5) NULL,
	[ImprintDiameter] [decimal](10, 3) NULL,
	[MetricDiameter] [decimal](10, 3) NULL,
	[SafetyUOM] [nvarchar](10) NULL,
	[BleedUOM] [nvarchar](10) NULL,
	[TATrangeID] [int] NULL,
	[RegionID] [int] NULL,
	[PsLocationID] [int] NULL,
	[PsDecorationID] [int] NULL,
 CONSTRAINT [PK_ProductImprints] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
