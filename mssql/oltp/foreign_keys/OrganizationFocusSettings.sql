ALTER TABLE [dbo].[OrganizationFocusSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationFocusSettings_currentYearPeriod]
   FOREIGN KEY([currentYearPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[OrganizationFocusSettings] WITH CHECK ADD CONSTRAINT [FK_OrganizationFocusSettings_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[OrganizationFocusSettings] WITH CHECK ADD CONSTRAINT [FK_TrendPeriodObjectId_Period]
   FOREIGN KEY([trendPeriodObjectId]) REFERENCES [dbo].[Period] ([objectId])

GO
