ALTER TABLE [dbo].[KaseCloseCustomParameters] WITH CHECK ADD CONSTRAINT [FK_KaseCloseCustomParameters_dataFieldObjectId]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[KaseCloseCustomParameters] WITH CHECK ADD CONSTRAINT [FK_KaseCloseCustomParameters_kaseManagementSettingsObjectId]
   FOREIGN KEY([kaseManagementSettingsObjectId]) REFERENCES [dbo].[KaseManagementSettings] ([objectId])

GO
