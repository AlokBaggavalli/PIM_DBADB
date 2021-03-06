
/****** Object:  Table [dbo].[PaperlessProducts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PaperlessProducts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NPProductCode] [nvarchar](50) NOT NULL,
	[DecoMethod] [nvarchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
