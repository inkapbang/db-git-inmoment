ALTER TABLE [dbo].[ReportSavedView] WITH CHECK ADD CONSTRAINT [FK_ReportSavedView_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[ReportSavedView] WITH CHECK ADD CONSTRAINT [FK_ReportSavedView_Page]
   FOREIGN KEY([reportObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ReportSavedView] WITH CHECK ADD CONSTRAINT [FK_ReportSavedView_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
