ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_Description_LocalizedString]
   FOREIGN KEY([descriptionId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_Label_LocalizedString]
   FOREIGN KEY([labelId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_Organization]
   FOREIGN KEY([organizationId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_Period]
   FOREIGN KEY([periodId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_PeriodType]
   FOREIGN KEY([periodTypeId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[Dashboard] WITH CHECK ADD CONSTRAINT [FK_Dashboard_UserAccount]
   FOREIGN KEY([userAccountObjectId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
