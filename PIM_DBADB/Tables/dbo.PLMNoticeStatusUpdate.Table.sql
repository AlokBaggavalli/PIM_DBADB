
/****** Object:  Table [dbo].[PLMNoticeStatusUpdate]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PLMNoticeStatusUpdate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryFamilyChannelStatusID] [int] NOT NULL,
	[Type] [nvarchar](50) NULL,
	[NoticeType] [nvarchar](50) NULL,
	[Channel] [nvarchar](50) NULL,
	[Org] [nvarchar](3) NULL,
	[PCode] [nvarchar](100) NULL,
	[Item] [nvarchar](100) NULL,
	[ProductFamilyStatus] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Category] [nvarchar](50) NULL,
	[ProcessStatus] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ProcessDate] [datetime] NULL,
 CONSTRAINT [PK_PLMNoticeStatusUpdate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
