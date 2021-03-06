
/****** Object:  Table [dbo].[PromoStandardsDownloadStage]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PromoStandardsDownloadStage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NULL,
	[VendorProductID] [nvarchar](50) NULL,
	[VendorPartID] [nvarchar](50) NULL,
	[LocationID] [int] NULL,
	[LocationName] [nvarchar](200) NULL,
	[DecorationID] [int] NULL,
	[DecorationName] [nvarchar](200) NULL,
	[ChargeID] [int] NULL,
	[ChargeName] [nvarchar](200) NULL,
	[ChargeDescription] [nvarchar](200) NULL,
	[ChargeType] [nvarchar](50) NULL,
 CONSTRAINT [PK_PromoStandardsDownloadStage] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PromoStandardsDownloadStage]  WITH CHECK ADD  CONSTRAINT [FK_PromoStandardsDownloadStage_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[PromoStandardsDownloadStage] CHECK CONSTRAINT [FK_PromoStandardsDownloadStage_Suppliers]
GO
