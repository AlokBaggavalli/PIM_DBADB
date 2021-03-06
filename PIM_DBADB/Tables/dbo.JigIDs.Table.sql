
/****** Object:  Table [dbo].[JigIDs]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[JigIDs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[ProcessId] [int] NULL,
	[JigTypeId] [int] NULL,
	[Rows] [int] NULL,
	[Columns] [int] NULL,
	[JigDecoReqs] [nvarchar](100) NULL,
	[Pieces] [int] NULL,
	[TNS] [int] NULL,
	[PLM] [int] NULL,
	[IRL] [int] NULL,
	[GER] [int] NULL,
	[JPN] [int] NULL,
	[JigNotes] [nvarchar](1000) NULL,
 CONSTRAINT [PK_JigIDs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Description] UNIQUE NONCLUSTERED 
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[JigIDs]  WITH CHECK ADD  CONSTRAINT [FK_JigIDs_JigDecoProcess] FOREIGN KEY([ProcessId])
REFERENCES [dbo].[JigDecoProcess] ([ID])
GO
ALTER TABLE [dbo].[JigIDs] CHECK CONSTRAINT [FK_JigIDs_JigDecoProcess]
GO
ALTER TABLE [dbo].[JigIDs]  WITH CHECK ADD  CONSTRAINT [FK_JigIDs_JigTypes] FOREIGN KEY([JigTypeId])
REFERENCES [dbo].[JigTypes] ([ID])
GO
ALTER TABLE [dbo].[JigIDs] CHECK CONSTRAINT [FK_JigIDs_JigTypes]
GO
