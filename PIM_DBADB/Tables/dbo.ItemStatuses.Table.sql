
/****** Object:  Table [dbo].[ItemStatuses]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ItemStatuses](
	[ID] [int] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[OrderBy] [int] NULL,
	[AllowedForChannel] [bit] NULL,
	[SummaryOrder] [int] NULL,
 CONSTRAINT [PK_ItemStatuses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
