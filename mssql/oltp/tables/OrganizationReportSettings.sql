CREATE TABLE [dbo].[OrganizationReportSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [advancedHierarchyPickerEnabled] [bit] NOT NULL,
   [allowRuntimeComputedDataFields] [bit] NULL

   ,CONSTRAINT [PK_OrganizationReportSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OrganizationReportSettings_OrganizationId] UNIQUE NONCLUSTERED ([organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationReportSettings_organizationObjectId] ON [dbo].[OrganizationReportSettings] ([organizationObjectId])

GO
