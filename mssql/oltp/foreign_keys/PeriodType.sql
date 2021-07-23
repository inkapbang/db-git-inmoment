ALTER TABLE [dbo].[PeriodType] WITH CHECK ADD CONSTRAINT [FK_PeriodType_label_LocalizedString]
   FOREIGN KEY([labelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
