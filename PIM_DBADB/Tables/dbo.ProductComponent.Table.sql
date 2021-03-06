
/****** Object:  Table [dbo].[ProductComponent]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ProductComponent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Component] [nvarchar](50) NULL,
	[MOQ] [int] NULL,
	[Description] [varchar](350) NULL,
 CONSTRAINT [PK_ProductComponent] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
