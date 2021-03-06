
/****** Object:  Table [dbo].[VignetteInfo]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[VignetteInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](3) NOT NULL,
	[VignetteExists] [bit] NOT NULL,
	[SampleURL] [nvarchar](255) NULL,
	[VignetteFolder] [nvarchar](50) NULL,
	[VignetteName] [nvarchar](3) NULL,
	[DecalBarrellayer] [nvarchar](50) NULL,
	[TrimLayer] [nvarchar](50) NULL,
 CONSTRAINT [PK_VignetteInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
