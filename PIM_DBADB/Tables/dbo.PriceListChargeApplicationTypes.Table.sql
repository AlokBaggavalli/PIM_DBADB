
/****** Object:  Table [dbo].[PriceListChargeApplicationTypes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PriceListChargeApplicationTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationType] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_SellPriceApplicationTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
