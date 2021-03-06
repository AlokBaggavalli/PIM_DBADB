
/****** Object:  Table [dbo].[ProductChannels]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductChannels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ChannelID] [int] NULL,
	[ABCID] [int] NULL,
	[TargetDate] [datetime] NULL,
	[ReleaseDate] [datetime] NULL,
	[ReleasedBy] [nvarchar](50) NULL,
	[TATmin] [varchar](50) NULL,
	[TATmax] [varchar](50) NULL,
	[TATrangeID] [int] NULL,
	[ProcessStatusID] [int] NULL,
	[ItemStatusID] [int] NULL,
	[WebCode] [nvarchar](50) NULL,
	[ABCChanged] [datetime] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[Marketable] [bit] NULL,
	[MarketableDate] [datetime] NULL,
	[SummaryStatusId] [int] NULL,
 CONSTRAINT [PK_ProductChannels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductChannels]  WITH CHECK ADD  CONSTRAINT [FK_ProductChannel_ItemStatus] FOREIGN KEY([SummaryStatusId])
REFERENCES [dbo].[ItemStatuses] ([ID])
GO
ALTER TABLE [dbo].[ProductChannels] CHECK CONSTRAINT [FK_ProductChannel_ItemStatus]
GO
