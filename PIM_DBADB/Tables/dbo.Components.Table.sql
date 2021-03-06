
/****** Object:  Table [dbo].[Components]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[Components](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Component] [nvarchar](100) NULL,
	[UOM] [nvarchar](10) NULL,
	[ComponentWeight] [decimal](5, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Component] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
