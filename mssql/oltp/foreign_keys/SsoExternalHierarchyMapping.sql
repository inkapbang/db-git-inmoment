ALTER TABLE [dbo].[SsoExternalHierarchyMapping] WITH CHECK ADD CONSTRAINT [FK_SsoExternalHierarchyMapping_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[SsoExternalHierarchyMapping] WITH CHECK ADD CONSTRAINT [FK_SsoExternalHierarchyMapping_LocationCategoryType_reportDistro]
   FOREIGN KEY([reportDistroCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[SsoExternalHierarchyMapping] WITH CHECK ADD CONSTRAINT [FK_SsoExternalHierarchyMapping_LocationCategoryType_webAccess]
   FOREIGN KEY([webAccessCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
