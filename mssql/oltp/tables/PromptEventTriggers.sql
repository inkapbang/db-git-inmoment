CREATE TABLE [dbo].[PromptEventTriggers] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [triggerType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [expressionId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [promptEventObjectId] [int] NULL,
   [dataFieldObjectId] [int] NULL,
   [operatorType] [int] NULL,
   [parseRule] [int] NULL,
   [parseRuleOptionsObjectId] [int] NULL,
   [rawValue] [varchar](100) NULL,
   [skipConfidenceCheck] [bit] NULL

   ,CONSTRAINT [PK_PromptEventTriggers] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTrigger_by_DataField] ON [dbo].[PromptEventTriggers] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventTrigger_by_PromptEvent] ON [dbo].[PromptEventTriggers] ([promptEventObjectId])

GO
