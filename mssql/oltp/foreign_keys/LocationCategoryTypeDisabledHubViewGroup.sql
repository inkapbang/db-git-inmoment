ALTER TABLE [dbo].[LocationCategoryTypeDisabledHubViewGroup] WITH CHECK ADD CONSTRAINT [FK_LocationCategoryTypeDisabledHubViewGroup_locationCategoryTypeObjectId]
   FOREIGN KEY([LocationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
