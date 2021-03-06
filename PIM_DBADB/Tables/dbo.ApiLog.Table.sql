CREATE TABLE [dbo].[ApiLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Api] [nvarchar](50) NULL,
	[EndPoint] [nvarchar](200) NULL,
	[RequestData] [nvarchar](max) NULL,
	[ProcessTime] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Exception] [nvarchar](max) NULL,
 CONSTRAINT [PK_ApiLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
