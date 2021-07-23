ALTER TABLE [dbo].[KeyDriverRank] WITH CHECK ADD CONSTRAINT [FK_KeyDriverRank_AssignerUserAccount]
   FOREIGN KEY([assignerAccountId]) REFERENCES [dbo].[UserAccount] ([objectId])

GO
ALTER TABLE [dbo].[KeyDriverRank] WITH CHECK ADD CONSTRAINT [FK_KeyDriverRank_KeyDriverRankings]
   FOREIGN KEY([keyDriverRankingsObjectId]) REFERENCES [dbo].[KeyDriverRankings] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[KeyDriverRank] WITH CHECK ADD CONSTRAINT [FK_KeyDriverRank_PerformanceAttribute]
   FOREIGN KEY([performanceAttributeObjectId]) REFERENCES [dbo].[UpliftModelPerformanceAttribute] ([objectId])

GO
