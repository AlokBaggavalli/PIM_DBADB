
/****** Object:  Table [dbo].[BatchExtractPartial]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[BatchExtractPartial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BatchID] [int] NULL,
	[Type] [int] NULL,
	[ProductID] [int] NULL,
	[DesignID] [int] NULL,
	[SkuID] [int] NULL,
	[Description] [nvarchar](100) NULL,
	[PriceList] [int] NULL,
	[LocaleID] [int] NULL,
	[Value] [nvarchar](100) NULL,
 CONSTRAINT [PK_BatchExtractPartial] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
