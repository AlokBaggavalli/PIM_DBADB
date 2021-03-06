
/****** Object:  Table [dbo].[Compliance]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Compliance](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Level] [int] NULL,
	[Channel] [varchar](50) NULL,
	[Regulations] [int] NULL,
	[LabId] [int] NULL,
	[TestReportRecieved] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[ReportNumber] [nvarchar](100) NULL,
 CONSTRAINT [PK_Compliance] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
