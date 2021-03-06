
/****** Object:  Table [dbo].[OculusProducts]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[OculusProducts](
	[ProductID] [int] NOT NULL,
	[Type] [varchar](1) NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_OculusProducts] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
