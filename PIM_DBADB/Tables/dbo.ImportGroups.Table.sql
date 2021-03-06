
/****** Object:  Table [dbo].[ImportGroups]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ImportGroups](
	[ID] [int] IDENTITY(100,1) NOT NULL,
	[FileName] [nvarchar](200) NULL,
	[FileVersion] [decimal](10, 2) NULL,
	[ImportDate] [datetime2](7) NULL,
	[DataSource] [nvarchar](20) NULL,
	[Comments] [nvarchar](2000) NULL,
	[SupplierID] [int] NULL,
	[VendorName] [nvarchar](50) NULL,
	[ItemCount] [int] NULL,
	[LoadedItemCount] [int] NULL,
	[ErrorCount] [int] NULL,
	[FatalErrorCount] [int] NULL,
	[WarningCount] [int] NULL,
	[ProductCount] [int] NULL,
	[NewProductLoadCount] [int] NULL,
	[ProductsRefreshedCount] [int] NULL,
	[RejectedItemCount] [int] NULL,
	[ProductsPreservedCount] [int] NULL,
	[ProductXMLUnchangedCount] [int] NULL,
	[ProductImageCount] [int] NULL,
	[ProductSkuImageCount] [int] NULL,
	[SupplierProductsCount] [int] NULL,
	[LogFile] [text] NULL,
	[TotalProcessingTime] [nvarchar](50) NULL,
 CONSTRAINT [PK_ImportGroups] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
