
/****** Object:  Table [dbo].[Orgs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Orgs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Org] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
	[Enabled] [bit] NULL,
	[FulfillerLocationID] [nvarchar](50) NULL,
	[FulfillerLocationCode] [nvarchar](50) NULL,
	[OracleOrgID] [int] NULL,
 CONSTRAINT [PK_Orgs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
