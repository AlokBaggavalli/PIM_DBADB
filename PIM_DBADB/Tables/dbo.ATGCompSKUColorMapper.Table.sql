CREATE TABLE [dbo].[ATGCompSKUColorMapper](
	[UniqueID] [int] IDENTITY(1,1) NOT NULL,
	[CompSKU_ID] [varchar](50) NULL,
	[Color_ID] [varchar](50) NULL,
	[Color_Value] [varchar](50) NULL,
	[Color_Name] [varchar](200) NULL,
	[Display_Name] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
