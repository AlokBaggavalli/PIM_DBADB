
/****** Object:  Table [dbo].[VendorDiscountCodes]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[VendorDiscountCodes](
	[DiscCode] [nvarchar](1) NOT NULL,
	[DiscPercent] [decimal](10, 2) NULL,
 CONSTRAINT [PK_VendorDiscountCodes] PRIMARY KEY CLUSTERED 
(
	[DiscCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
