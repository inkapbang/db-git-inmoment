ALTER TABLE [dbo].[VideoFeedbackSettings] WITH CHECK ADD CONSTRAINT [FK_VideoFeedbackSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
