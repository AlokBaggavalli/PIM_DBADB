
/****** Object:  Table [dbo].[TranslationValues]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[TranslationValues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocaleID] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[Value] [nvarchar](100) NULL,
 CONSTRAINT [PK_TranslationValues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
