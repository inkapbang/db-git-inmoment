ALTER TABLE [dbo].[KaseMetricField] WITH CHECK ADD CONSTRAINT [FK_KaseMetricField_dataFieldObjectId]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[KaseMetricField] WITH CHECK ADD CONSTRAINT [FK_KaseMetricField_kaseManagementSettingsObjectId]
   FOREIGN KEY([kaseManagementSettingsObjectId]) REFERENCES [dbo].[KaseManagementSettings] ([objectId])

GO
ALTER TABLE [dbo].[KaseMetricField] WITH CHECK ADD CONSTRAINT [FK_KaseMetricField_labelObjectId]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
