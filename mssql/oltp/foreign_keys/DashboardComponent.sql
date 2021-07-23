ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_ChangePeriodType]
   FOREIGN KEY([changePeriodType]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_Dashboard]
   FOREIGN KEY([dashboardId]) REFERENCES [dbo].[Dashboard] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_FeedbackChannel]
   FOREIGN KEY([feedbackChannelId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_LocationCatType]
   FOREIGN KEY([locationCategoryTypeId]) REFERENCES [dbo].[LocationCategoryType] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_Period]
   FOREIGN KEY([periodId]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_Period2]
   FOREIGN KEY([periodId2]) REFERENCES [dbo].[Period] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_PeriodType]
   FOREIGN KEY([periodTypeId]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_PeriodType2]
   FOREIGN KEY([periodTypeId2]) REFERENCES [dbo].[PeriodType] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_Title_LocalizedString]
   FOREIGN KEY([titleId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_UnstructuredFeedbackModel]
   FOREIGN KEY([unstructuredFeedbackModelId]) REFERENCES [dbo].[UnstructuredFeedbackModel] ([objectId])

GO
ALTER TABLE [dbo].[DashboardComponent] WITH CHECK ADD CONSTRAINT [FK_DashboardComponent_UpliftModel]
   FOREIGN KEY([upliftModelId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
