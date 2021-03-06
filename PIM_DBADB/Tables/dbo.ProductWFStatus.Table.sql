
/****** Object:  Table [dbo].[ProductWFStatus]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductWFStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[BatchID] [int] NOT NULL,
	[Finance] [int] NOT NULL,
	[OB] [int] NOT NULL,
	[CES] [int] NOT NULL,
	[PriceLoad] [int] NOT NULL,
	[ProductSpec] [int] NOT NULL,
	[XtraCharges] [int] NOT NULL,
	[Approval] [bit] NOT NULL,
	[ProductLoad] [int] NULL,
	[ProductDesign] [int] NULL,
	[DesignLoad] [int] NULL,
	[WebReady] [int] NULL,
	[Live] [bit] NULL,
	[Channel] [int] NULL,
 CONSTRAINT [PK_ProductWFStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
