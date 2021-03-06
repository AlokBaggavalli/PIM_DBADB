
/****** Object:  Table [dbo].[MCPStatusSyncHistory]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPStatusSyncHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductSkuID] [int] NULL,
	[MCPSku] [nvarchar](50) NULL,
	[SyncStatus] [bit] NULL,
	[Comment] [nvarchar](200) NULL,
	[ProcessDate] [datetime] NULL,
	[ProcessBy] [nvarchar](50) NULL,
	[ItemCode] [nvarchar](100) NULL,
 CONSTRAINT [PK_MCPStatusSyncHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
