ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_DataField]
   FOREIGN KEY([DataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_ReportColumnComputation]
   FOREIGN KEY([columnComputationObjectId]) REFERENCES [dbo].[ReportColumnComputation] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_DrillDownTargetPage]
   FOREIGN KEY([drillDownTargetPageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_Goal]
   FOREIGN KEY([goalObjectId]) REFERENCES [dbo].[Goal] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_LinkedReportTargetPage]
   FOREIGN KEY([linkedReportTargetPageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumn] WITH CHECK ADD CONSTRAINT [FK_ReportColumn_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
