
/****** Object:  Table [dbo].[SuperUsers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SuperUsers](
	[UserName] [varchar](100) NOT NULL,
	[AccessLevel] [int] NULL,
 CONSTRAINT [PK_SuperUsers] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
