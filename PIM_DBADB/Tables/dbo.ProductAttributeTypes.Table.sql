
/****** Object:  Table [dbo].[ProductAttributeTypes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductAttributeID] [int] NOT NULL,
	[Selected] [bit] NULL,
 CONSTRAINT [PK_ProductAttributeTypes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeTypes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTypes_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTypes] CHECK CONSTRAINT [FK_ProductAttributeTypes_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeTypes]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTypes_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTypes] CHECK CONSTRAINT [FK_ProductAttributeTypes_Products]
GO
