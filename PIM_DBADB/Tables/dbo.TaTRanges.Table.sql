
/****** Object:  Table [dbo].[TaTRanges]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[TaTRanges](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[LeadTime] [int] NULL,
 CONSTRAINT [PK_TaTRanges] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
