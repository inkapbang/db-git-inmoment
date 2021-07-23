ALTER TABLE [dbo].[KaseManagementSettingsEnabledOrgUnits] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettingsEnabledOrgUnits_KaseManagementSettings]
   FOREIGN KEY([kaseManagementSettingsObjectId]) REFERENCES [dbo].[KaseManagementSettings] ([objectId])

GO
ALTER TABLE [dbo].[KaseManagementSettingsEnabledOrgUnits] WITH CHECK ADD CONSTRAINT [FK_KaseManagementSettingsEnabledOrgUnits_OrgUnits]
   FOREIGN KEY([organizationalUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])

GO
