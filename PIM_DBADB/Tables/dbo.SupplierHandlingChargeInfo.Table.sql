
/****** Object:  Table [dbo].[SupplierHandlingChargeInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SupplierHandlingChargeInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[Comments] [varchar](1000) NULL,
	[HandlingCharge] [int] NULL,
	[StartDate] [date] NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SupplierHandlingChangeInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierHandlingChargeInfo]  WITH CHECK ADD  CONSTRAINT [FK_SupplierHandlingChangeInfo_MaterialSuppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[MaterialSuppliers] ([ID])
GO
ALTER TABLE [dbo].[SupplierHandlingChargeInfo] CHECK CONSTRAINT [FK_SupplierHandlingChangeInfo_MaterialSuppliers]
GO
