
/****** Object:  Table [dbo].[HtsInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[HtsInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[UsDutyPct] [decimal](7, 5) NULL,
	[UsAdditionalCost] [decimal](7, 5) NULL,
	[UsHtsCode] [nvarchar](50) NULL,
	[EuHtsCode] [nvarchar](50) NULL,
	[EuDutyPct] [decimal](7, 5) NULL,
	[CaHtsCode] [nvarchar](50) NULL,
	[CaDutyPct] [decimal](7, 5) NULL,
	[MxDutyPct] [decimal](7, 5) NULL,
	[MxAdditionalCost] [decimal](7, 5) NULL,
	[TRCommodityCode] [nvarchar](100) NULL,
	[TRDescription] [nvarchar](100) NULL,
	[TRHarmonizedCode] [nvarchar](100) NULL,
 CONSTRAINT [PK_HtsInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
