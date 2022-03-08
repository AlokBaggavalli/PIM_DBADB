
/****** Object:  Table [dbo].[Forecasts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Forecasts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Forecast] [nvarchar](50) NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_Forecasts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
