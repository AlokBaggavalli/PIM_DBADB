
/****** Object:  Table [dbo].[ImportDeletes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ImportDeletes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[SupplierID] [int] NULL,
	[DataSource] [nvarchar](20) NULL,
	[ProductXML] [xml] NULL,
	[DeletedDate] [datetime] NULL,
	[VendorProductID] [nvarchar](60) NULL,
 CONSTRAINT [PK_ImportDeletes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
