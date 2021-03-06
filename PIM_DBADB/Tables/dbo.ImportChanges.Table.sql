
/****** Object:  Table [dbo].[ImportChanges]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ImportChanges](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NULL,
	[ProductID] [int] NULL,
	[ChannelID] [int] NULL,
	[ProcessStatusID] [int] NULL,
	[ItemStatusID] [int] NULL,
	[BatchID] [int] NULL,
	[DataSource] [nvarchar](20) NULL,
	[NPProductCode] [nvarchar](50) NULL,
	[WebCode] [nvarchar](50) NULL,
	[NPProductName] [nvarchar](255) NULL,
	[MOQ] [int] NULL,
	[NetPrice] [decimal](10, 3) NULL,
	[ProductChange] [nvarchar](50) NULL,
	[Updated] [datetime] NULL,
	[VendorProductID] [nvarchar](60) NULL,
 CONSTRAINT [PK_ImportChanges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImportChanges]  WITH CHECK ADD  CONSTRAINT [FK_ImportChanges_DistributionChannels] FOREIGN KEY([ChannelID])
REFERENCES [dbo].[DistributionChannels] ([ID])
GO
ALTER TABLE [dbo].[ImportChanges] CHECK CONSTRAINT [FK_ImportChanges_DistributionChannels]
GO
ALTER TABLE [dbo].[ImportChanges]  WITH CHECK ADD  CONSTRAINT [FK_ImportChanges_ItemStatuses] FOREIGN KEY([ItemStatusID])
REFERENCES [dbo].[ItemStatuses] ([ID])
GO
ALTER TABLE [dbo].[ImportChanges] CHECK CONSTRAINT [FK_ImportChanges_ItemStatuses]
GO
ALTER TABLE [dbo].[ImportChanges]  WITH CHECK ADD  CONSTRAINT [FK_ImportChanges_ProcessStatuses] FOREIGN KEY([ProcessStatusID])
REFERENCES [dbo].[ProcessStatuses] ([ID])
GO
ALTER TABLE [dbo].[ImportChanges] CHECK CONSTRAINT [FK_ImportChanges_ProcessStatuses]
GO
ALTER TABLE [dbo].[ImportChanges]  WITH CHECK ADD  CONSTRAINT [FK_ImportChanges_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[ImportChanges] CHECK CONSTRAINT [FK_ImportChanges_Suppliers]
GO
