
/****** Object:  Table [dbo].[PLMStatusUpdate]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PLMStatusUpdate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Org] [nvarchar](3) NULL,
	[Item] [nvarchar](100) NULL,
	[Status] [nvarchar](50) NULL,
	[Category] [nvarchar](50) NULL,
	[Buyer] [nvarchar](100) NULL,
	[ProcessStatus] [nvarchar](50) NULL,
	[ProcessDate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[Comment] [nvarchar](200) NULL,
 CONSTRAINT [PK_PLMStatusUpdate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
