
/****** Object:  Table [dbo].[HistoryLog]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[HistoryLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorProductID] [nvarchar](60) NOT NULL,
	[Action] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[UserName] [nvarchar](100) NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_HistoryLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
