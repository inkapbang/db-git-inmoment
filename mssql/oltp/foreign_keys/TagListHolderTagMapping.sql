ALTER TABLE [dbo].[TagListHolderTagMapping] WITH CHECK ADD CONSTRAINT [FK_TagListHolderTagMapping_TagList]
   FOREIGN KEY([tagListHolderObjectId]) REFERENCES [dbo].[TagListHolder] ([objectId])

GO
ALTER TABLE [dbo].[TagListHolderTagMapping] WITH CHECK ADD CONSTRAINT [FK_TagListHolderTagMapping_Tag]
   FOREIGN KEY([tagObjectId]) REFERENCES [dbo].[Tag] ([objectId])

GO
