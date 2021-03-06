
/****** Object:  Table [dbo].[UserPreferences]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[UserPreferences](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Skin] [nvarchar](50) NULL,
	[BackgroundColor] [nvarchar](50) NULL,
	[LocaleID] [int] NULL,
	[ChannelID] [int] NULL,
	[SubGridSkin] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
