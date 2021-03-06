
/****** Object:  Table [dbo].[Suppliers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Suppliers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ASINumber] [nvarchar](50) NULL,
	[FTPLoginName] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[WebSiteUrl] [nvarchar](255) NULL,
	[ContactEmail] [nvarchar](255) NULL,
	[NPXML] [nvarchar](255) NULL,
	[Comment] [nvarchar](1000) NULL,
	[Region] [nvarchar](50) NULL,
	[SupplierNotes] [nvarchar](max) NULL,
	[SageSupplierID] [int] NULL,
	[SupplierInfoXML] [xml] NULL,
	[SageActive] [bit] NULL,
	[Type] [nvarchar](10) NULL,
	[MCPFulFillerID] [nvarchar](50) NULL,
	[MCPFulFillerIDCode] [nvarchar](50) NULL,
	[MCPFulFillerLocationIDs] [nvarchar](100) NULL,
	[MCPTenantID] [nvarchar](100) NULL,
	[MCPDataSheetID] [nvarchar](100) NULL,
	[MCPContractID] [nvarchar](100) NULL,
	[ChannelID] [int] NULL,
	[DataSourceUID] [nvarchar](50) NULL,
	[DataSourcePassCode] [nvarchar](100) NULL,
	[DataSourceInventoryAPI] [nvarchar](200) NULL,
	[DataSourceInvAPIVersion] [nvarchar](50) NULL,
	[DataSourceType] [nvarchar](100) NULL,
	[PromoStandardsActive] [bit] NULL,
	[NewDataSheet] [bit] NULL,
	[ATPTable] [bit] NULL,
	[MCPFulfillerLocationCode] [varchar](500) NULL,
 CONSTRAINT [PK_Suppliers_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT ((0)) FOR [SageActive]
GO
