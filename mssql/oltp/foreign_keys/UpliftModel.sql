ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_LocalizedString_AuditLegendLabel]
   FOREIGN KEY([auditLegendLabelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_FeedbackChannel]
   FOREIGN KEY([channelObjectId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_Page]
   FOREIGN KEY([pageObjectId]) REFERENCES [dbo].[Page] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_PerformanceIndicatorField]
   FOREIGN KEY([performanceIndicatorFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_PerformanceIndicatorGoal]
   FOREIGN KEY([performanceIndicatorGoalObjectId]) REFERENCES [dbo].[Goal] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_ptdLabel_LocalizedString]
   FOREIGN KEY([ptdLabelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_RegressionPerformanceIndicatorField]
   FOREIGN KEY([regressionPerformanceIndicatorFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_reviewRatingFieldObjectId_DataField]
   FOREIGN KEY([reviewRatingFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_LocalizedString_SurveyLegendLabel]
   FOREIGN KEY([surveyLegendLabelObjectId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[UpliftModel] WITH CHECK ADD CONSTRAINT [FK_UpliftModel_UpliftModelStrategy]
   FOREIGN KEY([upliftModelStrategyObjectId]) REFERENCES [dbo].[UpliftModelStrategy] ([objectId])

GO
