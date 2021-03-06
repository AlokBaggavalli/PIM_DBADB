
/****** Object:  Table [dbo].[CustomizationInfoSKULog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CustomizationInfoSKULog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[MCPSKU] [nvarchar](50) NULL,
	[ImprintArea1DefaultPantoneColorName] [nvarchar](100) NULL,
	[ImprintArea1DefaultBackgroundColorName] [nvarchar](100) NULL,
	[Status] [nvarchar](200) NULL,
	[ErrorMessage] [nvarchar](200) NULL,
 CONSTRAINT [PK_CustomizationInfoSKULog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomizationInfoSKULog]  WITH CHECK ADD  CONSTRAINT [FK_CustomizationInfoSKULog_CustomizationInfoLog] FOREIGN KEY([ParentId])
REFERENCES [dbo].[CustomizationInfoLog] ([Id])
GO
ALTER TABLE [dbo].[CustomizationInfoSKULog] CHECK CONSTRAINT [FK_CustomizationInfoSKULog_CustomizationInfoLog]
GO
