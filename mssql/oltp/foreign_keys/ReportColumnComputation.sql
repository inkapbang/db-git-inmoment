ALTER TABLE [dbo].[ReportColumnComputation] WITH CHECK ADD CONSTRAINT [FK_ReportColumnComputation_Column_A]
   FOREIGN KEY([colAColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
ALTER TABLE [dbo].[ReportColumnComputation] WITH CHECK ADD CONSTRAINT [FK_ReportColumnComputation_Column_B]
   FOREIGN KEY([colBColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
