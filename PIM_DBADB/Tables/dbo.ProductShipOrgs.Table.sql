
/****** Object:  Table [dbo].[ProductShipOrgs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductShipOrgs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[OrgID] [int] NULL,
	[ShipOrgID] [int] NULL,
	[Active] [bit] NULL,
	[Sample] [bit] NULL,
 CONSTRAINT [PK_ProductShipOrgs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
