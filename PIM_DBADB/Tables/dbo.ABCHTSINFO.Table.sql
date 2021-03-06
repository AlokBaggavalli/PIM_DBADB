CREATE TABLE [dbo].[ABCHTSINFO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Productcode] [nvarchar](50) NOT NULL,
	[ProductId] [int] NULL,
	[BatchId] [int] NULL,
	[MCPFamilyRefId] [nvarchar](50) NULL,
	[UsTariffCode] [nvarchar](20) NULL,
	[EuTariffCode] [nvarchar](20) NULL,
	[CaTariffCode] [nvarchar](20) NULL,
	[TrCommodityCode] [nvarchar](100) NULL,
	[TrHarmonizedCode] [nvarchar](100) NULL,
	[TariffDescription] [varchar](100) NULL,
	[ExtractType] [int] NULL,
	[Status] [int] NULL,
	[Extracted] [bit] NULL,
	[Comments] [varchar](1000) NULL,
	[ExtractDate] [datetime] NULL,
	[ExtractedBy] [varchar](100) NULL,
	[PartialExtractedBy] [varchar](100) NULL,
	[PartialExtractDate] [datetime] NULL,
 CONSTRAINT [PK_HTSEXTRACTINFO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
