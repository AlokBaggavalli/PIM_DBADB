
/****** Object:  Table [dbo].[ProductAttributeTypeTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeTypeTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductAttributeID] [int] NOT NULL,
	[ProductAttributeTypeID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Name] [nvarchar](60) NULL,
 CONSTRAINT [PK_ProductAttributeTypesTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTypeTranslations_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations] CHECK CONSTRAINT [FK_ProductAttributeTypeTranslations_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTypeTranslations_ProductAttributeTypes] FOREIGN KEY([ProductAttributeTypeID])
REFERENCES [dbo].[ProductAttributeTypes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations] CHECK CONSTRAINT [FK_ProductAttributeTypeTranslations_ProductAttributeTypes]
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTypeTranslations_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTypeTranslations] CHECK CONSTRAINT [FK_ProductAttributeTypeTranslations_Products]
GO
