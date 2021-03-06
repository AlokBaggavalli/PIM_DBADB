
/****** Object:  Table [dbo].[ProductDesignTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductDesignTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductDesignID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[CatLevel1] [nvarchar](60) NULL,
	[CatLevel2] [nvarchar](60) NULL,
	[Keywords] [nvarchar](1000) NULL,
	[WebDesc] [nvarchar](240) NULL,
	[MktDesc] [nvarchar](240) NULL,
 CONSTRAINT [PK_ProductDesignTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
