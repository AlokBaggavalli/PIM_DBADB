
/****** Object:  Table [dbo].[DataRulesStandards]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DataRulesStandards](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[Length] [nvarchar](10) NULL,
	[ProductRequiredLevel] [nvarchar](10) NULL,
	[AccessoryRequiredLevel] [nvarchar](10) NULL,
	[ConditionallyRequiredFields] [nvarchar](255) NULL,
	[Defaults] [nvarchar](255) NULL,
	[Comment] [nvarchar](max) NULL,
	[InHouseDefaults] [nvarchar](255) NULL,
	[NPLVendorDefaults] [nvarchar](255) NULL,
 CONSTRAINT [PK_DataRulesStandards] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
