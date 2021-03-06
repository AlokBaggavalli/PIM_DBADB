
/****** Object:  Table [dbo].[PriceLists]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PriceLists](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LocaleID] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Currency] [nvarchar](255) NULL,
	[OracleID] [float] NULL,
	[Org] [nvarchar](255) NULL,
	[Type] [nvarchar](5) NULL,
	[EffectiveFrom] [nvarchar](10) NULL,
	[EffectiveTo] [nvarchar](10) NULL,
 CONSTRAINT [PK_PriceLists] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
