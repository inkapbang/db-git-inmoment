CREATE TABLE [dbo].[SystemIssue] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [description] [varchar](2000) NULL,
   [opened] [datetime] NOT NULL,
   [targetProcessId] [varchar](100) NULL,
   [fixAvailable] [bit] NOT NULL,
   [fixLocation] [nvarchar](200) NULL,
   [resolved] [bit] NOT NULL,
   [resolutionDate] [datetime] NULL,
   [version] [int] NOT NULL,
   [applicationType] [int] NOT NULL
       DEFAULT ((4)),
   [sourceErrorLogEntryObjectId] [int] NULL

   ,CONSTRAINT [PK_SystemIssue] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_SystemIssue_opened_fixAvailable_resolved] ON [dbo].[SystemIssue] ([opened], [fixAvailable], [resolved])

GO
