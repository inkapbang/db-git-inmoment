ALTER TABLE [dbo].[ActiveListeningQuestion] WITH CHECK ADD CONSTRAINT [FK_ActiveListeningQuestion_Maping]
   FOREIGN KEY([mappingObjectId]) REFERENCES [dbo].[SmartCommentAnnotationMapping] ([objectId])

GO
ALTER TABLE [dbo].[ActiveListeningQuestion] WITH CHECK ADD CONSTRAINT [FK_ActiveListeningQuestion_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
