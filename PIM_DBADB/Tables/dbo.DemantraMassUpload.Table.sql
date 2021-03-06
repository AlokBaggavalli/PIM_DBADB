
/****** Object:  Table [dbo].[DemantraMassUpload]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[DemantraMassUpload](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[ProcessedOn] [datetime] NULL,
	[Status] [nvarchar](25) NULL,
	[Processed] [bit] NULL,
	[Comment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_DemantraMassUpload] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
