
/****** Object:  Table [dbo].[ImportManager]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ImportManager](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportGroupID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[SupplierID] [int] NULL,
	[ImporterStart] [datetime] NULL,
	[ImporterEnd] [datetime] NULL,
	[Import2Start] [datetime] NULL,
	[Import2End] [datetime] NULL,
	[UpdateStart] [datetime] NULL,
	[UpdateEnd] [datetime] NULL,
	[ChangeStart] [datetime] NULL,
	[ChangeEnd] [datetime] NULL,
	[DeleteStart] [datetime] NULL,
	[DeleteEnd] [datetime] NULL,
	[Error] [nvarchar](max) NULL,
 CONSTRAINT [PK_ImportManager] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
