CREATE TABLE [dbo].[PromptEventTriggerLocationCategory] (
   [promptEventObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerLocationCategory] PRIMARY KEY CLUSTERED ([promptEventObjectId], [locationCategoryObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTriggerLocationCategory_by_Event] ON [dbo].[PromptEventTriggerLocationCategory] ([promptEventObjectId]) INCLUDE ([locationCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_PromptEventTriggerLocationCategory_locationCategoryObjectId] ON [dbo].[PromptEventTriggerLocationCategory] ([locationCategoryObjectId])

GO
