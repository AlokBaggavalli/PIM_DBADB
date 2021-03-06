
/****** Object:  Table [dbo].[ProductPriceListCharges]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductPriceListCharges](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductPriceListID] [int] NOT NULL,
	[PriceListChargeID] [int] NULL,
	[PriceListApplicationTypeID] [int] NULL,
	[PriceListSelectionModeID] [int] NULL,
	[Amount] [decimal](18, 5) NULL,
	[MatchSkuQty] [bit] NULL,
	[Visible] [bit] NULL,
 CONSTRAINT [PK_ProductPriceListCharges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
