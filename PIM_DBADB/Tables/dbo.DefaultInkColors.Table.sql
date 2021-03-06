
/****** Object:  Table [dbo].[DefaultInkColors]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DefaultInkColors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ColorName] [nvarchar](50) NULL,
	[HexCode] [nvarchar](20) NULL,
	[LanguageCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_DefaultInkColors_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
