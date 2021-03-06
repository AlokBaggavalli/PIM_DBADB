
/****** Object:  Table [dbo].[Query]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Query](
	[QueryID] [int] IDENTITY(1,1) NOT NULL,
	[SSType] [date] NULL,
	[SSFieldName] [date] NULL,
	[DBField1] [date] NULL,
	[DBField2] [date] NULL,
	[DBField3] [date] NULL,
	[Comment] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[QueryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
