
/****** Object:  Table [dbo].[PriceListCharges]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PriceListCharges](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ATGCode] [nvarchar](20) NULL,
	[Description] [nvarchar](200) NULL,
	[ApplicableSkus] [bit] NULL,
	[SkuAttribute] [varchar](20) NULL,
	[SkuAttributeValue] [varchar](20) NULL,
	[NetPriceCharge] [varchar](50) NULL,
	[MarkupFactor] [decimal](10, 2) NULL,
 CONSTRAINT [PK_PriceListCharges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
