
/****** Object:  Table [dbo].[MasterSSMap]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MasterSSMap](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SSType] [nvarchar](50) NULL,
	[SSFieldName] [nvarchar](255) NULL,
	[DBField1] [nvarchar](255) NULL,
	[DBField2] [nvarchar](255) NULL,
	[DBField3] [nvarchar](255) NULL,
	[Comment] [nvarchar](255) NULL,
	[Enabled] [bit] NULL,
 CONSTRAINT [PK_MasterSSMap] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MasterSSMap] ADD  DEFAULT ((1)) FOR [Enabled]
GO
