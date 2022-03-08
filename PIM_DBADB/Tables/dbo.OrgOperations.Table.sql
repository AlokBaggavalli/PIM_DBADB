
/****** Object:  Table [dbo].[OrgOperations]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OrgOperations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgID] [int] NULL,
	[Code] [nvarchar](50) NULL,
	[Description] [varchar](250) NULL,
	[Dept] [int] NULL,
 CONSTRAINT [PK_OrgOperations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
