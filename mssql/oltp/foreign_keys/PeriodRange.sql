ALTER TABLE [dbo].[PeriodRange] WITH CHECK ADD CONSTRAINT [FK_PeriodRange_label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[PeriodRange] WITH CHECK ADD CONSTRAINT [FK_PeriodRange_PeriodType]
   FOREIGN KEY([periodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
