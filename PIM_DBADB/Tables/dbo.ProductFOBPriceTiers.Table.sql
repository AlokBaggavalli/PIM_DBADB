
/****** Object:  Table [dbo].[ProductFOBPriceTiers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFOBPriceTiers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFobID] [int] NULL,
	[QtyStart] [int] NULL,
	[NPQuote] [decimal](10, 3) NULL,
	[STDCatalogNet] [decimal](10, 3) NULL,
	[STDCatalogPrice] [decimal](10, 3) NULL,
	[PriceCode] [nvarchar](1) NULL,
	[PriceCodePct] [decimal](10, 2) NULL,
 CONSTRAINT [PK_ProductFOBPriceTiers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
