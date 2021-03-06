
/****** Object:  Table [dbo].[CSTItemCost]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CSTItemCost](
	[UniqueID] [int] IDENTITY(1,1) NOT NULL,
	[ItemNumber] [varchar](50) NULL,
	[OrgID] [int] NULL,
	[CostType] [varchar](50) NULL,
	[ItemCost] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
