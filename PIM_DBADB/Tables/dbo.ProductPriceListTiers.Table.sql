
/****** Object:  Table [dbo].[ProductPriceListTiers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductPriceListTiers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductPriceListID] [int] NULL,
	[QtyBreaks] [int] NULL,
	[PriceBreaks] [decimal](18, 5) NULL,
	[UpsellQty] [int] NULL,
	[UpsellPrice] [decimal](18, 5) NULL,
	[Free] [int] NULL,
	[Premium] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductPriceListTiers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
