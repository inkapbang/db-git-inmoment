CREATE TABLE [dbo].[PromptEventTriggersLanguage] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersLanguage] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [enumValue])
)


GO
