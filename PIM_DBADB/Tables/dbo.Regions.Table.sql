
/****** Object:  Table [dbo].[Regions]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Regions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Region] [nvarchar](100) NULL,
	[Channel] [nvarchar](50) NULL,
	[SellToCountries] [nvarchar](200) NULL,
 CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
