
/****** Object:  Table [dbo].[ImprintAreaCategories]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ImprintAreaCategories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](20) NULL,
 CONSTRAINT [PK_ImprintAreaCategories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
