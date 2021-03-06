
/****** Object:  Table [dbo].[ComponentOrgDetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ComponentOrgDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ComponentID] [int] NULL,
	[OrgID] [int] NULL,
	[ProductFamily] [nvarchar](200) NULL,
	[ProductCode] [nvarchar](100) NULL,
	[ABCID] [nvarchar](10) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComponentOrgDetails]  WITH CHECK ADD FOREIGN KEY([ComponentID])
REFERENCES [dbo].[Components] ([ID])
GO
