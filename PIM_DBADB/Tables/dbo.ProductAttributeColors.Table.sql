
/****** Object:  Table [dbo].[ProductAttributeColors]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeColors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductAttributeID] [int] NULL,
	[StartHexCode] [nvarchar](50) NULL,
	[EndHexCode] [nvarchar](50) NULL,
	[Selected] [bit] NULL,
	[ColorClassID] [int] NULL,
	[PMSCodeStart] [nvarchar](60) NULL,
	[PMSCodeEnd] [nvarchar](60) NULL,
	[SupplierCodeID] [int] NULL,
 CONSTRAINT [PK_ProductAttributeColors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeColors]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeColors_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeColors] CHECK CONSTRAINT [FK_ProductAttributeColors_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeColors]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeColors_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeColors] CHECK CONSTRAINT [FK_ProductAttributeColors_Products]
GO
