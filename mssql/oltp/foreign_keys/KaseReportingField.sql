ALTER TABLE [dbo].[KaseReportingField] WITH CHECK ADD CONSTRAINT [FK_KaseReportingField_dataFieldObjectId]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[KaseReportingField] WITH CHECK ADD CONSTRAINT [FK_KaseReportingField_kaseManagementSettingsObjectId]
   FOREIGN KEY([kaseManagementSettingsObjectId]) REFERENCES [dbo].[KaseManagementSettings] ([objectId])

GO
ALTER TABLE [dbo].[KaseReportingField] WITH CHECK ADD CONSTRAINT [FK_KaseReportingField_labelObjectId]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
