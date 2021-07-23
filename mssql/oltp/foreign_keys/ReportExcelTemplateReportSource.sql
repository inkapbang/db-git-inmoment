ALTER TABLE [dbo].[ReportExcelTemplateReportSource] WITH CHECK ADD CONSTRAINT [FK_ReportExcelTemplateReportSource_TemplateReport_Page]
   FOREIGN KEY([excelTemplateReportObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ReportExcelTemplateReportSource] WITH CHECK ADD CONSTRAINT [FK_ReportExcelTemplateReportSource_Page]
   FOREIGN KEY([reportObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
