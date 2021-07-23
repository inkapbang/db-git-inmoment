ALTER TABLE [dbo].[PublicReviewSettingsBrand] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettingsBrand_Brand]
   FOREIGN KEY([brandObjectId]) REFERENCES [dbo].[Brand] ([objectId])

GO
ALTER TABLE [dbo].[PublicReviewSettingsBrand] WITH CHECK ADD CONSTRAINT [FK_PublicReviewSettingsBrand_Setting]
   FOREIGN KEY([publicReviewSettingsObjectId]) REFERENCES [dbo].[PublicReviewSettings] ([objectId])

GO
