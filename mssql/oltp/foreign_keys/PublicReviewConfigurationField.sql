ALTER TABLE [dbo].[PublicReviewConfigurationField] WITH CHECK ADD CONSTRAINT [FK_PublicReviewConfigurationField_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewConfigurationField] WITH CHECK ADD CONSTRAINT [FK_PublicReviewField_Setting]
   FOREIGN KEY([publicReviewSettingsObjectId]) REFERENCES [dbo].[PublicReviewSettings] ([objectId])

GO
