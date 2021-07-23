ALTER TABLE [dbo].[EmailTemplateCategory] WITH CHECK ADD CONSTRAINT [FK_EmailTemplateCategory_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplateCategory] WITH CHECK ADD CONSTRAINT [FK_EmailTemplateCategory_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
