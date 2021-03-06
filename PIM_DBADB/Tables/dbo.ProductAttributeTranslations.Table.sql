
/****** Object:  Table [dbo].[ProductAttributeTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductAttributeID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Name] [nvarchar](60) NULL,
 CONSTRAINT [PK_ProductAccessoriesTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTranslations_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTranslations] CHECK CONSTRAINT [FK_ProductAttributeTranslations_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeTranslations_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeTranslations] CHECK CONSTRAINT [FK_ProductAttributeTranslations_Products]
GO
