ALTER TABLE [dbo].[ReportColumnLinkedReportParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnLinkedReportParam_Column]
   FOREIGN KEY([columnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
ALTER TABLE [dbo].[ReportColumnLinkedReportParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnLinkedReportParam_ParamCriterion]
   FOREIGN KEY([paramCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumnLinkedReportParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnLinkedReportParam_ValueColumn]
   FOREIGN KEY([valueColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
