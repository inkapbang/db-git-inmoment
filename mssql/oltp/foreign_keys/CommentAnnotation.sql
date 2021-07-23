ALTER TABLE [dbo].[CommentAnnotation] WITH CHECK ADD CONSTRAINT [FK_CommentAnnotation_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
