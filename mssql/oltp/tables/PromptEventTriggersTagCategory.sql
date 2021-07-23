CREATE TABLE [dbo].[PromptEventTriggersTagCategory] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [tagCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerTagCategories] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [tagCategoryObjectId])
)


GO
