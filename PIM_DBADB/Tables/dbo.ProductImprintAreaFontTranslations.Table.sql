
/****** Object:  Table [dbo].[ProductImprintAreaFontTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductImprintAreaFontTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductImprintAreaID] [int] NOT NULL,
	[ProductImprintAreaFontID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Name] [nvarchar](60) NULL,
 CONSTRAINT [PK_ProductImprintAreaFontsTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
