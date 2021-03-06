
/****** Object:  Table [dbo].[DataProcessErrorLog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DataProcessErrorLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataProcessSummaryLogID] [int] NULL,
	[RowNo] [int] NULL,
	[ErrorDescription] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataProcessErrorLog]  WITH CHECK ADD  CONSTRAINT [FK_DataProcessErrorLog_DataProcessSummaryLog] FOREIGN KEY([DataProcessSummaryLogID])
REFERENCES [dbo].[DataProcessSummaryLog] ([ID])
GO
ALTER TABLE [dbo].[DataProcessErrorLog] CHECK CONSTRAINT [FK_DataProcessErrorLog_DataProcessSummaryLog]
GO
