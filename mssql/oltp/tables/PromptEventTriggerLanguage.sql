CREATE TABLE [dbo].[PromptEventTriggerLanguage] (
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerLanguage] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)


GO
