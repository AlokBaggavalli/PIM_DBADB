
/****** Object:  Table [dbo].[ProductJigs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductJigs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[JigId] [int] NULL,
	[Comments] [nvarchar](50) NULL,
 CONSTRAINT [PK_ProductJigs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductJigs]  WITH CHECK ADD  CONSTRAINT [FK_ProductJigs_JigIDs] FOREIGN KEY([JigId])
REFERENCES [dbo].[JigIDs] ([ID])
GO
ALTER TABLE [dbo].[ProductJigs] CHECK CONSTRAINT [FK_ProductJigs_JigIDs]
GO
