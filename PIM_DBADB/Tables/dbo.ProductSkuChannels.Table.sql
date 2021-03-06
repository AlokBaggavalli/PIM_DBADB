
/****** Object:  Table [dbo].[ProductSkuChannels]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSkuChannels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductSkuID] [int] NULL,
	[ChannelID] [int] NULL,
	[Marketable] [bit] NULL,
	[MarketableDate] [datetime] NULL,
 CONSTRAINT [PK_ProductSkuChannels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
