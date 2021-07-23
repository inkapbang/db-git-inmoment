CREATE TABLE [dbo].[PromptEventPrompt] (
   [promptEventObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventPromp] PRIMARY KEY CLUSTERED ([promptEventObjectId], [promptObjectId], [sequence])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_PromptEventPrompt_Prompt_Event_sequence] ON [dbo].[PromptEventPrompt] ([promptObjectId], [promptEventObjectId], [sequence])

GO
