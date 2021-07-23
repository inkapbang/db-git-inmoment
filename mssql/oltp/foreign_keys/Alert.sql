ALTER TABLE [dbo].[Alert] WITH CHECK ADD CONSTRAINT [FK_Alert_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Alert] WITH CHECK ADD CONSTRAINT [FK_Alert_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
