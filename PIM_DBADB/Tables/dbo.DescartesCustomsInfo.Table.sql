
/****** Object:  Table [dbo].[DescartesCustomsInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DescartesCustomsInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataSource] [nvarchar](50) NULL,
	[CustomsPartKey] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[TariffType] [nvarchar](50) NULL,
	[TariffCode] [nvarchar](max) NULL,
	[Ruling] [nvarchar](50) NULL,
	[USFDAProductCode] [nvarchar](50) NULL,
	[USFDAClaimStatus] [nvarchar](50) NULL,
	[CustomsHold] [nvarchar](50) NULL,
 CONSTRAINT [PK_DescartesCustomsInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
