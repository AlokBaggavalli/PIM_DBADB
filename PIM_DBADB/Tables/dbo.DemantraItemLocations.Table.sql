
/****** Object:  Table [dbo].[DemantraItemLocations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DemantraItemLocations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DemantraLocationId] [int] NULL,
	[ChannelID] [int] NULL,
	[Division] [varchar](50) NULL,
	[SalesChannel] [nvarchar](10) NULL,
	[Country] [nvarchar](10) NULL,
	[OrgId] [int] NULL,
 CONSTRAINT [PK_DemantraItemLocations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
