ALTER TABLE [dbo].[IncidentManagementPreset] WITH CHECK ADD CONSTRAINT [FK_IncidentManagementPreset_LocalizedString]
   FOREIGN KEY([noteObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[IncidentManagementPreset] WITH CHECK ADD CONSTRAINT [FK_IncidentManagementPreset_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
