
/****** Object:  Table [dbo].[Locale]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Locale](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ATGCatalogID] [nvarchar](255) NULL,
	[ATGCatalogName] [nvarchar](255) NULL,
	[ATGSiteID] [float] NULL,
	[ATGSiteName] [nvarchar](255) NULL,
	[Locale] [nvarchar](255) NULL,
	[Meaning] [nvarchar](255) NULL,
	[CountryCode] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[LanguageCode] [nvarchar](255) NULL,
	[Language] [nvarchar](255) NULL,
 CONSTRAINT [PK_Locale] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
