ALTER TABLE [dbo].[Survey] WITH CHECK ADD CONSTRAINT [FK_Survey_FeedbackChannel]
   FOREIGN KEY([channelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[Survey] WITH CHECK ADD CONSTRAINT [FK_Survey_EmpathicaExportDefinition]
   FOREIGN KEY([exportDefinitionObjectId]) REFERENCES [dbo].[EmpathicaExportDefinition] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[Survey] WITH CHECK ADD CONSTRAINT [FK_Survey_Unit]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
