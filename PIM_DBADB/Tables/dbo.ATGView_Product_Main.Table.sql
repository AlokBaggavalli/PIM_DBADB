CREATE TABLE [dbo].[ATGView_Product_Main](
	[UniqueID] [int] IDENTITY(1,1) NOT NULL,
	[ITEM_TYPE] [varchar](50) NULL,
	[PRODUCT_ID] [varchar](50) NULL,
	[PIM_PRODUCT_ID] [varchar](300) NULL,
	[SITE] [varchar](300) NULL,
	[LOCALE] [varchar](50) NULL,
	[PRODUCT_CODE] [varchar](50) NULL,
	[ASI_NUMBER] [varchar](300) NULL,
	[DISPLAY_NAME] [varchar](300) NULL,
	[LONG_DESCRIPTION] [varchar](4000) NULL,
	[SITE_DISPLAY_NAME] [varchar](255) NULL,
	[MARKETING_CATEGORY_NAME] [varchar](300) NULL,
	[BRAND] [varchar](300) NULL,
	[BRANDED] [varchar](50) NULL,
	[MARKETING_TEXT] [varchar](500) NULL,
	[FREESAMP_IMAGEURL] [varchar](2000) NULL,
	[SHIP_CATEGORY] [varchar](50) NULL,
	[VERTICAL_TEMPLATE] [varchar](50) NULL,
	[VIGNETTE_PREVIEW] [varchar](50) NULL,
	[ALLOW_PRICINGTIERS] [int] NULL,
	[SPECIAL_INSTRUCTION_TITLE] [varchar](300) NULL,
	[KEYWORDS] [varchar](4000) NULL,
	[H_ONE] [varchar](100) NULL,
	[H_TWO] [varchar](100) NULL,
	[SEO_TEXT] [varchar](4000) NULL,
	[SEO_TITLE] [varchar](1000) NULL,
	[SEO_DESCRIPTION] [varchar](1000) NULL,
	[NPURL] [varchar](100) NULL,
	[TAT_MINIMUM] [varchar](50) NULL,
	[TAT_MAXIMUM] [varchar](50) NULL,
	[MATERIAL] [varchar](4000) NULL,
	[MINIMUM_QUANTITY] [int] NULL,
	[UOM] [varchar](50) NULL,
	[CREATION_DATE] [varchar](50) NULL,
	[Width] [decimal](10, 2) NULL,
	[Height] [decimal](10, 2) NULL,
	[Depth] [decimal](10, 2) NULL,
	[SizeUOM] [nvarchar](10) NULL,
	[ImprintMethod] [nvarchar](255) NULL,
	[ImprintLocation] [nvarchar](60) NULL,
	[IS_ACTIVE] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
