CREATE TABLE [dbo].[KaseCloseCustomParameters] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [ordinal] [int] NOT NULL,
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [parameterKey] [varchar](25) NOT NULL

   ,CONSTRAINT [PK_KaseCloseCustomParameters] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_KaseCloseCustomParameters_kaseManagementSettingsObjectId_dataFieldObjectId_parameterKey] UNIQUE NONCLUSTERED ([kaseManagementSettingsObjectId], [dataFieldObjectId], [parameterKey])
)

CREATE NONCLUSTERED INDEX [IX_KaseCloseCustomParameters_dataFieldObjectId] ON [dbo].[KaseCloseCustomParameters] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_KaseCloseCustomParameters_kaseManagementSettingsObjectId] ON [dbo].[KaseCloseCustomParameters] ([kaseManagementSettingsObjectId])

GO
