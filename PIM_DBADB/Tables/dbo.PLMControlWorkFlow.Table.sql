
/****** Object:  Table [dbo].[PLMControlWorkFlow]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[PLMControlWorkFlow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORGANIZATION_ID] [int] NULL,
	[PRODUCTFAMILY] [nvarchar](200) NULL,
	[PRODUCTSKUS] [nvarchar](200) NULL,
	[COMPONENT_ITEM] [nvarchar](200) NULL,
	[COMPONENT_ITEM_STATUS] [nvarchar](200) NULL,
	[COMPONENT_ITEM_CATEGORY] [nvarchar](200) NULL,
	[SKU_ITEM_TYPE] [varchar](50) NULL,
	[COMPONENT_ITEM_TYPE] [varchar](50) NULL,
	[COMPONENT_ITEM_CATEGORY_ORG1] [nvarchar](400) NULL,
	[UOM] [nvarchar](20) NULL
) ON [PRIMARY]
GO
