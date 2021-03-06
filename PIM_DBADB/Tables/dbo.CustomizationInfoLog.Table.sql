
/****** Object:  Table [dbo].[CustomizationInfoLog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CustomizationInfoLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [int] NULL,
	[Locale] [nvarchar](255) NULL,
	[NPProductCode] [nvarchar](50) NULL,
	[DefaultDesignFontFamilyName] [nvarchar](60) NULL,
	[NumberOfLines] [int] NULL,
	[NumberOfCharactersPerLine] [int] NULL,
	[DefaultFontSize] [decimal](10, 2) NULL,
	[MinimumFontSize] [decimal](10, 2) NULL,
	[MaximumFontSize] [decimal](10, 2) NULL,
	[Message] [nvarchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_CustomizationInfoLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
