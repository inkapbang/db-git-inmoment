ALTER TABLE [dbo].[ScorecardLocCatType] WITH CHECK ADD CONSTRAINT [FK_ScorecardLocCatType_LocationCategoryType]
   FOREIGN KEY([locationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[ScorecardLocCatType] WITH CHECK ADD CONSTRAINT [FK_ScorecardLocCatType_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
