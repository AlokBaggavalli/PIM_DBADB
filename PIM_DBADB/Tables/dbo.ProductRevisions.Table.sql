
/****** Object:  Table [dbo].[ProductRevisions]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductRevisions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Revision] [decimal](10, 1) NULL,
	[Description] [nvarchar](3000) NULL,
	[Originator] [nvarchar](60) NULL,
	[ChangeDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProductRevisions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
