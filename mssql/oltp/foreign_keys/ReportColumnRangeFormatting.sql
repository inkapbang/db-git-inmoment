ALTER TABLE [dbo].[ReportColumnRangeFormatting] WITH CHECK ADD CONSTRAINT [FK_ReportColumnRangeFormatting_ReportColumn]
   FOREIGN KEY([reportColumnObjectId]) REFERENCES [dbo].[ReportColumn] ([objectid])

GO
