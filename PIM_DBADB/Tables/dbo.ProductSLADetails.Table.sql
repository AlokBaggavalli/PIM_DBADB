
/****** Object:  Table [dbo].[ProductSLADetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductSLADetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Channel] [varchar](50) NULL,
	[PCode] [nvarchar](50) NULL,
	[DecoMethod] [nvarchar](60) NULL,
	[RushSLA] [int] NULL,
	[Orgs] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
