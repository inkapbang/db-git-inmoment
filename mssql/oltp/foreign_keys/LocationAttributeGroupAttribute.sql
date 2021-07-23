ALTER TABLE [dbo].[LocationAttributeGroupAttribute] WITH CHECK ADD CONSTRAINT [FK_LocationAttributeGroupAttribute_LocationAttributeGroup]
   FOREIGN KEY([attributeGroupObjectId]) REFERENCES [dbo].[LocationAttributeGroup] ([objectId])

GO
ALTER TABLE [dbo].[LocationAttributeGroupAttribute] WITH CHECK ADD CONSTRAINT [FK_LocationAttributeGroupAttribute_LocationAttribute]
   FOREIGN KEY([attributeObjectId]) REFERENCES [dbo].[LocationAttribute] ([objectId])

GO
