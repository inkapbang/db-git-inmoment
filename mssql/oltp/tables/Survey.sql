CREATE TABLE [dbo].[Survey] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NOT NULL,
   [description] [varchar](1000) NULL,
   [organizationObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [channelObjectId] [int] NULL,
   [exportDefinitionObjectId] [int] NULL,
   [useStarRepeat] [bit] NOT NULL,
   [responseDestination] [int] NULL,
   [transferOffsite] [bit] NULL,
   [externalId] [varchar](255) NULL,
   [createdAt] [datetime] NULL
       DEFAULT (getdate()),
   [updatedAt] [datetime] NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_Survey] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [_dta_index_Survey_5_2111346586__K4_1] ON [dbo].[Survey] ([organizationObjectId]) INCLUDE ([objectId])
CREATE NONCLUSTERED INDEX [IX_Survey_by_Organization] ON [dbo].[Survey] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_Survey_EmpathicaExportDefinition] ON [dbo].[Survey] ([exportDefinitionObjectId])
CREATE NONCLUSTERED INDEX [IX_Survey_FeedbackChannel] ON [dbo].[Survey] ([channelObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [UK_Survey_externalId_organizationId] ON [dbo].[Survey] ([externalId], [organizationObjectId]) WHERE ([externalId] IS NOT NULL)

GO
