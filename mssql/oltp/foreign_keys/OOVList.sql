ALTER TABLE [dbo].[OOVList] WITH CHECK ADD CONSTRAINT [FK_OOVList_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
