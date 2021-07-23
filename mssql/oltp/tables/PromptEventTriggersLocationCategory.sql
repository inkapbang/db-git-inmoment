CREATE TABLE [dbo].[PromptEventTriggersLocationCategory] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [locationCategoryObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersLocationCategory] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [locationCategoryObjectId])
)


GO
