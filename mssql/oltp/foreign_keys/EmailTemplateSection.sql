ALTER TABLE [dbo].[EmailTemplateSection] WITH CHECK ADD CONSTRAINT [FK_EmailTemplateSection_EmailTemplate]
   FOREIGN KEY([emailTemplateObjectId]) REFERENCES [dbo].[EmailTemplate] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplateSection] WITH CHECK ADD CONSTRAINT [FK_EmlTmpSct_LocalizedString_Height]
   FOREIGN KEY([heightObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplateSection] WITH CHECK ADD CONSTRAINT [FK_EmlTmpSct_LocalizedString_Imgsrc]
   FOREIGN KEY([imgSrcObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplateSection] WITH CHECK ADD CONSTRAINT [FK_EmailTemplateSection_LocalizedString]
   FOREIGN KEY([textObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[EmailTemplateSection] WITH CHECK ADD CONSTRAINT [FK_EmlTmpSct_LocalizedString_Width]
   FOREIGN KEY([widthObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
