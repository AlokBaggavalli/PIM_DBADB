
/****** Object:  Table [dbo].[ConversionExchangeRate]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ConversionExchangeRate](
	[UniqueID] [int] IDENTITY(1,1) NOT NULL,
	[From_Currency] [nvarchar](50) NULL,
	[To_Currency] [nvarchar](50) NULL,
	[Conversion_Date] [datetime] NULL,
	[Conversion_Rate] [decimal](20, 10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
