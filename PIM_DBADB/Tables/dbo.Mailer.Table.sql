
/****** Object:  Table [dbo].[Mailer]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Mailer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MailTo] [nvarchar](1000) NOT NULL,
	[MailCC] [nvarchar](1000) NULL,
	[MailFrom] [nvarchar](1000) NOT NULL,
	[MailSubject] [nvarchar](200) NOT NULL,
	[MailBody] [text] NOT NULL,
	[Attachments] [nvarchar](2000) NULL,
	[DeleteAttachments] [bit] NULL,
	[DateLoaded] [datetime] NOT NULL,
	[DateMailed] [datetime] NULL,
	[ProcessGroup] [int] NOT NULL,
	[GroupHeading] [nvarchar](2000) NULL,
	[GroupFooter] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Mailer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
