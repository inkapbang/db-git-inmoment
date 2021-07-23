ALTER TABLE [dbo].[PageWebAccess] WITH CHECK ADD CONSTRAINT [FK__PageWebAc__locat__55088C70]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[PageWebAccess] WITH CHECK ADD CONSTRAINT [FK_PageWebAccess_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
