ALTER TABLE [dbo].[SocialTypeOrgSetting] WITH CHECK ADD CONSTRAINT [FK_SocialTypeOrgSetting_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[SocialTypeOrgSetting] WITH CHECK ADD CONSTRAINT [FK_SocialTypeOrgSetting_RatingField]
   FOREIGN KEY([ratingFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
