CREATE TABLE [dbo].[ReportExcelTemplateReportSource] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [excelTemplateReportObjectId] [int] NOT NULL,
   [reportObjectId] [int] NOT NULL,
   [tabName] [nvarchar](100) NOT NULL

   ,CONSTRAINT [PK_ReportExcelTemplateReportSource] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ReportExcelTemplateReportSource_by_Page] ON [dbo].[ReportExcelTemplateReportSource] ([reportObjectId])
CREATE NONCLUSTERED INDEX [IX_ReportExcelTemplateReportSource_by_TemplateReport_Page] ON [dbo].[ReportExcelTemplateReportSource] ([excelTemplateReportObjectId])

GO
