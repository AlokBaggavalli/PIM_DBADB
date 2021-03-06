
/****** Object:  Table [dbo].[CompanyInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[CompanyInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChannelId] [int] NULL,
	[Address] [nvarchar](500) NOT NULL,
	[ContactInfo] [nvarchar](500) NOT NULL,
	[LogoURL] [nvarchar](1000) NOT NULL,
	[AdditionalLogoURL] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_CompanyInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_CompanyInfo_LogoURL] UNIQUE NONCLUSTERED 
(
	[LogoURL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyInfo]  WITH CHECK ADD  CONSTRAINT [FK_CompanyInfo_DistributionChannels] FOREIGN KEY([ChannelId])
REFERENCES [dbo].[DistributionChannels] ([ID])
GO
ALTER TABLE [dbo].[CompanyInfo] CHECK CONSTRAINT [FK_CompanyInfo_DistributionChannels]
GO
