CREATE TABLE [dbo].[PromptEventTriggerSocialType] (
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerSocialType] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)


GO
