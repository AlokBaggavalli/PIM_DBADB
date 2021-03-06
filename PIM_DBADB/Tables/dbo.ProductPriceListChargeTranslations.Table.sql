
/****** Object:  Table [dbo].[ProductPriceListChargeTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductPriceListChargeTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductPriceListID] [int] NOT NULL,
	[ProductPriceListChargeID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[DisplayName] [nvarchar](255) NULL,
 CONSTRAINT [PK_PriceListChargeTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
