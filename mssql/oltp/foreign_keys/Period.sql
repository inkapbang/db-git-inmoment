ALTER TABLE [dbo].[Period] WITH CHECK ADD CONSTRAINT [FK_Period_name_LocalizedString]
   FOREIGN KEY([nameObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Period] WITH CHECK ADD CONSTRAINT [FK_Period_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Period] WITH CHECK ADD CONSTRAINT [FK_Period_PeriodType]
   FOREIGN KEY([periodTypeObjectId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
