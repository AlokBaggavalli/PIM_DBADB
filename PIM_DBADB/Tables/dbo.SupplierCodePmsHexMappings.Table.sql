
/****** Object:  Table [dbo].[SupplierCodePmsHexMappings]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SupplierCodePmsHexMappings](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [nvarchar](50) NULL,
	[WebName] [nvarchar](50) NULL,
	[PMS] [nvarchar](50) NULL,
	[Hex] [nvarchar](10) NULL,
 CONSTRAINT [PK_SupplierCodePmsHexMappings] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
