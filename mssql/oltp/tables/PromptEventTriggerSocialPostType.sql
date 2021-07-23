CREATE TABLE [dbo].[PromptEventTriggerSocialPostType] (
   [promptEventObjectId] [int] NOT NULL,
   [enumValue] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerSocialPostType] PRIMARY KEY CLUSTERED ([promptEventObjectId], [enumValue])
)


GO
