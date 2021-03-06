
/****** Object:  Table [dbo].[ProductSkuBillOfMaterials]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSkuBillOfMaterials](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductSkuID] [int] NULL,
	[OrgID] [int] NULL,
	[UOMID] [int] NULL,
	[ItemSeq] [int] NULL,
	[OperatingSeq] [int] NULL,
	[Component] [nvarchar](30) NULL,
	[Quantity] [decimal](10, 6) NULL,
	[SupplyType] [nvarchar](25) NULL,
	[SubInventory] [nvarchar](25) NULL,
	[Critical] [bit] NULL,
	[LastPODate] [datetime] NULL,
 CONSTRAINT [PK_ProductSkuBillOfMaterials] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
