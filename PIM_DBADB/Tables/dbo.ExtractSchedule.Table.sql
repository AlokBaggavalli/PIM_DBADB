
/****** Object:  Table [dbo].[ExtractSchedule]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ExtractSchedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExtractType] [nvarchar](50) NULL,
	[TimePeriod] [nvarchar](50) NULL,
	[Frequency] [int] NULL,
	[LastExtract] [datetime] NULL,
	[Processed] [datetime] NULL,
	[NotificationList] [nvarchar](200) NULL,
 CONSTRAINT [PK_ExtractSchedule] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
