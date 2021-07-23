CREATE TABLE [dbo].[PromptEventTriggerLocationAttribute] (
   [promptEventObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventTriggerLocationAttribute] PRIMARY KEY CLUSTERED ([promptEventObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventTriggerLocationAttribute_attributeObjectId] ON [dbo].[PromptEventTriggerLocationAttribute] ([attributeObjectId])

GO
