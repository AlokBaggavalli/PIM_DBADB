
/****** Object:  Table [dbo].[PromoStandardsDownloadConfig]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PromoStandardsDownloadConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[EndPointUrl] [nvarchar](2000) NULL,
	[ServiceId] [nvarchar](200) NULL,
	[ServicePassword] [nvarchar](100) NULL,
	[ServiceVersion] [varchar](10) NULL,
	[ProductIds] [varchar](max) NULL,
	[ImportedDate] [datetime] NULL,
	[LastCheckedDate] [datetime] NULL,
	[MediaServiceVersion] [varchar](10) NULL,
	[MediaEndPointUrl] [nvarchar](2000) NULL,
	[PriceServiceVersion] [varchar](10) NULL,
	[PriceEndPointUrl] [nvarchar](2000) NULL,
	[DownloadData] [bit] NULL,
	[DownloadDetails] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PromoStandardsDownloadConfig]  WITH CHECK ADD  CONSTRAINT [FK_PromoStandardsDownloadConfig_Suppliers] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[PromoStandardsDownloadConfig] CHECK CONSTRAINT [FK_PromoStandardsDownloadConfig_Suppliers]
GO
