ALTER TABLE [dbo].[PearAnnotationTag] WITH CHECK ADD CONSTRAINT [FK_PearAnnotationTag_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[PearAnnotationTag] WITH CHECK ADD CONSTRAINT [FK_PearAnnotationTag_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
