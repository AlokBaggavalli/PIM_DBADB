
/****** Object:  Table [dbo].[ProductAttributeColorTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductAttributeColorTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductAttributeID] [int] NOT NULL,
	[ProductAttributeColorID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Start] [nvarchar](255) NULL,
	[End] [nvarchar](255) NULL,
	[ChannelID] [int] NULL,
 CONSTRAINT [PK_ProductAttributeColorTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeColorTranslations_ProductAttributeColors] FOREIGN KEY([ProductAttributeColorID])
REFERENCES [dbo].[ProductAttributeColors] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations] CHECK CONSTRAINT [FK_ProductAttributeColorTranslations_ProductAttributeColors]
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeColorTranslations_ProductAttributes] FOREIGN KEY([ProductAttributeID])
REFERENCES [dbo].[ProductAttributes] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations] CHECK CONSTRAINT [FK_ProductAttributeColorTranslations_ProductAttributes]
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeColorTranslations_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ID])
GO
ALTER TABLE [dbo].[ProductAttributeColorTranslations] CHECK CONSTRAINT [FK_ProductAttributeColorTranslations_Products]
GO
