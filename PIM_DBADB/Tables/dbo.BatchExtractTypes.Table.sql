
/****** Object:  Table [dbo].[BatchExtractTypes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[BatchExtractTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](30) NOT NULL,
 CONSTRAINT [PK_BatchExtractTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
