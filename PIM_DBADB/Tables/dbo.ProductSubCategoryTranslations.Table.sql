
/****** Object:  Table [dbo].[ProductSubCategoryTranslations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSubCategoryTranslations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[ProductSubCategoryID] [int] NOT NULL,
	[LocaleID] [int] NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProductSubCategoryTranslations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductSubCategoryTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductSubCategoryTranslations_Locale] FOREIGN KEY([LocaleID])
REFERENCES [dbo].[Locale] ([ID])
GO
ALTER TABLE [dbo].[ProductSubCategoryTranslations] CHECK CONSTRAINT [FK_ProductSubCategoryTranslations_Locale]
GO
ALTER TABLE [dbo].[ProductSubCategoryTranslations]  WITH CHECK ADD  CONSTRAINT [FK_ProductSubCategoryTranslations_ProductSubCategories] FOREIGN KEY([ProductSubCategoryID])
REFERENCES [dbo].[ProductSubCategories] ([ID])
GO
ALTER TABLE [dbo].[ProductSubCategoryTranslations] CHECK CONSTRAINT [FK_ProductSubCategoryTranslations_ProductSubCategories]
GO
