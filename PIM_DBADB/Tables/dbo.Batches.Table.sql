CREATE TABLE [dbo].[Batches](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BatchNumber] [varchar](20) NULL,
	[Description] [varchar](100) NULL,
	[Active] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[NotifyDate] [datetime] NULL,
	[Comment] [nvarchar](max) NULL,
	[Priority] [int] NULL,
	[Channel] [int] NULL,
	[Type] [int] NULL,
	[TargetDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Type2] [int] NULL,
	[Type3] [int] NULL,
	[StartDate] [datetime] NULL,
 CONSTRAINT [PK_Batches] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Batches] ADD  CONSTRAINT [DF_Batches_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Batches] ADD  CONSTRAINT [DF_Batches_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
