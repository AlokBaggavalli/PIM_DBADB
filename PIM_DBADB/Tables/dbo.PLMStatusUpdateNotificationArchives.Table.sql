
/****** Object:  Table [dbo].[PLMStatusUpdateNotificationArchives]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PLMStatusUpdateNotificationArchives](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NoticeType] [varchar](100) NULL,
	[Channel] [varchar](100) NULL,
	[ReportLink] [varchar](1000) NULL,
	[ReportDate] [datetime] NULL,
	[IncludedItems] [varchar](max) NULL,
 CONSTRAINT [PK_PLMStatusUpdateNotificationArchives] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
