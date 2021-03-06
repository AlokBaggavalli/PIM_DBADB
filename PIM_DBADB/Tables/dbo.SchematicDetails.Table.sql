
/****** Object:  Table [dbo].[SchematicDetails]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[SchematicDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchematicID] [int] NULL,
	[RecType] [varchar](10) NULL,
	[Fld] [varchar](100) NULL,
	[Typ] [varchar](100) NULL,
	[Format] [varchar](300) NULL,
 CONSTRAINT [PK_SchematicDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
