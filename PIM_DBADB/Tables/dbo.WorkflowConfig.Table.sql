CREATE TABLE [dbo].[WorkflowConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChannelID] [int] NULL,
	[WFDepartmentID] [int] NULL,
	[House] [bit] NULL,
	[Vendor] [bit] NULL,
	[HouseGrp] [nvarchar](250) NULL,
	[VendorGrp] [nvarchar](250) NULL,
 CONSTRAINT [PK_WorkflowConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
