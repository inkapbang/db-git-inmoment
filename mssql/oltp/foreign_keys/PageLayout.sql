ALTER TABLE [dbo].[PageLayout] WITH CHECK ADD CONSTRAINT [FK_PageLayout_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
