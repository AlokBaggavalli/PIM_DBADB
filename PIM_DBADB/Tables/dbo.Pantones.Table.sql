
/****** Object:  Table [dbo].[Pantones]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Pantones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[R] [int] NULL,
	[G] [int] NULL,
	[B] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
