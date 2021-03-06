
/****** Object:  Table [dbo].[ProductAttributeSizes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeSizes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductAttributeID] [int] NULL,
	[Value] [nvarchar](20) NULL,
	[UOM] [nvarchar](10) NULL,
	[Selected] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProductAttributeSizes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeSizes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeSizes_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeSizes] CHECK CONSTRAINT [FK_ProductAttributeSizes_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeSizes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeSizes_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeSizes] CHECK CONSTRAINT [FK_ProductAttributeSizes_Products]
GO
