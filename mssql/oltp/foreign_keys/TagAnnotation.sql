ALTER TABLE [dbo].[TagAnnotation] WITH CHECK ADD CONSTRAINT [FK_TagAnnotation_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[TagAnnotation] WITH CHECK ADD CONSTRAINT [FK_TagAnnotation_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
