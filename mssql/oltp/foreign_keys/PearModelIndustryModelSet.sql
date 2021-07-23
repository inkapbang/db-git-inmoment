ALTER TABLE [dbo].[PearModelIndustryModelSet] WITH CHECK ADD CONSTRAINT [FK_PearModelIndustryModelSet_IndustryModel]
   FOREIGN KEY([industryModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
ALTER TABLE [dbo].[PearModelIndustryModelSet] WITH CHECK ADD CONSTRAINT [FK_PearModelIndustryModelSet_PearModel]
   FOREIGN KEY([pearModelObjectId]) REFERENCES [dbo].[PearModel] ([objectId])

GO
