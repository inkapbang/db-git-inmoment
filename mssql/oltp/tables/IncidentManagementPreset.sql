CREATE TABLE [dbo].[IncidentManagementPreset] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [sequence] [int] NULL,
   [organizationObjectId] [int] NULL,
   [stateType] [int] NOT NULL,
   [noteObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_IncidentManagementPreset] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_IncidentManagementPreset_noteObjectId] ON [dbo].[IncidentManagementPreset] ([noteObjectId])
CREATE NONCLUSTERED INDEX [IX_IncidentManagementPreset_organizationObjectId] ON [dbo].[IncidentManagementPreset] ([organizationObjectId])

GO
