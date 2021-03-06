
/****** Object:  Table [dbo].[WebCategories]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[WebCategories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Level1] [int] NULL,
	[Level2] [int] NULL,
	[Level3] [int] NULL,
	[Level4] [int] NULL,
	[Level5] [int] NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_WebCategories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
