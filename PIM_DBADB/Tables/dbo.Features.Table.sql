
/****** Object:  Table [dbo].[Features]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Features](
	[Name] [nvarchar](50) NOT NULL,
	[DisplayGroup] [nvarchar](250) NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
