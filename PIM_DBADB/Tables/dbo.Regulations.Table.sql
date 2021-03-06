
/****** Object:  Table [dbo].[Regulations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Regulations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Regulation] [varchar](100) NOT NULL,
	[ShortRegulation] [varchar](100) NULL,
	[Description] [varchar](250) NULL,
	[Level] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Regulations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Regulations] UNIQUE NONCLUSTERED 
(
	[Regulation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
