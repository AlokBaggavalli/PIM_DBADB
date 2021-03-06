
/****** Object:  Table [dbo].[VendorImprintColors]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[VendorImprintColors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ColorName] [nvarchar](50) NULL,
	[ATGColorID] [float] NULL,
	[HexCode] [nvarchar](20) NULL,
	[Name] [nvarchar](255) NULL,
	[ASINumber] [nvarchar](50) NULL,
	[LanguageCode] [nvarchar](10) NULL,
	[Method] [nvarchar](255) NULL,
 CONSTRAINT [PK_VendorImprintColors_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VendorImprintColors] ADD  DEFAULT ('DEFAULT') FOR [Method]
GO
