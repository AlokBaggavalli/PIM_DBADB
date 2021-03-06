
/****** Object:  Table [dbo].[ProductFOBMaterialCosts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFOBMaterialCosts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFobID] [int] NULL,
	[MaterialSupplierID] [int] NULL,
	[PartNumber] [nvarchar](30) NULL,
	[EffectiveFrom] [datetime] NULL,
	[EffectiveTo] [datetime] NULL,
	[ItemCost] [decimal](10, 5) NULL,
	[AdditionalComments] [nvarchar](1000) NULL,
	[BuyerID] [int] NULL,
	[COO] [nvarchar](10) NULL,
 CONSTRAINT [PK_ProductFOBMaterialCosts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
