ALTER TABLE [dbo].[FieldDashboardReportComponent] WITH CHECK ADD CONSTRAINT [FK_FieldDashboardReportComponent_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
