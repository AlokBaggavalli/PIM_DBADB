
/****** Object:  Table [dbo].[ProductFOBs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFOBs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[City] [nvarchar](60) NULL,
	[StateProvinceCounty] [nvarchar](60) NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Country] [nvarchar](10) NULL,
	[Currency] [nvarchar](3) NULL,
	[Type] [nvarchar](10) NULL,
	[Qualifier] [nvarchar](100) NULL,
	[DecoMethod] [nvarchar](255) NULL,
	[ItemCode] [nvarchar](2000) NULL,
	[ColorCount] [int] NULL,
	[QualifierValue] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProductFOBs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
