
/****** Object:  Table [dbo].[ComplianceDocuments]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[ComplianceDocuments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ComplianceId] [int] NULL,
	[ComponentId] [int] NULL,
	[URL] [nvarchar](500) NOT NULL,
	[DocumentTypeId] [int] NULL,
	[CreatedBy] [nvarchar](250) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [nvarchar](250) NULL,
	[ModifiedOn] [datetime] NULL,
	[FileName] [nvarchar](255) NULL,
 CONSTRAINT [PK_ComplianceDocuments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ComplianceDocuments] UNIQUE NONCLUSTERED 
(
	[URL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComplianceDocuments]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceDocuments_Compliance] FOREIGN KEY([ComplianceId])
REFERENCES [dbo].[Compliance] ([ID])
GO
ALTER TABLE [dbo].[ComplianceDocuments] CHECK CONSTRAINT [FK_ComplianceDocuments_Compliance]
GO
ALTER TABLE [dbo].[ComplianceDocuments]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceDocuments_ComplianceComponents] FOREIGN KEY([ComponentId])
REFERENCES [dbo].[ComplianceComponents] ([ID])
GO
ALTER TABLE [dbo].[ComplianceDocuments] CHECK CONSTRAINT [FK_ComplianceDocuments_ComplianceComponents]
GO
ALTER TABLE [dbo].[ComplianceDocuments]  WITH CHECK ADD  CONSTRAINT [FK_ComplianceDocuments_DocumentTypes] FOREIGN KEY([DocumentTypeId])
REFERENCES [dbo].[DocumentTypes] ([ID])
GO
ALTER TABLE [dbo].[ComplianceDocuments] CHECK CONSTRAINT [FK_ComplianceDocuments_DocumentTypes]
GO
