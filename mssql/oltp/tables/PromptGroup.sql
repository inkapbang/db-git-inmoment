CREATE TABLE [dbo].[PromptGroup] (
   [promptGroupPromptObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NULL
      CONSTRAINT [DF__PromptGroup__versi__45B5055F] DEFAULT ((0))

   ,CONSTRAINT [PK_PromptGroup] PRIMARY KEY CLUSTERED ([promptGroupPromptObjectId], [promptObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_PromptGroup_Prompt_PromptGroupPrompt] ON [dbo].[PromptGroup] ([promptObjectId], [promptGroupPromptObjectId]) INCLUDE ([sequence])
CREATE NONCLUSTERED INDEX [IX_PromptGroup_PromptGroupPrompt_Prompt] ON [dbo].[PromptGroup] ([promptGroupPromptObjectId], [promptObjectId]) INCLUDE ([sequence])

GO
