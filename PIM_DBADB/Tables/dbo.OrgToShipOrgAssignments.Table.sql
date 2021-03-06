
/****** Object:  Table [dbo].[OrgToShipOrgAssignments]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OrgToShipOrgAssignments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChannelId] [int] NULL,
	[OrgTns] [bit] NULL,
	[OrgPlm] [bit] NULL,
	[OrgIrl] [bit] NULL,
	[OrgJpn] [bit] NULL,
	[Tns] [bit] NULL,
	[TnsShippingOrgId] [int] NULL,
	[Plm] [bit] NULL,
	[PlmShippingOrgId] [int] NULL,
	[Irl] [bit] NULL,
	[IrlShippingOrgId] [int] NULL,
	[Ppc] [bit] NULL,
	[PpcShippingOrgId] [int] NULL,
	[Ndc] [bit] NULL,
	[NdcShippingOrgId] [int] NULL,
	[San] [bit] NULL,
	[SanShippingOrgId] [int] NULL,
	[Zca] [bit] NULL,
	[ZcaShippingOrgId] [int] NULL,
	[Zpp] [bit] NULL,
	[ZppShippingOrgId] [int] NULL,
	[Zat] [bit] NULL,
	[ZatShippingOrgId] [int] NULL,
	[Ger] [bit] NULL,
	[GerShippingOrgId] [int] NULL,
	[Cze] [bit] NULL,
	[CzeShippingOrgId] [int] NULL,
	[Jpn] [bit] NULL,
	[JpnShippingOrgId] [int] NULL,
	[OrgCze] [bit] NULL,
 CONSTRAINT [PK_OrgToShipOrgAssignments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
