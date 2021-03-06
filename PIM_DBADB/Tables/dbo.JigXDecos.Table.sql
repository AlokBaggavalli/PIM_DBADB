
/****** Object:  Table [dbo].[JigXDecos]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[JigXDecos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[JigId] [int] NULL,
	[JigDecoId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[JigXDecos]  WITH CHECK ADD  CONSTRAINT [FK_JigXDecos_JigDecos] FOREIGN KEY([JigDecoId])
REFERENCES [dbo].[JigDecos] ([ID])
GO
ALTER TABLE [dbo].[JigXDecos] CHECK CONSTRAINT [FK_JigXDecos_JigDecos]
GO
ALTER TABLE [dbo].[JigXDecos]  WITH CHECK ADD  CONSTRAINT [FK_JigXDecos_JigIDs] FOREIGN KEY([JigId])
REFERENCES [dbo].[JigIDs] ([ID])
GO
ALTER TABLE [dbo].[JigXDecos] CHECK CONSTRAINT [FK_JigXDecos_JigIDs]
GO
