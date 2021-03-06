
/****** Object:  Table [dbo].[ProductFOBAdditionalCharges]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFOBAdditionalCharges](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFobID] [int] NULL,
	[Name] [nvarchar](250) NULL,
	[ApplicationMethod] [nvarchar](60) NULL,
	[NPQuote] [decimal](10, 2) NULL,
	[STDCatalogNet] [decimal](10, 2) NULL,
	[STDCatalogPrice] [decimal](10, 2) NULL,
	[PriceCode] [nvarchar](1) NULL,
	[PriceCodePct] [decimal](10, 2) NULL,
	[OracleChargeSkuID] [int] NULL,
	[PsChargeID] [int] NULL,
 CONSTRAINT [PK_ProductFOBAdditionalCharges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
