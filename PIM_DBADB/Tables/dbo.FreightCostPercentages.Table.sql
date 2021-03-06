
/****** Object:  Table [dbo].[FreightCostPercentages]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[FreightCostPercentages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[COO] [int] NULL,
	[FYXX] [varchar](4) NULL,
	[TNS] [decimal](10, 5) NULL,
	[PLM] [decimal](10, 5) NULL,
	[IRL] [decimal](10, 5) NULL,
	[GER] [decimal](10, 5) NULL,
	[CZE] [decimal](10, 5) NULL,
	[JPN] [decimal](10, 5) NULL,
 CONSTRAINT [PK_FreightCostPercentages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
