CREATE TABLE [dbo].[PromptEventTriggerTag] (
   [promptEventObjectId] [int] NOT NULL,
   [tagObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerTag] PRIMARY KEY CLUSTERED ([promptEventObjectId], [tagObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTriggerTag_tagObjectId] ON [dbo].[PromptEventTriggerTag] ([tagObjectId])

GO
