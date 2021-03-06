
/****** Object:  Table [dbo].[CountryCodes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CountryCodes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](2) NULL,
	[Description] [nvarchar](100) NULL,
	[FreightPct] [decimal](10, 5) NULL,
 CONSTRAINT [PK_CountryCodes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
