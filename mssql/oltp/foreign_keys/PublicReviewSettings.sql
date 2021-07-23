ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_ResponseText]
   FOREIGN KEY([responseTextObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_RootReviewCategory]
   FOREIGN KEY([rootCategoryObjectId]) REFERENCES [dbo].[PublicReviewCategory] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_UFM]
   FOREIGN KEY([unstructuredFeedbackModelObjectId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettings] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettings_UpliftModel]
   FOREIGN KEY([upliftModelObjectId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
