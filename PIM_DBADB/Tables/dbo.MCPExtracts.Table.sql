
/****** Object:  Table [dbo].[MCPExtracts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MCPExtracts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductSkuID] [int] NULL,
	[ProcessDate] [datetime] NULL,
	[Name] [nvarchar](50) NULL,
	[Processed] [bit] NULL,
	[Product] [bit] NULL,
	[Attribute] [bit] NULL,
	[Scenes] [bit] NULL,
	[Surface] [bit] NULL,
	[Pricing] [bit] NULL,
	[Comment] [nvarchar](max) NULL,
	[BatchID] [int] NULL,
	[ItemCode] [nvarchar](100) NULL,
	[MCPsku] [nvarchar](50) NULL,
	[ExtractType] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_MCPExtracts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
