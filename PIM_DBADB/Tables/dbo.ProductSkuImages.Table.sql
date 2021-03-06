
/****** Object:  Table [dbo].[ProductSkuImages]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSkuImages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductSkuID] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Path] [nvarchar](1000) NULL,
	[MCPSceneUri] [nvarchar](250) NULL,
	[Default] [bit] NULL,
	[MCP] [bit] NULL,
	[MCPcompositeSceneUri] [nvarchar](250) NULL,
	[Type] [nvarchar](20) NULL,
	[ChannelID] [int] NULL,
	[MCPActionID] [int] NULL,
 CONSTRAINT [PK_ProductSkuImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
