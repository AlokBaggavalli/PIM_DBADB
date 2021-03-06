
/****** Object:  Table [dbo].[ForecastAssignments]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ForecastAssignments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrgId] [int] NOT NULL,
	[ClassId] [int] NOT NULL,
	[ForecastSetId] [int] NOT NULL,
	[ForecastId] [int] NOT NULL,
 CONSTRAINT [PK_ForecastAssigments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
