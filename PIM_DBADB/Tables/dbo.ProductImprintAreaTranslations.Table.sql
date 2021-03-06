
/****** Object:  Table [dbo].[ProductImprintAreaTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductImprintAreaTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductImprintAreaID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Location] [nvarchar](255) NULL,
	[Method] [nvarchar](255) NULL,
 CONSTRAINT [PK_ProductImprintAreaTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
