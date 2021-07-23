CREATE TABLE [dbo].[PromptEventTrigger] (
   [promptEventObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTrigger] PRIMARY KEY CLUSTERED ([promptEventObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTrigger_by_Event] ON [dbo].[PromptEventTrigger] ([promptEventObjectId]) INCLUDE ([dataFieldOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventTrigger_dataFieldOptionObjectId] ON [dbo].[PromptEventTrigger] ([dataFieldOptionObjectId])

GO
