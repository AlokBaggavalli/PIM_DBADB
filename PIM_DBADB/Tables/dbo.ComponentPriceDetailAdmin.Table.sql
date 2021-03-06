
/****** Object:  Table [dbo].[ComponentPriceDetailAdmin]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ComponentPriceDetailAdmin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](250) NOT NULL,
	[SuperUser] [bit] NOT NULL,
 CONSTRAINT [PK_ComponentPriceDetailAdmin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
