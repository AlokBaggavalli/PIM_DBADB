
/****** Object:  Table [dbo].[CategoryCodes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CategoryCodes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Level1Code] [nvarchar](1) NULL,
	[Level2Code] [nvarchar](1) NULL,
	[Level3Code] [nvarchar](1) NULL,
	[Level4Code] [nvarchar](1) NULL,
	[Description] [nvarchar](100) NULL,
	[MCPTenantID] [int] NULL,
	[WebcodePrefix] [nvarchar](10) NULL,
 CONSTRAINT [PK_CategoryCodes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
