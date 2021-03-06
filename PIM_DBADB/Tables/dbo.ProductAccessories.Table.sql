
/****** Object:  Table [dbo].[ProductAccessories]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAccessories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[QtyMatch] [bit] NULL,
	[RelationTypeID] [int] NULL,
	[RelatedProductID] [int] NULL,
	[MCPUpdated] [datetime] NULL,
 CONSTRAINT [PK_ProductAccessories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAccessories] ADD  CONSTRAINT [DF_ProductAccessories_QtyMatch]  DEFAULT ((0)) FOR [QtyMatch]
GO
