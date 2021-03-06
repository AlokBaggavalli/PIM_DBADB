
/****** Object:  Table [dbo].[PromoStandardsDownloadDetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PromoStandardsDownloadDetails](
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
 CONSTRAINT [PK_PromoStandardsDownloadDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PromoStandardsDownloadDetails]  WITH CHECK ADD  CONSTRAINT [FK_PromoStandardsDownloadDetails_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[PromoStandardsDownloadDetails] CHECK CONSTRAINT [FK_PromoStandardsDownloadDetails_Suppliers]
GO
