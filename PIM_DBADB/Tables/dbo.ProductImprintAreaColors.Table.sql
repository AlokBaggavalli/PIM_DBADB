
/****** Object:  Table [dbo].[ProductImprintAreaColors]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductImprintAreaColors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ProductImprintAreaID] [int] NULL,
	[HexCode] [nvarchar](7) NULL,
	[Default] [bit] NULL,
	[ClassID] [int] NULL,
	[PMS] [nvarchar](60) NULL,
	[SpotColor] [nvarchar](100) NULL,
 CONSTRAINT [PK_ProductImprintAreaColors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
