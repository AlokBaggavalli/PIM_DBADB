
/****** Object:  Table [dbo].[OracleItemCode]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OracleItemCode](
	[InventoryItemID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[ItemCode] [varchar](50) NULL,
	[Descript] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryItemID] ASC,
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
