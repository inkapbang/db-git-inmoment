ALTER TABLE [dbo].[ReportColumnDrillDownParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnDrillDownParam_Column]
   FOREIGN KEY([columnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
ALTER TABLE [dbo].[ReportColumnDrillDownParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnDrillDownParam_ParamCriterion]
   FOREIGN KEY([paramCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
ALTER TABLE [dbo].[ReportColumnDrillDownParam] WITH CHECK ADD CONSTRAINT [FK_ReportColumnDrillDownParam_ValueColumn]
   FOREIGN KEY([valueColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
