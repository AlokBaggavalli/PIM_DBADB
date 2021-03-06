
/****** Object:  Table [dbo].[ProductSpecialCharacters]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSpecialCharacters](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[LocaleID] [int] NULL,
	[SeqNumber] [int] NULL,
	[Code] [nvarchar](4) NULL,
	[Char] [nvarchar](1) NULL,
 CONSTRAINT [PK_ProductSpecialCharacters] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
