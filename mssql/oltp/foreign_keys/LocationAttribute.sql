ALTER TABLE [dbo].[LocationAttribute] WITH CHECK ADD CONSTRAINT [FK_LocationAttribute_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[LocationAttribute] WITH CHECK ADD CONSTRAINT [FK_LocationAttribute_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
