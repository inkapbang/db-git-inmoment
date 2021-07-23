CREATE TABLE [dbo].[KaseManagementSettingsEnabledOrgUnits] (
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_KaseManagementSettingsEnabledOrgUnits] PRIMARY KEY CLUSTERED ([kaseManagementSettingsObjectId], [organizationalUnitObjectId])
)


GO
