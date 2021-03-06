
/****** Object:  Table [dbo].[WebSpecsInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[WebSpecsInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[Low] [decimal](10, 2) NULL,
	[High] [decimal](10, 2) NULL,
	[Sort] [int] NULL,
 CONSTRAINT [PK_WebSpecsInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
