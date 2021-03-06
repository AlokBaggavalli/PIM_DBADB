
/****** Object:  Table [dbo].[ProductFOBCostComponents]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFOBCostComponents](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFobID] [int] NULL,
	[ProductFobMaterialCostsID] [int] NULL,
	[Component] [nvarchar](30) NULL,
	[Description] [nvarchar](240) NULL,
	[UOMID] [int] NULL,
	[InventoryCategoryID] [int] NULL,
 CONSTRAINT [PK_ProductFOBCostComponents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
