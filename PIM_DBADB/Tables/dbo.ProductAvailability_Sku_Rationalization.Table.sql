
/****** Object:  Table [dbo].[ProductAvailability_Sku_Rationalization]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAvailability_Sku_Rationalization](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[OracleOrgID] [int] NULL,
	[ReceivedDate] [datetime] NULL,
	[FuturePODate] [datetime] NULL,
 CONSTRAINT [PK_ProductAvailability_Sku_Rationalization] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
