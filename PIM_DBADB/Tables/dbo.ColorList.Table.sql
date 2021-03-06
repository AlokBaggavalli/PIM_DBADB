
/****** Object:  Table [dbo].[ColorList]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ColorList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Hex] [nvarchar](6) NULL,
	[Red] [int] NULL,
	[Green] [int] NULL,
	[Blue] [int] NULL,
 CONSTRAINT [PK_ColorList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
