
/****** Object:  Table [dbo].[ProductPriceLists]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductPriceLists](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[PriceListNameID] [int] NULL,
	[ListPrice] [decimal](18, 5) NULL,
	[UnitPrice] [decimal](18, 5) NULL,
	[FreePercent] [int] NULL,
	[PriceTier] [int] NULL,
 CONSTRAINT [PK_ProductPriceLists] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This ID references the Locale ID field for the PriceListName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductPriceLists', @level2type=N'COLUMN',@level2name=N'PriceListNameID'
GO
