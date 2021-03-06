
/****** Object:  Table [dbo].[NoticeTypeRecipients]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[NoticeTypeRecipients](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NoticeType] [varchar](100) NULL,
	[Channel] [varchar](100) NULL,
	[Recipients] [varchar](1000) NULL,
 CONSTRAINT [PK_NoticeTypeRecipients] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
