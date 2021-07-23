ALTER TABLE [dbo].[ReportColumnCriteriaSet] WITH CHECK ADD CONSTRAINT [FK_ReportColumnCriteriaSet_ReportColumn]
   FOREIGN KEY([reportColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
ALTER TABLE [dbo].[ReportColumnCriteriaSet] WITH CHECK ADD CONSTRAINT [FK_ReportColumnCriteriaSet_ReportCriterion]
   FOREIGN KEY([reportCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
