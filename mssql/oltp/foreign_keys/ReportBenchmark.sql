ALTER TABLE [dbo].[ReportBenchmark] WITH CHECK ADD CONSTRAINT [FK_Report_benchmarkLabel_LocalizedString]
   FOREIGN KEY([benchmarkLabelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ReportBenchmark] WITH CHECK ADD CONSTRAINT [FK_Report_benchmarkLocationCategoryType]
   FOREIGN KEY([benchmarkLocationCategoryTypeObjectId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
