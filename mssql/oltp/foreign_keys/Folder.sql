ALTER TABLE [dbo].[Folder] WITH CHECK ADD CONSTRAINT [FK_Folder_Description_LocalizedString]
   FOREIGN KEY([descriptionObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Folder] WITH CHECK ADD CONSTRAINT [FK_Folder_Name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Folder] WITH CHECK ADD CONSTRAINT [FK_Folder_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
