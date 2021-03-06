
/****** Object:  Table [dbo].[LabInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[LabInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LabName] [varchar](100) NOT NULL,
	[Location] [varchar](100) NOT NULL,
	[AddressLine1] [varchar](250) NOT NULL,
	[AddressLine2] [varchar](250) NULL,
	[AddressLine3] [varchar](250) NULL,
	[City] [varchar](100) NOT NULL,
	[Province] [varchar](100) NOT NULL,
	[PostalCode] [varchar](10) NOT NULL,
	[Country] [varchar](100) NOT NULL,
	[TelephoneNumber] [varchar](25) NULL,
 CONSTRAINT [PK_LabInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_LabInfo] UNIQUE NONCLUSTERED 
(
	[LabName] ASC,
	[Location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
