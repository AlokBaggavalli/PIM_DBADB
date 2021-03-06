CREATE TABLE [dbo].[AutoPricingBlocks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Block] [nvarchar](7) NULL,
	[NetPriceLow] [decimal](10, 2) NULL,
	[NetPriceHigh] [decimal](10, 2) NULL,
	[Tier1] [decimal](10, 5) NULL,
	[Tier2] [decimal](10, 5) NULL,
	[Tier3] [decimal](10, 5) NULL,
	[Tier4] [decimal](10, 5) NULL,
	[Tier5] [decimal](10, 5) NULL,
	[Tier6] [decimal](10, 5) NULL,
	[Tier7] [decimal](10, 5) NULL,
	[Tier8] [decimal](10, 5) NULL,
	[Tier9] [decimal](10, 5) NULL,
	[ChannelID] [int] NULL,
 CONSTRAINT [PK_AutoPricingBlocks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
