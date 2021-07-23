CREATE TABLE [dbo].[PromptEventTriggerTagCategory] (
   [promptEventObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerTagCategory] PRIMARY KEY CLUSTERED ([promptEventObjectId], [tagCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTriggerTagCategory_tagCategoryObjectId] ON [dbo].[PromptEventTriggerTagCategory] ([tagCategoryObjectId])

GO
