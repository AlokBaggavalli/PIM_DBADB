
/****** Object:  Table [dbo].[MailerProcessGroups]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MailerProcessGroups](
	[ID] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[TimePeriod] [varchar](50) NOT NULL,
	[Frequency] [int] NOT NULL,
	[LastProcessed] [datetime] NULL,
 CONSTRAINT [PK_MailerProcessGroups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
