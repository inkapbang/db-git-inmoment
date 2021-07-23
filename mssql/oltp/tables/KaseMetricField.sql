CREATE TABLE [dbo].[KaseMetricField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [ordinal] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [showLabel] [int] NULL,
   [source] [tinyint] NOT NULL,
   [metricLabelType] [int] NOT NULL,
   [labelObjectId] [int] NULL

   ,CONSTRAINT [PK_KaseMetricField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_KaseMetricField_dataFieldObjectId] ON [dbo].[KaseMetricField] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_KaseMetricField_kaseManagementSettingsObjectId] ON [dbo].[KaseMetricField] ([kaseManagementSettingsObjectId])

GO
