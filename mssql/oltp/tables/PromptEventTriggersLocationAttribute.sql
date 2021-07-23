CREATE TABLE [dbo].[PromptEventTriggersLocationAttribute] (
   [promptEventTriggerObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggersLocationAttribute] PRIMARY KEY CLUSTERED ([promptEventTriggerObjectId], [attributeObjectId])
)


GO
