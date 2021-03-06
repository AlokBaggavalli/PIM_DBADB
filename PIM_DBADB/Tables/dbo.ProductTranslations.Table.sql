
/****** Object:  Table [dbo].[ProductTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[NPProductName] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
	[SubHeader] [nvarchar](1000) NULL,
	[LongDescriptionCopy] [nvarchar](3000) NULL,
	[WebName] [nvarchar](255) NULL,
	[Material] [nvarchar](1000) NULL,
	[Keywords] [nvarchar](2000) NULL,
	[NPurl] [nvarchar](1000) NULL,
	[SEOTitle] [nvarchar](1000) NULL,
	[SEODescription] [nvarchar](1000) NULL,
	[SEOText] [nvarchar](max) NULL,
	[NPWebNotes] [nvarchar](max) NULL,
	[SageThemes] [nvarchar](1000) NULL,
	[NPKeywords] [nvarchar](2000) NULL,
	[ChannelID] [int] NULL,
 CONSTRAINT [PK_ProductTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
