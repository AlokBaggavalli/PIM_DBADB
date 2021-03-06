
/****** Object:  Table [dbo].[ExtractHistory]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ExtractHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExtractRunId] [int] NULL,
	[ProcessName] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[TotalMinutes] [int] NULL,
	[Errors] [nvarchar](max) NULL,
 CONSTRAINT [PK_ExtractHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
