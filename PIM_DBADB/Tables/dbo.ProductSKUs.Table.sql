
/****** Object:  Table [dbo].[ProductSKUs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSKUs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[PartNumber] [nvarchar](60) NULL,
	[Description] [nvarchar](1000) NULL,
	[ATP] [int] NULL,
	[LastUpdate] [datetime] NULL,
	[OracleID] [nvarchar](255) NULL,
	[OracleDesc] [nvarchar](200) NULL,
	[ProdFamily] [nvarchar](60) NULL,
	[DecoMethod] [nvarchar](60) NULL,
	[ProdColor] [nvarchar](60) NULL,
	[BarrelType] [nvarchar](60) NULL,
	[InkColor] [nvarchar](60) NULL,
	[PackSize] [nvarchar](60) NULL,
	[Royalty] [nvarchar](25) NULL,
	[RoyaltySub] [nvarchar](25) NULL,
	[Colors] [nvarchar](300) NULL,
	[Component] [nvarchar](255) NULL,
	[SkuFormatID] [int] NULL,
	[CrossRef] [nvarchar](60) NULL,
	[DistChannel] [nvarchar](100) NULL,
	[ProductFamilyID] [int] NULL,
	[SampleTNS] [bit] NULL,
	[SamplePLM] [bit] NULL,
	[SampleIRL] [bit] NULL,
	[MCPsku] [nvarchar](50) NULL,
	[MCPSkuFamilyID] [nvarchar](100) NULL,
	[MCPRuleSetID] [nvarchar](100) NULL,
	[MCPSurfaceTemplateRefID] [nvarchar](100) NULL,
	[MCPSurfaceSetID] [nvarchar](100) NULL,
	[MCPDataSheetID] [nvarchar](100) NULL,
	[MCPContractID] [nvarchar](100) NULL,
	[OracleInventoryItemID] [int] NULL,
	[MCPstatusID] [int] NULL,
	[MCPUpdated] [datetime] NULL,
	[SampleGER] [bit] NULL,
	[DecoSubClass] [nvarchar](20) NULL,
	[SampleCZE] [bit] NULL,
	[SpotColor] [varchar](100) NULL,
 CONSTRAINT [PK_ProductSKUs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
