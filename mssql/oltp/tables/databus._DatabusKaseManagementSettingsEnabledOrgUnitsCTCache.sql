CREATE TABLE [databus].[_DatabusKaseManagementSettingsEnabledOrgUnitsCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusKaseManagementSettingsEnabledOrgUnitsCTCache_kaseManagementSettingsObjectId_organizationalUnitObjectId] PRIMARY KEY CLUSTERED ([kaseManagementSettingsObjectId], [organizationalUnitObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusKaseManagementSettingsEnabledOrgUnitsCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusKaseManagementSettingsEnabledOrgUnitsCTCache] ([ctVersion], [ctSurrogateKey])

GO
