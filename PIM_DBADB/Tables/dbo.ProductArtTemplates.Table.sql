
/****** Object:  Table [dbo].[ProductArtTemplates]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductArtTemplates](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Path] [nvarchar](1000) NULL,
	[ChannelID] [int] NULL,
 CONSTRAINT [PK_ProductArtTemplates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
