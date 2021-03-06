
/****** Object:  Table [dbo].[OracleProductItems]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OracleProductItems](
	[InventoryItemID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[EnabledFlag] [char](1) NULL,
	[Product] [varchar](10) NULL,
	[Category] [varchar](10) NULL,
	[ItemCode] [varchar](40) NULL,
	[Name] [nvarchar](240) NULL,
	[ItemCost] [numeric](18, 5) NULL,
	[MaterialCost] [numeric](18, 5) NULL,
	[MaterialOverheadCost] [numeric](18, 5) NULL,
	[ResourceCost] [numeric](18, 5) NULL,
	[OverheadCost] [numeric](18, 5) NULL,
	[DefaultShipWarehouseID] [int] NULL,
	[Attribute1] [varchar](50) NULL,
	[Attribute2] [varchar](50) NULL,
	[Attribute3] [varchar](50) NULL,
	[Attribute4] [varchar](50) NULL,
	[PlanningMakeBuyCode] [int] NULL,
	[CustomerOrderFlag] [varchar](50) NULL,
	[CustomerOrderEnabledFlag] [char](1) NULL,
	[Descript] [varchar](240) NULL,
	[CreationDate] [datetime] NULL,
	[ProductFamilyID] [int] NULL,
	[InvoiceEnabledFlag] [varchar](5) NULL,
	[Unit_Weight] [float] NULL,
	[InventoryItemStatusCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_ProductItems] PRIMARY KEY CLUSTERED 
(
	[InventoryItemID] ASC,
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
