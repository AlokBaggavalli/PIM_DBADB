CREATE TABLE [dbo].[DistributionChannels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Channel] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[MCPenabled] [bit] NULL,
 CONSTRAINT [PK_DistributionChannels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
