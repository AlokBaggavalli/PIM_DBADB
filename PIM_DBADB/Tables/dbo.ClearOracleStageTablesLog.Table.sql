
/****** Object:  Table [dbo].[ClearOracleStageTablesLog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ClearOracleStageTablesLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[TableName] [nvarchar](300) NULL,
	[status] [nvarchar](50) NULL,
	[ErrorDescription] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
