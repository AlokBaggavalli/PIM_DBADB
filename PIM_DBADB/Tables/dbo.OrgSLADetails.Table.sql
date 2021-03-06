
/****** Object:  Table [dbo].[OrgSLADetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OrgSLADetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Org] [nvarchar](50) NULL,
	[DecoMethod] [nvarchar](60) NULL,
	[Level1] [nvarchar](100) NULL,
	[Level2] [nvarchar](100) NULL,
	[SLA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
