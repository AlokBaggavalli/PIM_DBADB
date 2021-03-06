
/****** Object:  Table [dbo].[BatchExtracts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[BatchExtracts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BatchID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[LastExtract] [datetime] NULL,
	[Status] [int] NOT NULL,
	[ExtractedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_BatchExtracts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
