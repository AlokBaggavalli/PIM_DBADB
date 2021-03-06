
/****** Object:  Table [dbo].[SkuFormats]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SkuFormats](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_SkuFormats] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
