CREATE TABLE [dbo].[AutoPricingCatalogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Level1] [int] NOT NULL,
	[Level2] [int] NOT NULL,
	[Level3] [int] NOT NULL,
	[Level4] [int] NOT NULL,
	[Level5] [int] NOT NULL,
	[Level6] [int] NOT NULL,
	[PricingBlock] [nvarchar](7) NOT NULL,
	[ChannelID] [int] NULL,
 CONSTRAINT [PK_AutoPricingCatalogs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
