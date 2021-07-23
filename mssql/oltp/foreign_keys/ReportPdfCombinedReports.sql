ALTER TABLE [dbo].[ReportPdfCombinedReports] WITH CHECK ADD CONSTRAINT [FK_ReportPdfCombinedReports_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ReportPdfCombinedReports] WITH CHECK ADD CONSTRAINT [FK_ReportPdfCombinedReports_PdfCombinedReport_Page]
   FOREIGN KEY([pdfCombinedReportObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
