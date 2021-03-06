
/****** Object:  Table [dbo].[DataProcessSummaryLog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DataProcessSummaryLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataProcessBatchID] [int] NULL,
	[DataProcessStatus] [int] NULL,
	[NoofRecords] [int] NULL,
	[ErroneousRecords] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataProcessSummaryLog]  WITH CHECK ADD  CONSTRAINT [FK_DataProcessSummaryLog_DataProcessBatch] FOREIGN KEY([DataProcessBatchID])
REFERENCES [dbo].[DataProcessBatch] ([ID])
GO
ALTER TABLE [dbo].[DataProcessSummaryLog] CHECK CONSTRAINT [FK_DataProcessSummaryLog_DataProcessBatch]
GO
