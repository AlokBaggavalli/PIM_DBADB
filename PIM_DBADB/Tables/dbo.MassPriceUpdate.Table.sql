
/****** Object:  Table [dbo].[MassPriceUpdate]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MassPriceUpdate](
	[MassPriceUpdateID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[VendorProductID] [nvarchar](60) NULL,
	[SupplierID] [int] NULL,
	[SupplierName] [nvarchar](255) NULL,
	[StatusID] [int] NULL,
	[DateCreated] [datetime] NULL,
	[LastUpdatedDate] [datetime] NULL,
	[Comment] [nvarchar](50) NULL,
	[POStatusID] [int] NULL,
 CONSTRAINT [PK__MassPric__B4C720A721320869] PRIMARY KEY CLUSTERED 
(
	[MassPriceUpdateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MassPriceUpdate] ADD  CONSTRAINT [DF__MassPrice__DateC__0E591826]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[MassPriceUpdate] ADD  CONSTRAINT [DF__MassPrice__LastU__0F4D3C5F]  DEFAULT (getdate()) FOR [LastUpdatedDate]
GO
