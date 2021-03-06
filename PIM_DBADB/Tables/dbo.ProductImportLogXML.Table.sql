
/****** Object:  Table [dbo].[ProductImportLogXML]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductImportLogXML](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NULL,
	[VendorProductID] [nvarchar](60) NULL,
	[SupplierProductID] [nvarchar](60) NULL,
	[ProductID] [int] NULL,
	[LoadDate] [datetime] NULL,
	[PriorProductXML] [xml] NULL,
	[ProductXML] [xml] NULL,
	[ProductXMLCrc] [bigint] NULL,
	[DataSource] [nvarchar](20) NULL,
	[LoadGroupID] [int] NULL,
	[ImportAction] [nvarchar](150) NULL,
	[ImportActionID] [int] NULL,
	[Notes] [nvarchar](max) NULL,
	[PriorProductXMLCrc] [bigint] NULL,
	[SageProductCode] [nvarchar](60) NULL,
	[UpdateDataSource] [nvarchar](20) NULL,
 CONSTRAINT [PK_ProductImportLogXML] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
