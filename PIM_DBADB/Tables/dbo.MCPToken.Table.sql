
/****** Object:  Table [dbo].[MCPToken]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPToken](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MCPToken] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
