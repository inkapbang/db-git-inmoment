ALTER TABLE [dbo].[HierarchyDownloadJobConfig] WITH CHECK ADD CONSTRAINT [FK_HierarchyDownloadJobConfig_FtpProfile]
   FOREIGN KEY([ftpProfileObjectId]) REFERENCES [dbo].[FtpProfile] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyDownloadJobConfig] WITH CHECK ADD CONSTRAINT [FK_HierarchyDownloadJobConfig_HierarchyTransform]
   FOREIGN KEY([hierarchyTransformObjectid]) REFERENCES [dbo].[HierarchyTransform] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyDownloadJobConfig] WITH CHECK ADD CONSTRAINT [FK_HierarchyDownloadJobConfig_OfferCodePolicy]
   FOREIGN KEY([offerCodePolicyObjectId]) REFERENCES [dbo].[OfferCodePolicy] ([objectId])

GO
ALTER TABLE [dbo].[HierarchyDownloadJobConfig] WITH CHECK ADD CONSTRAINT [FK_HierarchyDownloadJobConfig_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
