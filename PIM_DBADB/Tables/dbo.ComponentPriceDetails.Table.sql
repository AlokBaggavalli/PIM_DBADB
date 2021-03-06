
/****** Object:  Table [dbo].[ComponentPriceDetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ComponentPriceDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RawCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](350) NULL,
	[Supplier] [nvarchar](255) NOT NULL,
	[MOQ] [int] NULL,
	[QtyPO] [int] NULL,
	[QtyCarton] [int] NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[Tier_Qty_1] [int] NULL,
	[Tier_Qty_2] [int] NULL,
	[Tier_Qty_3] [int] NULL,
	[Tier_Qty_4] [int] NULL,
	[Tier_Qty_5] [int] NULL,
	[Tier_Qty_6] [int] NULL,
	[Tier_Qty_7] [int] NULL,
	[Tier_Qty_8] [int] NULL,
	[Price_Tier_1] [decimal](18, 5) NULL,
	[Price_Tier_2] [decimal](18, 5) NULL,
	[Price_Tier_3] [decimal](18, 5) NULL,
	[Price_Tier_4] [decimal](18, 5) NULL,
	[Price_Tier_5] [decimal](18, 5) NULL,
	[Price_Tier_6] [decimal](18, 5) NULL,
	[Price_Tier_7] [decimal](18, 5) NULL,
	[Price_Tier_8] [decimal](18, 5) NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_ComponentPriceDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
