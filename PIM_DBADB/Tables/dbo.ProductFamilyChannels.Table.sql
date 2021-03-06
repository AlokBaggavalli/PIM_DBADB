
/****** Object:  Table [dbo].[ProductFamilyChannels]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductFamilyChannels](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductFamilyID] [int] NULL,
	[ChannelID] [int] NULL,
	[StatusID] [int] NULL,
	[CommentID] [int] NULL,
	[TNS] [int] NULL,
	[PLM] [int] NULL,
	[IRL] [int] NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[JPN] [int] NULL,
	[CZE] [int] NULL,
 CONSTRAINT [PK_ProductFamilyChannels] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
