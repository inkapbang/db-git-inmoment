ALTER TABLE [dbo].[EmailTemplate] WITH CHECK ADD CONSTRAINT [FK_EmailTemplate_EmailTemplateCategory]
   FOREIGN KEY([emailTemplateCategoryObjectId]) REFERENCES [dbo].[EmailTemplateCategory] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplate] WITH CHECK ADD CONSTRAINT [FK_EmailTemplate_LocalizedString2]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplate] WITH CHECK ADD CONSTRAINT [FK_EmailTemplate_LocalizedString1]
   FOREIGN KEY([noteObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplate] WITH CHECK ADD CONSTRAINT [FK_EmailTemplate_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplate] WITH CHECK ADD CONSTRAINT [FK_EmailTemplate_LocalizedString]
   FOREIGN KEY([subjectObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
