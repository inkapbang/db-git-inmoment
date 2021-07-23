ALTER TABLE [dbo].[ProgramProgressComponentEntry] WITH CHECK ADD CONSTRAINT [FK_ProgramProgressComponentEntry_dashboardComponentObjectId]
   FOREIGN KEY([dashboardComponentObjectId]) REFERENCES [dbo].[DashboardComponent] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[ProgramProgressComponentEntry] WITH CHECK ADD CONSTRAINT [FK_ProgramProgressComponentEntry_feedbackChannelObjectId]
   FOREIGN KEY([feedbackChannelId]) REFERENCES [dbo].[FeedbackChannel] ([objectId])

GO
ALTER TABLE [dbo].[ProgramProgressComponentEntry] WITH CHECK ADD CONSTRAINT [FK_ProgramProgressComponent_Localized]
   FOREIGN KEY([titleOverrideId]) REFERENCES [dbo].[LocalizedString] ([objectId])

GO
ALTER TABLE [dbo].[ProgramProgressComponentEntry] WITH CHECK ADD CONSTRAINT [FK_ProgramProgressComponentEntry_upliftModelObjectId]
   FOREIGN KEY([upliftModelId]) REFERENCES [dbo].[UpliftModel] ([objectId])

GO
