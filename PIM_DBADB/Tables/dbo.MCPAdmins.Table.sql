
/****** Object:  Table [dbo].[MCPAdmins]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPAdmins](
	[UserName] [nvarchar](200) NOT NULL,
	[LastMCPRepushDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
