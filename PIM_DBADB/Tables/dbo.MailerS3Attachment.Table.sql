
/****** Object:  Table [dbo].[MailerS3Attachment]    Script Date: 3/4/2022 11:44:42 AM ******/

CREATE TABLE [dbo].[MailerS3Attachment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MailerID] [int] NOT NULL,
 CONSTRAINT [PK_MailerS3Attachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MailerS3Attachment]  WITH CHECK ADD  CONSTRAINT [FK_MailerS3Attachment_Mailer] FOREIGN KEY([MailerID])
REFERENCES [dbo].[Mailer] ([ID])
GO
ALTER TABLE [dbo].[MailerS3Attachment] CHECK CONSTRAINT [FK_MailerS3Attachment_Mailer]
GO
