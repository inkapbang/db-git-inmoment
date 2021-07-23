CREATE TABLE [dbo].[KaseReportingField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [ordinal] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [source] [tinyint] NOT NULL,
   [labelType] [int] NOT NULL,
   [labelObjectId] [int] NULL

   ,CONSTRAINT [PK_KaseReportingField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KaseReportingField_dataFieldObjectId] ON [dbo].[KaseReportingField] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_KaseReportingField_kaseManagementSettingsObjectId] ON [dbo].[KaseReportingField] ([kaseManagementSettingsObjectId])

GO
