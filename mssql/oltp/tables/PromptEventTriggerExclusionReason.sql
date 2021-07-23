CREATE TABLE [dbo].[PromptEventTriggerExclusionReason] (
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerExclusionReason] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)


GO
