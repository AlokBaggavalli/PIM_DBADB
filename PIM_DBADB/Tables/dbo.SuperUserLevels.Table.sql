
/****** Object:  Table [dbo].[SuperUserLevels]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SuperUserLevels](
	[Level] [int] NOT NULL,
	[Restriction] [nvarchar](200) NULL,
 CONSTRAINT [PK_SuperUserLevels] PRIMARY KEY CLUSTERED 
(
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
