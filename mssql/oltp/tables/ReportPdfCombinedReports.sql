CREATE TABLE [dbo].[ReportPdfCombinedReports] (
   [pdfCombinedReportObjectId] [int] NOT NULL,
   [pageObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_ReportPdfCombinedReports] PRIMARY KEY CLUSTERED ([pdfCombinedReportObjectId], [sequence])
)

CREATE NONCLUSTERED INDEX [IX_ReportPdfCombinedReports_by_Page] ON [dbo].[ReportPdfCombinedReports] ([pageObjectId])

GO
