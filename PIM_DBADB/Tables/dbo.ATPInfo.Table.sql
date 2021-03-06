CREATE TABLE [dbo].[ATPInfo](
	[Id] [uniqueidentifier] NOT NULL,
	[SupplierId] [int] NOT NULL,
	[PartNumber] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateAvailable] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ATPInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ATPInfo] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[ATPInfo]  WITH NOCHECK ADD  CONSTRAINT [FK_ATPInfo_Supplier] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[ATPInfo] CHECK CONSTRAINT [FK_ATPInfo_Supplier]
GO
