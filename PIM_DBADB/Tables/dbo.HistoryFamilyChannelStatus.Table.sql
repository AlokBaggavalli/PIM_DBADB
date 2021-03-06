
/****** Object:  Table [dbo].[HistoryFamilyChannelStatus]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[HistoryFamilyChannelStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFamilyID] [int] NULL,
	[ProductFamilyChannelID] [int] NULL,
	[StatusFrom] [int] NULL,
	[StatusTo] [int] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[Stage] [nvarchar](50) NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_HistoryFamilyChannelStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[HistoryFamilyChannelStatus] ADD  CONSTRAINT [DF_HistoryFamilyChannelStatus_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
