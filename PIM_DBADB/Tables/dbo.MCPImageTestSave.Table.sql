
/****** Object:  Table [dbo].[MCPImageTestSave]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPImageTestSave](
	[NPProductCode] [nvarchar](50) NULL,
	[ID] [int] NOT NULL,
	[ProductID] [int] NULL,
	[LocaleID] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[Path] [nvarchar](1000) NULL,
	[Default] [bit] NULL,
	[MCP] [bit] NULL,
	[MCPSceneUri] [nvarchar](250) NULL,
	[MCPcompositeSceneUri] [nvarchar](250) NULL,
	[Type] [nvarchar](20) NULL,
	[ChannelID] [int] NULL,
	[Family] [bit] NULL,
	[MCPActionID] [int] NULL
) ON [PRIMARY]
GO
