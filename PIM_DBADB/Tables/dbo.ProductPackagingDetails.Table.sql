
/****** Object:  Table [dbo].[ProductPackagingDetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductPackagingDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[PackageType] [nvarchar](60) NULL,
	[QtyPerBox] [int] NULL,
	[QtyUOM] [nvarchar](10) NULL,
	[Height] [decimal](10, 2) NULL,
	[Width] [decimal](10, 2) NULL,
	[Depth] [decimal](10, 2) NULL,
	[SizeUOM] [nvarchar](10) NULL,
	[BoxWeight] [decimal](10, 2) NULL,
	[WeightUOM] [nvarchar](10) NULL,
	[BoxGrWeight] [decimal](10, 2) NULL,
	[Category] [nvarchar](20) NULL,
 CONSTRAINT [PK_ProductPackagingDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
