
/****** Object:  Table [dbo].[MaterialBuyers]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MaterialBuyers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Buyer] [nvarchar](20) NULL,
 CONSTRAINT [PK_MaterialBuyers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
