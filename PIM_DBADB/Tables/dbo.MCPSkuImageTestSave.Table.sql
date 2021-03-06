
/****** Object:  Table [dbo].[MCPSkuImageTestSave]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPSkuImageTestSave](
	[NPProductCode] [nvarchar](50) NULL,
	[ID] [int] NOT NULL,
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
	[MCPActionID] [int] NULL
) ON [PRIMARY]
GO
