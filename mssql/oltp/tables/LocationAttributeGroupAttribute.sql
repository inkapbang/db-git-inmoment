CREATE TABLE [dbo].[LocationAttributeGroupAttribute] (
   [attributeGroupObjectId] [int] NOT NULL,
   [attributeObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_LocationAttributeGroupAttribute] PRIMARY KEY CLUSTERED ([attributeGroupObjectId], [attributeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_LocationAttributeGroupAttribute_LocationAttribute] ON [dbo].[LocationAttributeGroupAttribute] ([attributeObjectId])
CREATE NONCLUSTERED INDEX [IX_LocationAttributeGroupAttribute_LocationAttributeGroup] ON [dbo].[LocationAttributeGroupAttribute] ([attributeGroupObjectId])

GO
