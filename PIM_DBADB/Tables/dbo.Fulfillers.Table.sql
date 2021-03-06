
/****** Object:  Table [dbo].[Fulfillers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Fulfillers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[Fulfiller] [nvarchar](100) NOT NULL,
	[MCPFulfillerIDCode] [nvarchar](100) NOT NULL,
	[UID] [nvarchar](150) NULL,
	[Password] [nvarchar](200) NULL,
	[EndpointURL] [nvarchar](1000) NULL,
	[DataSource] [varchar](500) NULL,
	[InventoryVersion] [varchar](20) NULL,
 CONSTRAINT [PK_Fulfillers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fulfillers]  WITH CHECK ADD  CONSTRAINT [FK_Fulfillers_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([ID])
GO
ALTER TABLE [dbo].[Fulfillers] CHECK CONSTRAINT [FK_Fulfillers_Suppliers]
GO
