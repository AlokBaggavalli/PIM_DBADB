
/****** Object:  Table [dbo].[WFTasks]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[WFTasks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[SortOrder] [int] NULL,
	[NotifyGroup] [nvarchar](250) NULL,
	[Triggers] [bit] NOT NULL,
	[ValidationSet] [bit] NOT NULL,
	[VendorKPIReport] [bit] NOT NULL,
 CONSTRAINT [PK_WFTasks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WFTasks] ADD  DEFAULT ((0)) FOR [Triggers]
GO
ALTER TABLE [dbo].[WFTasks] ADD  DEFAULT ((0)) FOR [ValidationSet]
GO
ALTER TABLE [dbo].[WFTasks] ADD  DEFAULT ((0)) FOR [VendorKPIReport]
GO
