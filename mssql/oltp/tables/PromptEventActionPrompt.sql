CREATE TABLE [dbo].[PromptEventActionPrompt] (
   [promptEventActionObjectId] [int] NOT NULL,
   [promptObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK__PromptEv__44299016443F263B] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [promptObjectId], [sequence])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_PromptEventActionPrompt_Prompt_Action_sequence] ON [dbo].[PromptEventActionPrompt] ([promptObjectId], [promptEventActionObjectId], [sequence])

GO
