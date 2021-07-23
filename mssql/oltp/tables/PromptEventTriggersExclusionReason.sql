CREATE TABLE [dbo].[PromptEventTriggersExclusionReason] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersExclusionReason] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [enumValue])
)


GO
